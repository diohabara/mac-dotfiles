#!/usr/bin/env bash
set -eu -o pipefail
export LC_ALL=C
export LANG=C
IFS="$(printf " \t\nx")"

# XDG Base Directory Specification
XDG_CONFIG_HOME="${HOME}/.config"
XDG_CACHE_HOME="${HOME}/.cache"
XDG_DATA_HOME="${HOME}/.share"

# data direcotory for zsh
ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# misc
ZSH_FUNCCOMP_DIR="${ZDOTDIR}/func_comp"
GHQ_ROOT="${HOME}/repo"
REPO_ROOT="${GHQ_ROOT}/github.com/diohabara/dotfiles"

command mkdir -p "${ZSH_FUNCCOMP_DIR}"

command_exists() {
	command -v "$1" &>/dev/null
}

: "remap keys" && {
	gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']" # turn capslock into control
}

: "enable multi-arch support" && {
	sudo dpkg --add-architecture i386
}

: "uninstall packages by apt" && {
	if [ apt list -a emacs ]; then
		sudo apt --purge -y remove emacs
	fi
  if [ apt list -a ibus ]; then
    sudo apt --purge -y remove ibus
  fi
}

: "install packages by apt" && {
	# https://askubuntu.com/questions/462094/unable-to-install-libssl1-0-0i386-due-to-unmet-dependencies/462471#462471
	echo "deb http://security.ubuntu.com/ubuntu bionic-security main" |
		sudo tee -a /etc/apt/sources.list.d/bionic.list
	sudo apt update
	sudo apt upgrade -y
	sudo apt purge -y --autoremove
	sudo apt install -y \
		apt-transport-https \
		build-essential \
		ca-certificates \
		clang \
		clang-format \
		gnupg \
		grep \
		lib32z1 \
		libblkid-dev \
		libbz2-1.0:i386 \
		libc6:i386 \
		libcanberra-gtk-module \
		libcanberra-gtk3-module \
		libfontconfig1-dev \
		libfreetype6-dev \
		libgraphite2-dev \
		libgtk-3-dev \
		libharfbuzz-dev \
		liblzma-dev \
		libncurses5:i386 \
		libssl-dev \
		libstdc++6:i386 \
		libtinfo-dev \
		libtool \
		libtool-bin \
		libvterm-dev \
		libxcb-xfixes0-dev \
		lsb-release \
		ninja-build \
		snapd \
		software-properties-common \
		xclip \
		zlib1g-deva \
    fcitx-mozc \
    zsh \

}

: "install packages by snap" && {
	sudo snap set system experimental.parallel-instances=true
	sudo snap refresh
	sudo snap install --classic flutter
	sudo snap install --classic android-studio
	sudo snap install --classic intellij-idea-community
}

#!/usr/bin/env bash
set -euo pipefail
IFS="$(printf " \t\nx")"

# XDG Base Directory Specification
XDG_CONFIG_HOME="${HOME}/.config"
# shellcheck disable=SC2034
XDG_CACHE_HOME="${HOME}/.cache"
# shellcheck disable=SC2034
XDG_DATA_HOME="${HOME}/.share"

# data direcotory for zsh
ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# misc
ZSH_FUNCCOMP_DIR="${ZDOTDIR}/func_comp"
GHQ_ROOT="${HOME}/repo"
# shellcheck disable=SC2034
REPO_ROOT="${GHQ_ROOT}/github.com/diohabara/dotfiles"

command mkdir -p "${ZSH_FUNCCOMP_DIR}"

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

: "remap keys" && {
  gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']" # turn capslock into control
}

: "enable multi-arch support" && {
  sudo dpkg --add-architecture i386
}

: "uninstall packages by apt" && {
  if apt list -a emacs; then
    sudo apt --purge -y remove emacs emacs23 emacs24 emacs25 emacs26 \
      emacs26-common emacs-common apel flim w3m-el emacs-el emacs-bin-common
  fi
}

: "add apt repositories" && {
  if ! command_exists obs; then
    sudo add-apt-repository ppa:obsproject/obs-studio
    sudo add-apt-repository ppa:kelleyk/emacs
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
    "libcanberra-gtk*" \
    apt-transport-https \
    build-essential \
    bzip2 \
    ca-certificates \
    clang \
    clang-format \
    emacs27 \
    fcitx-mozc \
    firefox \
    gnupg \
    grep \
    ibus-mozc \
    lib32z1 \
    libaio-dev \
    libblkid-dev \
    libbz2-1.0:i386 \
    libbz2-dev \
    libc6:i386 \
    libdb-dev \
    libedit-dev \
    libexpat1-dev \
    libffi-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libgdbm-dev \
    libgmp3-dev \
    libgraphite2-dev \
    libgtk-3-dev \
    libharfbuzz-dev \
    liblzma-dev \
    libmpdec-dev \
    libncurses5-dev \
    libncurses5:i386 \
    libncursesw5-dev \
    libreadline-dev \
    libreadline6-dev \
    libsqlite3-dev \
    libssl-dev \
    libstdc++6:i386 \
    libtinfo-dev \
    libtool \
    libtool-bin \
    libvterm-dev \
    libxcb-xfixes0-dev \
    lsb-release \
    ninja-build \
    obs-studio \
    snapd \
    software-properties-common \
    sqlite3 \
    v4l2loopback-dkms \
    verilator \
    xclip \
    zlib1g-dev \
    zlib1g-dev \
    zsh

}

: "install packages by snap" && {
  echo "You may not use Japanese Input in Apps installed by snap"
  # sudo snap set system experimental.parallel-instances=true
  # : "install emacs" && {
  #   sudo snap install emacs --beta --classic
  # }
  # : "install with classic" && {
  #   sudo snap install --classic android-studio
  #   sudo snap install --classic clion
  #   sudo snap install --classic code
  #   sudo snap install --classic emacs
  #   sudo snap install --classic flutter
  #   sudo snap install --classic intellij-idea-community
  #   sudo snap install --classic slack
  # }
  # : "install without classic" && {
  #   sudo snap install docker
  #   sudo snap install spotify
  #   sudo snap install zulip
  # }
  # sudo snap refresh
}

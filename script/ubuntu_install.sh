#!/usr/bin/env bash
set -euox pipefail
IFS="$(printf " \t\nx")"

# XDG Base Directory Specification
XDG_CONFIG_HOME="${HOME}/.config"

# data direcotory for zsh
ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# misc
ZSH_FUNCCOMP_DIR="${ZDOTDIR}/func_comp"

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

: "install tailscale" && {
  # Doc: https://login.tailscale.com/admin/welcome
  if ! command_exists tailscale; then
    curl -fsSL https://tailscale.com/install.sh | sh
  fi
}

: "fzf" && {
  if ! command_exists fzf; then
    # Doc: https://github.com/junegunn/fzf#installation
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
  fi
}

: "install packages by apt" && {
  # https://askubuntu.com/questions/462094/unable-to-install-libssl1-0-0i386-due-to-unmet-dependencies/462471#462471
  echo "deb http://security.ubuntu.com/ubuntu bionic-security main" |
    sudo tee -a /etc/apt/sources.list.d/bionic.list
  sudo apt update
  sudo apt upgrade -y
  sudo apt purge -y --autoremove
  sudo apt install -y build-essential neovim
}

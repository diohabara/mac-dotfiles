#!/usr/bin/env bash
set -euox pipefail
IFS="$(printf " \t\nx")"

# XDG Base Directory Specification
XDG_CONFIG_HOME="${HOME}/.config"

# data direcotory for zsh
ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# misc
ZSH_FUNCCOMP_DIR="${ZDOTDIR}/func_comp"
CURRENT_DIR="$(cd "$(dirname "$0")" && pwd)"

command mkdir -p "${ZSH_FUNCCOMP_DIR}"

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

: "install nix" && {
  if ! command_exists nix; then
    # Doc: https://nixos.org/manual/nix/unstable/installation/installing-binary.html#macos
    if test -f "/etc/bashrc.backup-before-nix"; then
      sudo mv /etc/bashrc.backup-before-nix /etc/bashrc
    fi
    if test -f "/etc/zshrc.backup-before-nix"; then
      sudo mv /etc/zshrc.backup-before-nix /etc/zshrc
    fi
    if test -f "/etc/bash.bashrc.backup-before-nix"; then
      sudo mv /etc/bash.bashrc.backup-before-nix /etc/bash.bashrc
    fi
    if test -f "/etc/zsh/zshrc.backup-before-nix"; then
      sudo mv /etc/zsh/zshrc.backup-before-nix /etc/zsh/zshrc
    fi
    # Doc: https://nixos.org/manual/nix/stable/#sect-single-user-installation
    # Doc: https://nixos.org/manual/nix/stable/#sect-macos-installation
    if [ "$(uname)" == "Darwin" ]; then
      sh <(curl -L https://nixos.org/nix/install)
    else
      sh <(curl -L https://nixos.org/nix/install) --daemon
    fi
  fi

  if command_exists nix; then
    # Doc: https://nix-community.github.io/home-manager/index.html#sec-install-standalone
    : "install home manager" && {
      if ! command_exists home-manager; then
        nix-channel --add https://github.com/nix-community/home-manager/archive/release-22.11.tar.gz home-manager
        # nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
        nix-channel --update
        nix-shell '<home-manager>' -A install
      fi
      home-manager switch
    }
  fi
}

: "install brew" && {
  if ! command_exists brew; then
    # Doc: https://brew.sh/
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    export PATH="${PATH}:/opt/homebrew/bin"
  fi

  : "install packages by brew" && {
    # Doc: https://homebrew-file.readthedocs.io/en/latest/usage.html
    brew upgrade
    brew bundle install --file "${CURRENT_DIR}/../Brewfile" --no-lock
  }
}

: "set up Emacs" && {
  "link Emacs.app" && {
    ln -sf /opt/homebrew/opt/emacs-plus/Emacs.app /Applications/Emacs.app
    # ln -sf /opt/homebrew/opt/emacs-mac/Emacs.app /Applications/Emacs.app
  }
}

: "AppleScript" && {
  # put Dock left
  defaults write com.apple.Dock orientation -string left
  killall Dock
  # enable key repeating
  defaults write -g ApplePressAndHoldEnabled -bool false
  "${CURRENT_DIR}/apple.applescript"
}

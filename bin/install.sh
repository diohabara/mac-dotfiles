#!/usr/bin/env bash
set -euo pipefail
IFS="$(printf " \t\nx")"

# XDG Base Directory Specification
XDG_CONFIG_HOME="${HOME}/.config"

# data direcotory for zsh
ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# misc
ZSH_FUNCCOMP_DIR="${ZDOTDIR}/func_comp"
GHQ_ROOT="${HOME}/repo"
REPO_ROOT="${GHQ_ROOT}/github.com/diohabara/dotfiles"

command mkdir -p "${ZSH_FUNCCOMP_DIR}"

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

: "install nix" && {
  if ! command_exists nix; then
    # Doc: https://nixos.org/manual/nix/stable/#sect-single-user-installation
    # Doc: https://nixos.org/manual/nix/stable/#sect-macos-installation
    sudo mv /etc/bashrc.backup-before-nix /etc/bashrc
    sudo mv /etc/zshrc.backup-before-nix /etc/zshrc
    sudo mv /etc/bash.bashrc.backup-before-nix /etc/bash.bashrc
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
        nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
        nix-channel --update
        nix-shell '<home-manager>' -A install
      fi
      home-manager switch
    }
  fi
}

case ${OSTYPE} in
darwin*)
  bash "${REPO_ROOT}/bin/mac_install.sh"
  ;;
linux*)
  if [ -e /etc/debian_version ] || [ -e /etc/debian_release ]; then
    if [ -e /etc/lsb-release ]; then
      bash "${REPO_ROOT}/bin/ubuntu_install.sh"
    fi
  fi
  ;;
*)
  echo "This operating system is not supported by this dotfiles"
  exit 1
  ;;
esac

: "install zplug" && {
  if ! [ -d "${HOME}/.zplug" ]; then
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
  fi
}

: "install go packages" && {
  if command_exists go; then
    go install github.com/bazelbuild/bazelisk@latest
    go install github.com/bazelbuild/buildtools/buildifier@latest
    go install golang.org/x/tools/cmd/godoc@latest
    go install golang.org/x/tools/cmd/goimports@latest
    go install golang.org/x/tools/cmd/gorename@latest
    go install golang.org/x/tools/cmd/guru@latest
  fi
}

: "install haskell" && {
  : "install haskell packages" && {
    if ! command_exists ghcup; then
      curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
    else
      ghcup upgrade -n
      ghcup install ghc
    fi
  }
}

# : "install ocaml" && {
#   : "install opam packages" && {
#     if command_exists opam; then
#       if [ ! -d "${HOME}/.opam" ]; then
#         opam init
#       fi
#       opam install async -y
#       opam install core -y
#       opam install dune -y
#       opam install js_of_ocaml -y
#       opam install js_of_ocaml-ppx -y
#       opam install merlin -y
#       opam install ocaml -y
#       opam install ocaml-lsp-server -y
#       opam install ocamlformat -y
#       opam install ocamlformat-rpc -y
#       opam install ocp-indent -y
#       opam install user-setup -y
#       opam install utop -y
#       opam update -y
#       opam upgrade -y
#     fi
#   }
# }

: "install python" && {
  : "install pyenv" && {
    if ! command_exists pyenv; then
      # Doc: https://github.com/pyenv/pyenv-installer
      rm -rf ~/.pyenv
      curl https://pyenv.run | bash
    fi
  }
  : "install via pip3" && {
    if command_exists pip3; then
      pip3 install --user --upgrade pip
      pip3 install --user atcoder-tools
    fi
  }
}

: "install rust packages" && {
  if ! command_exists rustup; then
    # Doc: https://www.rust-lang.org/tools/install
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
    # shellcheck disable=SC1091
    source "${HOME}/.cargo/env"
  fi
  : "install rustup components" && {
    rustup toolchain install stable
    rustup toolchain install nightly
    rustup update
    # Doc: https://rust-lang.github.io/rustup/installation/index.html#enable-tab-completion-for-bash-fish-zsh-or-powershell
    rustup completions zsh >"${ZSH_FUNCCOMP_DIR}/_rustup"
    # For rust-analyzer
    # Doc: https://rust-analyzer.github.io/manual.html#installation
    rustup component add rust-src
    # Doc: https://github.com/hlissner/doom-emacs/blob/develop/modules/lang/rust/README.org
    rustup component add rustfmt-preview
    rustup component add clippy-preview
    # For rls
    # Doc: https://github.com/rust-lang/rls
    rustup component add rls
    rustup component add rust-analysis
    rustup component add rust-src
  }

  : "install cargo packages" && {
    if command_exists cargo; then
      cargo install cargo-check
    fi
  }
}

: "update font cache" && {
  fc-cache -fv
}

echo "Complete installation!"

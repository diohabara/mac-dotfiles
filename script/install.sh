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

: "os specific" && {
  case ${OSTYPE} in
  darwin*)
    bash "${CURRENT_DIR}/mac_install.sh"
    ;;
  linux*)
    if [ -e /etc/debian_version ] || [ -e /etc/debian_release ]; then
      if [ -e /etc/lsb-release ]; then
        bash "${CURRENT_DIR}/ubuntu_install.sh"
      fi
    fi
    ;;
  *)
    echo "This operating system is not supported by this dotfiles"
    exit 1
    ;;
  esac
}

: "misc" && {
  : "starship" && {
    # https://github.com/starship/starship#step-1-install-starship
    if ! command_exists starship; then
      curl -sS https://starship.rs/install.sh | sh
    fi
  }
  : "direnv" && {
    # https://direnv.net/docs/installation.html
    if ! command_exists direnv; then
      curl -sfL https://direnv.net/install.sh | bash
    fi
  }
  : "zplug" && {
    if ! [ -d "${HOME}/.zplug" ]; then
      curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
    fi
  }
  : "fzf" && {
    if ! command_exists fzf; then
      git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
      ~/.fzf/install
    fi
  }
}

: "python" && {
  : "pyenv" && {
    # https://github.com/pyenv/pyenv#automatic-installer
    curl https://pyenv.run | bash
  }
  : "poetry" && {
    curl -sSL https://install.python-poetry.org | python3 -
  }
}

: "go" && {
  if ! command_exists go; then
    bash <(curl -sL https://git.io/go-installer)
  fi
  if command_exists go; then
    go install github.com/bazelbuild/bazelisk@latest
    go install github.com/bazelbuild/buildtools/buildifier@latest
    go install golang.org/x/tools/cmd/godoc@latest
    go install golang.org/x/tools/cmd/goimports@latest
    go install golang.org/x/tools/cmd/gorename@latest
    go install golang.org/x/tools/cmd/guru@latest
  fi
}

: "doom" && {
  if ! command_exists doom; then
    git clone --depth 1 https://github.com/hlissner/doom-emacs "${HOME}/.emacs.d"
    "${HOME}/.emacs.d/bin/doom" install
  else
    doom sync
    doom upgrade
    doom build
  fi
}

: "ocaml" && {
  : "install opam" && {
    if ! command_exists opam; then
      bash -c "sh <(curl -fsSL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh)"
    fi
  }

  : "install opam packages" && {
    if command_exists opam; then
      if [ ! -d "${HOME}/.opam" ]; then
        opam init
      fi
      opam install async -y
      opam install core -y
      opam install dune -y
      opam install js_of_ocaml -y
      opam install js_of_ocaml-ppx -y
      opam install merlin -y
      opam install ocaml -y
      opam install ocaml-lsp-server -y
      opam install ocamlformat -y
      opam install ocamlformat-rpc -y
      opam install ocp-indent -y
      opam install user-setup -y
      opam install utop -y
    fi
  }
}

: "rust" && {
  if ! command_exists rustup; then
    # Doc: https://www.rust-lang.org/tools/install
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
    # shellcheck disable=SC1091
    source "${HOME}/.cargo/env"
  fi
  rustup toolchain install stable
  rustup toolchain install nightly
  rustup update
  # Doc: https://rust-lang.github.io/rustup/installation/index.html#enable-tab-completion-for-bash-fish-zsh-or-powershell
  rustup completions zsh >"${ZSH_FUNCCOMP_DIR}/_rustup"
  # Doc: https://rust-analyzer.github.io/manual.html#installation
  rustup component add rust-src
  # Doc: https://github.com/hlissner/doom-emacs/blob/develop/modules/lang/rust/README.org
  rustup component add rustfmt-preview
  rustup component add clippy-preview
  if command_exists cargo; then
    cargo install \
      bat \
      bottom \
      exa \
      fd-find \
      git-delta \
      hyperfine \
      ripgrep \
      tokei
  fi
}

: "update_font" && {
  fc-cache -fv
}

echo "Complete installation!"

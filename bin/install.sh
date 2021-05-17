#!/usr/bin/env bash
set -eu
export LC_ALL=C
export LANG=C
IFS="$(printf " \t\nx")"

# XDG Base Directory Specification
XDG_CONFIG_HOME="${HOME}/.config"
## XDG_CACHE_HOME="${HOME}/.cache"
# XDG_DATA_HOME="${HOME}/.share"

# data direcotory for zsh
ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

ZSH_FUNCCOMP_DIR="${ZDOTDIR}/func_comp"
GHQ_ROOT="${HOME}/repo"
REPO_ROOT="${GHQ_ROOT}/github.com/diohabara/mac-dotfiles"
# DOTFILES_HOME="${REPO_ROOT}/dotfiles"

command mkdir -p "${ZSH_FUNCCOMP_DIR}"

function command_exists() {
  command -v "$1" &> /dev/null ;
}

: "install brew" && {
  if ! command_exists brew; then
    # Doc: https://brew.sh/
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  : "install packages by brew" && {
    # Doc: https://homebrew-file.readthedocs.io/en/latest/usage.html
    brew upgrade
    brew bundle install --file "${REPO_ROOT}/Brewfile" --no-lock
  }
}

: "Java" && {
  : "Java symlinking" && {
    if ! command_exists java; then
      sudo ln -sfn /usr/local/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk # java15
      sudo ln -sfn $(brew --prefix)/opt/openjdk@11/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-11.jdk # java11
      sudo ln -sfn $(brew --prefix)/opt/openjdk@8/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-8.jdk # java8
    fi
  }

  : "jenv" && {
    if [ ! -d "${HOME}/.jenv/versions" ]; then
      mkdir -p "${HOME}/.jenv/versions"
    fi
  }
}



: "install fzf settings" && {
  if command_exists fzf && [ ! -e "${HOME}/.fzf.zsh" ]; then
    $(brew --prefix)/opt/fzf/install
  fi
}

: "install go packages" && {
  if command_exists go; then
    go get -u github.com/motemen/gore/cmd/gore
    go get -u github.com/stamblerre/gocode
    go get -u golang.org/x/tools/cmd/godoc
    go get -u golang.org/x/tools/cmd/goimports
    go get -u golang.org/x/tools/cmd/gorename
    go get -u golang.org/x/tools/cmd/guru
    go get -u github.com/cweill/gotests/...
    go get -u github.com/fatih/gomodifytags
  fi
}

: "install haskell" && {
  : "install ghcup" && {
    if ! command_exists ghcup; then
      # Doc: https://gitlab.haskell.org/haskell/ghcup-hs
      curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
    else
      ghcup upgrade
    fi
  }
  : "install haskell package" && {
    if command_exists stack; then
      stack setup
      stack install hoogle
    fi

    if command_exists ghcup; then
      ghcup install hls
    fi
  }
}

: "install ocaml" && {
  : "install opam packages" && {
    if command_exists opam; then
      opam install merlin
      opam install utop
      opam install ocp-indent
      opam install dune
      opam install ocamlformat
    fi
  }
}

: "install python" && {
  : "install poetry" && {
    if ! command_exists poetry; then
      # Doc: https://python-poetry.org/docs/
      curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3
    fi
  }
  : "install via pip3" && {
    if command_exists pip3; then
      pip3 install 'python-language-server[all]'
      pip3 install atcoder-tools
      pip3 install black
      pip3 install isort
      pip3 install online-judge-tools
      pip3 install pyflakes
      pip3 install pyls-spyder
      pip3 install pytest
      pip3 install wakatime
    fi
  }
}

: "install rust packages" && {
  if ! command_exists rustup; then
    # Doc: https://www.rust-lang.org/tools/install
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
  fi
  : "install rustup components" && {
    rustup toolchain install stable
    rustup toolchain install nightly
    rustup update
    # Doc: https://rust-lang.github.io/rustup/installation/index.html#enable-tab-completion-for-bash-fish-zsh-or-powershell
    rustup completions zsh > "${ZSH_FUNCCOMP_DIR}/_rustup"
    # For rust-analyzer
    # Doc: https://rust-analyzer.github.io/manual.html#installation
    rustup component add rust-src
    # Doc: https://github.com/hlissner/doom-emacs/blob/d62c82ddbe0c9fa603be24f5eb8e563d16f5e45f/modules/lang/rust/README.org
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
      cargo install cargo-raze
      cargo install cargo-vendor
      cargo install mdbook
    fi
  }
}

: "install npm packages" && {
  if command_exists npm; then
    . "${HOME}/.profile"
    npm i -g bash-language-server
    npm install -g pyright
    npm install -g prettier
  fi
}

echo "Complete installation!"

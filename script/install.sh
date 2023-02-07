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
    if ! command_exists starship; then
      # https://github.com/starship/starship#step-1-install-starship
      curl -sS https://starship.rs/install.sh | sh
    fi
  }
  : "direnv" && {
    if ! command_exists direnv; then
      # https://direnv.net/docs/installation.html
      curl -sfL https://direnv.net/install.sh | bash
    fi
  }
  : "zplug" && {
    if ! [ -d "${HOME}/.zplug" ]; then
      curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
    fi
  }
}

: "laguages" && {
  : "python" && {
    : "pyenv" && {
      if ! command_exists pyenv; then
        # https://github.com/pyenv/pyenv#automatic-installer
        curl https://pyenv.run | bash
      fi
    }
    : "poetry" && {
      if ! command_exists poetry; then
        # https://python-poetry.org/docs/
        curl -sSL https://install.python-poetry.org | python3 -
      fi
    }
  }
  : "go" && {
    if ! command_exists go; then
      # Doc: https://github.com/kerolloz/go-installer
      bash <(curl -sL https://git.io/go-installer)
    fi
  }
  : "node" && {
    if ! command_exists volta; then
      # Doc: https://docs.volta.sh/advanced/installers
      curl https://get.volta.sh | bash
    fi
  }
  : "rust" && {
    if ! command_exists rustup; then
      # Doc: https://www.rust-lang.org/tools/install
      curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
      # shellcheck disable=SC1091
      source "${HOME}/.cargo/env"
    fi
    if command_exists rustup; then
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
    fi
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
}

: "update_font" && {
  # Doc: https://gist.github.com/matthewjberger/7dd7e079f282f8138a9dc3b045ebefa0
  declare -a fonts=(
    JetBrainsMono
    Noto
    RobotoMono
    Ubuntu
    UbuntuMono
  )

  # Doc: https://github.com/ryanoasis/nerd-fonts/branches
  version='2.3.3'
  fonts_dir="${HOME}/.local/share/fonts"

  if [[ ! -d "$fonts_dir" ]]; then
    mkdir -p "$fonts_dir"
  fi

  for font in "${fonts[@]}"; do
    zip_file="${font}.zip"
    download_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v${version}/${zip_file}"
    echo "Downloading $download_url"
    wget "$download_url"
    unzip "$zip_file" -d "$fonts_dir"
    rm "$zip_file"
  done

  find "$fonts_dir" -name '*Windows Compatible*' -delete

  fc-cache -fv
}

echo "Complete installation!"

#!/usr/bin/env sh
# XDG Base Directory Specification
XDG_CONFIG_HOME="${HOME}/.config"
XDG_CACHE_HOME="${HOME}/.cache"
XDG_DATA_HOME="${HOME}/.share"
CASK_ROOM="/usr/local/Caskroom/"

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Autocompletion
autoload -Uz compinit
compinit -u
if [ "${uname}" = "Darwin" ]; then
  chmod 755 /usr/local/share/zsh
  chmod 755 /usr/local/share/zsh/site-functions
fi
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
eval "$(gh completion -s zsh)"

# divided files
# shellcheck disable=SC1090
. "${XDG_CONFIG_HOME}/zsh/.alias"

# Shell prompt
eval "$(starship init zsh)"
export STARSHIP_CONFIG="${HOME}/.config/starship.toml"

# set color config
export TERM=xterm-color

# brew
export PATH="${PATH}:/opt/homebrew/bin"

# PATH
export PATH="${PATH}:/usr/local/bin"
export PATH="${PATH}:${HOME}/.local/bin"
export PATH="${PATH}:/usr/local/opt/binutils/bin"

# Doom Emacs
export PATH="${PATH}:${HOME}/.emacs.d/bin"

## LLVM
export PATH="/usr/local/opt/llvm/bin:${PATH}" # LLVM
export LDFLAGS="-L/usr/local/opt/llvm/lib"
export CPPFLAGS="-I/usr/local/opt/llvm/include"

# Languages
## Python
export PYENV_ROOT="${HOME}/.pyenv"
export PATH="${PATH}:${PYENV_ROOT}/bin"
eval "$(pyenv init --path)"
### poetry
# shellcheck disable=SC1090
if [ -e "${HOME}/.poetry" ]; then
  . "${HOME}/.poetry/env"
fi

## Rust
export PATH="${PATH}:${HOME}/.cargo/bin"
export PKG_CONFIG_PATH="${HOME}/bin/convert"

## Haskell
export PATH="${PATH}:${HOME}/.cabal/bin:${HOME}/.ghcup/bin"
if [ -f "${HOME}/.ghcup/env" ]; then
  . "${HOME}/.ghcup/env"
fi

## Golang
export PATH="${PATH}:${HOME}/go/bin"
export PATH="${PATH}:${HOME}/.go/bin"
export PATH="${PATH}:$(go env GOPATH)/bin"

## OCaml
eval "$(opam env)"

## LaTeX
export PATH="${PATH}:/usr/local/texlive/2020/bin/x86_64-darwin/"
export PATH="${PATH}:/Library/TeX/texbin/"

# fzf
# Doc: https://nixos.wiki/wiki/Fzf
# shllcheck disable=SC3054
if [ -n "$(which fzf-share)" ]; then
  # shellcheck disable=SC1091
  . "$(fzf-share)/key-bindings.zsh"
  # shellcheck disable=SC1091
  . "$(fzf-share)/completion.zsh"
fi

# for toolchain
# Doc: https://github.com/riscv/riscv-gnu-toolchain
# export PATH="${PATH}:/opt/riscv/bin"

# zplug
source "${HOME}/.zplug/init.zsh"
zplug "sobolevn/wakatime-zsh-plugin", from:github
zplug load

# Doc: https://nixos.wiki/wiki/Locales
# fix nix locale
export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive
# Doc: https://nix-community.github.io/home-manager/index.html#sec-install-standalone
export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}

# for LLVM dev
export PATH="$PATH:${HOME}/repo/github.com/phacility/arcanist/bin/"

# for deno
export PATH="$HOME/.deno/bin:$PATH"

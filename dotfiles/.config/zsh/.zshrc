#!/usr/bin/env sh

# XDG Base Directory Specification
XDG_CONFIG_HOME="${HOME}/.config"
XDG_CACHE_HOME="${HOME}/.cache"
XDG_DATA_HOME="${HOME}/.share"
CASK_ROOM="/usr/local/Caskroom/"

# Autocompletion
autoload -Uz compinit
compinit -u
if [ $OSTYPE == "Darwin" ]; then
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
export STARSHIP_CONFIG=~/.config/starship.toml

# PATH
export PATH="${PATH}:/usr/local/bin"
export PATH="${PATH}:${HOME}/.local/bin"

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
eval "$(pyenv init -)"
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
# shellcheck disable=SC1090
[ -f "${HOME}/.ghcup/env" ] && . "${HOME}/.ghcup/env" # ghcup-env

## Node.js
### nvm
export NVM_DIR="${HOME}/.nvm"
# shellcheck disable=SC1091
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh" # This loads nvm
# shellcheck disable=SC1091
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completio

## Java
### jenv
export PATH="${PATH}:/usr/local/opt/openjdk/bin"
export PATH="${PATH}:/usr/local/opt/openjdk@11/bin"
export PATH="${PATH}:/usr/local/opt/openjdk@8/bin"
eval "$(jenv init -)"

## LaTeX
export PATH="${PATH}:/usr/local/texlive/2020/bin/x86_64-darwin/"
export PATH="${PATH}:/Library/TeX/texbin/"

# fzf
# shellcheck disable=SC1090
[ -f "${HOME}/.fzf.zsh" ] && source "${HOME}/.fzf.zsh"

# google-cloud-sdk
# shellcheck disable=SC1090
. "${CASK_ROOM}/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
# shellcheck disable=SC1090
. "${CASK_ROOM}/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

# for toolchain
# Doc: https://github.com/riscv/riscv-gnu-toolchain
export PATH="${PATH}:/opt/riscv/bin"

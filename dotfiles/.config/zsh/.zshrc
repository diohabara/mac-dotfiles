#!/usr/bin/env sh
# load zplug
source "${HOME}/.zplug/init.zsh"

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
# shellcheck disable=SC1090
[ -f "${HOME}/.ghcup/env" ] && . "${HOME}/.ghcup/env" # ghcup-env

## Node.js
### nvm
export NVM_DIR="${HOME}/.nvm"
# shellcheck disable=SC1091
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh" # This loads nvm
# shellcheck disable=SC1091
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completio

## Golang
export PATH="${PATH}:${HOME}/go/bin"
export PATH="${PATH}:${HOME}/.go/bin"
export PATH="${PATH}:$(go env GOPATH)/bin"

## Java
### jenv
if command_exists jenv; then
	export PATH="${PATH}:/usr/local/opt/openjdk/bin"
	export PATH="${PATH}:/usr/local/opt/openjdk@11/bin"
	export PATH="${PATH}:/usr/local/opt/openjdk@8/bin"
	eval "$(jenv init -)"
fi

## OCaml
### opam
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

# zoxide
eval "$(zoxide init zsh --cmd cd)"

# google-cloud-sdk
if [ -d "${CASK_ROOM}" ]; then
	# shellcheck disable=SC1091
	. "${CASK_ROOM}/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
	# shellcheck disable=SC1091
	. "${CASK_ROOM}/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
fi

# for toolchain
# Doc: https://github.com/riscv/riscv-gnu-toolchain
export PATH="${PATH}:/opt/riscv/bin"

# zplug
zplug "sobolevn/wakatime-zsh-plugin", from:github

zplug load

# start tmux when log in
if [ "$TMUX" = "" ]; then
	tmux
fi

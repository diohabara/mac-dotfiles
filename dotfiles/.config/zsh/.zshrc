# Autocompletion
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
eval "$(gh completion -s zsh)"

# Shell prompt
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship.toml

# Alias
## for security
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
## for convenience
alias c='cargo'
alias e='emacs -nw'
alias find='fd'
alias gd='cd $(ghq root)'
alias gf='cd $(ghq list -p | fzf)'
alias gs='git status'
alias ls='exa'
alias sudo='sudo -E'
alias tree='exa -T'

# PATH
export PATH="/usr/local/bin:$PATH"
export PATH=$PATH:~/.local/bin

# Languages
## Python
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
### poetry
source $HOME/.poetry/env

## Rust
export PATH="$HOME/.cargo/bin:$PATH"
export PKG_CONFIG_PATH="$HOME/bin/convert"

## Haskell
export PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env

# Projects
## V8
export PATH=/Users/jio/repo/chromium.googlesource.com/chromium/tools/depot_tools:$PATH


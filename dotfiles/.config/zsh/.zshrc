# Autocompletion
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' # ignore lowercase

# Shell prompt
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship.toml

# Alias
alias new='emacs -nw'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias sudo='sudo -E'

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

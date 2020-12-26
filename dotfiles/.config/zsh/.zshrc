# XDG Base Directory Specification
XDG_CONFIG_HOME="${HOME}/.config"
XDG_CACHE_HOME="${HOME}/.cache"
XDG_DATA_HOME="${HOME}/.share"

# Autocompletion
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
eval "$(gh completion -s zsh)"

# Shell prompt
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship.toml

# history
export HISTFILE=${XDG_CONFIG_HOME}/zsh/.zsh_history # where to save
export HISTSIZE=1000 # max size in memory
export SAVEHIST=100000 # max size in .zsh_history
setopt hist_ignore_dups # never save duplicates
setopt EXTENDED_HISTORY # save when to start and end

# divided files
source .alias

# PATH
export PATH="/usr/local/bin:$PATH"
export PATH=$PATH:~/.local/bin
## LLVM
export PATH="/usr/local/opt/llvm/bin:$PATH" # LLVM
export LDFLAGS="-L/usr/local/opt/llvm/lib"
export CPPFLAGS="-I/usr/local/opt/llvm/include"

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


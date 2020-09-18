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

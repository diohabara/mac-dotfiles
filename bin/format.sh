#!/usr/bin/env bash
# shell script
shfmt -f . | xargs shellcheck
shfmt -f . | xargs shfmt -w
shellcheck ./dotfiles/{.profile,.zshenv}
shfmt -w ./dotfiles/{.profile,.zshenv}
shellcheck ./dotfiles/.config/zsh/{.alias,.zshenv,.zshrc}
shfmt -w ./dotfiles/.config/zsh/{.alias,.zshenv,.zshrc}

# nix
fd "nix$" dotfiles/.config/ | xargs nixfmt

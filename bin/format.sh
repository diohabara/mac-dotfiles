#!/usr/bin/env bash
# shell script
shfmt -f . | xargs shellcheck -x
shfmt -f . | xargs shfmt -w
shellcheck -x ./dotfiles/.profile
shfmt -w ./dotfiles/{.profile,.zshenv}
shfmt -w ./dotfiles/.config/zsh/{.alias,.zshenv,.zshrc}

# nix
fd --hidden --extension nix | xargs nixpkgs-fmt

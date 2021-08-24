#!/usr/bin/env bash
# shell script
shfmt -f . | xargs shellcheck
shfmt -f . | xargs shfmt -w

# nix
fd "nix$" dotfiles/.config/ | xargs nixfmt

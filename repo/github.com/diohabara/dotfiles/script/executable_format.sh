#!/usr/bin/env bash
set -euox pipefail
IFS="$(printf " \t\nx")"
# shell script
shfmt -f . | xargs shellcheck -x
shfmt -f . | xargs shfmt -w

# nix
fd --hidden --extension nix | xargs nixpkgs-fmt

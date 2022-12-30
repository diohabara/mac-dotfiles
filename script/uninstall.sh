#!/usr/bin/env bash
set -euox pipefail

IFS="$(printf " \t\nx")"

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

: "uninstall pip packages" && {
  if command_exists pip; then
    pip freeze --user | xargs pip uninstall -y
    pip freeze | xargs pip uninstall -y
  fi
}

: "uninstall opam packages" && {
  if command_exists opam; then
    opam list -i -a | xargs opam uninstall
  fi
}

: "uninstall npm packages" && {
  if command_exists npm; then
    npm ls -g --depth=0 | awk -F/ '/node_modules/ && !/\/npm$/ {print $NF}' | xargs npm -g rm
  fi
}

: "nix uninstall all store paths unused by current generations" && {
  if command_exists nix-collect-garbage; then
    sudo nix-collect-garbage -d
  fi
}

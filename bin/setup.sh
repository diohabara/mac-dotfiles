#!/usr/bin/env bash
set -euo pipefail
IFS="$(printf " \t\nx")"

REPO_URI='https://github.com/diohabara/dotfiles.git'
GHQ_ROOT="${HOME}/repo"
REPO_ROOT="${GHQ_ROOT}/github.com/diohabara/dotfiles"

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

if [ "$(uname)" = "Darwin" ] && ! command_exists xcode-select; then
  xcode-select --install
elif [ -e /etc/lsb-release ] && ! command_exists git; then
  sudo apt update
  sudo apt upgrade -y
  sudo apt install -y git
fi

if [ ! -d "${REPO_ROOT}" ]; then
  command git clone "${REPO_URI}" "${REPO_ROOT}"
else
  cd "${REPO_ROOT}"
  command git pull origin master
fi

cd "${REPO_ROOT}"

# main
./bin/format.sh
./bin/link.sh
./bin/install.sh

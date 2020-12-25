#!/usr/bin/env sh
set -eu
export LC_ALL=C
export LANG=C
IFS="$(printf " \t\nx")"

REPO_URI='https://github.com/diohabara/mac-dotfiles.git'
GHQ_ROOT="${HOME}/repo"
REPO_ROOT="${GHQ_ROOT}/github.com/diohabara/mac-dotfiles"

: "install CLT" && {
  if ! type xcode-select &> /dev/null; then
    xcode-install --install
  fi
}

if [ ! -d "${REPO_ROOT}" ]; then
    command git clone "${REPO_URI}" "${REPO_ROOT}"
else
    cd "${REPO_ROOT}"
    command git pull origin master
fi

cd "${REPO_ROOT}"
./bin/link.sh
./bin/install.sh

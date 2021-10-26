#!/usr/bin/env bash
set -euo pipefail

IFS="$(printf " \t\nx")"

GHQ_ROOT="${HOME}/repo"
REPO_ROOT="${GHQ_ROOT}/github.com/diohabara/dotfiles"
DOTFILES_HOME="${REPO_ROOT}/dotfiles"

cd "${DOTFILES_HOME}"

echo 'Symlinking dotfiles...'
find . -type d -print0 | xargs --null -I '{}' mkdir -p "${HOME}/{}"
find . -type f -print0 | xargs --null -I '{}' ln -snf "${DOTFILES_HOME}/{}" "${HOME}/{}"
echo 'Symlinking dotfiles complete.'

#!/usr/bin/env sh
set -eu
export LANG="C.UTF-8"
IFS="$(printf " \t\nx")"

GHQ_ROOT="${HOME}/repo"
REPO_ROOT="${GHQ_ROOT}/github.com/diohabara/dotfiles"
DOTFILES_HOME="${REPO_ROOT}/dotfiles"

cd "${DOTFILES_HOME}"

echo 'Symlinking dotfiles...'
find . -type d | xargs -I '{}' mkdir -p "${HOME}/{}"
find . -type f |
	xargs -I '{}' ln -snf "${DOTFILES_HOME}/{}" "${HOME}/{}"
echo 'Symlinking dotfiles complete.'

#!/usr/bin/env sh
set -eu
export LC_ALL=C
export LANG=C
IFS="$(printf " \t\nx")"

GHQ_ROOT="${HOME}/repo"
REPO_ROOT="${GHQ_ROOT}/github.com/diohabara/mac-dotfiles"
DOTFILES_HOME="${REPO_ROOT}/dotfiles"

cd "${DOTFILES_HOME}"

: "link Emacs" && {
  file="/Applications/Emacs.app"
  if [[ -L "${file}" && -d "${file}" ]]; then
    echo "Emacs already installed";
  else
    ln -s "/usr/local/opt/emacs-mac/Emacs.app" "/Applications/Emacs.app"
  fi
}

echo 'Symlinking dotfiles...'
command find . -type d | command xargs -I '{}' command mkdir -p "${HOME}/{}"
command find . -type f |
    command xargs -I '{}' command ln -snf "${DOTFILES_HOME}/{}" "${HOME}/{}"
echo 'Symlinking dotfiles complete.'

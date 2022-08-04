#!/usr/bin/env bash
set -euo pipefail
IFS="$(printf " \t\nx")"

# XDG Base Directory Specification
XDG_CONFIG_HOME="${HOME}/.config"

# data direcotory for zsh
ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# misc
ZSH_FUNCCOMP_DIR="${ZDOTDIR}/func_comp"
CURRENT_DIR="$(cd "$(dirname "$0")" && pwd)"

command mkdir -p "${ZSH_FUNCCOMP_DIR}"

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

: "install brew" && {
  if ! command_exists brew; then
    # Doc: https://brew.sh/
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    export PATH="${PATH}:/opt/homebrew/bin"
  fi

  : "install packages by brew" && {
    # Doc: https://homebrew-file.readthedocs.io/en/latest/usage.html
    brew upgrade
    brew bundle install --file "${CURRENT_DIR}/../Brewfile" --no-lock
  }
}

# : "Java" && {
#   : "Java symlinking" && {
#     if ! command_exists java; then
#       sudo ln -sfn "/usr/local/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk"             # java15
#       sudo ln -sfn "$(brew --prefix)/opt/openjdk@11/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-11.jdk" # java11
#       sudo ln -sfn "$(brew --prefix)/opt/openjdk@8/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-8.jdk"   # java8
#     fi
#   }
#
#   : "jenv" && {
#     if [ ! -d "${HOME}/.jenv/versions" ]; then
#       mkdir -p "${HOME}/.jenv/versions"
#     fi
#   }
# }

: "AppleScript" && {
  # put Dock left
  defaults write com.apple.Dock orientation -string left
  killall Dock
  # enable key repeating
  defaults write -g ApplePressAndHoldEnabled -bool false
  "${CURRENT_DIR}/apple.applescript"
}

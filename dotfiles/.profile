#!/usr/bin/env bash

# LaTeX
export PATH="${PATH}:/usr/local/texlive/2020/bin/x86_64-darwin/"
export PATH="${PATH}:/Library/TeX/texbin/"

# npm
# Doc: https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally
NPM_CONFIG_PREFIX=~/.npm-global

# Nix
# shellckeck disable=SC1091
if [ -e /Users/jio/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/jio/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

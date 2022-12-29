#!/usr/bin/env zsh
# Doc: http://zsh.sourceforge.net/Doc/Release/Files.html
export ZDOTDIR="${HOME}/.config/zsh"
. "${ZDOTDIR}/.zshenv"

### XDG Base Directory ###
# Doc: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"${HOME}/.config"}"

if [ -e "${HOME}/.nix-profile/etc/profile.d/nix.sh" ]; then . "${HOME}/.nix-profile/etc/profile.d/nix.sh"; fi # added by Nix installer
export NIX_PATH=${NIX_PATH:+$NIX_PATH:}$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels

# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End Nix

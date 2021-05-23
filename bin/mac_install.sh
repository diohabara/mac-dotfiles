#!/usr/bin/env bash
set -eu -o pipefail
export LC_ALL=C
export LANG=C
IFS="$(printf " \t\nx")"

# XDG Base Directory Specification
XDG_CONFIG_HOME="${HOME}/.config"
XDG_CACHE_HOME="${HOME}/.cache"
XDG_DATA_HOME="${HOME}/.share"

# data direcotory for zsh
ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# misc
ZSH_FUNCCOMP_DIR="${ZDOTDIR}/func_comp"
GHQ_ROOT="${HOME}/repo"
REPO_ROOT="${GHQ_ROOT}/github.com/diohabara/dotfiles"

command mkdir -p "${ZSH_FUNCCOMP_DIR}"

command_exists() {
	command -v "$1" >/dev/null 2>&1
}

: "install brew" && {
	if ! command_exists brew; then
		# Doc: https://brew.sh/
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi

	: "install packages by brew" && {
		# Doc: https://homebrew-file.readthedocs.io/en/latest/usage.html
		brew upgrade
		brew bundle install --file "${REPO_ROOT}/Brewfile" --no-lock
	}
}

: "Java" && {
	: "Java symlinking" && {
		if ! command_exists java; then
			sudo ln -sfn "/usr/local/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk"             # java15
			sudo ln -sfn "$(brew --prefix)/opt/openjdk@11/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-11.jdk" # java11
			sudo ln -sfn "$(brew --prefix)/opt/openjdk@8/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-8.jdk"   # java8
		fi
	}

	: "jenv" && {
		if [ ! -d "${HOME}/.jenv/versions" ]; then
			mkdir -p "${HOME}/.jenv/versions"
		fi
	}
}

: "install fzf settings" && {
	if command_exists fzf && [ ! -e "${HOME}/.fzf.zsh" ]; then
		"$(brew --prefix)/opt/fzf/install"
	fi
}

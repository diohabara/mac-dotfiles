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

: "install nix" && {
	if ! command_exists nix; then
		# Doc: https://nixos.org/manual/nix/stable/#sect-single-user-installation
		# Doc: https://nixos.org/manual/nix/stable/#sect-macos-installation
		if [ "$(uname)" == "Darwin" ]; then
			sh <(curl -L https://nixos.org/nix/install) --no-daemon --no-modify-profile
		else
			sh <(curl -L https://nixos.org/nix/install) --no-daemon --darwin-use-unencrypted-nix-store-volume --no-modify-profile
		fi
		# shellcheck disable=SC1091
		. "${HOME}/.nix-profile/etc/profile.d/nix.sh"
	fi

	if command_exists nix; then
		: "upgrade nix" && {
			# Doc: https://nixos.org/manual/nix/stable/#ch-upgrading-nix
			nix-channel --update
			nix-env -iA nixpkgs.nix
		}
		: "install cachix" && {
			# nix-channel --add https://nixos.org/channels/nixpkgs-unstable
			nix-channel --update
			nix-env -iA nixpkgs.cachix
		}
		: "install home manager" && {
			if ! command_exists home-manager; then
				nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
				nix-channel --update
				nix-shell '<home-manager>' -A install
			fi
			nix-channel --update
			nix-channel --update home-manager
			nix-env -f '<nixpkgs>' -iA myPackages
			home-manager switch
		}
	fi
}

case ${OSTYPE} in
darwin*)
	bash "${REPO_ROOT}/bin/mac_install.sh"
	;;
linux*)
	if [ -e /etc/debian_version ] || [ -e /etc/debian_release ]; then
		if [ -e /etc/lsb-release ]; then
			bash "${REPO_ROOT}/bin/ubuntu_install.sh"
		fi
	fi
	;;
*)
	echo "This operating system is not supported by this dotfiles"
	exit 1
	;;
esac

: "install Doom Emacs" && {
	if ! [ -d "$HOME/.emacs.d" ]; then
		git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
		~/.emacs.d/bin/doom install
	else
		~/.emacs.d/bin/doom sync
	fi
}

: "install go packages" && {
	if command_exists go; then
		go get -u -v github.com/bazelbuild/bazelisk
		go get -u -v github.com/bazelbuild/buildtools/buildifier
		go get -u -v github.com/cweill/gotests/...
		go get -u -v github.com/fatih/gomodifytags
		go get -u -v github.com/motemen/gore/cmd/gore
		go get -u -v github.com/stamblerre/gocode
		go get -u -v golang.org/x/tools/cmd/godoc
		go get -u -v golang.org/x/tools/cmd/goimports
		go get -u -v golang.org/x/tools/cmd/gorename
		go get -u -v golang.org/x/tools/cmd/guru
	fi
}

: "install ocaml" && {
	: "install opam packages" && {
		if command_exists opam; then
			opam update
			opam upgrade
			opam install dune
			opam install merlin
			opam install ocamlformat
			opam install ocp-indent
			opam install utop
		fi
	}
}

: "install python" && {
	: "install pyenv" && {
		if ! command_exists pyenv; then
			# Doc: https://github.com/pyenv/pyenv-installer
			rm -rf ~/.pyenv
			curl https://pyenv.run | bash
		fi
	}
	: "install via pip3" && {
		if command_exists pip3; then
			pip3 install --user --upgrade pip
			pip3 install --user atcoder-tools
			pip3 install --user online-judge-tools
		fi
	}
}

: "install haskell package" && {
	if command_exists stack; then
		stack setup
		stack install hoogle
	fi

	if command_exists ghcup; then
		ghcup install hls
	fi
}

: "install rust packages" && {
	if ! command_exists rustup; then
		# Doc: https://www.rust-lang.org/tools/install
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
		# shellcheck disable=SC1091
		source "${HOME}/.cargo/env"
	fi
	: "install rustup components" && {
		rustup toolchain install stable
		rustup toolchain install nightly
		rustup update
		# Doc: https://rust-lang.github.io/rustup/installation/index.html#enable-tab-completion-for-bash-fish-zsh-or-powershell
		rustup completions zsh >"${ZSH_FUNCCOMP_DIR}/_rustup"
		# For rust-analyzer
		# Doc: https://rust-analyzer.github.io/manual.html#installation
		rustup component add rust-src
		# Doc: https://github.com/hlissner/doom-emacs/blob/develop/modules/lang/rust/README.org
		rustup component add rustfmt-preview
		rustup component add clippy-preview
		# For rls
		# Doc: https://github.com/rust-lang/rls
		rustup component add rls
		rustup component add rust-analysis
		rustup component add rust-src
	}

	: "install cargo packages" && {
		if command_exists cargo; then
			cargo install cargo-check
		fi
	}
}

echo "Complete installation!"

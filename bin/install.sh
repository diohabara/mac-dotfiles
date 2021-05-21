#!/usr/bin/env bash
set -eu
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

case ${OSTYPE} in
darwin*)
	bash ./mac_install.sh
	;;
linux*)
	if [ -e /etc/debian_version ] || [ -e /etc/debian_release ]; then
		if [ -e /etc/lsb-release ]; then
			bash ./ubuntu_install.sh
		fi
	fi
	;;
esac

: "install nix" && {
	if ! command_exists nix; then
		# Doc: https://nixos.org/download.html
		curl -L https://nixos.org/nix/install | sh
		. "${HOME}/.nix-profile/etc/profile.d/nix.sh"
	fi

	if command_exists nix; then
		# Doc: https://nixos.org/manual/nix/stable/#ch-upgrading-nix
		nix-channel --update
		nix-env -iA nixpkgs.nix
	fi

	: "install nixpkgs" && {
		if command_exists nix-env; then
			# Doc: https://nixos.org/manual/nixpkgs/stable/#sec-declarative-package-management
			nix-env -iA nixpkgs.myPackages
		fi
	}
}

: "install Doom Emacs" && {
	if ! [ -d "$HOME/.emacs.d" ]; then
		git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
		~/.emacs.d/bin/doom install
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
		go get -u -v github.com/x-motemen/ghq
		go get -u -v golang.org/x/tools/cmd/godoc
		go get -u -v golang.org/x/tools/cmd/goimports
		go get -u -v golang.org/x/tools/cmd/gorename
		go get -u -v golang.org/x/tools/cmd/guru
	fi
}

: "install ocaml" && {
	: "install opam packages" && {
		if command_exists opam; then
			opam install merlin
			opam install utop
			opam install ocp-indent
			opam install dune
			opam install ocamlformat
		fi
	}
}

: "install python" && {
	: "install pyenv" && {
		if ! command_exists pyenv; then
			# Doc: https://github.com/pyenv/pyenv-installer
			rm -rf ~/.pyenv
			curl https://pyenv.run | bash
			# Doc: https://github.com/pyenv/pyenv
		fi
	}
	: "install via pip3" && {
		if command_exists pip3; then
			pip3 install --upgrade pip
			pip3 install --user 'python-language-server[all]'
			pip3 install --user atcoder-tools
			pip3 install --user black
			pip3 install --user isort
			pip3 install --user nose
			pip3 install --user online-judge-tools
			pip3 install --user pyflakes
			pip3 install --user pyls-spyder
			pip3 install --user pytest
			pip3 install --user wakatime
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
		source "$HOME/.cargo/env"
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
		# Doc: https://github.com/hlissner/doom-emacs/blob/d62c82ddbe0c9fa603be24f5eb8e563d16f5e45f/modules/lang/rust/README.org
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
			cargo install cargo-raze
			cargo install cargo-vendor
			cargo install mdbook
			cargo install git-delta
		fi
	}
}

: "install npm packages" && {
	if command_exists npm; then
		. "${HOME}/.profile"
		npm i -g bash-language-server
		npm install -g pyright
		npm install -g prettier
	fi
}

echo "Complete installation!"

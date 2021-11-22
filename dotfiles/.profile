
#### FIG ENV VARIABLES ####
# Please make sure this block is at the start of this file.
[ -s ~/.fig/shell/pre.sh ] && source ~/.fig/shell/pre.sh
#### END FIG ENV VARIABLES ####
#!/usr/bin/env bash
# Doc: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME}:${HOME}/.config"

export LANG="C.UTF-8"

# Nix
if [ -e /home/jio/.nix-profile/etc/profile.d/nix.sh ]; then
	. /home/jio/.nix-profile/etc/profile.d/nix.sh
fi
if [ "${OSTYPE}" = "linux-gnu" ]; then
	export XDG_DATA_DIRS="${XDG_DATA_DIRS}:${HOME}/.nix-profile/share"

	# Doc: https://danielmangum.com/posts/vivado-2020-x-ubuntu-20-04/
	VIVADO_PATH="/tools/Xilinx/Vivado/2020.3/bin"
	if [ -d "${VIVADO_PATH}" ]; then
		export PATH="${PATH}:${VIVADO_PATH}"
	fi
fi

# LaTeX
export PATH="${PATH}:/usr/local/texlive/2020/bin/x86_64-darwin/"
export PATH="${PATH}:/Library/TeX/texbin/"

# npm
# Doc: https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally
NPM_CONFIG_PREFIX=~/.npm-global

# Python
export PATH="${PATH}:${HOME}/.poetry/bin"

# Golang
# https://golang.org/doc/install#install
export PATH="${PATH}:${HOME}/go/bin"
export PATH="${PATH}:${HOME}/.go/bin"
export PATH="${PATH}:$(go env GOPATH)/bin"

#### FIG ENV VARIABLES ####
# Please make sure this block is at the end of this file.
[ -s ~/.fig/fig.sh ] && source ~/.fig/fig.sh
#### END FIG ENV VARIABLES ####

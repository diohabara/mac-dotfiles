let pkgs = import <nixpkgs> { };
in {
  allowBroken = true;
  allowUnfree = true;
  allowUnsupportedSystem = true;
  nixpkgs.config.allowUnfree = true;
  packageOverrides = pkgs:
    with pkgs; rec {
      myPackages = pkgs.buildEnv {
        name = "my-packages";
        paths = [
          alacritty
          aspell
          bat
          bazel
          bazel-buildtools
          black
          bottom
          ccls
          cmake
          coreutils
          curl
          delta
          dust
          editorconfig-checker
          editorconfig-core-c
          exa
          expat
          fd
          ffmpeg
          flock
          fzf
          gawk
          gdb
          gh
          ghc
          ghq
          gibo
          git
          gmp
          gnused
          go
          gocode
          golangci-lint
          gomodifytags
          gore
          gotests
          gradle
          gzip
          haskellPackages.ghcup
          hyperfine
          isl
          jq
          libmpc
          libtelnet
          mdbook
          mpfr
          neofetch
          neovim
          nixfmt
          nodePackages.bash-language-server
          nodePackages.js-beautify
          nodePackages.npm
          nodePackages.prettier
          nodePackages.pyright
          nodePackages.stylelint
          nodejs
          opam
          openssl
          pandoc
          pipenv
          pkg-config
          poetry
          procs
          python38Packages.python-language-server
          python39
          python39Packages.isort
          python39Packages.nose
          python39Packages.pip
          python39Packages.pyflakes
          python39Packages.pytest
          readline
          ripgrep
          rlwrap
          roswell
          rufo
          rust-analyzer
          sbcl
          sd
          shellcheck
          shfmt
          stack
          starship
          tcl
          tectonic
          tldr
          tmux
          tokei
          typora
          unzip
          wakatime
          wget
          xz
          yarn
          youtube-dl
          zlib
        ];
      };
    };
}

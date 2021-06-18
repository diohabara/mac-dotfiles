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
          # node packages
          nodePackages.bash-language-server
          nodePackages.js-beautify
          nodePackages.npm
          nodePackages.prettier
          nodePackages.pyright
          nodePackages.stylelint
          nodejs
          # Python packages
          python38Packages.python-language-server
          python39
          python39Packages.isort
          python39Packages.nose
          python39Packages.pip
          python39Packages.pyflakes
          python39Packages.pytest
          pipenv
          # Rust packages
          alacritty
          bat
          exa
          fd
          hyperfine
          tokei
          procs
          # Go packages
          fzf
          ghq
          go
          gocode
          golangci-lint
          gomodifytags
          gore
          gotests
          # Haskell packages
          ghc
          haskellPackages.ghcup
          stack
          # others
          aspell
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
          expat
          ffmpeg
          flock
          gawk
          gdb
          gh
          gibo
          git
          gmp
          gnused
          gradle
          gzip
          isl
          jq
          libmpc
          libtelnet
          mdbook
          mpfr
          neofetch
          neovim
          nixfmt
          opam
          openssl
          pandoc
          pkg-config
          poetry
          readline
          ripgrep
          rlwrap
          roswell
          rsync
          rufo
          rust-analyzer
          sbcl
          sd
          shellcheck
          shfmt
          starship
          tcl
          tectonic
          tldr
          tmux
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

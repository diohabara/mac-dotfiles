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
          pipenv
          python38Packages.python-language-server
          python39
          python39Packages.isort
          python39Packages.nose
          python39Packages.pip
          python39Packages.pyflakes
          python39Packages.pytest
          wakatime
          # Rust packages
          alacritty
          bat
          bottom
          delta
          dust
          exa
          fd
          hyperfine
          mdbook
          procs
          ripgrep
          rust-analyzer
          sd
          tokei
          # Go packages
          fzf
          ghq
          go
          gocode
          golangci-lint
          gomodifytags
          gore
          gotests
          tectonic
          # Haskell packages
          ghc
          haskellPackages.ghcup
          pandoc
          stack
          # others
          aspell
          bazel
          bazel-buildtools
          black
          ccls
          cmake
          coreutils
          curl
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
          mpfr
          neofetch
          neovim
          nixfmt
          opam
          openssl
          pkg-config
          poetry
          readline
          rlwrap
          roswell
          rsync
          rufo
          sbcl
          shellcheck
          shfmt
          starship
          tcl
          tldr
          tmux
          typora
          unzip
          wget
          xz
          yarn
          youtube-dl
          zlib
        ];
      };
    };
}

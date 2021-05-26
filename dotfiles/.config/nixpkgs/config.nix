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
          bat
          bazel
          bazel-buildtools
          black
          ccls
          cmake
          coreutils
          curl
          delta
          pipenv
          dust
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
          golangci-lint
          gradle
          gzip
          haskellPackages.ghcup
          hyperfine
          isl
          jdk8_headless
          jq
          libmpc
          mdbook
          mpfr
          neofetch
          neovim
          nixfmt
          nodePackages.bash-language-server
          nodePackages.npm
          nodePackages.prettier
          nodePackages.pyright
          nodejs
          opam
          openssl
          pandoc
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

let pkgs = import <nixpkgs> { };
in {
  allowBroken = true;
  allowUnfree = true;
  allowUnsupportedSystem = true;
  nixpkgs.config.allowUnfree = true;
  packageOverrides = pkgs:
    with pkgs; {
      myPackages = pkgs.buildEnv {
        name = "my-packages";
        paths = [
          alacritty
          bat
          bazel
          bazel-buildtools
          shfmt
          ccls
          cmake
          coreutils
          curl
          delta
          docker
          dust
          exa
          expat
          #fcitx-engines.mozc
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
          nodePackages.npm
          nodejs
          openssl
          pandoc
          pkg-config
          poetry
          procs
          python39
          python39Packages.pip
          readline
          ripgrep
          rlwrap
          roswell
          rufo
          sbcl
          sd
          shellcheck
          stack
          starship
          tcl
          tectonic
          tldr
          tmux
          tokei
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

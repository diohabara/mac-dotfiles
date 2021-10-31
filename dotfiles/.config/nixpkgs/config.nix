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
          poetry
          # python39Packages.python-lsp-server
          # python38Packages.python-language-server
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
          starship
          tectonic
          tokei
          zellij
          zoxide

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
          # haskellPackages.ghc_8_10_2
          # haskellPackages.ghcup
          # haskellPackages.hls
          haskellPackages.hoogle
          haskellPackages.pandoc
          haskellPackages.stack

          # OCaml package
          # ocamlPackages.merlin
          dune_2
          ocamlPackages.async
          ocamlPackages.core
          ocamlPackages.js_of_ocaml
          ocamlPackages.js_of_ocaml-ppx
          ocamlPackages.ocaml-lsp
          ocamlPackages.ocamlformat-rpc-lib
          ocamlPackages.ocp-indent
          ocamlPackages.utop
          ocamlformat
          opam

          # Git tools
          gh
          git
          git-lfs

          # editor
          neovim

          # others
          aspell
          bazel
          bazel-buildtools
          binutils
          bison
          black
          broot
          ccls
          cmake
          coreutils
          coreutils
          curl
          editorconfig-checker
          editorconfig-core-c
          expat
          ffmpeg
          flock
          gawk
          gdb
          gibo
          glslang
          gmp
          gnused
          gradle
          graphviz
          gzip
          isl
          jq
          libmpc
          libtelnet
          llvm
          mpfr
          neofetch
          ninja
          nixfmt
          openssl
          pkg-config
          readline
          rlwrap
          roswell
          rsync
          rufo
          sbcl
          shellcheck
          shfmt
          tcl
          tldr
          tmux
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

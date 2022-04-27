{ config, pkgs, ... }:

let
  name = "diohabara";
  email = "diohabara@gmail.com";
  githubUsername = "diohabara";
in
{
  # config
  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;

  home = {
    username = "${name}";
    packages = with pkgs; [
      # fonts
      # Docs: https://github.com/ryanoasis/nerd-fonts/blob/master/bin/scripts/lib/fonts.json
      (nerdfonts.override {
        fonts = [
          "AnonymousPro"
          "FiraCode"
          "JetBrainsMono"
          "Noto"
          "Ubuntu"
          "UbuntuMono"
        ];
      })

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
      python39Packages.python-lsp-server
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
      tidy-viewer
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
      #haskellPackages.ghc_8_10_2
      #haskellPackages.ghcup
      #haskellPackages.hls
      haskellPackages.hoogle
      haskellPackages.pandoc
      haskellPackages.stack

      # OCaml package
      opam

      # Git tools
      act
      gh
      git
      git-lfs

      # editor
      #neovim

      # others
      #bazel
      #bazel-buildtools
      #binutils
      #ccls
      #clang-tools
      #jdk11
      #jdk8
      #reattach-to-user-namespace
      aspell
      bison
      black
      broot
      cachix
      cmake
      coq
      coreutils
      curl
      docker
      docker-compose
      editorconfig-checker
      editorconfig-core-c
      expat
      ffmpeg
      findutils
      flock
      fontconfig
      gawk
      gdb
      gibo
      glslang
      gmp
      gnused
      gradle
      graphviz
      gzip
      imagemagick
      inkscape
      isl
      jq
      libmpc
      libtelnet
      llvm
      mpfr
      neofetch
      neovim
      ninja
      nixfmt
      nixpkgs-fmt
      openssl
      pkg-config
      readline
      rlwrap
      rnix-lsp
      roswell
      rsync
      rufo
      shellcheck
      shfmt
      tcl
      texlive.combined.scheme-minimal
      tikzit
      tldr
      tmux
      unzip
      verilog
      wget
      xz
      yarn
      yt-dlp
      zlib
    ];
  };

  # programs.bat = {
  #   enable = true;
  #   config = {
  #     theme = "GitHub";
  #     italic text = "always";
  #   };
  # };

  # programs.git = {
  #   enable = true;
  #   userName = "diohabara";
  #   userEmail = "diohabara@gmail.com";
  #   extraConfig = {
  #     core = {
  #       editor = "nvim";
  #       quotepath = "false";
  #       excludefile = "~/.git/ignore";
  #     };
  #     color = {
  #       ui = "auto";
  #     };
  #     push = {
  #       default = "simple";
  #     };
  #     pull = {
  #       ff = "only";
  #     };
  #     init = {
  #       templatedir = "~/.config/git/templates";
  #       defaultBranch = "main";
  #     };
  #   };
  #   ignores = [
  #     ".DS_Store"
  #   ];
  #   delta = {
  #     navigate = true;
  #     line numbers = true;
  #     syntax theme = "GitHub";
  #   };
  # };
}


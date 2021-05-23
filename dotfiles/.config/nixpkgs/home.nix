# Ref: https://github.com/JonathanReeve/dotfiles/blob/minimal/dotfiles/home.nix
{ pkgs, ... }:

let
  name = "diohabara";
  email = "diohabara@gmail.com";
  githubUsername = "diohabara";
in {
  fonts.fontconfig.enable = true;
  programs = { home-manager = { enable = true; }; };
  home = {
    username = "${name}";
    packages = with pkgs; [
      alacritty
      bash
      bat
      bazel
      bazel-buildtools
      ccls
      clang_12
      cmake
      coreutils
      curl
      delta
      docker
      du-dust
      dust
      exa
      expat
      fcitx-engines.mozc
      fd
      ffmpeg
      flock
      fzf
      gawk
      gcc
      gdb
      gh
      ghc
      ghq
      gibo
      git
      gmp
      gnumake
      gnused
      go
      golangci-lint
      gradle
      gzip
      haskellPackages.ghcup
      hyperfine
      hyperfine
      isl
      jdk8_headless
      jq
      libgccjit
      libmpc
      llvm
      mdbook
      mpfr
      mysql
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
      sqlite
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
      zsh

      # fonts
      cascadia-code
      dejavu_fonts
      jetbrains-mono
      nerdfonts
      noto-fonts-cjk
      powerline-fonts
      roboto
      source-code-pro
      emacs-all-the-icons-fonts
    ];
  };
}

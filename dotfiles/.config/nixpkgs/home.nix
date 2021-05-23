# Ref: https://github.com/JonathanReeve/dotfiles/blob/minimal/dotfiles/home.nix
{ pkgs, ... }:

let
  name = "diohabara";
  email = "diohabara@gmail.com";
  githubUsername = "diohabara";
in {
  fonts.fontconfig.enable = true;
  programs.home-manager.enable = true;
  home = {
    username = "${name}";
    packages = with pkgs; [
      alacritty
      bash
      bat
      bazel
      bazel-buildtools
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

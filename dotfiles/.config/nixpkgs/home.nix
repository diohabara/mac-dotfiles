{ config, lib, pkgs, ... }:

let
  name = "diohabara";
  email = "diohabara@gmail.com";
  githubUsername = "diohabara";
in
{
  # config
  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;
  home.stateVersion = "22.05";
  home.homeDirectory = builtins.getEnv "HOME";
  home.language.base = "en_US.UTF-8";

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
      # Rust packages
      bat
      bottom
      delta
      exa
      fd
      hyperfine
      ripgrep
      rust-analyzer
      starship
      tectonic

      # Go packages
      fzf
      ghq
      shfmt

      # Git tools
      act
      gh
      git
      git-lfs

      # editor
      neovim

      # nix
      rnix-lsp
      nixfmt
      nixpkgs-fmt

      # others
      cachix
      editorconfig-checker
      editorconfig-core-c
      ffmpeg
      fontconfig
      gawk
      gdb
      gmp
      gnused
      gzip
      imagemagick
      isl
      libmpc
      libtelnet
      most
      mpfr
      neofetch
      shellcheck
      tldr
      yt-dlp
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


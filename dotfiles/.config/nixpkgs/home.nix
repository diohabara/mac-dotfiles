{ config, lib, pkgs, ... }:

let
  name = "卍diohabara卍";
  email = "diohabara@gmail.com";
  githubUsername = "diohabara";
in
{
  # config
  manual.manpages.enable = false;
  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;
  home.stateVersion = "22.11"; # https://github.com/nix-community/home-manager/blob/master/modules/misc/version.nix
  home.homeDirectory = builtins.getEnv "HOME";

  home = {
    username = "${name}";
    packages = with pkgs; [
      # fonts
      # Docs: https://github.com/ryanoasis/nerd-fonts/blob/master/bin/scripts/lib/fonts.json
      (nerdfonts.override {
        fonts = [
          "AnonymousPro"
          "DejaVuSansMono"
          "FiraCode"
          "JetBrainsMono"
          "Noto"
          "Ubuntu"
          "UbuntuMono"
        ];
      })
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
      wget
      yt-dlp
    ];
  };
}


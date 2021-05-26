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
      dejavu_fonts
      emacs-all-the-icons-fonts
      nerdfonts
      noto-fonts-cjk
      powerline-fonts
      roboto
      source-code-pro
    ];
  };

  #  nixpkgs.overlays = [
  #    (import (builtins.fetchTarball {
  #      url =
  #        "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
  #    }))
  #  ];
  #
  #  programs.emacs = {
  #    enable = true;
  #    package = pkgs.emacsGcc;
  #    extraPackages = (epkgs: [ epkgs.vterm ]);
  #  };
}

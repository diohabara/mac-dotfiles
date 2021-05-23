{ pkgs, ... }:

let
  name = "diohabara";
  email = "diohabara@gmail.com";
  githubUsername = "diohabara";
in {
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome3.enable = true;
  fonts.fontconfig.enable = true;
  programs.home-manager.enable = true;
  home = {
    username = "${name}";
    packages = with pkgs; [
      cascadia-code
      dejavu_fonts
      emacs-all-the-icons-fonts
      emacs-all-the-icons-fonts
      hello
      jetbrains-mono
      noto-fonts-cjk
      powerline-fonts
      roboto
      source-code-pro
    ];
  };

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url =
        "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
    }))
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacsGcc;
    extraPackages = (epkgs: [ epkgs.vterm ]);
  };
}

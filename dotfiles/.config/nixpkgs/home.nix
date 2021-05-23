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

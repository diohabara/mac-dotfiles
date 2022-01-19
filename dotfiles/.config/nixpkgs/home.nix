{ pkgs, ... }:

let
  name = "diohabara";
  email = "diohabara@gmail.com";
  githubUsername = "diohabara";
in
{
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
}

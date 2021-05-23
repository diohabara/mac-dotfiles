{ pkgs, ... }:

{
  nixpkgs.config = {
    allowUnsupportedSystem = true;
    allowUnfree = true;
  };

  # Fonts!
  fonts.fonts = with pkgs; [
    jetbrains-mono
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
  ];

  environment.variables = { EDITOR = "emacsclient -c"; };

  services = {
    emacs = {
      enable = true;
      defaultEditor = true;
    };
  };
}

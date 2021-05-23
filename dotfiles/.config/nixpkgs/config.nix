{ config, lib, pkgs, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
  };

  # Fonts!
  fonts.fonts = with pkgs; [
    jetbrains-mono
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
  ];
  environment.systemPackages = with pkgs; [
     home-manager           
     gcc gnumake
     wget
     pandoc                 
     tectonic               
     git                    
     stack
     ghc
     (python3.withPackages(ps: with ps; [
       pandas
       jupyter
     ]))
     fzf                    
     bat                    
     fd                     
   ];

  environment.variables = {
    EDITOR = "emacsclient -c";
  };

  services = {
    emacs = {
      enable = true;
      defaultEditor = true;
    };
  };
}

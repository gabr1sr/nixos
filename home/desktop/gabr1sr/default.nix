{ config, pkgs, ... }: {
  imports =
    [ ./programs/git.nix ./programs/direnv.nix ./programs/vscodium.nix ];

  nixpkgs.config.allowUnfree = true;

  home.username = "gabr1sr";
  home.homeDirectory = "/home/gabr1sr";

  home.stateVersion = "23.11";

  home.packages = [
    pkgs.authy
    pkgs.spotify
    pkgs.discord

    pkgs.vscode-solidity-server

    pkgs.dangerzone
  ];

  home.file = { };

  home.sessionVariables = { };

  programs.home-manager.enable = true;
  programs.emacs.enable = true;
  programs.bash = { enable = true; };
}

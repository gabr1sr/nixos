{ config, pkgs, ... }:

{
  imports = [
    ./programs/firefox.nix
    ./programs/polybar.nix
    ./programs/i3.nix
    ./programs/direnv.nix
    ./programs/kitty.nix
    ./programs/dunst.nix
    ./programs/git.nix
  ];
  
  home.username = "gabriel";
  home.homeDirectory = "/home/gabriel";

  home.stateVersion = "23.11";

  home.packages = [
    # i3
    pkgs.i3status
    pkgs.i3lock
    pkgs.i3blocks
    pkgs.dmenu

    # Rust
    pkgs.rust-bin.stable.latest.default
    pkgs.rust-analyzer
    pkgs.rust-script

    # Solidity
    pkgs.solc
    pkgs.nur.repos.gabr1sr.vscode-solidity-server

    # Cairo
    pkgs.nur.repos.gabr1sr.starknet-foundry-bin
    pkgs.nur.repos.gabr1sr.scarb-bin
  ];

  home.file = {};

  services.flameshot = {
    enable = true;

    settings = {
      General = {
        disabledTrayIcon = true;
        showStartupLaunchMessage = false;
      };
    };
  };

  home.sessionVariables = {
    EDITOR = "emacs";
  };

  programs.home-manager.enable = true;
  programs.bash.enable = true;
}

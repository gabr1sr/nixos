{ config, pkgs, ... }: {
  imports =
    [ ./programs/git.nix ./programs/direnv.nix ./programs/vscodium.nix ];

  nixpkgs.config.allowUnfree = true;

  home.username = "gabr1sr";
  home.homeDirectory = "/home/gabr1sr";

  home.stateVersion = "23.11";

  home.packages = [
    # Unfree
    pkgs.authy
    pkgs.spotify
    pkgs.discord

    # Misc
    pkgs.dangerzone
    pkgs.protonup-qt

    # Gaming
    pkgs.clonehero

    # Starknet / Cairo
    pkgs.nur.repos.gabr1sr.starknet-foundry-bin
    pkgs.nur.repos.gabr1sr.scarb-bin

    # Rust
    pkgs.rust-bin.stable.latest.default
    pkgs.rust-analyzer
    pkgs.rust-script
  ];

  home.file = { };

  home.sessionVariables = { };

  programs.home-manager.enable = true;
  programs.emacs.enable = true;
  programs.bash = { enable = true; };
}

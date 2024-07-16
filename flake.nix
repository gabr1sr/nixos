{
  description = "My NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";
    nur.url = "github:nix-community/nur";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, nixpkgs, hardware, nur, home-manager, emacs-overlay, rust-overlay, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;

        overlays = [
          nur.overlay
          emacs-overlay.overlay
          rust-overlay.overlays.default
          (import ./overlays { inherit inputs system; })
        ];

        config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
          "spotify"
          "steam"
          "steam-run"
          "steam-original"
          "zerotierone"
          "clonehero"
          "mongodb"
          "google-chrome"
          "discord"
        ];
      };
    in {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt;

      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          inherit pkgs;
          specialArgs = { inherit inputs; };
          modules = [ ./host/desktop ];
        };
      };

      homeConfigurations = {
        "gabriel@desktop" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; };

          modules = [
            ./home/desktop/gabriel
            { imports = [ inputs.nur.hmModules.nur ]; }
          ];
        };
      };

      templates = {
        foundry = {
          description = "Foundry Project";
          path = ./templates/foundry;
        };

        foundry-devenv = {
          description = "Foundry Project (devenv)";
          path = ./templates/foundry-devenv;
        };

        rust = {
          description = "Rust Project";
          path = ./templates/rust;
        };

        rust-nightly = {
          description = "Rust Nightly Project";
          path = ./templates/rust-nightly;
        };

        nodejs = {
          description = "Node.js Project";
          path = ./templates/nodejs;
        };

        elixir = {
          description = "Elixir Mix Project";
          path = ./templates/elixir;
        };
      };
    };
}

{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:NixOS/nixos-hardware";
    nur.url = "github:nix-community/NUR";

    rust-overlay.url = "github:oxalica/rust-overlay";
    
    homeManager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nur, hardware, rust-overlay, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          nur.overlay
          (import ./overlays { inherit inputs system; })
          (import rust-overlay)
        ];
      };
    in {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt;

      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [ ./host/desktop/configuration.nix ];
        };
      };

      homeConfigurations = {
        "gabr1sr@desktop" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./home/desktop/gabr1sr/default.nix

            { imports = [ inputs.nur.hmModules.nur ]; }
          ];
        };
      };
    };
}

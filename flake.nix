{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:NixOS/nixos-hardware";
    nur.url = "github:nix-community/nur";

    homeManager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nur, hardware, ... }@inputs:
  {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
	      modules = [
	        ./host/desktop/configuration.nix
	      ];
      };
    };

    homeConfigurations = {
      "gabr1sr@desktop" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
	      extraSpecialArgs = { inherit inputs; };
	      modules = [
	        ./home/desktop/gabr1sr/default.nix

          {
	          imports = [ inputs.nur.hmModules.nur ];
	        }
	      ];
      };
    };
  };
}

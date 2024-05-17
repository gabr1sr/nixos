{
  description = "Solidity project using Foundry";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    foundry.url = "github:shazow/foundry.nix";
    nur.url = "github:nix-community/NUR";
  };

  outputs = { self, nixpkgs, utils, foundry, nur }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ foundry.overlay nur.overlay ];
        };
      in {
        devShell = pkgs.mkShell {
          buildInputs = [
            pkgs.nur.repos.gabr1sr.vscode-solidity-server
            pkgs.foundry-bin
            pkgs.solc
          ];

          shellHook = ''
            export PS1="[solidity] $PS1"
          '';
        };
    });
}

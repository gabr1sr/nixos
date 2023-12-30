{ inputs, system, ... }:

final: prev: {
  vscode-solidity-server = final.callPackage ../packages/vscode-solidity-server.nix { };
}

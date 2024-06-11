{ pkgs, config, inputs, ... }:

{
  imports = [ inputs.nur.nixosModules.nur ];

  packages = [ config.nur.repos.gabr1sr.vscode-solidity-server ];

  cachix.enable = false;
  
  languages.solidity.enable = true;
  languages.solidity.foundry.enable = true;

  enterShell = ''
    if [ ! -e ./foundry.toml ]; then
      forge init --force
    fi
  '';

  enterTest = ''
    forge test
  '';
}

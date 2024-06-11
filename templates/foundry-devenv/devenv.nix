{ pkgs, config, inputs, ... }:

{
  imports = [ inputs.nur.nixosModules.nur ];

  packages = [ pkgs.nur.repos.gabr1sr.vscode-solidity-server ];
  
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

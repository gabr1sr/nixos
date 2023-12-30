{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    userSettings = {
      "editor.fontFamily" = "JetBrains Mono";
      "terminal.integrated.fontFamily" = "JetBrains Mono";
    };

    extensions = with pkgs.vscode-extensions; [
      JuanBlanco.solidity
      tintinweb.solidity-visual-auditor
      editorconfig.editorconfig
    ];
  };
}

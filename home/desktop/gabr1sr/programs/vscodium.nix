{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    userSettings = {
      "editor.fontFamily" = "JetBrains Mono";
      "terminal.integrated.fontFamily" = "JetBrains Mono";
      "workbench.colorTheme" = "Solidity Visual Developer Dark";
    };

    extensions = with pkgs.vscode-extensions; [
      editorconfig.editorconfig
    ];
  };
}

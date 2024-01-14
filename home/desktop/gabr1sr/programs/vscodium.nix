{ config, pkgs, ... }: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    userSettings = {
      "editor.fontFamily" = "JetBrains Mono";
      "terminal.integrated.fontFamily" = "JetBrains Mono";
      "workbench.colorTheme" = "Solidity Visual Developer Dark";
    };

    extensions = with pkgs.vscode-extensions; [
      # Solidity
      juanblanco.solidity
      tintinweb.solidity-visual-auditor
      tintinweb.vscode-solidity-language

      # Misc
      jebbs.plantuml
      editorconfig.editorconfig
      tintinweb.graphviz-interactive-preview
      starkware.cairo1
    ];
  };
}

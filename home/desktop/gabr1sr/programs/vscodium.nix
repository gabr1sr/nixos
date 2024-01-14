{ config, pkgs, ... }: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    userSettings = {
      "editor.fontFamily" = "JetBrains Mono";
      "terminal.integrated.fontFamily" = "JetBrains Mono";
      "workbench.colorTheme" = "Solidity Visual Developer Dark";
      "rust-analyzer.server.path" = "${pkgs.rust-analyzer}/bin/rust-analyzer";
    };

    extensions = with pkgs.vscode-extensions; [
      # Solidity
      juanblanco.solidity
      tintinweb.solidity-visual-auditor
      tintinweb.vscode-solidity-language

      # Rust
      rust-lang.rust-analyzer
      bungcip.better-toml
      starkware.cairo1
      
      # Misc
      jebbs.plantuml
      editorconfig.editorconfig
      tintinweb.graphviz-interactive-preview
    ];
  };
}

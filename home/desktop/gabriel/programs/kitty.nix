{ config, pkgs, ... }: {
  programs.kitty = {
    enable = true;
    theme = "Doom One";
    shellIntegration.enableBashIntegration = true;

    font = {
      name = "JetBrains Mono";
      package = pkgs.jetbrains-mono;
    };
  };
}

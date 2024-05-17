{ config, pkgs, ... }: {
  programs.git = {
    enable = true;
    package = pkgs.gitFull;

    userName = "Gabriel Rosa";
    userEmail = "gabr1sr@proton.me";

    signing = {
      key = "962539742E68B192";
      signByDefault = true;
    };

    extraConfig = {
      color.ui = true;
      core.askPass = "";
      credential.helper = "store";
      github.user = "gabr1sr";
      init.defaultBranch = "master";
    };
  };
}

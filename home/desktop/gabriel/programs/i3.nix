{ config, pkgs, lib, ... }:
let
  modifier = "Mod4";
in {
  xsession = {
    enable = true;

    scriptPath = ".hm-xsession";
    
    windowManager = {
      command = "${pkgs.i3}/bin/i3";
      
      i3 = {
        enable = true;

        config = {
          modifier = modifier;
          terminal = "kitty";
          defaultWorkspace = "workspace number 1";

          colors = {
            focused = {
              background = "#E5C07B";
              border = "#E5C07B";
              childBorder = "#E5C07B";
              indicator = "#E5C07B";
              text = "#282C34";
            };

            focusedInactive = {
              background = "#282C34";
              border = "#282C34";
              childBorder = "#282C34";
              indicator = "#282C34";
              text = "#ABB2BF";
            };

            unfocused = {
              background = "#282C34";
              border = "#282C34";
              childBorder = "#282C34";
              indicator = "#282C34";
              text = "#ABB2BF";
            };

            urgent = {
              background = "#E06C75";
              border = "#E06C75";
              childBorder = "#E06C75";
              indicator = "#E06C75";
              text = "#282C34";
            };

            placeholder = {
              background = "#61AFEF";
              border = "#61AFEF";
              childBorder = "#61AFEF";
              indicator = "#61AFEF";
              text = "#282C34";
            };

            background = "#ffffff";
          };
          
          window = {
            hideEdgeBorders = "smart";
            titlebar = false;
            border = 3;
          };

          gaps = {
            inner = 2;
            outer = 0;
            smartBorders = "on";
            smartGaps = true;
          };
          
          startup = [
            { command = "systemctl --user restart polybar"; always = true; notification = false; }
          ];

          keybindings = lib.mkOptionDefault {
            "${modifier}+d" = "exec ${pkgs.dmenu}/bin/dmenu_run -b";
            "Print" = ''exec "flameshot gui"'';
          };

          bars = [ ];
        };
      };
    };
  };
}

{ config, pkgs, ... }: {
  services.polybar = {
    enable = true;

    package = pkgs.polybar.override {
      alsaSupport = true;
      pulseSupport = true;
    };

    script = "polybar main &";

    config = let
      background = "#282C34";
      foreground = "#ABB2BF";
      red = "#E06C75";
      green = "#98C379";
      yellow = "#E5C07B";
      blue = "#61AFEF";
      purple = "#C678DD";
      turquoise = "#56B6C2";
      disabled = "#707880";
      sep = "#3F5360";
      fill = "⏽";
      empty = "⏽";
      indicator = "";
    in {
      "bar/main" = {
        width = "100%";
        height = "24pt";
        line-size = "3pt";

        background = background;
        foreground = foreground;

        font-0 = "JetBrains Mono:size=9:style=Regular;0";
        font-1 = "JetBrains Mono:size=9:style=Regular;2";
        font-2 = "feather:size=12;3";

        fixed-center = true;
        
        module-margin = 1;
        
        modules-left = "xworkspaces";
        modules-center = "xwindow";
        modules-right = "cpu memory filesystem network keyboard volume date tray";
      };

      "module/xworkspaces" = {
        type = "internal/xworkspaces";

        label-active = "%name%";
        label-active-font = 2;
        label-active-background = background;
        label-active-underline = yellow;
        label-active-padding = 1;

        label-occupied = "%name%";
        label-occupied-font = 2;
        label-occupied-padding = 1;

        label-urgent = "%name%";
        label-urgent-font = 2;
        label-urgent-background = red;
        label-urgent-padding = 1;

        label-empty = "%name%";
        label-empty-font = 2;
        label-empty-foreground = disabled;
        label-empty-padding = 1;
      };

      "module/xwindow" = {
        type = "internal/xwindow";
        label = "%title%";
        label-maxlen = 50;
        label-font = 2;
      };

      "module/cpu" = {
        type = "internal/cpu";
        interval = 1;

        format = "<label>";
        format-prefix = "";
        format-prefix-foreground = red;

        label = " %percentage%%";
        label-font = 2;
      };

      "module/memory" = {
        type = "internal/memory";
        interval = 1;

        format = "<label>";
        format-prefix = "";
        format-prefix-foreground = green;

        label = " %mb_used%";
        label-font = 2;
      };

      "module/filesystem" = {
        type = "internal/fs";
        mount-0 = "/";
        interval = 30;
        fixed-values = true;

        format-mounted = "<label-mounted>";
        format-mounted-foreground = foreground;
        
        format-mounted-prefix = "";
        format-mounted-prefix-foreground = yellow;
        

        format-unmounted = "<label-unmounted>";
        format-unmounted-foreground = foreground;

        format-unmounted-prefix = "";
        format-unmounted-prefix-foreground = yellow;

        label-mounted = " %free%";
        label-mounted-font = 2;

        label-unmounted = " %mountpoint%: NA";
        label-unmounted-font = 2;
      };

      "module/network" = {
        type = "internal/network";
        interface = "eno1";
        interval = 1;

        accumulate-stats = true;
        unknown-as-up = true;

        format-connected = "<label-connected>";
        format-connected-prefix = "";
        format-connected-prefix-foreground = blue;

        format-disconnected = "<label-disconnected>";
        format-disconnected-prefix = "";
        format-disconnected-prefix-foreground = blue;

        label-connected = " %ifname%";
        label-connected-font = 2;

        label-disconnected = " offline";
        label-disconnected-font = 2;
      };

      "module/keyboard" = {
        type = "internal/xkeyboard";

        blacklist-0 = "num lock";
        blacklist-1 = "scroll lock";

        format = "<label-layout> <label-indicator>";
        format-prefix = "";
        format-prefix-foreground = purple;

        label-layout = " %layout%";
        label-layout-font = 2;

        label-indicator-on = "%name%";
        label-indicator-on-foreground = foreground;
        label-indicator-on-font = 2;
      };

      "module/volume" = {
        type = "internal/pulseaudio";

        master-soundcard = "default";
        speaker-soundcard = "default";
        headphone-soundcard = "default";

        use-ui-max = false;

        master-mixer = "Master";

        interval = 5;

        format-volume = "<ramp-volume> <bar-volume>";

        format-muted = "<label-muted>";
        format-muted-prefix = "";
        format-muted-prefix-foreground = turquoise;

        label-volume = "%percentage%%";

        label-muted = " MUTED";
        label-muted-foregruond = sep;
        label-muted-font = 2;

        ramp-volume-0 = "";
        ramp-volume-1 ="";
        ramp-volume-2 = "";
        ramp-volume-foreground = turquoise;

        bar-volume-format = "%fill%%indicator%%empty%";
        bar-volume-width = 11;
        bar-volume-gradient = false;

        bar-volume-indicator = indicator;
        bar-volume-indicator-foreground = turquoise;
        bar-indicator-font = 2;

        bar-volume-fill = fill;
        bar-volume-fill-font = 2;
        bar-volume-foreground-0 = foreground;
        bar-volume-foreground-1 = foreground;
        bar-volume-foreground-2 = foreground;
        bar-volume-foreground-3 = foreground;
        bar-volume-foreground-4 = foreground;

        bar-volume-empty = empty;
        bar-volume-empty-font = 2;
        bar-volume-empty-foreground = sep;
      };

      "module/date" = {
        type = "internal/date";
        interval = 5;

        date = "%a %b %d";
        date-alt = "%Y-%m-%d";

        time = "%H:%M";
        time-alt = "%H:%M";

        label = "%date% %time%";
        label-font = 2;

        format = "<label>";
        format-prefix = " ";
        format-prefix-foreground = red;
      };

      "module/tray" = {
        type = "internal/tray";
        format-margin = "2px";
        tray-spacing = "8px";
        tray-size = "50%";
      };
    };
  };
}

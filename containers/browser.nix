{ config, pkgs, ... }:

{
  containers.browser = {
    autoStart = false;
    privateNetwork = true;
    hostAddress = "192.168.7.10";
    localAddress = "192.168.7.11";
    config = { config, pkgs, ... }: {
      services.openssh = {
        enable = true;
        settings.X11Forwarding = true;
        extraConfig = ''
        X11Forwarding yes
        '';
      };

      users.extraUsers.browser = {
        isNormalUser = true;
        home = "/home/browser";
        openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB63kRM4JhFq01690vYRLF9heUCVgSA+4AgYoED6tNCP gabr1sr@desktop" ];
        extraGroups = [ "audio" "video" ];
      };

      networking.firewall.allowedTCPPorts = [ 4713 6000 ];
      hardware.pulseaudio = {
        enable = true;
        systemWide = true;
        support32Bit = true;
        tcp = {
          enable = true;
          anonymousClients = {
            allowedIpRanges = [
              "127.0.0.1"
              "192.168.7.0/24"
            ];
          };
        };
      };

      environment.systemPackages = with pkgs; [
        tor-browser
        apulse
        xpra
        xorg.xhost
      ];
    };
  };
}

{ config, pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  boot.kernel.sysctl."net.ipv4.ip_unprivileged_port_start" = 80;
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-c35fcab0-d5c7-4c6d-aed5-7e4ff104241c".device =
    "/dev/disk/by-uuid/c35fcab0-d5c7-4c6d-aed5-7e4ff104241c";
  networking.hostName = "desktop";

  networking.networkmanager.enable = true;

  networking.firewall = {
    logReversePathDrops = true;

    extraCommands = ''
      ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN
      ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN
    '';

    extraStopCommands = ''
      ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN || true
      ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN || true
    '';

    allowedTCPPorts = [ 22 80 443 ];
  };

  networking.nat = {
    enable = true;
    internalInterfaces = [ "ve-browser" ];
    externalInterface = "wg0";
  };

  time.timeZone = "America/Sao_Paulo";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver.enable = true;

  services.xserver.videoDrivers = [ "amdgpu" ];
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  services.xserver.displayManager.setupCommands = ''
    xhost +si:localuser:gabr1sr
  '';

  services.xserver = {
    xkb = {
      layout = "br";
      variant = "";
    };
  };

  console.keyMap = "br-abnt2";

  services.printing.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.syncthing = {
    enable = true;
    user = "gabr1sr";
    dataDir = "/home/gabr1sr/Documentos";
    configDir = "/home/gabr1sr/Documentos/.config/syncthing";
    overrideDevices = true;
    overrideFolders = true;
    settings = {
      devices = {
        "device1" = { id = "EYCKXUJ-LMZSDA7-TS6PYR5-AM6T3KX-CEE5OHZ-L54KV7C-3VO4KGD-EZBEGQX"; };
      };
      folders = {
        "Documents" = {
          path = "/home/gabr1sr/Documentos";
          devices = [ "device1" ];
        };

        "Org" = {
          path = "/home/gabr1sr/org";
          devices = [ "device1" ];
        };

        "safe" = {
          path = "/home/gabr1sr/safe";
          devices = [ "device1" ];
        };
      };
    };
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [ ];
    authentication = pkgs.lib.mkOverride 10 ''
      #type database DBuser origin-address auth-method
      local all      all                   trust
      host  all      all    127.0.0.1/32   trust
      host  all      all    ::1/128        trust
    '';
  };

  users.users.gabr1sr = {
    isNormalUser = true;
    description = "Gabriel Rosa";
    extraGroups = [ "networkmanager" "wheel" "audio" ];
    packages = with pkgs; [ ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.variables.VK_ICD_FILENAMES =
    "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json:/run/opengl-driver-32/share/vulkan/icd.d/radeon_icd.i686.json";

  environment.systemPackages = with pkgs; [
    wget
    git
    jetbrains-mono
    libGL
    libxml2
    libselinux
    mpv
    socat
    xorg.xhost
    wineWowPackages.stable
    winetricks
    lutris
    libreoffice-qt
    hunspell
    hunspellDicts.pt_BR
    tor-browser
    mangohud
    vesktop
    hugo
    ripgrep
    podman-compose
    mermaid-cli

    (steam.override {
      extraPkgs = pkgs: [
        gamemode
        mangohud
        glxinfo
        gperftools
        xorg.libXcursor
        xorg.libXi
        xorg.libXinerama
        xorg.libXScrnSaver
        libpng
        libpulseaudio
        libvorbis
        stdenv.cc.cc.lib
        libkrb5
        keyutils
      ];
    }).run
  ];

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "qt";
  };

  programs.firejail = {
    enable = true;
    wrappedBinaries = {
      firefox = {
        executable = "${pkgs.firefox}/bin/firefox";
        profile = "${pkgs.firejail}/etc/firejail/firefox.profile";
      };

      discord = {
        executable = "${pkgs.discord}/bin/discord";
        profile = "${pkgs.firejail}/etc/firejail/discord.profile";
      };

      tor-browser = {
        executable = "${pkgs.tor-browser}/bin/tor-browser";
        profile = "${pkgs.firejail}/etc/firejail/tor-browser-en-us.profile";
      };
    };
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };

  programs.noisetorch.enable = true;
  programs.gamemode.enable = true;
  
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  system.stateVersion = "23.11";
}

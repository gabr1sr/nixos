# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };
  
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    
    initrd.luks.devices."luks-5bab707a-7250-4048-a1d3-3e1ce7549bb4".device = "/dev/disk/by-uuid/5bab707a-7250-4048-a1d3-3e1ce7549bb4";
  };

  networking = {
    hostName = "desktop";
    networkmanager.enable = true;

    firewall = {
      enable = true;
      logReversePathDrops = true;

      allowedTCPPorts = [ 9993 ];
      allowedUDPPorts = [ 9993 ];

      extraCommands = ''
        ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN
        ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN
      '';

      extraStopCommands = ''
        ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN || true
        ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN || true
      '';
    };
  };

  console.keyMap = "br-abnt2";
  
  time.timeZone = "America/Sao_Paulo";

  i18n = {
    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
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
  };

  security.rtkit.enable = true;

  users.users.gabriel = {
    isNormalUser = true;
    description = "Gabriel";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" ];
    packages = with pkgs; [];
  };

  environment = {
    pathsToLink = [ "/libexec" ];
    
    variables = {
      EDITOR = "emacs";
      VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json:/run/opengl-driver-32/share/vulkan/icd.d/radeon_icd.i686.json";
    };
    
    systemPackages = with pkgs; [
      git
      vim
      wget
      mg
      emacs-unstable
      tor-browser
      xorg.xhost
      vesktop
      feh
      gcc
      ccls
      cmake
      libvterm-neovim
      ripgrep
      texlive.combined.scheme-full
      spotify
      mangohud
      gamemode
      pavucontrol
      mpv
      qbittorrent
      prismlauncher
      clonehero
      gzdoom
      xonotic
      dive
      podman-tui
      podman-compose
    ];
  };

  fonts.packages = with pkgs; [
    jetbrains-mono
    feather-icon-font
    fira-code
  ];

  programs = {
    light.enable = true;
    dconf.enable = true;
    mtr.enable = true;
    gamemode.enable = true;
    gamescope.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-qt;
    };

    firejail = {
      enable = true;

      wrappedBinaries = {
        tor-browser = {
          executable = "${pkgs.tor-browser}/bin/tor-browser";
          profile = "${pkgs.firejail}/etc/firejail/tor-browser-en-us.profile";
        };
      };
    };

    steam = {
      enable = true;
      # remotePlay.openFirewall = true;
      # dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
      package = with pkgs; steam.override {
        extraPkgs = pkgs: [
          gamescope
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
      };
    };
  };

  services = {
    xserver = {
      enable = true;
      xkb.layout = "br";
      videoDrivers = [ "amdgpu" ];

      desktopManager = {
        wallpaper.mode = "fill";
      };
      
      displayManager = {
        lightdm.enable = true;

        setupCommands = ''
          ${pkgs.xorg.xhost}/bin/xhost +si:localuser:gabriel
        '';
        
        session = [
          {
            manage = "desktop";
            name = "home-manager";
            start = ''
              ${pkgs.runtimeShell} $HOME/.hm-xsession &
              waitPID=$!

              ${pkgs.feh}/bin/feh --bg-fill $HOME/.background-image
            '';
          }
        ];
      };
    };

    displayManager.defaultSession = "home-manager";

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    emacs = {
      enable = true;
      package = pkgs.emacs-unstable;
    };

    dbus.enable = true;
    zerotierone = {
      enable = true;
      port = 9993;
      joinNetworks = [ "856127940c59bdf2" ];
    };
  };

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  system.stateVersion = "23.11";
}

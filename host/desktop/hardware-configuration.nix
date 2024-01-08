{ config, lib, pkgs, modulesPath, ... }: {
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules =
    [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" "amdgpu" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/90c47bae-2f8f-4f8d-aed6-a17550166b30";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-30b8da95-2fff-414d-85c3-c3a9a4ae4de4".device =
    "/dev/disk/by-uuid/30b8da95-2fff-414d-85c3-c3a9a4ae4de4";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/FB9A-F5A2";
    fsType = "vfat";
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/7424b452-c5ca-4423-af90-b4fe63b422fd"; }];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.opengl = {
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = [ pkgs.amdvlk ];
    extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
  };
}

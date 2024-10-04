{
  configs,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot.initrd = {
    kernelModules = [];
    availableKernelModules = [
      "ahci"
      "xhci_pci"
      "virtio_pci"
      "sr_mod"
      "virtio_blk"
    ];
  };

  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [];

  # filesystems
  # fileSystems."/boot" = {
  #   label = "ESP";
  #   fsType = "vfat";
  # };
  # fileSystems."/" = {
  #   label = "root";
  #   fsType = "ext4";
  # };

  swapDevices = [];

  networking.useDHCP = lib.mkDefault true;
  networking.interfaces.enp1s0.useDHCP = lib.mkDefault = true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
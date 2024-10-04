{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
  ];

  # hostname
  networking.hostName = "khas";

  # networking
  networking.wireless.enable = true;

  # touchpad
  services.xserver.libinput.enable = true;
}
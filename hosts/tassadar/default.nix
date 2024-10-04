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
  ];

  # hostname
  networking.hostName = "tassadar";

  # networking
  networking.hosts = "";
  networking.wireless.enable = true;
  networking.wireless.iwd.enable = true;

  # touchpad
  services.xserver.libinput.enable = true;
}
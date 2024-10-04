{
  self,
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
    "${self}/modules/nixos/nvidia.nix"
  ];

  # hostname
  networking.hostName = "khas";
}
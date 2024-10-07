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

  users.users = {
    hws = {
      isNormalUser = true;
      openssh.authorizedKeys.keys = [

      ];
      extraGroups = ["wheel"];
    };
  };

  networking.hostName = "raszagal";

  programs.htop.enable = true;

  environment.systemPackages = with pkgs; [
    mtr
  ];
}

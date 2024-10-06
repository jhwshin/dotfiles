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

  programs.htop.enable = true;

  environment.systemPackages = with pkgs; [
    mtr
  ];

  users.users = {
    hws = {
      isNormalUser = true;
      openssh.authorizedKeys.keys = [

      ];
      extraGroups = ["wheel"];
    };
  };

  system.stateVersion = "24.05";
}

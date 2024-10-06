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

  system.stateVersion = "24.05";
}

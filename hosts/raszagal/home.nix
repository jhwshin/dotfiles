{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../home-common.nix
  ];

  home.packages = with pkgs; [ ranger ];

  programs.fastfetch.enable = true;

}


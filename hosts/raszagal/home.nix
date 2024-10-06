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

  programs.fastfetch.enable = true;

}


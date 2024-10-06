{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../common/home.nix
  ];

  home.packages = with pkgs; [ ranger ];

  programs.fastfetch.enable = true;

}


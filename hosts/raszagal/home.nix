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

  home = {
    username = "hws";
    homeDirectory = "/home/hws";
  };

  programs.fastfetch.enable = true;

  home.packages = with pkgs; [
    ranger
  ];
}


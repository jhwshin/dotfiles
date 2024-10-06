{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home = {
    username = "hws";
    homeDirectory = "/home/hws";
  };
  programs.home-manager.enable = true;

  home.packages = with pkgs; [ neovim ];

  programs.git.enable = true;
  programs.kitty.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "24.05";
}

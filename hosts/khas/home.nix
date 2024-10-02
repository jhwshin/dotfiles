  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    
  ];

  home = {
    username = "hws";
    homeDirectory = "/home/hws";
  };

  home.packages = with pkgs; [ neovim ];

  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "24.05";
}

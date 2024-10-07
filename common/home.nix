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

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;
  programs.git.enable = true;
  programs.kitty.enable = true;

  home.packages = with pkgs; [
    neovim
  ];

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "24.05";
}

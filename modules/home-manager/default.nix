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

  home = {
    username = "hws";
    homeDirectory = "/home/hws";
  };

  let
    enabledPrograms = with pkgs; [
      home-manager
      kitty
      tmux
      neovim
      fastfetch
    ];
  in {
    programs = lib.genAttrs enabledPrograms (
      name: {
        enable = true;
      };
    );
  };

  home.packages = with pkgs; [
    
  ];

  # reload systemd units when changing configs
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "24.05";
}

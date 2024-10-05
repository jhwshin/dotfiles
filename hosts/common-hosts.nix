{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      experimental-features = "nix-command flakes";
      flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };
    channel.enable = false;
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  # enable propreitary packages
  nixpkgs.config.allowUnfree = true;

  # boot loader
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
    };
  };

  # timezone
  time.timeZone = "Australia/Sydney";

  # locale
  i18n.defaultLocale = "en_AU.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # cpu
  hardware.cpu.intel.updateMicrocode = true;

  # btrfs
  services.locate.pruneNames = [ ".snapshots" ];

  # sound
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true;
    # media-session.enable = true;
  };

  # networking
  networking.networkManager.enable = true;

  # desktop environment
  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.windowManager.i3.enable = true;

  # applications
  programs.git.enable = true;
  programs.firefox.enable = true;
  environment.systemPackages = with pkgs; [
    home-manager
  ];

  # ssh
  services.openssh = {
    enable = true;
    settings = {
      permitRootLogin = "no";
      PasswordAuthentication = true;
    };
  };

  # users
  users.users = {
    hws = {
      isNormaluser = true;
      extraGroups = [ "wheel" ];
      open.ssh.authorizedKeys.keys = [

      ];
    };
  };

  system.stateVersion = "24.05";
}

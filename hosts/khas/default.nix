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

  # BOOTLOADER
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.efi.canTouchEfiVariables = true;

  # NETWORKING
  networking.hostName = "khas";
  # networking.wireless.enable = true;
  networking.networkmanager.enable = true;

  # TIMEZONE
  time.timeZone = "Australia/Sydney";

  # LOCALE
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

  # DISPLAY SERVER
  services.xserver.enable = true;

  # DESKTOP ENVIRONMENT
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  # SOUND
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

  # TOUCHPAD
  # services.xserver.libinput.enable = true;

  # APPLICATIONS
  programs.firefox.enable = true;
  environment.systemPackages = with pkgs; [

  ];

  users.users = {
    hws = {
      isNormalUser = true;
      openssh.authorizedKeys.keys = [

      ];
      extraGroups = ["wheel"];
    };
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
    };
  };

  system.stateVersion = "24.05";
}

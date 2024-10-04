{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {

  # boot.initrd.kernelModules = ["nvidia"];
  # boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
  # boot.kernelParams = [ "module_blacklist=i915" ];
  hardware.opengl.enable = true;
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    open = false;
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    nvidia.Persistenced = true;
    nvidia.settings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    # forceFullCompositionPipeline = true;
  };
}

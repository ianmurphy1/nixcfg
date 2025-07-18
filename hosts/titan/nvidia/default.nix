{ lib, config, ... }:
{
  hardware.nvidia = {
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    nvidiaSettings = true;
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = lib.mkDefault [ "nvidia" ];
}

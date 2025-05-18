{ config, lib, pkgs, ... }:
{
  hardware.nvidia = {
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    nvidiaSettings = true;
    open = true;
  };

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = lib.mkDefault [ "nvidia" ];
}

{ config, lib, pkgs, ... }:
{
  hardware.nvidia = {
    powerManagement.enable = true;
    #enabled = true;
    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
    };
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  services.xserver.videoDrivers = lib.mkDefault [ "nvidia" ];
}

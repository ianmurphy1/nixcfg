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
    package = let
      base = config.boot.kernelPackages.nvidiaPackages.latest;
      patch = pkgs.fetchpatch {
        url = "https://raw.githubusercontent.com/CachyOS/CachyOS-PKGBUILDS/master/nvidia/nvidia-utils/kernel-6.19.patch";
        sha256 = "sha256-YuJjSUXE6jYSuZySYGnWSNG5sfVei7vvxDcHx3K+IN4=";
      };
    in
      base // {
        open = base.open.overrideAttrs (old: {
          patches = (old.patches or []) ++ [ patch ];
        });
      };
    # package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  services.xserver.videoDrivers = lib.mkDefault [ "nvidia" ];
}

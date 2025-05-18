{ lib, pkgs, ... }:

{
  hardware.cpu = {
    intel.updateMicrocode = true;
  };  

  hardware.graphics.extraPackages = with pkgs; [
    intel-vaapi-driver
    intel-ocl
    intel-media-driver
    intel-compute-runtime
    vpl-gpu-rt
  ];

  services.thermald.enable = lib.mkDefault true;
}

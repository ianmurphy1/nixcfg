{ lib, pkgs, ... }:

{
  hardware.cpu = {
    intel.updateMicrocode = true;
  };  

  services.thermald.enable = lib.mkDefault true;
}

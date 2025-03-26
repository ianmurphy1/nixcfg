{ pkgs, config, lib, ... }:

{
  boot = {
    #kernelPackages = pkgs.linuxPackages_latest;
    kernelPackages = pkgs.linuxPackages_testing;
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };
    # Removing lenovo-legion-module until builds on >= 6.14 kernel get fixed
    #extraModulePackages = [ config.boot.kernelPackages.lenovo-legion-module ];
    kernelParams = [
      "splash"
    ];
  };

  hardware = {
    enableRedistributableFirmware = true;
    firmware = [
      pkgs.linux-firmware
    ];
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
          FastConnectable = true;
        };
        Policy = {
          AutoEnable = true;
        };
      };
      input = {
        General = {
          UserspaceHID = true;
        };
      };
    };
  };
  

  networking = {
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Dublin";
  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    earlySetup = true;
    keyMap = "us";
  };
  system.stateVersion = "25.05"; # Did you read the comment?
}

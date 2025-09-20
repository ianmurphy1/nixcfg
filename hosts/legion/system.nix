{ pkgs, config, lib, ... }:

{
  boot = {
    binfmt.emulatedSystems = [ "aarch64-linux" ];
    # kernelPackages = pkgs.linuxPackages_testing;
    kernelPackages = pkgs.linuxPackages_latest;
    #kernelPackages = pkgs.linuxPackages_6_14;
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
  i18n = {
    defaultLocale = "en_IE.UTF-8";
    extraLocales = [
      "en_GB.UTF-8/UTF-8"
    ];
  };
  console = {
    earlySetup = true;
    keyMap = "us";
  };
  system.stateVersion = "25.11"; # Did you read the comment?
}

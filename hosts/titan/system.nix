{ pkgs, config, lib, ... }:

{
  boot = {
    binfmt.emulatedSystems = [ "aarch64-linux" ];
    #kernelPackages = pkgs.linuxPackages_testing;
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };
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
      enable = false;
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
    keyMap = "uk";
  };
  system.stateVersion = "25.05"; # Did you read the comment?
}

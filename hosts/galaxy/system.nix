{ pkgs, ... }:
{
  boot = {
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
    initrd = {
      enable = true;
      includeDefaultModules = true;
    };
  };

  services.fwupd.enable = true;
  services.thermald.enable = true;

  hardware = {
    enableRedistributableFirmware = true;
    firmware = [
      pkgs.linux-firmware
    ];
    cpu = {
      intel.updateMicrocode = true;
    };
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
    keyMap = "uk";
  };
  system.stateVersion = "25.05"; # Did you read the comment?
}

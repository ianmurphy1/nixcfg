{ pkgs, config, lib, ... }:

{
  boot = {
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
    extraModulePackages = [ config.boot.kernelPackages.lenovo-legion-module ];
    blacklistedKernelModules = [ "snd_soc_avs" ];
    extraModprobeConfig = ''
      options snd-hda-intel model=auto
    '';
  };

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
  
  services.thermald.enable = lib.mkDefault true;

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

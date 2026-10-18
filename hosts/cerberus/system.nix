{ pkgs, ... }:

{
  boot = {
    binfmt.emulatedSystems = [ "aarch64-linux" ];
    # kernelPackages = pkgs.linuxPackages_testing;
    # kernelPackages = pkgs.unstable.linuxPackages_latest;
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot = {
        enable = false;
        configurationLimit = 5;
      };
      grub = {
        enable = true;
        device = "/dev/nvme0n1";
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
      # pkgs.unstable.linux-firmware
      pkgs.linux-firmware
    ];
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
  system.stateVersion = "26.05"; # Did you read the comment?
}

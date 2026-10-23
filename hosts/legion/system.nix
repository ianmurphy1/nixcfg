{ pkgs, ... }:

{
  boot = {
    binfmt.emulatedSystems = [ "aarch64-linux" ];
    # kernelPackages = pkgs.linuxPackages_testing;
    # kernelPackages = pkgs.unstable.linuxPackages_latest;
    kernelPackages = pkgs.linuxPackages_7_2;
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };
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

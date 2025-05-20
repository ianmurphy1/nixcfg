{ pkgs, ... }:
{
  services.xserver = {
    enable = false;
    exportConfiguration = true;
    xkb = {
      layout = "gb";
    };
  };

  services.displayManager.sddm = {
    enable = true;
    wayland = {
      enable = true;
      compositor = "kwin";
    };
  };
  services.desktopManager.plasma6.enable = true;

  environment.systemPackages = with pkgs; [
    xsettingsd
    xorg.xrdb
  ];
}

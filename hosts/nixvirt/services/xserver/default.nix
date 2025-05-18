{ pkgs, ... }:
{
  services.xserver = {
    enable = true;
    exportConfiguration = true;
    xkb = {
      layout = "gb";
    };
  };
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;
  #xdg.portal = {
  #  wlr.enable = true;
  #  enable = true;
  #  extraPortals = [
  #    pkgs.xdg-desktop-portal-gtk
  #    pkgs.kdePackages.xdg-desktop-portal-kde
  #  ];
  #  configPackages = [
  #    pkgs.xdg-desktop-portal-gtk
  #    pkgs.xdg-desktop-portal
  #  ];
  #};
}

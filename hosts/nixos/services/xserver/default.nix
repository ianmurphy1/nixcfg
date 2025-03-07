{ pkgs, ... }:
{
  services.xserver = {
    enable = true;
    exportConfiguration = true;
    xkb = {
      layout = "gb";
    };
  };
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.kdePackages.xdg-desktop-portal-kde
    ];
  };
}

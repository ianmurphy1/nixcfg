{ pkgs, ... }:
{
  services.xserver = {
    enable = false;
    exportConfiguration = true;
    xkb = {
    };
  };
  xdg.portal = {
    wlr.enable = true;
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.kdePackages.xdg-desktop-portal-kde
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
    xdgOpenUsePortal = true;
  };

  environment.systemPackages = with pkgs; [
    kdePackages.breeze
    kdePackages.breeze-gtk
  ];
}

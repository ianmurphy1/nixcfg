{ pkgs, ... }:
{
  services.xserver = {
    enable = false;
    exportConfiguration = true;
    xkb = {
      layout = "gb";
    };
  };
  xdg.portal = {
    wlr.enable = true;
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.kdePackages.xdg-desktop-portal-kde
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
  };

  environment.systemPackages = with pkgs; [
    kdePackages.breeze
    kdePackages.breeze-gtk
  ];
}

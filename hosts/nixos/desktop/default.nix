{ pkgs, ... }:
{
  xdg.portal = {
    config = {
      common = {
        default = [ "kde" ];
        "org.freedesktop.impl.portal.Settings" = "kde;gnome";
      };
    };
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
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
    kdePackages.partitionmanager
    kdePackages.xdg-desktop-portal-kde
  ];
}

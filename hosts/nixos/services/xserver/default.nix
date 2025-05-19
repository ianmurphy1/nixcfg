{ pkgs, ... }:
{
  services.xserver = {
    enable = false;
    exportConfiguration = true;
    xkb = {
      layout = "gb";
    };
  };
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;
}

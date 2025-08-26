# hyprland.nix
{ pkgs, inputs, ... }:

{
  # Enable Hyprland and install related pkgs
  # Configs in configs/ian/hyprland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
  environment.sessionVariables.GTK_THEME = "volantes-light-cursors";
  environment.sessionVariables.XCURSOR_THEME = "Volantes-Light-Cursors";
  environment.sessionVariables.XCURSOR_SIZE = "30";

  programs.hyprland = {
    enable = true;
    # make sure to also set the portal package, so that they are in sync
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
    xwayland = {
      enable = true;
    };
  };
  programs.hyprlock.enable = true;

  programs.xwayland.enable = true;

  environment.systemPackages = with pkgs; [
    dunst
    hyprpaper
    hyprcursor
    hyprlock
    hypridle
    rofi-wayland
    qt5.qtwayland
    qt6.qtwayland
    waybar
    wl-clipboard
    cliphist
    #nwg-displays
    nwg-look
    brightnessctl
    acpi
    blueman
    adwaita-qt6
    libsForQt5.qt5ct
    kdePackages.qt6ct
    kdePackages.qtwayland
    glib
    gsettings-qt
    xdg-user-dirs
    xdg-utils
  ];
}

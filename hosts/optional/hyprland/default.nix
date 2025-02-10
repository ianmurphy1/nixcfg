# hyprland.nix
{ pkgs, ... }:

{
  # Enable Hyprland and install related pkgs
  # Configs in configs/ian/hyprland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
  programs.hyprland = {
    enable = true;
    xwayland = {
      enable = true;
    };
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };
  environment.systemPackages = with pkgs; [
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
  ];
}

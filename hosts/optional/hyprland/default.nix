# hyprland.nix
{ pkgs, inputs, ... }:

{
  # Enable Hyprland and install related pkgs
  # Configs in configs/ian/hyprland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    xwayland = {
      enable = true;
    };
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
    nwg-displays
    nwg-look
    brightnessctl
    acpi
    blueman
    adwaita-qt6
  ];
}

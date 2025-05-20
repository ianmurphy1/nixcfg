{ pkgs, ... }:

{
  # Enable Theme
  # environment.variables.GTK_THEME = "volantes-light-cursors";
  # environment.variables.XCURSOR_THEME = "Volantes-Light-Cursors";
  # environment.variables.XCURSOR_SIZE = "30";
  
  qt = {
    enable = true;
    #platformTheme = "qt5ct";
  };

  environment.systemPackages = with pkgs; [
    nordic
    adwaita-icon-theme
    volantes-cursors
    kdePackages.xdg-desktop-portal-kde
  ];
}

{ pkgs, ... }:

{
  # Enable Theme
  # environment.variables.GTK_THEME = "volantes-light-cursors";
  # environment.variables.XCURSOR_THEME = "Volantes-Light-Cursors";
  # environment.variables.XCURSOR_SIZE = "30";
  
  qt = {
    enable = true;
    #platformTheme = "qt5ct";
    style = "breeze";
  };

  environment.systemPackages = with pkgs; [
    volantes-cursors
    kdePackages.xdg-desktop-portal-kde
  ];
}

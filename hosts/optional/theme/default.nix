{ pkgs, ... }:

{
  # Enable Theme
  environment.variables.GTK_THEME = "volantes-light-cursors";
  environment.variables.XCURSOR_THEME = "Volantes-Light-Cursors";
  environment.variables.XCURSOR_SIZE = "30";
  
  qt = {
    enable = true;
    #platformTheme = "qt5ct";
  };

  # Override packages
  nixpkgs.config.packageOverrides = pkgs: {
    colloid-icon-theme = pkgs.colloid-icon-theme.override { colorVariants = ["default"]; };
  };

  environment.systemPackages = with pkgs; [
    numix-icon-theme-circle
    colloid-icon-theme
    adwaita-icon-theme
    volantes-cursors
  ];
}

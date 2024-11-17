{ pkgs, ... }:

{
  # Enable Theme
  environment.variables.GTK_THEME = "notwaita-white";
  environment.variables.XCURSOR_THEME = "Notwaita-White";
  environment.variables.XCURSOR_SIZE = "28";
  console = {
    earlySetup = true;
  };
  
  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = "adwaita";
  };

  # Override packages
  nixpkgs.config.packageOverrides = pkgs: {
    colloid-icon-theme = pkgs.colloid-icon-theme.override { colorVariants = ["default"]; };
  };

  environment.systemPackages = with pkgs; [
    numix-icon-theme-circle
    colloid-icon-theme
    adwaita-icon-theme
  ];
}

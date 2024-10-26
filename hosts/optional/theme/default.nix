{ pkgs, ... }:

{
  
  # Enable Theme
  environment.variables.GTK_THEME = "catppuccin-latte-dark";
  environment.variables.XCURSOR_THEME = "Catppuccin-Latte-Dark";
  environment.variables.XCURSOR_SIZE = "26";
  environment.variables.HYPRCURSOR_THEME = "catppuccin-latte-dark-cursors";
  environment.variables.HYPRCURSOR_SIZE = "26";
  qt.enable = true;
  qt.platformTheme = "qt5ct";
  qt.style = "adwaita";
  console = {
    earlySetup = true;
  };

  # Override packages
  nixpkgs.config.packageOverrides = pkgs: {
    colloid-icon-theme = pkgs.colloid-icon-theme.override { colorVariants = ["default"]; };
    catppuccin-gtk = pkgs.catppuccin-gtk.override {
      accents = [ "blue" ]; # You can specify multiple accents here to output multiple themes 
      size = "standard";
      variant = "latte";
    };
  };

  environment.systemPackages = with pkgs; [
    numix-icon-theme-circle
    colloid-icon-theme
    catppuccin-gtk
    catppuccin-kvantum
    catppuccin-cursors.latteDark
    adwaita-icon-theme
  ];
}

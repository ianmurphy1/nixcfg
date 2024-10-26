{ config, pkgs, lib, inputs, myvars, ...}:
{
  imports = lib.flatten [
    ../../configs/${myvars.username}
    (myvars.scanPaths ./.)
  ];

  home = {
    username = "${myvars.username}";
    homeDirectory = "/home/${myvars.username}";
    stateVersion = lib.mkDefault "24.11";
    pointerCursor = {
      x11.enable = true;
      gtk.enable = true;
      package = pkgs.catppuccin-cursors.latteDark;
      name = "catppuccin-latte-dark-cursors";
      size = 26;
    };
  };
  programs.home-manager.enable = true;
}

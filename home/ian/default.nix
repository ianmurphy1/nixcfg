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
  };
  programs.home-manager.enable = true;
}

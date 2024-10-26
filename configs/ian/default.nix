{ config, pkgs, lib, inputs, myvars, ...}:
{
  imports = [
    ./vim
    ./hyprland
  ];
  home = {
    username = "${myvars.username}";
    homeDirectory = "/home/${myvars.username}";
    stateVersion = lib.mkDefault "24.11";
  };
}

{ pkgs, lib, myvars, mylib, config, ...}:
{
  imports = lib.flatten [
    ../../configs/${myvars.username}
    ./ssh
    ./git
  ];

  home = {
    username = "${myvars.username}";
    stateVersion = lib.mkDefault "25.05";
  };
  programs.home-manager.enable = true;
}

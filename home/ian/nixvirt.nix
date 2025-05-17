{ lib, myvars, osConfig, ...}:
let
  username = myvars.username;
  hostname = "${osConfig.networking.hostName}";
in
{
  imports = lib.flatten [
    ../../configs/${username}/${hostname}
    ./ssh
    ./git
  ];

  home = {
    username = "${myvars.username}";
    stateVersion = lib.mkDefault "25.05";
  };
  programs.home-manager.enable = true;
}

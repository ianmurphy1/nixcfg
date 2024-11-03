{ pkgs, lib, myvars, mylib, config, inputs, ...}:
let
  secretspath = builtins.toString inputs.mysecrets;
  username = myvars.username;
  user = config.users.users."${username}";
  hostname = config.networking.hostName;
  usergroup = user.group;
  homedir = user.home;
in
{
  imports = lib.flatten [
    ../../configs/${myvars.username}
    ./ssh
    ./git
    ./zsh
  ];

  home = {
    username = "${myvars.username}";
    stateVersion = lib.mkDefault "24.11";
  };
  programs.home-manager.enable = true;
}

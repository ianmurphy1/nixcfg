{ config, myvars, ... }:
let
  homedir = config.users.users."${myvars.username}".home;
in
{
  programs.nh = {
    enable = true;
    flake = "${homedir}/nixcfg";
    clean = {
      enable = true;
      dates = "weekly";
      # Keep last 5 and remove older than
      # one week
      extraArgs = "-k 5 -K 7d";
    };
  };
}

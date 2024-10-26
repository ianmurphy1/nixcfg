{ config, ... }:
{
  programs.nh = {
    enable = true;
    flake = "${config.users.users.ian.home}/nixcfg";
    clean = {
      enable = true;
      dates = "weekly";
      # Keep last 5 and remove older than
      # one week
      extraArgs = "-k 5 -K 7d";
    };
  };
}

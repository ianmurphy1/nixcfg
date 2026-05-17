{ config, myvars, pkgs, ... }:
let
  homedir = config.users.users."${myvars.username}".home;
  nh-latest = pkgs.nh.overrideAttrs(
    finalAttrs: previousAttrs: {
      version = "master";
      src = pkgs.fetchFromGitHub {
        owner = "nix-community";
        repo = "nh";
        rev = "247d26d2058eda0ca26315cac8cb415ea599927f";
        hash = "sha256-B14CmTmyokfvM/ADMTyMpaH2Ip8Gtyc35pLpocVf6X4=";
      };
    }
  );
in
{
  programs.nh = {
    enable = true;
    package = nh-latest;
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

{ config, inputs, pkgs, ... }:
let
  hostName = config.networking.hostName;
  enableNiri = (hostName == "legion" || hostName == "titan");
in
{
  programs.niri = {
    enable = enableNiri;
    useNautilus = true;
  };

  services.power-profiles-daemon.enable = enableNiri;
  services.upower.enable = enableNiri;

  environment.systemPackages = with pkgs; [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    xwayland-satellite
  ];
}

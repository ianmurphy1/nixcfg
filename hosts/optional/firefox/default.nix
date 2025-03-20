{ config, ... }:
let
  hostName = config.networking.hostName;
  scales = {
    nixos = "1.25";
    galaxy = "1.15";
    legion = "1.25";
  };
in
{
  programs.firefox = {
    enable = true;
    preferences = {
      "layout.css.devPixelsPerPx" = scales.${hostName};
    };
  };
}

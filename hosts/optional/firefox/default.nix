{ lib, config, ... }:
let
  hostName = config.networking.hostName;
  scales = {
    nixos = "1.60";
    nixvirt = "1.25";
    galaxy = "1.15";
    legion = "1.25";
    titan = "1.0";
  };
in
{
  # programs.firefox = {
  #   enable = false;
  #   preferences = {
  #     "layout.css.devPixelsPerPx" = scales.${hostName};
  #   } // lib.optionalAttrs (hostName == "titan") {
  #     "font.name.monospace.x-western" = "SauceCodePro Nerd Font";
  #     "font.size.monospace.x-western" = 14;
  #     "font.minimum-size.x-western" = 14;
  #   };
  # };
}

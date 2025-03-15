{ lib, config, ... }:
{
  programs.firefox = {
    enable = true;
    preferences = {
      "layout.css.devPixelsPerPx" =
        if config.networking.hostName == "nixos" then "1.25" else "1.15";
    };
  };
}

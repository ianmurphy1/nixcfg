{ lib, ... }:
{
  home.file = {
    ".config/waybar" = lib.mkOverride 10 {
      source = ./config;
      recursive = true;
    };
  };
}

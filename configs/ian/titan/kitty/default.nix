{ lib, ... }:
{
  home.file = {
    ".config/kitty" = lib.mkOverride 200 {
      source = ./config;
      recursive = true;
    };
  };
}

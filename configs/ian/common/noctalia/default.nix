{ ... }:
{
  home.file = {
    "./config/noctalia" = {
      source = ./config;
      recursive = true;
    };
  };
}

{ ... }:
{
  home.file = {
    ".config/hypr/monitors.conf" = {
      source = ./configs/monitors.conf;
    };
    ".config/hypr/hyprpaper.conf" = {
      source = ./configs/hyprpaper.conf;
      force = true;
    };
  };
}

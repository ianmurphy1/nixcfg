{ osConfig, ... }:
let
  hostname = osConfig.networking.hostName;
  wallpaper = {
    legion = "legion_wp.jpg";
    galaxy = "space.png";
    nixos = "space.png";
  };
in
{
  home.file = {
    ".config/hypr" = {
      source = ./configs;
      recursive = true;
    };
    ".config/hypr/input.conf" = {
      text = ''
        input {
          ${ if hostname == "legion" then
          "kb_layout = us
          kb_variant = euro"
          else "kb_layout = gb" }
          follow_mouse = 2
          numlock_by_default = 1
        
          touchpad {
              natural_scroll = no
              clickfinger_behavior = 1
          }
        
          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
        }
      '';
    };
    ".config/hypr/hyprpaper.conf" = {
      text = ''
        preload = ~/.config/hypr/share/${wallpaper."${hostname}"}
        wallpaper = ,~/.config/hypr/share/${wallpaper."${hostname}"}
        splash = false
      '';
    };
    ".confif/hypr/hypridle.conf" = {
      text = ''
        general {
            lock_cmd = ~/.config/hypr/scripts/lockscreen.sh
            before_sleep_cmd = loginctl lock-session    # lock before suspend.
            after_sleep_cmd = hyprctl dispatch dpms on  # to avoid having to press a key twice to turn on the display.
        }
        
        listener {
            timeout = 540                                # 9min.
            on-timeout = brightnessctl -e4 -s set 60%    # set monitor backlight to minimum, avoid 0 on OLED monitor.
            on-resume = brightnessctl -r                 # monitor backlight restore.
        }
        
        listener {
            timeout = 1200                              # 20min
            on-timeout = loginctl lock-session          # lock screen when timeout has passed
        }
        
        listener {
            timeout = 900                               # 15min
            on-timeout = hyprctl dispatch dpms off      # screen off when timeout has passed
            on-resume = hyprctl dispatch dpms on        # screen on when activity is detected after timeout has fired.
        }
        
        listener {
            timeout = 3600                              # 1h
            on-timeout = systemctl suspend              # suspend pc
        }
        
        # vim: ft=conf
      '';
    };
  };
}

{ lib, osConfig, ... }:
let
  hostname = osConfig.networking.hostName;
  display = {
    galaxy = "eDP-1";
    nixos = "eDP-1";
    nixvirt = "eDP-1";
    legion = "eDP-1";
    titan = "DP-2";
  };
  thermalZones = {
    galaxy = "7";
    nixos = "6";
    nixvirt = "6";
    legion = "9";
    titan = "1";
  };
in
{
  home.file = {
    ".config/waybar" = lib.mkDefault {
      source = ./config;
      recursive = true;
    };
    ".config/waybar/config.jsonc" = lib.mkDefault {
      text = ''
        {
          "layer": "top", // Waybar at top layer
          "output": "${display."${hostname}"}",
          "height": 30, // Waybar height (to be removed for auto height)
          "spacing": 4,
          "modules-left": [
            "user",
            "temperature",
            "cpu",
            "memory",
            "network",
            "hyprland/workspaces"
          ],
          "modules-center": ["hyprland/window"],
          "modules-right": [
            "idle_inhibitor",
            "pulseaudio#output",
            "pulseaudio#input",
            "backlight",
            "keyboard-state",
            "battery",
            "tray",
            "clock",
            "custom/poweroff"
          ],
          "user": {
            "format": "<span text-transform=\"lowercase\">{user}</span>",
            "open-on-click": false
          },
          "hyprland/workspaces": {
            "format": "{icon}",
            "sort-by-number": true,
            "active-only": false,
            "format-icons": {
              "1": "",
              "2": ""
            },
            "on-click": "activate"
          },
          "keyboard-state": {
            "numlock": true,
            "format": "{name} {icon}",
            "format-icons": {
              "locked": "",
              "unlocked": ""
            }
          },
          "hyprland/window": {
            "format": "{class}@@@{title}",
            "rewrite": {
              "(firefox)@@@(.*) — Mozilla Firefox.*": "  $2",
              "firefox@@@Mozilla Firefox.*": "  firefox",
              "(librewolf)@@@(.*) — LibreWolf.*": "$2",
              "librewolf@@@LibreWolf.*": "LibreWolf",
              "(thunderbird)@@@(.*) — Mozilla Thunderbird.*": "  $2",
              "thunderbird@@@Mozilla Thunderbird.*": "  Thunderbird",
              //"(kitty)@@@(.*)": " $2",
              "(kitty)@@@vim (.*)": " $2",
              "(kitty)@@@(?!vim)(.*)": "  $2",
              "@@@": ""        
            }
          },
          "hyprland/mode": {
            "format": "<span style=\"italic\">{}</span>"
          },
          "idle_inhibitor": {
            "format": "{icon}",
            "format-icons": {
              "activated": " ",
              "deactivated": " "
            }
          },
          "tray": {
            // "icon-size": 21,
            "spacing": 10
          },
          "clock": {
            "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>",
            "format-alt": "{:%Y-%m-%d}"
          },
          "cpu": {
            "format": " {usage}%",
          },
          "memory": {
            "format": " {}%"
          },
          "temperature": {
            "thermal-zone": ${thermalZones."${hostname}"},
            "critical-threshold": 80,
            "format-critical": "{icon} {temperatureC}°C",
            "format": "{icon} {temperatureC}°C",
            "format-icons": ["", "", ""]
          },
          "backlight": {
            "format": "{icon} {percent}%",
            "format-icons": ["", "", "", "", "", "", "", "", ""]
          },
          "battery": {
            "states": {
            // "good": 95,
              "warning": 30,
              "critical": 15
            },
            "full-at": 100,
            "format": "{icon} {capacity}%",
            "format-charging": " {capacity}%",
            "format-full": " {capacity}%",
            "format-icons": ["", "", "", "", ""],
            "adapter": "ACAD"
          },
          "network": {
            // "interface": "wlp2*" (Optional) To force the use of this interface
            "format-wifi": "{essid} ({signalStrength}%)  ",
            "format-ethernet": " {ifname}",
            "tooltip-format": " {ifname} via {gwaddr}",
            "format-linked": " {ifname} (No IP)",
            "format-disconnected": "Disconnected ⚠ {ifname}",
            "format-alt": " {ifname}: {ipaddr}/{cidr}"
          },
          "pulseaudio#output": {
            // "scroll-step": 1, // %, can be a float
            "format": "{icon} {volume}%",
            "format-bluetooth": " {icon} {volume}% {format_source}",
            "format-bluetooth-muted": "󰝟  {icon} {format_source}",
            "format-muted": " ",
            "format-icons": {
              // "headphone": "",
              // "hands-free": "",
              // "headset": "",
              // "phone": "",
              // "portable": "",
              // "car": "",
              "default": [" ", " ", " "]
            },
            "on-click": "pamixer -t",
            "on-scroll-up": "pamixer -i 5",
            "on-scroll-down": "pamixer -d 5"
          },
          "pulseaudio#input": {
            "format-source": "",
            "format-source-muted": " ",
            "format": "{format_source}",
            "on-click": "pamixer -t --default-source" 
          },
          "custom/poweroff": {
            "tooltip": false,
            "format": " ",
            "on-click": "bash $HOME/.config/waybar/scripts/poweroff.sh"
          }
        }
      '';
    };
  };
}

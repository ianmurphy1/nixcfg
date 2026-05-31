{ osConfig, lib, ... }:
let
  hostname = osConfig.networking.hostName;
  fontSizes = {
    legion = "16";
    titan = "12";
    galaxy = "15";
    nixos = "12";
    nixvirt = "16";
  };
in
{
  home.file = {
    ".config/kitty/kitty.conf" = lib.mkDefault {
      text = ''
        font_family SauceCodePro Nerd Font
        font_size ${fontSizes."${hostname}"}
        enable_audio_bell no
        symbol_map U+f6a9,U+f2db,U+f538 Font Awesome 6 Free Solid
        
        tab_bar_edge top
        tab_bar_style powerline
        tab_bar_min_tabs 1
        
        active_tab_foreground #ffffff
        active_tab_background #437019
        inactive_tab_foreground #ffffff
        inactive_tab_background #666666
        tab_bar_background #151515
        
        cursor_shape block
        cursor_blink_interval 0
        
        shell_integration no-cursor
        
        map ctrl+shift+d new_tab_with_cwd 

        ${lib.optionalString (hostname == "legion") "
        include /home/ian/.config/kitty/themes/noctalia.conf
        "}
      '';
    };
    ".config/kitty/themes/noctalia.conf" = lib.mkDefault {
      text = ''
        color0 #15161e
        color1 #f7768e
        color2 #9ece6a
        color3 #e0af68
        color4 #7aa2f7
        color5 #bb9af7
        color6 #7dcfff
        color7 #a9b1d6
        color8 #414868
        color9 #f7768e
        color10 #9ece6a
        color11 #e0af68
        color12 #7aa2f7
        color13 #bb9af7
        color14 #7dcfff
        color15 #c0caf5
        selection_foreground #c0caf5
        cursor #c0caf5
        cursor_text_color #1a1b26
        foreground #c0caf5
        selection_background #283457
        active_border_color #7aa2f7
        inactive_border_color #bb9af7
        active_tab_foreground   #16161e
        active_tab_background   #7aa2f7
        inactive_tab_foreground #9aa5ce
        inactive_tab_background #24283b
        cursor_trail_color      #9aa5ce
      '';
    };
  };
}

{ osConfig, ... }:
let
  hostname = osConfig.networking.hostName;
  fontSizes = {
    legion = "16";
    galaxy = "15";
    nixos = "12";
    nixvirt = "16";
  };
in
{
  home.file = {
    ".config/kitty/kitty.conf" = {
      text = ''
        font_family SauceCodePro Nerd Font
        font_size ${fontSizes."${hostname}"}
        enable_audio_bell no
        symbol_map U+f6a9,U+f2db,U+f538 Font Awesome 6 Free Solid
        
        tab_bar_edge top
        tab_bar_style powerline
        
        active_tab_foreground #ffffff
        active_tab_background #437019
        inactive_tab_foreground #ffffff
        inactive_tab_background #666666
        tab_bar_background #151515
        
        cursor_shape block
        cursor_blink_interval 0
        
        shell_integration no-cursor
        
        map ctrl+shift+d new_tab_with_cwd 
      '';
    };
  };
}

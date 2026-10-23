{ pkgs, lib, ... }:
let
  tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
  startCmd = "${pkgs.hyprland}/bin/start-hyprland";
  niriSession = "${pkgs.niri}/bin/niri-session";
in
{
  # services.greetd = {
  #   enable = true;
  #   useTextGreeter = true;
  #   settings = {
  #     default_session = {
  #       command = "${tuigreet} --asterisks --time --remember --no-xsession-wrapper --cmd ${niriSession}";
  #       user = "greeter";
  #     };
  #   };
  # };

  services.gnome.gnome-keyring.enable = true;
  services.gnome.gcr-ssh-agent.enable = false;

  security.pam.services.greetd.enableGnomeKeyring = true;
  security.pam.services.login.enableGnomeKeyring = true;

  services.displayManager.noctalia-greeter = {
    enable = true;
    settings = {
      session.default = "niri";
      user.default = "ian";
      auth = {
        allow_empty_password = false;
      };
      appearance = {
        scheme = "Synced";
        hide_logo = true;
        font_family = "NotoMono NF";
        wallpaper = {
          fill_mode = "crop";
          path = "/var/lib/noctalia-greeter/wallpaper.jpg";
        };
      };
      cursor.size = 14;
      keyboard.layout = "gb";
    };
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };
    passwordlessSyncUsers = [ "ian" ];
  };
}

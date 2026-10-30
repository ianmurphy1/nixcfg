{ pkgs, lib, ... }:
let
  tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
  niriSession = "${pkgs.niri}/bin/niri-session";
in
{
  services.gnome.gnome-keyring.enable = true;
  services.gnome.gcr-ssh-agent.enable = false;

  security.pam.services.greetd.fprintAuth = lib.mkForce false;
  # security.pam.services.login.fprintAuth = lib.mkForce false;
  security.pam.services.greetd.enableGnomeKeyring = true;
  security.pam.services.login.enableGnomeKeyring = true;
  security.pam.services.login.fprintAuth = false;
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
      keyboard.layout = "us";
    };
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };
    passwordlessSyncUsers = [ "ian" ];
}

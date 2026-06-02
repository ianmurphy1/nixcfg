{ pkgs, lib, ... }:
let
  tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
  startCmd = "${pkgs.hyprland}/bin/start-hyprland";
  niriSession = "${pkgs.niri}/bin/niri-session";
in
{
  services.greetd = {
    enable = true;
    useTextGreeter = true;
    settings = {
      default_session = {
        command = "${tuigreet} --asterisks --time --remember --no-xsession-wrapper --cmd ${niriSession}";
        user = "greeter";
      };
    };
  };

  services.gnome.gnome-keyring.enable = true;
  services.gnome.gcr-ssh-agent.enable = false;

  security.pam.services.greetd.fprintAuth = lib.mkForce false;
  security.pam.services.greetd.enableGnomeKeyring = true;

  # this is a life saver.
  # literally no documentation about this anywhere.
  # might be good to write about this...
  # https://www.reddit.com/r/NixOS/comments/u0cdpi/tuigreet_with_xmonad_how/
  # systemd.services.greetd.serviceConfig = {
  #   Type = "idle";
  #   StandardInput = "tty";
  #   StandardOutput = "tty";
  #   StandardError = "journal"; # Without this errors will spam on screen
  #   # Without these bootlogs will spam on screen
  #   TTYReset = true;
  #   TTYVHangup = true;
  #   TTYVTDisallocate = true;
  # };
}

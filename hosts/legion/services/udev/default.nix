# udev.nix
{ ... }:

{
  ## Extra settings for udev to enable keyboard micmute button
  services.udev.extraHwdb = ''
    evdev:input:b0003v048DpC997e0110*
      KEYBOARD_KEY_70039=esc
  '';
}

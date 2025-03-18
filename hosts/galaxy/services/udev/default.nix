# udev.nix
{ lib, ... }:

{
  ## Extra settings for udev to map capsl to escape
  services.udev.extraHwdb = ''
    evdev:input:b0011v0001p0001eAB83*
      KEYBOARD_KEY_3a=esc
  '';
}

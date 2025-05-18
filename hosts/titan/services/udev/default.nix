# udev.nix
{ ... }:

{
  services.udev.extraHwdb = ''
    evdev:input:b0003v1B1Cp1BB3e0100*
      KEYBOARD_KEY_70039=esc
  '';
}

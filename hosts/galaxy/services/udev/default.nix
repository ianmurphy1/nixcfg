# udev.nix
{ lib, ... }:

{
  ## Extra settings for udev to enable keyboard micmute button
  services.udev.extraHwdb = lib.mkIf false ''
    evdev:atkbd:dmi:bvnInsydeCorp.:bvrV1.03:bd03/03/2023:br1.3:efr1.3:svnAcer:pnSwiftSFG16-71*
      KEYBOARD_KEY_66=micmute
      KEYBOARD_LED_NUMLOCK=0
  '';
}

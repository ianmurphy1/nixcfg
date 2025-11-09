{ lib, ... }:
{
  environment.sessionVariables.XCURSOR_SIZE = lib.mkOverride 10 "24";
}

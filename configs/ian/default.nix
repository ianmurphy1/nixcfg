{ lib, mylib, ...}:
{
  imports = lib.flatten [
    (mylib.scanPaths ./.)
  ];
}

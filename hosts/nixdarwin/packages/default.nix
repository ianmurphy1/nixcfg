{ mylib, lib, ... }:
{
  imports = lib.flatten [
    (mylib.scanPaths ./.)
  ];
}

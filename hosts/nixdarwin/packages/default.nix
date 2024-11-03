{ mylib, lib, ... }:
{
  inputs = lib.flatten [
    (mylib.scanPaths ./.)
  ];
}

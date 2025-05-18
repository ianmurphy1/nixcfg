{ lib, mylib, ...}:
{
  imports = lib.flatten [
    (mylib.scanPaths ./.)
    ../common/kitty
    ../common/vim
  ];
}

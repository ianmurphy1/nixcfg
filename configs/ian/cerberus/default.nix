{ lib, mylib, ...}:
{
  imports = lib.flatten [
    (mylib.scanPaths ./.)
    ../common/vim
    ../common/zsh
  ];
}

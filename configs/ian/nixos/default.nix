{ lib, mylib, ...}:
{
  imports = lib.flatten [
    ../common/kitty
    ../common/vim
    ../common/zsh
  ];
}

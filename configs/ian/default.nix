{ config, pkgs, lib, inputs, myvars, ...}:
{
  imports = (myvars.scanPaths ./.);
}

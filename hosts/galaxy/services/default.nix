{ mylib, ... }:
{
  imports = (mylib.scanPaths ./.);
}

{ mylib, ...}:
{
  imports = (mylib.scanPaths ./.);
}

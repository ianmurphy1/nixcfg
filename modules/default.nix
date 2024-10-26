{ lib, inputs, ... }:
let
  filesIn = dir: (map (fname: dir + "/${fname}")
    (builtins.attrNames (builtins.readDir dir)));
  dirsIn = dir:
    inputs.nixpkgs.lib.filterAttrs (name: value: value == "directory")
    (builtins.readDir dir);
in
{
  imports = lib.flatten lib.attrsets.mapAttrsToList(dirsIn ./.);
}

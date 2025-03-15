{
  pkgs ? import <nixpkgs> { },
}:
{

  #################### Packages with external source ####################

  unseal-vault = pkgs.callPackage ./unseal-vault {};
}

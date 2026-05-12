{
  pkgs ? import <nixpkgs> { },
}:
{

  #################### Packages with external source ####################

  unseal-vault = pkgs.callPackage ./unseal-vault {};
  randpass = pkgs.callPackage ./randpass {};
  mirror = pkgs.callPackage ./mirror {};
}

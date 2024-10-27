{ lib, inputs, myvars, mylib, ... }:
let
  username = myvars.username;
in
{
  imports = lib.flatten [
    inputs.home-manager.nixosModules.home-manager
    (mylib.scanPaths ./.)
  ];

  home-manager = {
    users = {
      "${username}" = ../../home/${username};
    };
  };
}

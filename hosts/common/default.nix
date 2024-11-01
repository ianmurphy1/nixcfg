{ lib, inputs, outputs, myvars, mylib, ... }:
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
    extraSpecialArgs = { inherit inputs outputs; };
  };
}

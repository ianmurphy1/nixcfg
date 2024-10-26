{ lib, inputs, myvars, ... }:
let
  username = myvars.username;
in
{
  imports = lib.flatten [
    inputs.home-manager.nixosModules.home-manager
    (myvars.scanPaths ./.)
  ];

  home-manager = {
    users = {
      "${username}" = ../../home/${username};
    };
  };
}

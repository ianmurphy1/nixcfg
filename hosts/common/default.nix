{ lib, inputs, myvars, ... }:
{
  imports = lib.flatten [
    inputs.home-manager.nixosModules.home-manager
    (myvars.scanPaths ./.)
  ];

  home-manager = {
    users = {
      "${myvars.username}" = ../../configs/${myvars.username};
    };
  };
}

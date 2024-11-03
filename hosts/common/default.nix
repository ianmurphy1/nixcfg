{ config, lib, inputs, outputs, myvars, mylib, ... }:
let
  username = myvars.username;
  hostname = config.networking.hostName;
in
{
  imports = lib.flatten [
    (mylib.scanPaths ./.)
  ];

  home-manager = {
    users = {
      "${username}" = ../../home/${username}/${hostname}.nix;
    };
    extraSpecialArgs = { inherit inputs outputs; };
  };
}

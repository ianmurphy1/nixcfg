# This function creates a NixOS system based on our VM setup for a
# particular architecture.
{ nixpkgs, nur, inputs }:

name:
{
  system,
  darwin ? false,
}:

let
  # NixOS vs nix-darwin functionst
  systemFunc = if darwin then inputs.darwin.lib.darwinSystem else nixpkgs.lib.nixosSystem;
  home-manager = if darwin then inputs.home-manager.darwinModules else inputs.home-manager.nixosModules;
  lib = nixpkgs.lib;
  myvars = import ../vars;
  mylib = import ./default.nix { inherit lib; };
  nixosModules = import ../modules;

  specialArgs = {
    inherit
      inputs
      #pkgs
      mylib
      nur
      myvars;
  };
in systemFunc {
  inherit system specialArgs;
  modules = [
    nur.modules.nixos.default
    nixosModules
    ../hosts/${name}
    { networking.hostName = "${name}"; }
    home-manager.default {
      home-manager.useGlobalPkgs = true;
      home-manager.extraSpecialArgs = specialArgs;
    }
  ];
}

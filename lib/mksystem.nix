# This function creates a NixOS system based on our VM setup for a
# particular architecture.
{ nixpkgs, overlays, inputs }:

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

  pkgs = import nixpkgs {
    inherit system overlays;
    config.allowUnfree = true;
  };

  specialArgs = {
    inherit
      inputs
      pkgs
      mylib
      myvars;
  };
in systemFunc {
  inherit system specialArgs;
  modules = [
    ../hosts/${name}
    home-manager.default {
      home-manager.useGlobalPkgs = true;
      home-manager.extraSpecialArgs = specialArgs;
    }
  ];
}

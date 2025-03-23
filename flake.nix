{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    mysecrets = {
      url = "git+ssh://git@github.com/ianmurphy1/sops-secrets.git?ref=main&shallow=1";
      flake = false;
    };
  };

  outputs = { nixpkgs, nur, ... }@inputs:
    let
      mkSystem = import ./lib/mksystem.nix {
        inherit nixpkgs nur inputs;
      };
    in {
      nixosConfigurations = {
        nixos = mkSystem "nixos" {
          system = "x86_64-linux";
        };
        galaxy = mkSystem "galaxy" {
          system = "x86_64-linux";
        };
        legion = mkSystem "legion" {
          system = "x86_64-linux";
        };
      };
      darwinConfigurations = {
        nixdarwin = mkSystem "nixdarwin" {
          system = "x86_64-darwin";
          darwin = true;
        };
      };
  };
}

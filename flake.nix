{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix-local = {
      url = "git+file:///Users/ian/dev/nixos/sops-nix-fork";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mysecrets = {
      url = "git+ssh://git@github.com/ianmurphy1/sops-secrets.git?ref=main&shallow=1";
      flake = false;
    };
  };

  outputs = { nixpkgs, ... }@inputs:
    let
      overlays = import ./overlays;

      mkSystem2 = import ./lib/mksystem.nix {
        inherit nixpkgs overlays inputs;
      };
    in {
      nixosConfigurations = {
        #nixos = mkSystem inputs.nixpkgs "x86_64-linux" "nixos";
        nixos = mkSystem2 "nixos" rec {
          system = "x86_64-linux";
        };
      };
      darwinConfigurations = {
        nixdarwin = mkSystem2 "nixdarwin" {
          system = "x86_64-darwin";
          darwin = true;
        };
      };
  };
}

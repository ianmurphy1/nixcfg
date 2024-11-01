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

    mysecrets = {
      url = "git+ssh://git@github.com/ianmurphy1/sops-secrets.git?ref=main&shallow=1";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";

      lib = nixpkgs.lib;
      myvars = import ./vars { };
      mylib = import ./lib { inherit lib; };
      overlays = import ./overlays;
      pkgs = import nixpkgs { 
        system = system;
        config.allowUnfree = true;
        inherit overlays;
      };
      specialArgs = {
        inherit
          inputs
          outputs
          pkgs
          mylib
          myvars;
      };

      mkSystem = pkgs: system: hostname:
        pkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = [
            { networking.hostName = hostname; }
            home-manager.nixosModules.default
            {
              home-manager.extraSpecialArgs = specialArgs; 
              home-manager.useGlobalPkgs = true;
            }
            ./hosts/${hostname}
          ];
        };
    in {
      nixosConfigurations = {
        nixos = mkSystem inputs.nixpkgs "x86_64-linux" "nixos";
      };
  };
}

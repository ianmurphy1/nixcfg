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
      pkgs = import nixpkgs { 
        system = system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
      myvars = import ./vars { inherit lib; };
      specialArgs = {
        inherit
          inputs
          outputs
          pkgs
          myvars;
      };

      mkSystem = pkgs: system: hostname:
        pkgs.lib.nixosSystem {
          system = system;
          inherit specialArgs;
          modules = [
            { networking.hostName = hostname; }
            home-manager.nixosModules.home-manager
            { home-manager.extraSpecialArgs = specialArgs; }
            ./hosts/${hostname}
          ];
        };
    in {
      nixosConfigurations = {
        nixos = mkSystem inputs.nixpkgs "x86_64-linux" "nixos";
      };
  };
}

{ config, pkgs, inputs, lib, myvars, mylib, ...}:

let
  secretspath = builtins.toString inputs.mysecrets;
  username = myvars.username;
  user = config.users.users."${username}";
  hostname = config.networking.hostName;
  usergroup = user.group;
  homedir = user.home;
in
{
  imports = lib.flatten [
    ./packages
    ../common
    inputs.home-manager.darwinModules.home-manager
  ];

  home-manager = {
    sharedModules = [
      inputs.sops-nix.homeManagerModules.sops
    ];
    users = {
      "${username}" = ../../home/${username}/${hostname}.nix;
    };
    extraSpecialArgs = { inherit inputs; };
  };
  system.stateVersion = 5;
  services.nix-daemon = {
    enable = true;
  };
  users.users.${username} = {
    name = "${username}";
    home = "/Users/${username}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  nix = {
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "${username}" ];
      auto-optimise-store = true;
      warn-dirty = false;
    };
    optimise.automatic = true;
  };

  environment.systemPackages = with pkgs; [
    curl
    git
    wget
    zsh
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
}

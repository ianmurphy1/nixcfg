{ config, pkgs, inputs, lib, myvars, mylib, ...}:

let
  secretspath = builtins.toString inputs.mysecrets;
  username = myvars.username;
  user = config.users.users."${username}";
  usergroup = user.group;
  homedir = user.home;
in
{
  users.users.${username} = {
    isNormalUser = true;
    home = "/Users/ian";
    shell = pkgs.zsh;
  };

  sops = {
    age = {
      keyFile = "${homedir}/.config/sops/age/keys.txt";
    };
    defaultSopsFile = "${secretspath}/${config.networking.hostName}.secrets.yaml";
    secrets = {
      user_pass = {
        neededForUsers = true;
      };
    };
  };

  imports = lib.flatten [
    inputs.sops-nix.nixosModules.sops
    ../common
  ];

  programs.ssh = {
    startAgent = true;
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

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
}

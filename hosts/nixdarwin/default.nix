{ config, pkgs, inputs, lib, myvars, mylib, ...}:

let
  secretspath = builtins.toString inputs.mysecrets;
  username = myvars.username;
  user = config.users.users."${username}";
  hostname = config.networking.hostName;
  homedir = user.home;
in
{
  imports = lib.flatten [
    ../optional/zsh
    ../common
    inputs.home-manager.darwinModules.home-manager
    inputs.sops-nix-local.darwinModules.sops
  ];

  sops = {
    age = {
      keyFile = "${homedir}/.config/sops/age/keys.txt";
    };
    defaultSopsFile = "${secretspath}/${hostname}.secrets.yaml";
    secrets = {
      test_template_secret = {
        neededForUsers = true;
      };
    };
  };

  home-manager = {
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
      warn-dirty = false;
    };
    optimise.automatic = true;
  };

  environment.systemPackages = with pkgs; [
    python3
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

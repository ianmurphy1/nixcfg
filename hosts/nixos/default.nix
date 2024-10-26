{ config, pkgs, inputs, lib, outputs, myvars, ...}:

let
  username = myvars.username;
  secretspath = builtins.toString inputs.mysecrets;
in
{
  imports = lib.flatten [
    ./services
    ./hardware-configuration.nix
    ./system.nix
    inputs.sops-nix.nixosModules.sops
    ../common
    (myvars.scanPaths ../optional)
  ];

  sops = {
    age = {
      keyFile = "${config.users.users."${username}".home}/.config/sops/age/keys.txt";
    };
    defaultSopsFile = "${secretspath}/${config.networking.hostName}.secrets.yaml";
    secrets = {
      user_pass = {
        neededForUsers = true;
      };
    };
    
  };

  users.users.${username} = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets.user_pass.path;
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "video"
      "input"
    ];
    shell = pkgs.zsh;
  };

  programs.ssh = {
    startAgent = true;
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
    };
  };

  environment.systemPackages = with pkgs; [
    git
    zsh
    curl
    wget
    intel-media-driver
  ];

  nix = {
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "ian" "@wheel" ];
      auto-optimise-store = true;
    };
    optimise.automatic = true;
  };


  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };
}

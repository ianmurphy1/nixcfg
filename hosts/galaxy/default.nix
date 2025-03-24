{ config, pkgs, inputs, nur, lib, myvars, mylib, ...}:

let
  secretspath = builtins.toString inputs.mysecrets;
  username = myvars.username;
  user = config.users.users."${username}";
  usergroup = user.group;
  homedir = user.home;
  localOverlays = lib.flatten [
    (import ../../overlays)
    nur.overlays.default
  ];
  pubKeys = mylib.scanPathsExt {
    path = ../common/security/ssh-keys;
    ext = "pub";
  };
in
{
  imports = lib.flatten [
    ./services
    ./hardware-configuration.nix
    ./system.nix
    ../common
    (mylib.scanPaths ../optional)
    inputs.home-manager.nixosModules.home-manager
    inputs.sops-nix.nixosModules.sops
  ];

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

  users.users.${username} = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets.user_pass.path;
    extraGroups = [
      "render"
      "wheel"
      "networkmanager"
      "audio"
      "video"
      "input"
      "docker"
    ];
    shell = pkgs.zsh;
    openssh = {
      authorizedKeys = {
        keyFiles = pubKeys;
      };
    };
  };

  # Create directories for vim to store its temp files
  systemd.user.tmpfiles = {
    #Type Path Mode User Group Age Argument…
    rules = [
      "d /home/${username}/.vimextra/swap 0755 ${username} ${usergroup} - -"
      "d /home/${username}/.vimextra/backup 0755 ${username} ${usergroup} - -"
    ];
  };

  security = {
    sudo.extraRules = [
      {
        users = [ "${myvars.username}" ];
        commands = [
          {
            command = "ALL";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
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
    fwupd
  ];

  nix = {
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "${username}" "@wheel" ];
      auto-optimise-store = true;
      warn-dirty = false;
      substituters = [
        "https://ncps.home"
      ];
      trusted-public-keys = [
        "ncps.home:6qNYS6mjcO2Ef2VcmIEC7rX4ZMP91PL74oP2cO9JJcU="
      ];
    };
    optimise.automatic = true;
  };

  nixpkgs = {
    overlays = localOverlays;
    
    config = {
      allowBroken = true;
      allowUnfree = true; 
    };
  };
}

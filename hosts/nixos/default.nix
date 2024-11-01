{ config, pkgs, inputs, lib, outputs, myvars, mylib, ...}:

let
  secretspath = builtins.toString inputs.mysecrets;
  username = myvars.username;
  user = config.users.users."${username}";
  usergroup = user.group;
  homedir = user.home;
in
{
  imports = lib.flatten [
    inputs.sops-nix.nixosModules.sops
    ./services
    ./hardware-configuration.nix
    ./system.nix
    ../common
    (mylib.scanPaths ../optional)
  ];

  # Init sops-nix here and use secrets wherever they're needed
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
      "wheel"
      "networkmanager"
      "audio"
      "video"
      "input"
    ];
    shell = pkgs.zsh;
  };

  # Create directories for vim to store its temp files
  systemd.user.tmpfiles = {
    #Type Path Mode User Group Age Argument…
    rules = [
      "d /home/${username}/.vimextra/swap 0755 ${username} ${usergroup} - -"
      "d /home/${username}/.vimextra/backup 0755 ${username} ${usergroup} - -"
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
  ];

  nix = {
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "${username}" "@wheel" ];
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

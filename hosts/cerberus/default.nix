{ config, pkgs, inputs, nur, lib, myvars, mylib, ...}:

let
  system = pkgs.stdenv.hostPlatform.system;
  secretspath = toString inputs.mysecrets;
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
    # ./intel
    # ./nvidia
    # ./services
    ./hardware-configuration.nix
    ./system.nix
    ./ec2.nix
    ../common
    ../optional/zsh
    ../optional/nh
    # (mylib.scanPathsExt { path = ../optional; })
    inputs.home-manager.nixosModules.home-manager
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      generateKey = true;
      keyFile = "${homedir}/.config/sops/age/keys.txt";
    };
    defaultSopsFile = "${secretspath}/${config.networking.hostName}.secrets.yaml";
    secrets = {
      user_pass = {
        neededForUsers = true;
      };
      vault_unseal_keys = {
        owner = "${username}";
      };
    };
  };

  programs.zsh.enable = true;

  users.users.${username} = {
    isNormalUser = true;
    # hashedPasswordFile = config.sops.secrets.user_pass.path;
    extraGroups = 
      let
        dockerEnabled = config.virtualisation.docker.enable;
      in [
        "render"
        "wheel"
        "networkmanager"
        "audio"
        "video"
        "input"
      ] ++ lib.optionals dockerEnabled [
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
    package = pkgs.openssh;
  };

  services.openssh = {
    enable = true;
    package = pkgs.openssh;
    settings = {
      PasswordAuthentication = true;
    };
  };

  environment.systemPackages = with pkgs; [
    # zen-browser-bin
    git
    zsh
    curl
    wget
  ];

  nix = {
    # nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    settings = {
      nix-path = [ "nixpkgs=${inputs.nixpkgs}" ];
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "${username}" "@wheel" ];
      auto-optimise-store = true;
      warn-dirty = false;
      substituters = [
        "https://cache.nixos.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
      # extra-platforms = config.boot.binfmt.emulatedSystems;
    };
    optimise.automatic = true;
  };

  nixpkgs = {
    overlays = [
      (final: prev: {
        unstable = import inputs.nixpkgs-unstable {
          system = system;
          config = {
            allowUnfree = true;
          };
        };
        # fork = import inputs.nixpkgs-fork {
        #   system = system;
        #   config = {
        #     allowUnfree = true;
        #   };
        # };
      })
    ] ++ localOverlays;

    config = {
      allowBroken = true;
      allowUnfree = true;
    };
  };
}

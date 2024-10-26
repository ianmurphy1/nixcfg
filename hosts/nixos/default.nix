{ config, pkgs, inputs, myvars, ...}:

let
  username = myvars.username;
  secretspath = builtins.toString inputs.mysecrets;
in
{
  imports = [
    ./hardware-configuration.nix
    ./system.nix
    inputs.sops-nix.nixosModules.sops
    ../common
    ../optional/hyprland
    ../optional/firefox
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
  };

  environment.systemPackages = with pkgs; [
    git
    zsh
    curl
    wget
  ];
}

{ config, pkgs, inputs, lib, myvars, mylib, ...}:

let
  secretspath = builtins.toString inputs.mysecrets;
  username = myvars.username;
  user = config.users.users."${username}";
  usergroup = user.group;
  homedir = user.home;
in
{
  imports = [
    ../common/vim
    ../common/kitty
    inputs.home-manager.darwinModules.home-manager
  ];

  home-manager = {
    users = {
      "${username}" = ../../home/${username};
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

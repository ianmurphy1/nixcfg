# zsh.nix
{ config, pkgs, ... }:

let
  nixosConfig = "${config.users.users.ian.home}/nixcfg";
in
{
  environment.systemPackages = with pkgs; [
    zsh
    zoxide
    zsh-powerlevel10k
    zsh-fast-syntax-highlighting
  ];

  environment.variables = {
    VAULT_ADDR = "https://vault.home";
    VAULT_FORMAT = "json";
  };
}

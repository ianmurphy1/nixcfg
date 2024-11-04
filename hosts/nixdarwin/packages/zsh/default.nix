# zsh.nix
{ config, pkgs, myvars, ... }:

let
  nixosConfig = "${config.users.users.ian.home}/nixcfg";
  username = myvars.username;
in
{
  sops.secrets = {
    test_secret = {
      owner = username;
    };
    template_test_secret = {
      owner = username;
    };
    new_secret = {
      owner = username;
    };
  };
  environment.systemPackages = with pkgs; [
    zsh
    zoxide
    zsh-powerlevel10k
    zsh-fast-syntax-highlighting
    python3
  ];

  environment.variables = {
    VAULT_ADDR = "https://vault.home";
    VAULT_FORMAT = "json";
  };

  sops.templates."template_test" = {
    content = ''
      secret for template is: ${config.sops.placeholder.template_test_secret}
    '';
    owner = username;
  };
}

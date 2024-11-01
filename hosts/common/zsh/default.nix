# zsh.nix
{ config, pkgs, ... }:

let
  nixosConfig = "${config.users.users.ian.home}/nixcfg";
in
{
  sops.secrets.vault_token = {
    owner = "${config.users.users.ian.name}";
  };

  programs.zsh = {
    enable = true;
    histSize = 10000;
    enableCompletion = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    shellAliases = {
      ssh = "kitten ssh";
      rebuild = "nh os switch";
      update = "nix flake update --flake ${nixosConfig}/.#";
      garbage = "nh clean all -k 5 -K 5d";
      config = "cd ${nixosConfig}";
    };
    interactiveShellInit = ''
      source ${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh
      eval "$(${pkgs.zoxide}/bin/zoxide init zsh --cmd cd)"
    '';
    shellInit = ''
      export VAULT_TOKEN="$(cat ${config.sops.secrets.vault_token.path})"
    '';
    ohMyZsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "direnv"
        "rust"
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    zoxide
    zsh-powerlevel10k
    zsh-fast-syntax-highlighting
  ];
  environment.variables = {
    VAULT_ADDR = "https://vault.home";
    VAULT_FORMAT = "json";
  };
}

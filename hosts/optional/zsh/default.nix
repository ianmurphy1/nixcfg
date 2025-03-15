# zsh.nix
{ config, pkgs, ... }:

let
  nixosConfig = "${config.users.users.ian.home}/nixcfg";
in
{
  sops.secrets = {
    vault_token = {
      owner = "${config.users.users.ian.name}";
    };
    cachix_token = {
      owner = "${config.users.users.ian.name}";
    };
    vault_unseal_keys = {
      owner = "${config.users.users.ian.name}";
    };
  };

  programs.zsh = {
    enable = true;
    histSize = 10000;
    enableCompletion = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    promptInit = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme;
      
      [[ ! -f $${./p10k.zsh;} ]] || source $${./p10k.zsh}
    '';
    shellAliases = {
      ssh = "kitten ssh";
      rebuild = "nh os switch";
      update = "nix flake update --flake ${nixosConfig}/.#";
      garbage = "nh clean all -k 5 -K 5d";
      config = "cd ${nixosConfig}";
    };
    interactiveShellInit = ''
      ZVM_CURSOR_STYLE_ENABLED=false
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      source ${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh
      source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh
      eval "$(${pkgs.zoxide}/bin/zoxide init zsh --cmd cd)"
    '';
    shellInit = ''
      export VAULT_TOKEN="$(cat ${config.sops.secrets.vault_token.path})"
      export CACHIX_TOKEN="$(cat ${config.sops.secrets.cachix_token.path})"
      export TOKEN_FILE="${config.sops.secrets.vault_unseal_keys.path}"
    '';
    ohMyZsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "aws"
        "git"
        "direnv"
        "rust"
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    unseal-vault # custom package, in pkgs dir
  ];

  environment.variables = {
    VAULT_ADDR = "https://vault.home";
    VAULT_FORMAT = "json";
  };
}

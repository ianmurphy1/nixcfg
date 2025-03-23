# zsh.nix
{ config, pkgs, lib, ... }:

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
    attic_token = {
      owner = "${config.users.users.ian.name}";
    };
  };

  system.userActivationScripts.zshrc = "touch .zshrc";

  programs.zsh = {
    enable = true;
    histSize = 10000;
    enableCompletion = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    promptInit = ''
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
    shellAliases = {
      ssh = "kitten ssh";
      rebuild = "nh os switch";
      update = "nix flake update --flake ${nixosConfig}/.#";
      garbage = "nh clean all -k 5 -K 5d";
      config = "cd ${nixosConfig}";
    };
    interactiveShellInit = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme;
      source ${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh
      source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh
      eval "$(${lib.getExe pkgs.zoxide} init zsh --cmd cd)"
    '';
    shellInit = ''
      export VAULT_TOKEN="$(cat ${config.sops.secrets.vault_token.path})"
      export ATTIC_TOKEN="$(cat ${config.sops.secrets.attic_token.path})"
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

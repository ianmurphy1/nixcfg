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
    postgres_pass = {
      owner = "${config.users.users.ian.name}";
    };
    terraform_cloud_api_key = {
      owner = "${config.users.users.ian.name}";
    };
    cloudflare_r2_api_token = {
      owner = "${config.users.users.ian.name}";
    };
  };

  system.userActivationScripts.zshrc = "touch .zshrc";

  programs.zsh = {
    antidote = {
      enable = false;
      plugins = [
        "zdharma-continuum/fast-syntax-highlighting kind:defer"
        "chisui/zsh-nix-shell"

        "ohmyzsh/ohmyzsh path:plugins/git"
        "ohmyzsh/ohmyzsh path:plugins/aws"
        "ohmyzsh/ohmyzsh path:plugins/direnv"
        "ohmyzsh/ohmyzsh path:plugins/terraform"
        "ohmyzsh/ohmyzsh path:plugins/opentofu"

        "belak/zsh-utils path:history"
        "belak/zsh-utils path:editor"
        "belak/zsh-utils path:utility"

        "zsh-users/zsh-autosuggestions"
        "zsh-users/zsh-history-substring-search"
      ];
      enablePowerlevel10k = true;
      enableOhMyZsh = true;
    };
    enable = true;
    histSize = 10000;
    enableCompletion = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    promptInit = ''
      # promptInit: START
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      # promptInit: END
    '';
    shellAliases = {
      ssh = "kitten ssh";
      rebuild = "nh os switch";
      update = "nix flake update --flake ${nixosConfig}/.#";
      garbage = "nh clean all -k 5 -K 5d";
      config = "cd ${nixosConfig}";
      myip = "curl https://am.i.mullvad.net/ip";
    };
    interactiveShellInit = ''
      # interactiveShellInit: START
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme;
      source ${pkgs.zsh-fast-syntax-highlighting}/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
      source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh
      eval "$(${lib.getExe pkgs.zoxide} init zsh --cmd cd)"
      # interactiveShellInit: END
    '';
    shellInit = ''
      export VAULT_TOKEN="$(cat ${config.sops.secrets.vault_token.path})"
      export ATTIC_TOKEN="$(cat ${config.sops.secrets.attic_token.path})"
      export CACHIX_TOKEN="$(cat ${config.sops.secrets.cachix_token.path})"
      export TOKEN_FILE="${config.sops.secrets.vault_unseal_keys.path}"
      export PGPASSWORD="$(cat ${config.sops.secrets.postgres_pass.path})"
      export TFE_TOKEN_app_terraform_io="$(cat ${config.sops.secrets.terraform_cloud_api_key.path})"
      export TFE_TOKEN="''${TFE_TOKEN_app_terraform_io}"
      export CLOUDFLARE_SECRET_KEY="$(cat ${config.sops.secrets.cloudflare_r2_api_token.path})"
    '';
    ohMyZsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "aws"
        "git"
        "direnv"
        "rust"
        "terraform"
        "opentofu"
        "kubectl"
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    unseal-vault # custom package, in pkgs dir
  ];

  environment.variables = {
    VAULT_ADDR = "https://vault.home";
    VAULT_FORMAT = "json";
    PGHOST = "postgres.home";
    PGUSER = "postgres";
  };
}

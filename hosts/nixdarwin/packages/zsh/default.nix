{ pkgs, config, ... }:
{
  sops.secrets = {
    test_secret = {
      owner = "ian";
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

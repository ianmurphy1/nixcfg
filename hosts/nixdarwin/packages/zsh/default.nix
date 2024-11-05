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

  #sops.templates.test_template = {
  #  content = ''
  #    TESTING OUT SOPS TEMPLATES
  #    THE SECRET VALUE IS: ${config.sops.placeholder.test_template_secret}
  #    TESTING IF THIS GETS ADDED
  #  '';
  #  owner = "ian";
  #};

  environment.variables = {
    VAULT_ADDR = "https://vault.home";
    VAULT_FORMAT = "json";
  };
}

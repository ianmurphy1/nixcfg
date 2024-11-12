{ pkgs, ... }:
{
  # Collection of cli tools that didn't really fit
  # into a specific place
  environment.systemPackages = with pkgs; [
    vault-bin jq yq-go fastfetch 
    bat zip
    unrar unzip sops age
    tree ripgrep fd
  ];
}

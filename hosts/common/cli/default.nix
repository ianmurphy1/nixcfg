{ pkgs, ... }:
{
  # Collection of cli tools that didn't really fit
  # into a specific place
  environment.systemPackages = with pkgs; [
    vault jq yq-go fastfetch 
    bat step-cli zip 
    unrar unzip sops age
    tree ripgrep fd
  ];
}

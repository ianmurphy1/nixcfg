{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vault jq yq-go fastfetch 
    bat step-cli just zip 
    unrar unzip sops age
    tree git-filter-repo
  ];
}

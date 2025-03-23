{ pkgs, ... }:
{
  # Collection of cli tools that didn't really fit
  # into a specific place
  environment.systemPackages = with pkgs; [
    attic-client
    vault-bin jq jp yq-go fastfetch 
    bat zip bottom zoxide
    unrar unzip sops age
    tree ripgrep fd
    terraform-ls cachix
    google-cloud-sdk
    (texlive.combine {
      inherit (texlive) scheme-full;
    })
  ];
}

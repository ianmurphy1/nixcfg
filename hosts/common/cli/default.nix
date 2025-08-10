{ pkgs, ... }:
{
  # Collection of cli tools that didn't really fit
  # into a specific place
  environment.systemPackages = with pkgs; [
    libation ntfs3g usbutils
    openssl kubelogin-oidc
    vault-bin jq jp yq-go fastfetch 
    bat zip bottom zoxide
    unrar unzip sops age
    tree ripgrep fd
    terraform-ls cachix
    google-cloud-sdk
    (texlive.combine {
      inherit (texlive) scheme-full;
    })
    pgcli
    nodePackages.cdktf-cli
  ];
}

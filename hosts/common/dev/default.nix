# dev.nix
{ pkgs, ... }:
let
  nodePkgs = with pkgs.nodePackages; [
    # aws-cdk
  ];

  unstablePkgs = with pkgs.unstable; [
    awscli2
    aws-sso-util
  ];
in
{
  programs.direnv = {
    package = pkgs.direnv;
    enable = true;
    silent = false;
    loadInNixShell = true;
    direnvrcExtra = "";
    nix-direnv = {
      enable = true;
      package = pkgs.nix-direnv;
    };
  };

  environment.systemPackages = with pkgs; [
    devenv just
    nixos-generators git-filter-repo
    # awscli2
    argocd
    kubectl
    kustomize
    kubernetes-helm
    #docker
    ipcalc
    act
    gopls
    postgresql
    gh
    opentofu
    terraform
    pulumi
    pulumiPackages.pulumi-nodejs
  ] ++ nodePkgs
    ++ unstablePkgs;
}

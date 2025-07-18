# dev.nix
{ pkgs, ... }:
let
  nodePkgs = with pkgs.nodePackages; [
    aws-cdk
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

  #virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    devenv just
    nixos-generators git-filter-repo
    awscli2
    argocd
    kubectl
    kustomize
    kubernetes-helm
    #docker
    act
    gopls
    postgresql
    gh
    opentofu
    terraform
    pulumi
    pulumiPackages.pulumi-nodejs
  ] ++ nodePkgs;
}

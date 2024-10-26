# dev.nix
{ pkgs, ... }:

{
  programs.direnv = {
    package = pkgs.direnv;
    enable = true;
    nix-direnv = {
      enable = true;
      package = pkgs.nix-direnv;
    };
  };

  environment.systemPackages = with pkgs; [
    devenv
    nixos-generators
    awscli2
    kubectl
    kustomize
    kubernetes-helm
  ];
}

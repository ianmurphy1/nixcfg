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

  services.lorri.enable = true;

  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    devenv just
    nixos-generators git-filter-repo
    awscli2
    kubectl
    kustomize
    kubernetes-helm
    docker
  ];
}

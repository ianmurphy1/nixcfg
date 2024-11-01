{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim-full # Uses the vim defined by the overlay
    nodejs_20
    nixd
  ];
  environment.sessionVariables = {
    EDITOR = "vim";
  };
}

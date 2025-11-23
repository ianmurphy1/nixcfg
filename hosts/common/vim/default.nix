{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim-full # Uses the vim defined by the overlay
    nodejs
    nixd
  ];

  environment.variables = {
    EDITOR = "vim";
  };
}

{ pkgs, ... }:
{
  programs.thunderbird = {
    enable = true;
  };
  environment.systemPackages = with pkgs; [
    thunderbird
  ];
}

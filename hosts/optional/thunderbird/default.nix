{ pkgs, ... }:
{
  programs.thunderbird = {
    enable = false;
  };
  environment.systemPackages = with pkgs; [
    # thunderbird
  ];
}

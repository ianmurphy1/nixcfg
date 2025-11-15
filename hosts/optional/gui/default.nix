{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    unstable.protonvpn-gui
  ];
}

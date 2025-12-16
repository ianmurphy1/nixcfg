{ pkgs, ... }:
{
  services.mullvad-vpn = {
    enable = false;
    package = pkgs.mullvad-vpn;
  };
  environment.systemPackages = [ pkgs.mullvad-vpn ];
}

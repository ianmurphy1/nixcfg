{ pkgs, ... }:
{
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };
  environment.systemPackages = [ pkgs.mullvad-vpn ];
}

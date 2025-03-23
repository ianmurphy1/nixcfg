{
  config,
  lib,
  ...
}:
let
  hostName = config.networking.hostName;
in
{
  security = {
    pki = {
      certificateFiles = [
        ./certs/ca/root.crt
      ];
    };
  };

  services.fprintd = lib.mkIf (hostName == "legion") {
    enable = true;
  };
}

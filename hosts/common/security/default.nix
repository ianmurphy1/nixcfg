{
  config,
  ...
}:
let
  hostName = config.networking.hostName;
  fprintEnabled = {
    legion = true;
  };
in
{
  security = {
    pki = {
      certificateFiles = [
        ./certs/ca/root.crt
      ];
    };
  };

  services.fprintd = {
    enable = fprintEnabled.${hostName};
  };
}

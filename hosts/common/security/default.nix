{
  myvars,
  ...
}:
{
  security = {
    pki = {
      certificateFiles = [
        ./certs/ca/root.crt
      ];
    };
  };
}

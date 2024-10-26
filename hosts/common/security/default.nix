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
    sudo.extraRules = [
      {
        users = [ "${myvars.username}" ];
        commands = [
          {
            command = "ALL";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
  };
}

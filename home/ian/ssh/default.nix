{ ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "192.168.1.*" = {
        Host = "192.168.1.*";
        IdentityFile = "~/.ssh/id_ed25519";
        StrictHostKeyChecking = "accept-new";
      };
      "*.home" = {
        Host = "*.home";
        IdentityFile = "~/.ssh/id_ed25519";
        StrictHostKeyChecking = "accept-new";
      };
      "i-*" = {
        ProxyCommand = ''
          sh -c "aws ssm start-session --target %h --document-name AWS-StartSSHSession --parameters 'portNumber=%p'"
        '';
      };
    };
  };
}

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
        ProxyCommand = "ssh-ssm %h %r";
        IdentityFile = "~/.ssh/ssm-ssh-tmp";
        StrictHostKeyChecking = "no";
        BatchMode = "yes";
      };
    };
  };
}

{ ... }:
{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "192.168.1.*" = {
        host = "192.168.1.*";
        identityFile = "~/.ssh/id_ed25519";
        extraOptions = {
          StrictHostKeyChecking = "accept-new";
        };
      };
    };
  };
}

{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    settings = {
      user = {
        email = "iano200@gmail.com";
        name = "ianmurphy1";
      };
      init = {
        defaultBranch = "main";
        pager = {
          branch = false;
        };
      };
    };
    signing = {
      format = "ssh";
    };
  };
}

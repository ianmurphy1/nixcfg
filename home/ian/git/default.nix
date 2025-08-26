{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "ianmurphy1";
    userEmail = "iano200@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      pager.branch = false;
    };
    signing = {
      format = "ssh";
    };
  };
}

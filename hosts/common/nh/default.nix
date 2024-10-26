{ ... }:
{
  programs.nh = {
    enable = true;
    flake = builtins.toString ../../..;
    clean = {
      enable = true;
      dates = "weekly";
      # Keep last 5 and remove older than
      # one week
      extraArgs = "-k 5 -K 7d";
    };
  };
}

{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    tutanota-desktop
    beekeeper-studio
  ];

  environment.etc = {
    "beekeeper-studio/system.config.ini" = {
      text = ''
        ; My Beekeeper Studio Configuration
        ; Lines starting with semicolons are comments

        [ui.tableTable]
        pageSize = 1000
      '';
    };
  };
}

{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.programs.stow;
in {
  options = {
    programs.stow = {
      enable = lib.mkEnableOption "Enable stow symlink manager";

      package = lib.mkPackageOption pkgs "stow";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}

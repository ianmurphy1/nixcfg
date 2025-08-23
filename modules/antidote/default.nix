{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.programs.zsh.antidote;
in
{
  options.programs.zsh.antidote = {
    enable = lib.mkEnableOption "antidote";

    package = lib.mkPackageOption pkgs "antidote" {};
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };

}

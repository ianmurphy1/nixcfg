{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.programs.zsh.antidote;

  pluginString = (
    pluginNames:
    lib.optionalString (pluginNames != [])
      "${lib.concatStrings (
        map (name: ''
          ${name}
        '') pluginNames
      )}"
  );

  parseHashId = path: lib.elemAt (builtins.match "${builtins.storeDir}/([a-zA-Z0-9]+)-.*" path) 0;
in
{
  options.programs.zsh.antidote = {
    enable = lib.mkEnableOption "antidote";

    package = lib.mkPackageOption pkgs "antidote" {};

    plugins = lib.mkOption {
      default = [];
      type = lib.types.listOf (lib.types.str);
      description = "List of plugins to enable";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];

    programs.zsh.promptInit = lib.mkDefault "";

    programs.zsh.interactiveShellInit = 
      let 
        configs = pkgs.runCommand "antidote-files" {} ''
          echo "${pluginString cfg.plugins}" > $out
        '';
        hashId = parseHashId "${configs}";
      in
      (lib.mkOrder 400 ''
        source ${cfg.package}/share/antidote/antidote.zsh

        bundlefile=${configs}        

        zstyle ':antidote:bundle' file $bundlefile
        staticfile=/tmp/tmp_zsh_plugins.zsh-${hashId} 
        zstyle ':antidote:static' file $staticfile

        antidote load $bundlefile $staticfile
      '');
  };

}

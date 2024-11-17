{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.programs.stow;
  type = lib.types.attrsOf (lib.types.submodule ({config, ...}: {
    options = {
      name = lib.mkOption {
        default = config._module.args.name;
        description = "Name of the file to be managed by stow";
        type = lib.types.str;
      };

      source = lib.mkOption {
        type = lib.types.path;
        description = "Path of the source file or directory";
      };

      target = lib.mkOption {
        type = lib.types.str;

      };
    };
  }));
in {
  options = {
    programs.stow = {
      enable = lib.mkEnableOption "Enable stow symlink manager";

      package = lib.mkPackageOption pkgs "stow" {};

      type = lib.mkOption {
        type = with lib.types; attrsOf ( submodule (
          { name, config, options }:
          {
            options = {
              target = lib.mkOption {
                type = lib.types.str;
                description = "Path of where stow will symlink to";
              };

              source = lib.mkOption {
                type = lib.types.path;
                description = "Path of the source file";
              };

              text = lib.mkOption {
                default = null;
                type = lib.types.nullOr lib.types.lines;
                description = "Text content of file";
              };
            };

            config = {
              target = lib.mkDefault name;
              source = lib.mkIf (config.text != null) (
                lib.mkDerivedConfig options.text (pkgs.writeText name)
              );
            };
          }));
      };

    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}

{ pkgs, ... }:

let
  lxcsecrets = pkgs.writeShellScriptBin "lxcsecrets" (builtins.readFile ./scripts/lxc_secrets.sh);
in 
{
  environment.systemPackages = [ lxcsecrets ];
}

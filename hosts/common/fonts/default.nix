{ pkgs, ... }:
let
  nfs = (
    pkgs.nerdfonts.override {
      fonts = [
        "SourceCodePro"
        "Noto"
      ];
    }
  );
in
{
  fonts = {
    packages = with pkgs; [
      source-code-pro
      font-awesome
      font-awesome_5
      powerline-fonts
      nfs
    ];
  };
}

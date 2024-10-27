{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      source-code-pro
      font-awesome
      font-awesome_5
      noto-fonts
      powerline-fonts
      (nerdfonts.override { fonts = [ "SourceCodePro" ]; })
    ];
  };
}

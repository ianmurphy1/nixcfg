{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      source-code-pro
      font-awesome
      font-awesome_5
      font-awesome_6
      powerline-fonts
      nerd-fonts.sauce-code-pro
      nerd-fonts.noto
    ];
  };
}

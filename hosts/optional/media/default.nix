{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    mpv zathura ffmpeg
  ];
}

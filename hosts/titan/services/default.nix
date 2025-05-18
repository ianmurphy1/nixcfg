{ mylib, ... }:
{
  imports = [
    ./cups
    ./pipewire
    ./udev
    ./xserver
  ];
}

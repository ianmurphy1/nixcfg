{ ... }:
{
  services.xserver = {
    enable = false;
    exportConfiguration = true;
    xkb = {
      layout = "gb";
    };
  };
}

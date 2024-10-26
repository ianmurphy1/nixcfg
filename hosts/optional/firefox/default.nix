{ ... }:
{
  programs.firefox = {
    enable = true;
    preferences = {
      "layout.css.devPixelsPerPx" = "1.25";
    };
  };
}

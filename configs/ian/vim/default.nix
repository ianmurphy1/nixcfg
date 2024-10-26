{ ... }:
{
  home.file = {
    ".vim" = {
      source = ./vimrc;
      recursive = true;
    };
  };
}

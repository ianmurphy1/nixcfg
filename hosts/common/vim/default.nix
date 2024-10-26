{pkgs, ...}:
let
  vim = ((pkgs.vim-full.override {}).customize {
    vimrcConfig.packages.packages = with pkgs.vimPlugins; {
      start = [
        vim-nix
        gitgutter
        jellybeans-vim
        vim-airline
        vim-airline-themes
        nerdtree
        vim-go
        rust-vim
        coc-nvim
        vim-terraform
        gitgutter        
      ];
    };
    
  });
in
  {
    environment.systemPackages = [ vim ];
    environment.sessionVariables = {
      EDITOR = "vim";
    };
  }


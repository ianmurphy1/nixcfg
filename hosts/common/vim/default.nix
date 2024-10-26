{pkgs, ...}:
let
  myvim = ((pkgs.vim-full.override {}).customize {
    vimrcConfig.packages.packages = with pkgs.vimPlugins; {
      start = [
        vim-nix
        gitgutter
        jellybeans-vim
        vim-airline
        vim-airline-themes
        nerdtree
        #vim-go
        rust-vim
        coc-nvim
        vim-terraform
        gitgutter        
      ];
    };
    
  });
in
  {
    environment.systemPackages = with pkgs; [
      myvim
      nodejs_22 # Required by coc-nvim
      nixd #LSP server for nix
    ];
    environment.sessionVariables = {
      EDITOR = "vim";
    };
  }


{pkgs, lib, ... }:
let
  myvim = ((pkgs.vim-full.override {}).customize {
    vimrcConfig.packages.packages = with pkgs.vimPlugins; {
      start = [
        vim-fugitive
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
      ];
    };
    # Proper VIM loading seems to be borked
    # with this so source main vimrc file
    # from here
    vimrcConfig.customRC = ''
      source ~/.vim/vimrc
    '';
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

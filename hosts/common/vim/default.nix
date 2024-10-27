{pkgs, ... }:
let
  myvim = ((pkgs.vim-full.override {}).customize {
    vimrcConfig.packages.packages = with pkgs.vimPlugins; {
      start = [
        vim-fugitive vim-just
        vim-nix
        gitgutter
        jellybeans-vim
        vim-airline
        vim-airline-themes
        nerdtree vim-nerdtree-syntax-highlight
        rust-vim
        coc-nvim
        vim-terraform
        vim-devicons
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

{pkgs, ... }:
let
  complete_packages = with pkgs.vimPlugins; [
    coc-nvim
    coc-rust-analyzer
    coc-sh
    coc-json
    coc-rust-analyzer
    coc-yaml
    coc-vimlsp
  ];
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
        vim-terraform
        vim-devicons
        vim-python-pep8-indent
      ] ++ complete_packages;
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
      nodejs_20      
      nixd
    ];
    environment.sessionVariables = {
      EDITOR = "vim";
    };
  }

final: prev:
let
  vimPlugins = prev.vimPlugins;
  autocomplete_plugins = with vimPlugins; [
    coc-nvim
    coc-sh
    coc-json
    coc-rust-analyzer
    coc-yaml
    coc-vimlsp
  ];
  base_plugins = with vimPlugins; [
    vim-fugitive vim-just
    vim-nix vimtex
    gitgutter
    jellybeans-vim
    vim-airline
    vim-airline-themes
    nerdtree vim-nerdtree-syntax-highlight
    rust-vim
    vim-terraform
    vim-devicons
    vim-python-pep8-indent
  ];
in
{
  vim-full = (prev.vim-full.override {}).customize {
    name = "vim";
    vimrcConfig.packages.custom = {
      start = base_plugins ++ autocomplete_plugins;
      opt = [ ];
    };
    # Proper VIM loading seems to be borked
    # with this so source main vimrc file
    # from here
    vimrcConfig.customRC = ''
      source ~/.vim/vimrc
    '';
  };
}

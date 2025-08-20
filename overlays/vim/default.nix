final: prev:
let
  other = with prev; [
  ];
  vimPlugins = prev.vimPlugins;
  autocomplete_plugins = with vimPlugins; [
    coc-nvim
    coc-sh
    coc-json
    coc-rust-analyzer
    coc-yaml
    coc-vimlsp
    #coc-ansible
  ];
  base_plugins = with vimPlugins; [
    vim-fugitive vim-just
    vim-nix vimtex
    vim-gitgutter vim-commentary
    jellybeans-vim
    vim-airline
    vim-airline-themes
    nerdtree vim-nerdtree-syntax-highlight
    rust-vim vim-go
    vim-terraform
    vim-devicons
    vim-python-pep8-indent
    ansible-vim
  ];
in
{
  vim-full = (prev.vim-full.override {}).customize {
    name = "vim";
    vimrcConfig.packages.custom = {
      start = other ++ base_plugins ++ autocomplete_plugins;
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

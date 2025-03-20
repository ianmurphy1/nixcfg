final: prev:
let
  vimPlugins = prev.vimPlugins;
  vimcomplete = prev.vimUtils.buildVimPlugin {
    name = "vimcomplete";
    src = prev.fetchFromGitHub {
      owner = "girishji";
      repo = "vimcomplete";
      rev = "0a2f5899aa398f6f8743ccfde1ce9985781f5e6b";
      hash = "sha256-l+3n2AezQyy4IXKMu/gbPzaMFxfxQdbrf0/37gMKTHw=";
    };
  };
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
    vimcomplete
    vim-fugitive vim-just
    vim-nix vimtex
    gitgutter
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

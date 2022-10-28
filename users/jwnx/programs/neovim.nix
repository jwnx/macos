{ pkgs, lib, ... }:

let
  nvim-treesitter-endwise = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-treesitter-endwise";
    src = pkgs.fetchFromGitHub {
      owner = "RRethy";
      repo = "nvim-treesitter-endwise";
      rev = "f653101e056cebcee71b47b8adb93d3a878cda36";
      sha256 = "sha256-J1cKq/Ctw8Vj7RL3D9AnSezS+8Ugm+nfgXz7KjfKtVo=";
    };
  };
in

{
  enable = true;
  vimAlias = true;
  vimdiffAlias = true;

  extraConfig = builtins.concatStringsSep "\n" [
    (lib.strings.fileContents ./neovim/config.vim)

    ''
        lua << EOF
        ${lib.strings.fileContents ./neovim/config.lua}
        EOF
    ''
  ];

  plugins = with pkgs.vimPlugins; [
    # supertab
    sensible

    # UI
    # onedark-nvim
    # lualine-nvim
    # nvim-web-devicons
    # trouble-nvim

    # vim-fugitive
    # webapi-vim
    # vim-gist
    # vim-tmux-navigator
    # vim-carbon-now-sh

    # LSP
    # nvim-lspconfig
    # nvim-cmp
    # cmp-nvim-lsp
    # lspsaga-nvim
    # luasnip
    # lspkind-nvim

    # Navigation
    # plenary-nvim
    # telescope-nvim

    # Highlight
    # nvim-treesitter
    # nvim-treesitter-context
    # nvim-treesitter-endwise

    null-ls-nvim
    plenary-nvim
    vim-addon-nix
  ];
}
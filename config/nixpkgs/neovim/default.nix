{ pkgs }:
with pkgs;
let
  plugins = import ./plugins.nix { inherit vimUtils fetchgit; };
in
  neovim.override {
      configure = {
        packages.vim-ranger.start = with plugins; [ vim-ranger ];
        packages.minimap.start = with plugins; [ minimap ];
        packages.vim-bookmarks.start = with plugins; [ vim-bookmarks ];
        packages.vim-ripgrep.start = with plugins; [ vim-ripgrep ];
        packages.git-messenger.start = with plugins; [ git-messenger ];
        packages.mercury-vim.start = with plugins; [ mercury-vim ];
        #packages.vim-numbertoggle.start = with plugins; [ vim-numbertoggle ];
        packages.vim-tidal.start = with plugins; [ vim-tidal ];
        #packages.vim-pandoc-markdown-preview.start = with plugins; [ vim-pandoc-markdown-preview ];
        packages.rainbow_csv.start = with plugins; [ rainbow_csv ];
        #packages.vimpyter.start = with plugins; [ vimpyter ];
        #packages.LanguageClient-neovim.start = with plugins; [ LanguageClient-neovim ];
        #packages.tlaplus.start = with plugins; [ tlaplus ];
        #packages.repl-vim.start = with plugins; [ repl-vim ];
        customRC = ''
          " vim config
          let mapleader = ","
          let maplocalleader=","
          set noswapfile
          set expandtab
          set tabstop=4
          set shiftwidth=4
          set autoindent
          set nu
          hi cursorline term=NONE ctermbg=DarkBlue
          hi cursorcolumn term=NONE ctermbg=darkblue
          hi Visual cterm=None ctermbg=DarkBlue ctermfg=None guibg=DarkBlue
          hi Search cterm=None ctermfg=white ctermbg=darkgreen
          '' +
          ''
          set clipboard+=unnamedplus
          '' +
          ''
          nnoremap <C-J> <C-W><C-J>
          nnoremap <C-K> <C-W><C-K>
          nnoremap <C-L> <C-W><C-L>
          nnoremap <C-H> <C-W><C-H>
          '' +
          ''
          nnoremap <Leader>j :TidalSend<CR>
          '' +
          ''
          let g:EasyMotion_keys = get(g:, 'EasyMotion_keys', 'asdghklqwertyuiopzxcvbnmfj')
          let g:EasyMotion_smartcase = 0
          let g:EasyMotion_do_shade = 1
          let g:EasyMotion_inc_highlight = 0
          map <Leader>; <Leader><Leader>b
          map ; <Leader><Leader>w
          '' +
          ''
          map <Leader>t :Tabularize /=<CR>
          '' +
          ''
          let g:highlightedyank_highlight_duration = 700
          '' +
          ''
          nnoremap <Leader>. :CtrlPMRU<CR>
          '' +
          ''
          nnoremap <Leader>s :Rg <C-R>=expand('<cword>')<cr><cr>
          '' +
          ''
          '' +
          ''
          let g:filetype_pl="prolog"
          '' +
          ''
          let g:md_pdf_viewer="zathura"
          '' +
		  ''
		  let g:tidal_target = "terminal"
		  '' +
          ''
          nnoremap <Leader>w :Websearch <C-R>=expand('<cword>')<cr><cr>
          function! s:init_lynx()
            nnoremap <nowait><buffer> <C-F> i<PageDown><C-\><C-N>
            tnoremap <nowait><buffer> <C-F> <PageDown>

            nnoremap <nowait><buffer> <C-B> i<PageUp><C-\><C-N>
            tnoremap <nowait><buffer> <C-B> <PageUp>

            nnoremap <nowait><buffer> <C-D> i:DOWN_HALF<CR><C-\><C-N>
            tnoremap <nowait><buffer> <C-D> :DOWN_HALF<CR>

            nnoremap <nowait><buffer> <C-U> i:UP_HALF<CR><C-\><C-N>
            tnoremap <nowait><buffer> <C-U> :UP_HALF<CR>

            nnoremap <nowait><buffer> <C-N> i<Delete><C-\><C-N>
            tnoremap <nowait><buffer> <C-N> <Delete>

            nnoremap <nowait><buffer> <C-P> i<Insert><C-\><C-N>
            tnoremap <nowait><buffer> <C-P> <Insert>

            nnoremap <nowait><buffer> u     i<Left><C-\><C-N>
            nnoremap <nowait><buffer> U     i<C-U><C-\><C-N>
            nnoremap <nowait><buffer> <CR>  i<CR><C-\><C-N>
            nnoremap <nowait><buffer> gg    i:HOME<CR><C-\><C-N>
            nnoremap <nowait><buffer> G     i:END<CR><C-\><C-N>
            nnoremap <nowait><buffer> zl    i:SHIFT_LEFT<CR><C-\><C-N>
            nnoremap <nowait><buffer> zL    i:SHIFT_LEFT<CR><C-\><C-N>
            nnoremap <nowait><buffer> zr    i:SHIFT_RIGHT<CR><C-\><C-N>
            nnoremap <nowait><buffer> zR    i:SHIFT_RIGHT<CR><C-\><C-N>
            nnoremap <nowait><buffer> gh    i:HELP<CR><C-\><C-N>
            nnoremap <nowait><buffer> cow   i:LINEWRAP_TOGGLE<CR><C-\><C-N>

            tnoremap <buffer> <C-C> <C-G><C-\><C-N>
            nnoremap <buffer> <C-C> i<C-G><C-\><C-N>
          endfunction
          command! -nargs=1 Web       vnew|call termopen('lynx-wrapper -scrollbar https://duckduckgo.com/lite/?q='.shellescape(substitute(<q-args>,'#','%23','g')))|call <SID>init_lynx()
          command! -nargs=1 Websearch vnew|call termopen('lynx-wrapper -scrollbar https://duckduckgo.com/lite/?q='.shellescape(substitute(<q-args>,'#','%23','g')))|call <SID>init_lynx()
          '';
        vam.pluginDictionaries = [
          { names = [
            "easymotion"
            "ctrlp-vim"
            "nerdtree"
            "nerdcommenter"
            "vim-airline"
            "fugitive"
            "vim-css-color"
            "vim-gitgutter"
            "vim-trailing-whitespace"
            "vim-multiple-cursors"
            "vim-expand-region"
            "vim-markdown"
            "vim-nix"
            "zenburn"
            "vim-highlightedyank"
            "vim-pandoc"
            "vim-pandoc-syntax"
            "typescript-vim"
            "Tabular"
            "agda-vim"
            "vim-toml"
          ]; }
        ];
      };
    }

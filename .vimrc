" Resources:
" ThePrimagean on YouTube
" https://medium.com/swlh/ultimate-vim-typescript-setup-35b5ac5c8c4e
" https://jamesnewton.com/blog/setting-up-coc-nvim-for-ruby-development

syntax on

set background=dark " Dark theme 🤘
set t_Co=256 " Compatability for color scheme colors
set hidden " Hide buffers that haven't been modified, rather than attempt to close them
set autoread " Automatically read external file changes
set backspace=indent,eol,start  " More powerful backspacing
set noerrorbells " Do not sound annoying MacOS error bells sounds
set tabstop=2 softtabstop=2 " Tab size
set shiftwidth=2 " Shifting lines size
set expandtab " Tabs are converted to spaces
set smartindent " Vim will try to automatically indent cleverly
set number " Show line numbers
set relativenumber " Show relative line numbers
set ignorecase " Cases are ignored while searching with /
set smartcase " Searching with / will be case-insensitive until a capital letter is introduced
set noswapfile " Do not create swapfiles
set undofile " Keep a history of undos in a file
set nobackup " Create no backup files. Think this isn't critical because we set undo files
set undodir=~/.vim/undodir " The directory in which to place undo files. ⚠️  This directory will not be created by vim
set incsearch " Searching with / will continually show and highlight results
set hlsearch " Search matches are highlighted
set ttimeoutlen=0 " Key code timeouts are instant, causing ESC to be more responsive, but disallows its use in sequences
set scrolloff=5 " Amount of lines to show at the bottom/top of screen when nearing edge
set clipboard=unnamedplus " Use system clipboard for yanks
set cursorline " Highline line of cursor
set nowrap " Do not wrap overflowing lines to next line
set regexpengine=1 " Use old regex engine, which can boost performance

" Ref: http://vimdoc.sourceforge.net/htmldoc/options.html#'statusline'
" :help statusline
set statusline=
set statusline+=%#StatusLineNC#
set statusline+=%{FugitiveStatusline()}
set statusline+=%#StatusLine#
set statusline+=\ %<
set statusline+=\ %f
set statusline+=\ 
set statusline+=%#WildMenu#
set statusline+=%m
set statusline+=%#StatusLineNC#
set statusline+=\ %=
set statusline+=%{coc#status()}
set statusline+=\ %=
set statusline+=%p%%
set statusline+=\ %l:%c
set statusline+=\ 

packadd cfilter " Activate the cfilter plugin, see :h cfilter

let g:mapleader = "\<space>" " Leader key is space

" Syntax highlight from beginning of active buffer for best results
autocmd BufEnter * :syntax sync fromstart
" Clear syntax when leave buffer for performance
autocmd BufLeave * :syntax sync clear

" Switch to last used buffer using enter
nnoremap <silent><CR> :e #<CR>

" Window naviagtion
nnoremap <silent><leader>h :wincmd h<CR>
nnoremap <silent><leader>l :wincmd l<CR>
nnoremap <silent><leader>j :wincmd j<CR>
nnoremap <silent><leader>k :wincmd k<CR>

" Quickfix list naviagtion
nnoremap <silent><leader>J :cnext<CR>
nnoremap <silent><leader>K :cprev<CR>

" Search for string when selected in visual mode mapping
vnoremap <leader>f y/<c-r>0

" File explorer mapping
nnoremap <silent><leader>A :Explore<CR>

" Upload current file to GitHub Gist
command Gist execute("!gist -u '0fd53835801f8e966b64fdd0d4d9359a' %")

" Convenient edit and save (+upload) .vimrc
command Rc if bufname('%') =~# '\.vimrc' | source % | execute("Gist") |
      \ else | edit ~/.vimrc |
      \ endif

" Plugin manager
call plug#begin('~/.vim/plugged')
  " Fuzzy file finder
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

  " Vim integration with FZF
  Plug 'junegunn/fzf.vim'
    nnoremap <silent><leader><space> :Buffers!<CR>
    nnoremap <silent><leader>f :Files!<CR>
    nnoremap <silent><leader>F :Ag!<CR>
    vnoremap <leader>F y:Ag <c-r>0<CR>
    command! -bang -nargs=+ -complete=dir Rag call fzf#vim#ag_raw(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0) " Use <:Rag 'query' path> to search for ag matches in specific folder.

  " Code completion (vscode-esc) using language server
  Plug 'neoclide/coc.nvim' , { 'branch' : 'release'  }
    " Language server implementations
    let g:coc_global_extensions = [ 'coc-tsserver', 'coc-solargraph', 'coc-eslint', 'coc-graphql', 'coc-styled-components' ]
    Plug 'neoclide/coc-eslint'

  " Change surrounding delimiter with cs<d><d> (eg. cs"{ )
  Plug 'tpope/vim-surround'

  " Git client using :G <command> (eg. :G rebase -I )
  Plug 'tpope/vim-fugitive'
    nnoremap <leader>g :G<space>

  " Toggle code comments using cc (or with motion: 2cc )
  Plug 'scrooloose/nerdcommenter'
    let g:NERDCreateDefaultMappings = 1
    let g:NERDSpaceDelims = 1
    let g:NERDCommentEmptyLines = 1
    let g:NERDDefaultAlign = 'left'

  " Undo steps manager and overview
  Plug 'mbbill/undotree' " Undo steps manager.
    nnoremap <silent><leader>U :UndotreeToggle<CR>:UndotreeFocus<CR>

  " Status line
  " Plug 'vim-airline/vim-airline' " Horrible for performance
  " Plug 'itchyny/lightline.vim'

  " Automatically close blocks with end, endif, etc.
  Plug 'tpope/vim-endwise'

  " Prettier code formatting with <space>p
  Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

  " FZF for git branches
  Plug 'stsewd/fzf-checkout.vim'
    nnoremap <leader>B :GBranches!<CR>

  " Color highlights in code
  Plug 'lilydjwg/colorizer'

  " Language support
  Plug 'vim-ruby/vim-ruby' " Syntax highlighting, indentation
  Plug 'tpope/vim-rails' " Syntax highlighting, identation, commands, go to file ( gf )
  Plug 'pangloss/vim-javascript' " Syntax highlighting, indentation
  Plug 'leafgarland/typescript-vim' " Syntax highlighting, indentation
  Plug 'maxmellon/vim-jsx-pretty' " Syntax highlighting, indentation
  Plug 'jparise/vim-graphql' " Syntax highlighting, indentation
call plug#end()

" Coc - Action mappings
nmap <leader>ac  <Plug>(coc-codeaction)
xmap <leader>ac  <Plug>(coc-codeaction-selected)
nmap <leader>ar <Plug>(coc-rename)
nmap <leader>af <Plug>(coc-format)
xmap <leader>af <Plug>(coc-format-selected)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Coc - TypeScript compilation command
command! -nargs=0 Tsc :call CocAction('runCommand', 'tsserver.watchBuild') | copen

" Coc - Use K to show documentation under cursor
nnoremap <silent> K :call CocAction('doHover')<CR>

" Coc - Use TAB to trigger completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Coc - Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Hardmode >:D
for key in ['<Up>', '<Down>', '<Left>', '<Right>']
  exec 'noremap' key '<Nop>'
  exec 'inoremap' key '<Nop>'
  exec 'cnoremap' key '<Nop>'
endfor

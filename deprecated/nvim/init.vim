set nocompatible

call plug#begin('~/.vim/plugged')
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-syntastic/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'posva/vim-vue'
Plug 'reasonml-editor/vim-reason-plus'
Plug 'editorconfig/editorconfig-vim'
Plug 'munshkr/vim-tidal'
Plug 'joshdick/onedark.vim'

Plug 'dracula/vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'w0rp/ale'
Plug 'parsonsmatt/intero-neovim'
Plug 'alx741/vim-hindent'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}

Plug 'supercollider/scvim'
Plug 'tidalcycles/vim-tidal'
call plug#end()

if has("autocmd")
  augroup templates
    autocmd BufNewFile *.sh 0r ~/.config/nvim/templates/skeleton.sh
    autocmd BufNewFile *.hs 0r ~/.config/nvim/templates/skeleton.hs
  augroup END
endif

filetype plugin indent on

highlight Normal ctermbg=none
highlight NonText ctermbg=none

colorscheme dracula

set encoding=utf8
set guifont=Source\ Code\ Pro\ Medium:h11

let g:airline_powerline_fonts = 1
let g:airline_theme = "hybrid"

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

set ignorecase
set smartcase
set incsearch
set hlsearch

set relativenumber
set number
set numberwidth=2

set wrap linebreak nolist
set autoindent
set smartindent

set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

set scrolloff=7
set sidescrolloff=7

set nobackup
set noswapfile

set hidden

set visualbell

set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

set wildmenu
set wildmode=list:longest
set wildignore=*/target/*
set wildignore+=tags
set wildignore+=*/node_modules/*
set wildignore+=*/coverage/*

set autoread


let mapleader=" "

map <leader>f :FZF<cr>
map <leader>n :NERDTreeToggle<cr>

nnoremap <leader>q :q<cr>
nnoremap <leader>t :terminal<cr>

nnoremap <leader>j <C-W><C-J>
nnoremap <leader>k <C-W><C-K>
nnoremap <leader>l <C-W><C-L>
nnoremap <leader>h <C-W><C-H>

nnoremap <leader>v :vs<cr>
nnoremap <leader>s :sp<cr>

nnoremap tn :tabnew<cr>
nnoremap th :tabfirst<cr>
nnoremap tk :tabnext<cr>
nnoremap tj :tabprev<cr>
nnoremap tl :tablast<cr>
nnoremap td :tabclose<cr>
nnoremap tm :tabm<SPACE>

tnoremap <Esc> <C-\><C-n>

autocmd BufWritePre * %s/\s\+$//e

autocmd Filetype haskell setlocal ts=2 sw=2 expandtab
autocmd Filetype purescript setlocal ts=2 sw=2 expandtab
autocmd Filetype yaml setlocal ts=2 sw=2 expandtab
autocmd Filetype sh setlocal ts=2 sw=2 expandtab

let g:haskell_indent_if = 2
" Indent 'where' block two spaces under previous body
let g:haskell_indent_before_where = 2
" Allow a second case indent style (see haskell-vim README)
let g:haskell_indent_case_alternative = 1
" Only next under 'let' if there's an equals sign
let g:haskell_indent_let_no_in = 0

" ----- hindent & stylish-haskell -----

" Indenting on save is too aggressive for me
let g:hindent_on_save = 0

" Helper function, called below with mappings
function! HaskellFormat(which) abort
  if a:which ==# 'hindent' || a:which ==# 'both'
    :Hindent
  endif
  if a:which ==# 'stylish' || a:which ==# 'both'
    silent! exe 'undojoin'
    silent! exe 'keepjumps %!stylish-haskell'
  endif
endfunction

" Key bindings
augroup haskellStylish
  au!
  " Just hindent
  au FileType haskell nnoremap <leader>hi :Hindent<CR>
  " Just stylish-haskell
  au FileType haskell nnoremap <leader>hs :call HaskellFormat('stylish')<CR>
  " First hindent, then stylish-haskell
  au FileType haskell nnoremap <leader>hf :call HaskellFormat('both')<CR>
augroup END

" ----- w0rp/ale -----

let g:ale_linters = {}
" let g:ale_linters.haskell = ['stack-ghc-mod', 'hlint']
 let g:ale_linters.haskell = ['hlint']

" Prefer starting Intero manually (faster startup times)
let g:intero_start_immediately = 0
" Use ALE (works even when not using Intero)
let g:intero_use_neomake = 0

augroup interoMaps
  au!

  au FileType haskell nnoremap <silent> <leader>io :InteroOpen<CR>
  au FileType haskell nnoremap <silent> <leader>iov :InteroOpen<CR><C-W>H
  au FileType haskell nnoremap <silent> <leader>ih :InteroHide<CR>
  au FileType haskell nnoremap <silent> <leader>is :InteroStart<CR>
  au FileType haskell nnoremap <silent> <leader>ik :InteroKill<CR>

  au FileType haskell nnoremap <silent> <leader>wr :w \| :InteroReload<CR>
  au FileType haskell nnoremap <silent> <leader>il :InteroLoadCurrentModule<CR>
  au FileType haskell nnoremap <silent> <leader>if :InteroLoadCurrentFile<CR>

  au FileType haskell map <leader>t <Plug>InteroGenericType
  au FileType haskell map <leader>T <Plug>InteroType
  au FileType haskell nnoremap <silent> <leader>it :InteroTypeInsert<CR>

  au FileType haskell nnoremap <silent> <leader>jd :InteroGoToDef<CR>
  au FileType haskell nnoremap <silent> <leader>iu :InteroUses<CR>
  au FileType haskell nnoremap <leader>ist :InteroSetTargets<SPACE>
augroup END

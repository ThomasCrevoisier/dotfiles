call plug#begin()

Plug 'arcticicestudio/nord-vim'
Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-fugitive'

call plug#end()

if (has("termguicolors"))
  set termguicolors
endif

colorscheme nord

filetype plugin indent on

highlight Normal ctermbg=none
highlight NonText ctermbg=none

set encoding=utf8

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

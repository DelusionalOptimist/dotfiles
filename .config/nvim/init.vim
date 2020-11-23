call plug#begin('~/.vim/plugged')

Plug 'mhinz/vim-grepper'
Plug 'mhinz/vim-startify'
Plug 'lifepillar/vim-mucomplete'
Plug 'tpope/vim-unimpaired'
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'haishanh/night-owl.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mhinz/vim-crates'
call plug#end()

set nocompatible

" --General
set backspace=indent,eol,start
set ruler
set number
set relativenumber
set autoread
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set list
set listchars=tab:>-
set showcmd
set incsearch
set hlsearch
set mouse=a
set clipboard=unnamedplus
set scrolloff=10
set sidescrolloff=15
set sidescroll=1

syntax on

let mapleader="\<space>"
nmap <leader>gg :Grepper<CR>
noremap <Up> <nop>
noremap <Left> <nop>
noremap <Down> <nop>
noremap <Right> <nop>
nnoremap <leader>ev :vsplit ~/.config/nvim/init.vim<cr>
nnoremap <leader>tv :tab new ~/.config/nvim/init.vim<cr>
nnoremap <leader>sv :source ~/.config/nvim/init.vim<cr>
nnoremap <leader><space> :silent execute "nohlsearch"<cr>
nnoremap <leader>ts :%s/\s\+$//e<cr>
map <C-p> :Files<cr>
nmap <leader>w :update<cr>

if exists('+termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
colorscheme night-owl


set completeopt+=menuone
set completeopt+=noselect
let g:mucomplete#enable_auto_at_startup = 1

if !(&filetype == "txt")
  highlight WhiteSpaces ctermbg=green guibg=#55aa55
  match WhiteSpaces /\s\+$/
endif


call plug#begin('~/.vim/plugged')

Plug 'mhinz/vim-grepper'
Plug 'mhinz/vim-grepper'
Plug 'mhinz/vim-startify'
Plug 'lifepillar/vim-mucomplete'
Plug 'tpope/vim-unimpaired'
Plug 'itchyny/lightline.vim'
Plug 'norcalli/typeracer.nvim'
Plug '~/Work/nvim-scratchpad'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround',
Plug 'vim-conf-live/pres.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'haishanh/night-owl.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" 

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

syntax on

nmap <leader>gg :Grepper<CR>
inoremap jk <esc>
noremap <Up> <nop>
noremap <Left> <nop>
noremap <Down> <nop>
noremap <Right> <nop>
inoremap <esc> <nop>
nnoremap <leader>ev :vsplit ~/.config/nvim/init.vim<cr>
nnoremap <leader>tv :tab new ~/.config/nvim/init.vim<cr>
nnoremap <leader>sv :source ~/.config/nvim/init.vim<cr>
nnoremap <leader><space> :silent execute "nohlsearch"<cr>
nnoremap ts :%s/\s\+$//e<cr>

if exists('+termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
colorscheme night-owl 


set completeopt+=menuone
set completeopt+=noselect
set shortmess+=c   " Shut off completion messages
let g:mucomplete#enable_auto_at_startup = 1

if !(&filetype == "txt")
  highlight WhiteSpaces ctermbg=green guibg=#55aa55
  match WhiteSpaces /\s\+$/
endif

augroup mygroup
  autocmd!
  autocmd FileType c,cpp iabbrev <buffer> iff if () {<cr>}jkkf(a
" autocmd for removing trailing whitespaces
  autocmd FileType c,cpp autocmd BufWritePre <buffer> :%s/\s\+$//e
" autocmd for comments
  autocmd FileType c,cpp nnoremap <buffer> <leader>c I//<esc>
  autocmd FileType vim nnoremap <buffer> <leader>c I"<space><esc>
" don't like seeing numbers in a markdown file
  autocmd BufRead,BufNewFile diary.wiki VimwikiDiaryGenerateLinks
augroup end

" Plugins
call plug#begin('~/.vim/plugged')

" god plugins
Plug 'tpope/vim-unimpaired'
Plug 'junegunn/fzf.vim'

" session restore
Plug 'tpope/vim-obsession'

" for git
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'

" for using tab in autocompletion suggestions
Plug 'lifepillar/vim-mucomplete'
" autocompletion engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" themes
Plug 'dracula/vim',{'as':'dracula'}
Plug 'morhetz/gruvbox'
Plug 'haishanh/night-owl.vim'

" file/language specific
Plug 'mhinz/vim-crates'
Plug 'fatih/vim-go'

" fancy stuff
Plug 'mhinz/vim-startify'
Plug 'itchyny/lightline.vim'

" Plugins whose importance I have not realized yet
Plug 'mhinz/vim-grepper'

call plug#end()

" Go syntax highlighting
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1
let g:go_doc_keywordprg_enabled = 0


" --General
set nocompatible
set backspace=indent,eol,start
set ruler
set number
set relativenumber
set autoread
set smarttab
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
set hidden
set termguicolors
set cursorline

syntax on

" leader key mappings
let mapleader="\<space>"
nmap <leader>gg :Grepper<CR>
nnoremap <leader>ev :vsplit ~/.config/nvim/init.vim<cr>
nnoremap <leader>sv :source ~/.config/nvim/init.vim<cr>
nnoremap <leader><space> :silent execute "nohlsearch"<cr>
nnoremap <leader>ts :%s/\s\+$//e<cr>
nnoremap <leader>w :update<cr>
nnoremap <leader>q :q<cr>

nnoremap <leader>o :Obsess<cr>
nnoremap <leader>o! :Obsess!<cr>

" coc specific configuration
nmap <silent> gd :sp<CR><Plug>(coc-definition)
nmap <silent> gy :sp<CR><Plug>(coc-type-definition)
nmap <silent> gi :sp<CR><Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

noremap <Up> <nop>
noremap <Left> <nop>
noremap <Down> <nop>
noremap <Right> <nop>
inoremap jk <esc>

map <C-p> :Files<cr>
map <C-m> :Marks<cr>

colorscheme gruvbox
set background=light

set completeopt+=menuone
set completeopt+=noselect
let g:mucomplete#enable_auto_at_startup = 1

if !(&filetype == "txt")
	highlight WhiteSpaces ctermbg=green guibg=#55aa55
	match WhiteSpaces /\s\+$/
endif

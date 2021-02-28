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

" Rich syntax-highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" autocompletion engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'MattesGroeger/vim-bookmarks'

" themes
Plug 'dracula/vim',{'as':'dracula'}
Plug 'morhetz/gruvbox'
Plug 'haishanh/night-owl.vim'

" file/language specific
Plug 'mhinz/vim-crates'

" fancy stuff
Plug 'mhinz/vim-startify'
Plug 'itchyny/lightline.vim'

" I don't use this much
Plug 'preservim/tagbar'

" Plugins whose importance I have not realized yet
Plug 'mhinz/vim-grepper'

call plug#end()

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
set listchars=tab:\|\ 
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
set shortmess=c
set foldmethod=expr
set completeopt+=menuone,noselect

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
nnoremap <leader>Q :q!<cr>

inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
"TODO: configure these better
"inoremap [ []<left>
"inoremap { {}<left>
"inoremap {<CR> {<CR>}<ESC>0
"inoremap {;<CR> {<CR>};<ESC>0

" general keymaps
noremap <Up> <nop>
noremap <Left> <nop>
noremap <Down> <nop>
noremap <Right> <nop>
inoremap jk <esc>
nmap <silent> <c-k> :wincmd k <cr>
nmap <silent> <c-j> :wincmd j <cr>
nmap <silent> <c-h> :wincmd h <cr>
nmap <silent> <c-l> :wincmd l <cr>

"keymaps for plugins
nnoremap <leader>o :Obsess<cr>
nnoremap <leader>o! :Obsess!<cr>

map <C-p> :Files<cr>
map <C-m> :Marks<cr>
map <leader>bt :BTags<cr>
map <leader>t :Tags<cr>

" treesitter config
lua <<EOF
require'nvim-treesitter.configs'.setup {
	ensure_installed = "maintained",
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
	incremental_selection = {
		enable = true,
	}
}
EOF

" gotags config for tagbar
let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }

let g:netrw_liststyle = 3
nnoremap <Leader>T :TagbarToggle<CR><C-W>l

" vim-bookmark config
let g:bookmark_auto_close = 1
let g:bookmark_location_list = 1

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

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" chained fallback completion
"let g:mucomplete#enable_auto_at_startup = 1

"current theme
colorscheme gruvbox
"set bg=dark

" highlight whitespaces
if !(&filetype == "txt")
	highlight WhiteSpaces ctermbg=green guibg=#55aa55
	match WhiteSpaces /\s\+$/
endif

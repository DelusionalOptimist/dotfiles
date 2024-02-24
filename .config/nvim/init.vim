" Plugins
call plug#begin('~/.vim/plugged')

" god plugins
Plug 'tpope/vim-unimpaired'
Plug 'junegunn/fzf.vim'

" for git
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'

" Rich syntax-highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" autocompletion engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Make neovim a markdown editor
Plug 'ellisonleao/glow.nvim', {'branch': 'main'}

Plug 'MattesGroeger/vim-bookmarks'

" themes
"Plug 'dracula/vim',{'as':'dracula'}
Plug 'morhetz/gruvbox'
"Plug 'haishanh/night-owl.vim'
Plug 'folke/tokyonight.nvim'

" fancy stuff
Plug 'mhinz/vim-startify'
Plug 'itchyny/lightline.vim'

Plug 'rexagod/samwise.nvim'

" I don't use this much
Plug 'preservim/tagbar'

" Plugins whose importance I have not realized yet
Plug 'mhinz/vim-grepper'

" I'm sick of buffers eating my memory
Plug 'Asheq/close-buffers.vim'

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
set nobackup " We have vcs, we don't need backups.
set nowritebackup " We have vcs, we don't need backups.
set noswapfile " They're just annoying. Who likes them?
set ignorecase
set smartcase

syntax on
filetype plugin indent on

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

nnoremap <leader>\| :vsplit<cr>
nnoremap <leader>" :split<cr>
nnoremap <leader>i :Windows<cr>

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
nnoremap <silent> <leader>bm :Bdelete menu<CR>

map <leader>p :Files<cr>
map <leader>m :Marks<cr>
map <leader>bt :BTags<cr>
map <leader>t :Tags<cr>
map <leader>l :Lines<cr>

" treesitter config
lua <<EOF
require'nvim-treesitter.configs'.setup {
	ensure_installed = {"go", "lua", "java", "rust", "json", "c", "cpp", "bash"},
	highlight = {
		enable = true,
	},
	incremental_selection = {
		enable = true,
	}
}
EOF

" glow.nvim configuration
let g:glow_use_pager = v:true
let g:glow_style = "dark"

" gotags config for tagbar
"let g:tagbar_type_go = {
"	\ 'ctagstype' : 'go',
"	\ 'kinds'     : [
"		\ 'p:package',
"		\ 'i:imports:1',
"		\ 'c:constants',
"		\ 'v:variables',
"		\ 't:types',
"		\ 'n:interfaces',
"		\ 'w:fields',
"		\ 'e:embedded',
"		\ 'm:methods',
"		\ 'r:constructor',
"		\ 'f:functions'
"	\ ],
"	\ 'sro' : '.',
"	\ 'kind2scope' : {
"		\ 't' : 'ctype',
"		\ 'n' : 'ntype'
"	\ },
"	\ 'scope2kind' : {
"		\ 'ctype' : 't',
"		\ 'ntype' : 'n'
"	\ },
"	\ 'ctagsbin'  : 'gotags',
"	\ 'ctagsargs' : '-sort -silent'
"\ }

let g:netrw_liststyle = 3
nnoremap <Leader>T :TagbarToggle<CR><C-W>l

" vim-bookmark config
let g:bookmark_auto_close = 1
let g:bookmark_location_list = 1

"let g:samwise_echo = v:false
"let g:samwise_float = v:true
"
"nnoremap <Leader>p :SamwiseMoveBack<CR>
"nnoremap <Leader>n :SamwiseMoveFwd<CR>
"nnoremap <Leader>s :SamwiseToggleBuffer<CR>
"nnoremap <Leader>S :SamwiseToggleHighlight<CR>

"function! OpenSamwiseBlankLine()
"	let cur_line = line('.')
"	execute ':SamwiseToggleBuffer'
"	call BlankDown(cur_line)
"endfunction

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
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

"current theme
colorscheme tokyonight-storm
"set bg=dark

" highlight whitespaces
if !(&filetype == "txt")
	highlight WhiteSpaces ctermbg=green guibg=#55aa55
	match WhiteSpaces /\s\+$/
endif

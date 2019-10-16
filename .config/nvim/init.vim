set runtimepath+=/usr/local/opt/fzf

set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]

set list lcs=tab:\|-,trail:•,extends:»,precedes:«,nbsp:␣

set number " line numbers on
set scrolloff=5 "scroll offset to 5 lines
set lazyredraw " should help with performance with macros
set wildmode=list:longest " suggestions on normal with longest list
set background=dark

" download plug if not installed
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()
Plug 'editorconfig/editorconfig-vim'
Plug 'nathanaelkane/vim-indent-guides'
"Plug 'w0rp/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-surround'
Plug 'powerman/vim-plugin-AnsiEsc'

" Theme
" mac:
" Plug 'altercation/vim-colors-solarized.git'
" arch
"Plug 'dylanaraps/wal.vim'

" HTML
Plug 'mattn/emmet-vim'
Plug 'mhinz/vim-startify'

" React
"Plug 'neoclide/vim-jsx-improve'
"Plug 'HerringtonDarkholme/yats.vim'
"Plug 'peitalin/vim-jsx-typescript'
call plug#end()

"call vundle#begin()
"Plugin 'VundleVim/Vundle.vim'
"Plugin 'scrooloose/nerdtree'
"Plugin 'editorconfig/editorconfig-vim'
"Plugin 'nathanaelkane/vim-indent-guides'
"Plugin 'w0rp/ale'
"Plugin 'git://github.com/neoclide/coc.nvim.git'
"Plugin 'vimwiki/vimwiki'
"Plugin 'tpope/vim-surround'
"Plugin 'powerman/vim-plugin-AnsiEsc'
"
"" Theme
"" mac:
""Plugin 'altercation/vim-colors-solarized.git'
"" arch
""Plugin 'dylanaraps/wal.vim'
"
"
"" HTML
"Plugin 'mattn/emmet-vim'
"
"" React
"Plugin 'neoclide/vim-jsx-improve'
"Plugin 'HerringtonDarkholme/yats.vim'
"Plugin 'peitalin/vim-jsx-typescript'
"call vundle#end()
" turn filetype back on
"filetype plugin indent on
"syntax on

" omnicomplete (taken over by ale)
"set omnifunc=syntaxcomplete#Complete
" fix issue with omnicomplete adding text as you type
"set completeopt=menu,menuone,preview,noselect,noinsert

" Theme
"let g:airline_theme='solarized'
"mac
"colorscheme solarized
" linux
" colorscheme wal

set tabstop=2
set shiftwidth=2
set expandtab

"let g:airline#extensions#ale#enabled = 1
"let g:ale_completion_enabled = 1
"let g:ale_sign_column_always = 1
""let g:ale_typescript_tsserver_use_global = 1
"let g:ale_sign_error = '✕'
"let g:ale_sign_warning = '!'
"let g:ale_fixers = { 'javascript' : ['eslint'] }

" use ripgrep
if executable('rg')
  " Use rg over Grep
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
  noremap \ :Rg<SPACE>

  if !exists(':Rg')
    command -nargs=+ -complete=file -bar Rg silent! grep! <args>|cwindow|redraw!
  endif
endif

if executable('fzf')
  noremap <C-p> :FZF<ENTER>
endif

" enable matchit plugin for more awesome % command
"runtime macros/matchit.vim

" autoreload vimrc on save
augroup reload_vimrc " {
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" Press Space to turn off highlighting and clear any message already
" displayed.
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>


" custom keys/etc
let mapleader = ',' " move mapleader from \ to ,
" map c-x and x-y to cut and paste in insert mode
"let &clipboard = has('unnamedplus') ? 'unnamedplus' : 'unnamed'
vm <c-x> "+x
vm <c-c> "+y
cno <c-v> <c-r>+
" exe 'ino <script> <C-V>' paste#paste_cmd['i']
"

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" set no backup and set swapfile dir to temp
"set nobackup
"set directory=~/.vim/swap

noremap <leader>a ggVG " ,a is select all

" lvim wiki
let main_wiki = {}
let main_wiki.syntax = 'markdown'
let main_wiki.path = '~/wiki/'
let g:vimwiki_list = [main_wiki]

" use netrw like NERDTree
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 2
let g:netrw_winsize = 25

noremap <C-n> :Vexplore<Enter>

vmap <Leader>f <Plug>(coc-format-selected)
nmap <Leader>f <Plug>(coc-format-selected)

:autocmd VimResized * wincmd =

" coc maps
" " Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"
autocmd CursorHold * silent call CocActionAsync('highlight')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


"ALE error style
"highlight ALEError term=underline cterm=underline ctermbg=0

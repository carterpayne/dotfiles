" set runtime path to include vundle
set runtimepath+=~/.vim/bundle/Vundle.vim
set runtimepath+=/usr/local/opt/fzf

set laststatus=2 " Always show status line

set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]

set list lcs=tab:\|-,trail:•,extends:»,precedes:«,nbsp:␣

set number " line numbers on
set scrolloff=5 "scroll offset to 5 lines
set hlsearch " highlight search (does not hide until next search)
set incsearch " search as we type
set autoread " autoreload on change
set lazyredraw " should help with performance with macros
set wildmode=list:longest " suggestions on normal with longest list
set wildmenu " set suggestions on command with <TAB>
set background=dark

" Press Space to turn off highlighting and clear any message already
" displayed.
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" download plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()
Plug 'editorconfig/editorconfig-vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'w0rp/ale'
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

" React
Plug 'neoclide/vim-jsx-improve'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
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
let g:ale_sign_column_always = 1
"let g:ale_typescript_tsserver_use_global = 1
let g:ale_sign_error = '✕'
let g:ale_sign_warning = '!'
let g:ale_fixers = { 'javascript' : ['eslint'] }

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
runtime macros/matchit.vim

" autoreload vimrc on save
augroup reload_vimrc " {
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }


" custom keys/etc
let mapleader = ',' " move mapleader from \ to ,
" map c-x and x-y to cut and paste in insert mode
"let &clipboard = has('unnamedplus') ? 'unnamedplus' : 'unnamed'
vm <c-x> "+x
vm <c-c> "+y
cno <c-v> <c-r>+
" exe 'ino <script> <C-V>' paste#paste_cmd['i']

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" set no backup and set swapfile dir to temp
set nobackup
set directory=~/.vim/swap

noremap <leader>a ggVG " ,a is select all

augroup jenkins_file_types " {
  autocmd BufEnter Jenkinsfile set filetype=groovy
augroup END " }

set backspace=indent,eol,start

" lvim wiki
let main_wiki = {}
let main_wiki.syntax = 'markdown'
let main_wiki.path = '~/wiki/'
let g:vimwiki_list = [main_wiki]

:autocmd VimResized * wincmd =


"ALE error style
"highlight ALEError term=underline cterm=underline ctermbg=0

set nocompatible " set to be VIM, required for vundle
filetype off " required for vundle to work

" set runtime path to include vundle
set runtimepath+=~/.vim/bundle/Vundle.vim
let g:airline_powerline_fonts=1 " get airline fonts working
set laststatus=2 " airline show up before splits

set list lcs=tab:\|-,trail:•,extends:»,precedes:«,nbsp:␣

set number " line numbers on
set scrolloff=5 "scroll offset to 5 lines
set hlsearch " highlight search (does not hide until next search)
set incsearch " search as we type
set autoread " autoreload on change
set lazyredraw " should help with performance with macros
set wildmode=list:longest " suggestions on normal with longest list
set wildmenu " set suggestions on command with <TAB>
set expandtab " use spaces instead of tabs
"set background=dark

" Press Space to turn off highlighting and clear any message already
" displayed.
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'kien/ctrlp.vim'
Plugin 'w0rp/ale'
Plugin 'majutsushi/tagbar'
Plugin 'vimwiki/vimwiki'
Plugin 'tpope/vim-surround'
Plugin 'powerman/vim-plugin-AnsiEsc'

" Theme
" mac:
"Plugin 'altercation/vim-colors-solarized.git'
" arch
Plugin 'dylanaraps/wal.vim'


" HTML
Plugin 'mattn/emmet-vim'

" React
Plugin 'neoclide/vim-jsx-improve'
Plugin 'HerringtonDarkholme/yats.vim'
Plugin 'peitalin/vim-jsx-typescript'
call vundle#end()

" turn filetype back on
filetype plugin indent on
syntax on

" omnicomplete (taken over by ale)
set omnifunc=syntaxcomplete#Complete
" fix issue with omnicomplete adding text as you type
set completeopt=menu,menuone,preview,noselect,noinsert

" Theme
let g:airline_theme='solarized'
"mac
" colorscheme solarized
" linux
colorscheme wal

set tabstop=2
set shiftwidth=2
set expandtab

let g:airline#extensions#ale#enabled = 1
let g:ale_completion_enabled = 1
let g:ale_sign_column_always = 1
let g:ale_typescript_tsserver_use_global = 1
let g:ale_sign_error = '✕'
let g:ale_sign_warning = '!'
let g:ale_fixers = { 'javascript' : ['eslint'] }

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag --literal --files-with-matches --nocolor --hidden --filename-pattern "" %s'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

  if !exists(':Ag')
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    nnoremap \ :Ag<SPACE>
  endif
endif

set textwidth=80
set colorcolumn=+1

" enable matchit plugin for more awesome % command
runtime macros/matchit.vim

" open NERD tree when no files specified when vim opens
augroup nerd_on_start " {
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
augroup END " }

" show hidden files
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['^\.DS_Store$']
map <C-n> :NERDTreeToggle<CR>

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
exe 'ino <script> <C-V>' paste#paste_cmd['i']

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


set nocompatible " set to be VIM, required for vundle
filetype off " required for vundle to work

" set runtime path to include vundle
set rtp+=~/.vim/bundle/Vundle.vim
let g:airline_powerline_fonts=1 " get airline fonts working
set laststatus=2 " airline show up before splits

set list lcs=tab:\|-,trail:•,extends:»,precedes:«,nbsp:␣

" Theme
let g:airline_theme='solarized'
set background=dark
colorscheme solarized

set number " line numbers on
set scrolloff=5 "scroll offset to 5 lines
set hlsearch " highlight search (does not hide until next search)
set incsearch " search as we type
set autoread " autoreload on change
set lazyredraw " should help with performance with macros
set wildmode=list:longest " suggestions on normal with longest list
set wildmenu " set suggestions on command with <TAB>
set expandtab " use spaces instead of tabs

" Press Space to turn off highlighting and clear any message already
" displayed.
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'mattn/emmet-vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'altercation/vim-colors-solarized.git'
Plugin 'vim-syntastic/syntastic'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'fatih/vim-go'
Plugin 'leafgarland/typescript-vim'
Plugin 'Valloric/YouCompleteMe'
call vundle#end()
" turn filetype back on
filetype plugin indent on
syntax on

set tabstop=4
set shiftwidth=4
set expandtab

" syntastic + airline
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" use location list for syntastic, other config
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_html_checkers=['']

let g:syntastic_rust_checkers = ['rustc']
let g:syntastic_typescript_checkers = ['tslint', 'tsc']

let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_javascript_checkers = ['jsxhint']

" enable matchit plugin for more awesome % command
runtime macros/matchit.vim

" open NERD tree when no files specified when vim opens
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

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
let mapleader = "," " move mapleader from \ to ,
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
set dir=~/.vim/swap

noremap <leader>a ggVG " ,a is select all

" ycm
nmap <F12> :YcmCompleter GoToDefinition<CR>
nmap <F9> :YcmCompleter RefactorRename 

autocmd BufEnter Jenkinsfile set filetype=groovy

set backspace=indent,eol,start


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
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-surround'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'sonph/onehalf', { 'rtp': 'vim/' }
Plug 'tpope/vim-dadbod'
Plug 'jparise/vim-graphql'

Plug 'mattn/emmet-vim'
Plug 'mhinz/vim-startify'
call plug#end()

set tabstop=2
set shiftwidth=2
set expandtab
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
set t_Co=256
colorscheme onehalfdark

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
:nnoremap <silent> <Space><Space> :nohlsearch<Bar>:echo<CR>


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

" floating fzf
if has('nvim')
  let $FZF_DEFAULT_OPTS .= ' --layout=reverse'

  function! FloatingFZF()
    let width = float2nr(&columns * 0.9)
    let height = float2nr(&lines * 0.6)
    let opts = { 'relative': 'editor',
       \ 'row': (&lines - height) / 2,
       \ 'col': (&columns - width) / 2,
       \ 'width': width,
       \ 'height': height,
       \ 'style': 'minimal'
       \}
    let buf = nvim_create_buf(v:false, v:true)
    let win = nvim_open_win(buf, v:true, opts)
    call setwinvar(win, '&winhl', 'NormalFloat:TabLine')
  endfunction

  let g:fzf_layout = { 'window': 'call FloatingFZF()' }
endif

let g:startify_change_to_dir = 0

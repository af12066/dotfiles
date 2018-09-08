set encoding=utf-8
scriptencoding utf-8
set fileformats=unix
set fileencodings=utf-8
set autoindent
set smartindent
set number
set showmatch
set shiftwidth=2
set tabstop=2
set smarttab
set textwidth=0
set expandtab
set clipboard+=unnamed
source $VIMRUNTIME/macros/matchit.vim

set nowritebackup
set nobackup
set noswapfile

set ignorecase
set smartcase
set incsearch
set wrapscan
set laststatus=2
set cursorline
set showmode
set hlsearch

set clipboard+=unnamedplus

" filetype
autocmd BufRead,BufNewFile *.scss  setlocal filetype=scss
autocmd BufRead,BufNewFile *.sass setlocal filetype=sass
autocmd BufRead,BufNewFile *.erb setlocal filetype=eruby.html
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=$HOME/.config/nvim/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state($HOME.'/.config/nvim/dein')
  call dein#begin($HOME.'/.config/nvim/dein')

  " Let dein manage dein
  " Required:
  call dein#add($HOME.'/.config/nvim/dein/repos/github.com/Shougo/dein.vim')

  call dein#add('Shougo/deoplete.nvim')
  call dein#add('zchee/deoplete-go', {'build': 'make', 'on_ft': ['go']})
  call dein#add('tpope/vim-fugitive')
  call dein#add('zebult/auto-gtags.vim')
  call dein#add('scrooloose/nerdtree')
  call dein#add('Xuyuanp/nerdtree-git-plugin')
  call dein#add('othree/yajs.vim', {'on_ft': ['javascript']})
  call dein#add('carlitux/deoplete-ternjs', {'build': 'npm install -g tern'})
  call dein#add('posva/vim-vue', {'on_ft': ['vue']})

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

" deoplete
set completeopt+=noselect
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_refresh_always = 0
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#auto_completion_start_length = 0
" ternjs
let g:deoplete#sources#ternjs#tern_bin = $HOME.'/.anyenv/envs/ndenv/shims/tern'
let g:deoplete#sources#ternjs#timeout = 1
let g:deoplete#sources#ternjs#filetypes = [
  \ 'jsx',
  \ 'vue'
  \ ]

" deoplete-go
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'

" gtags
source $HOME/.config/nvim/gtags.vim
" nerdtree
autocmd vimenter * NERDTree
let NERDTreeShowHidden = 1
let NERDTreeIgnore=['\.git$']

" vim-vue
autocmd FileType vue syntax sync fromstart

set encoding=utf-8
scriptencoding utf-8
set background=dark
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
set hlsearch
set laststatus=1
set showmode

set completeopt+=noselect
set guifont=MyricaM\ Monospace:h15
set termguicolors

if &compatible
  set nocompatible
endif
set runtimepath+=$HOME/.config/nvim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state($HOME."/.config/nvim/dein")
  call dein#begin($HOME."/.config/nvim/dein")

  call dein#add($HOME."/.config/nvim/dein/repos/github.com/Shougo/dein.vim")
  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  call dein#add('Shougo/neosnippet')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Shougo/neco-vim')
  call dein#add('Shougo/neco-syntax')
  call dein#add('fishbullet/deoplete-ruby', {'on_ft': 'ruby'})
  call dein#add('zchee/deoplete-go', {'build': 'make', 'on_ft': 'go'})
  call dein#add('fatih/vim-go', {'on_ft': 'go', 'on_cmd': 'GoInstallBinaries'})
  call dein#add('Shougo/vimproc.vim', {'build': 'make'})
  call dein#add('osyo-manga/vim-monster', {'on_ft': 'ruby'})
  call dein#add('scrooloose/nerdtree')
  call dein#add('vim-syntastic/syntastic')
  call dein#add('icymind/NeoSolarized')
  call dein#add('zchee/deoplete-jedi', {'on_ft': 'python'})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#complete_method = 'omnifunc'
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#sources#go#package_dot = 1
let g:deoplete#sources#go#gocode_binary = $GOPATH."/bin/gocode"
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']

" neosnippet
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" vim-go
let g:go_fmt_autosave = 1
let g:go_template_autocreate = 0

" vim-monster
let g:monster#completion#rcodetools#backend = "async_rct_complete"
let g:deoplete#omni#input_patterns = get(g:, 'deoplete#omni#input_patterns', {})
let g:deoplete#omni#input_patterns.javascript = ''
let g:deoplete#omni#input_patterns.ruby = ['[^. *\t]\.\w*', '[a-zA-Z_]\w*::']
let g:deoplete#omni#input_patterns.css  = '^\s\+\w\+\|\w\+[):;]\?\s\+\w*\|[@!]'
let g:deoplete#omni#input_patterns.scss = '^\s\+\w\+\|\w\+[):;]\?\s\+\w*\|[@!]'
let g:deoplete#omni#input_patterns.sass = '^\s\+\w\+\|\w\+[):;]\?\s\+\w*\|[@!]'
let g:deoplete#omni#input_patterns.md = '<[^>]*'
let g:deoplete#omni#input_patterns.html = '<[^>]*'
let g:deoplete#omni#input_patterns.go = '[a-zA-Z_]\w\.\w*'
let g:deoplete#omni#functions = get(g:, 'deoplete#omni#functions', {})
let g:deoplete#omni#functions.ruby = 'rubycomplete#Complete'
let g:deoplete#omni#functions.javascript = 'javascriptcomplete#CompleteJS'
let g:deoplete#omni#functions.html= 'htmlcomplete#CompleteTags'
let g:deoplete#omni#functions.markdown = 'htmlcomplete#CompleteTags'
let g:deoplete#omni#functions.css = 'csscomplete#CompleteCSS'

" NERDTree
autocmd vimenter * NERDTree
let NERDTreeShowHidden=1  " 隠しファイルを表示する
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif  " バッファを全て閉じたらNERDTreeも閉じる
let NERDTreeIgnore=['\.git$']  " ツリーに表示させないファイルを指定

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['pyflakes', 'pep8']
let g:syntastic_go_checkers = ['go']
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_markdown_checkers = ['textlint']
let g:syntastic_text_checkers = ['textlint']
let g:syntastic_mode_map = {'mode': 'active'}

" NeoSolarized
colorscheme NeoSolarized
let g:neosolarized_contrast = "normal"
let g:neosolarized_visibility = "normal"

filetype plugin indent on
syntax enable

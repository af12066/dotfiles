set encoding=utf-8  " デフォルトエンコーディング

set background=dark  " ダークテーマの適用
set autoindent  " インデントの自動化
set number  " 行番号の可視化
set showmatch  " 対応するカッコにハイライト表示
set shiftwidth=4  " 自動インデントの余白の数
set smarttab  " Tabキー押下でshiftwidthぶんインデントを挿入
set tabstop=4  " Tabキー押下時の空白の長さ
set textwidth=0  " 改行の自動化をしない
set colorcolumn=130  " その代わり130文字目にラインを入れる
set expandtab  " タブ文字の代わりに半角スペースを使用する
set smartindent  " 高度な自動インデント

" バックアップファイルの無効化
set nowritebackup
set nobackup
set noswapfile

set ignorecase  " 検索時の大文字・小文字を区別しない
set smartcase  " 検索文字列に大文字が含まれていたら区別
set incsearch  " インクリメンタルサーチ
set wrapscan  " 末尾まで検索したら先頭まで戻る
set laststatus=2  " ステータスラインを常に表示
set cursorline  " カーソル行のハイライト
set showmode  " 現在のモードを表示
set hlsearch  " 検索結果のハイライト表示

set clipboard+=unnamed,autoselect " OSレベルでクリップボードの共有
set guifont=MyricaM\ Monospace:h15  " GVim のフォント設定
" GVim 起動時にフルスクリーン設定
if has("gui_running")
    set fuoptions=maxvert,maxhorz
    au GUIEnter * set fullscreen
endif
set completeopt=menuone  " 補完時に表示される項目

" カッコの補完
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>

" 開き括弧+Enterで改行+インデント+カーソル位置を変更
inoremap {<Enter> {}<LEFT><CR><ESC><S-o>
inoremap [<Enter> []<LEFT><CR><ESC><S-o>
inoremap (<Enter> ()<LEFT><CR><ESC><S-o>
inoremap "<Enter> ""<LEFT><CR><ESC><S-o>
inoremap '<Enter> ''<LEFT><CR><ESC><S-o>

" FileTypeの設定
augroup fileTypeIndent
  autocmd!
  autocmd BufNewFile,BufRead .vimrc setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.py setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4
  autocmd BufNewFile,BufRead *.rb,*.erb setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.js setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.sh setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.R setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.tex,*.sty setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.json setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4
  autocmd BufNewFile,BufRead *.html,*.css,*.scss setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 softtabstop=4 shiftwidth=4
augroup END

if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.dein')
  call dein#begin('~/.dein')

  " Let dein manage dein
  " Required:
  call dein#add('~/.dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/neocomplete.vim')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('altercation/vim-colors-solarized')
  call dein#add('nathanaelkane/vim-indent-guides')
  call dein#add('tpope/vim-fugitive')
  call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
  call dein#add('osyo-manga/vim-monster')  " need to install rcodetools (via gem)
  call dein#add('fatih/vim-go') " need to setup `go get github.com/nsf/gocode`
  call dein#add('vim-syntastic/syntastic')
  call dein#add('pearofducks/ansible-vim')
  call dein#add('scrooloose/nerdtree')
  call dein#add('Xuyuanp/nerdtree-git-plugin')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('davidhalter/jedi-vim')
  call dein#add('lambdalisue/vim-pyenv', {
        \ 'depends' : ['davidhalter/jedi-vim'],
        \ 'autoload' : {
        \   'filetypes' : ['python'],
        \ }})

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

" NERDTree
autocmd vimenter * NERDTree
let NERDTreeShowHidden=1  " 隠しファイルを表示する
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif  " バッファを全て閉じたらNERDTreeも閉じる
let NERDTreeIgnore=['\.git$']  " ツリーに表示させないファイルを指定

" vim-go
let g:go_fmt_autosave = 1
let g:go_snippet_engine = "neosnippet"
let g:go_template_autocreate = 0

" Neocomplete
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
" Set async completion.
let g:monster#completion#rcodetools#backend = "async_rct_complete"
" With neocomplete.vim
let g:neocomplete#sources#omni#input_patterns = {
\   "ruby" : '[^. *\t]\.\w*\|\h\w*::',
\   "go" : '\h\w\.\w*',
\   "python" : '\h\w*\|[^. \t]\.\w*',
\}
" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=jedi#completions
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" jedi-vim
let g:jedi#show_function_definition = 0  " 補完候補表示時に詳細を表示しない

" neosnippet
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" vim-color-solarized
colorscheme solarized

" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1

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

" ステータスラインの設定
" fugitive#statusline()は vim-fugitive が必要
set statusline=%<%F\ %m%r%h%w
set statusline+=%=%l,%c\ %{fugitive#statusline()}\ \[%{&fileformat}:%{&fileencoding}\]\ %y

" Insert時にステータスラインをハイライト
let g:hi_insert = 'highlight StatusLine guifg=#ffffd7 guibg=#af8700 gui=none ctermfg=230 ctermbg=136 cterm=none'
if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif
let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction
function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction
if has('unix') && !has('gui_running')
  inoremap <silent> <ESC> <ESC>
endif

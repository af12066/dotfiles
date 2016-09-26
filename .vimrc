set encoding=utf-8  " デフォルトエンコーディング

set background=dark

set autoindent  " インデントの自動化
set number  " 行番号の可視化
set showmatch  " 対応するカッコにハイライト表示
set smarttab
set textwidth=0  " 改行の自動化をしない
set colorcolumn=80  " その代わり80文字目にラインを入れる
set expandtab  " タブ文字の代わりに半角スペースを使用する
set tabstop=4
set shiftwidth=4

" バックアップファイルの無効化
set nowritebackup
set nobackup
set noswapfile

set ignorecase  " 検索時の大文字・小文字を区別しない
set smartcase  " 検索文字列に大文字が含まれていたら区別
set incsearch  " インクリメンタルサーチ
set wrapscan
set laststatus=2  " ステータスラインの表示
set cursorline  " カーソル行のハイライト
set showmode  " 現在のモードを表示

" カッコの補完
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
vnoremap { "zdi^V{<C-R>z}<ESC>
vnoremap [ "zdi^V[<C-R>z]<ESC>
vnoremap ( "zdi^V(<C-R>z)<ESC>
vnoremap " "zdi^V"<C-R>z^V"<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>

autocmd BufWritePre * :%s/\s\+$//ge  " 保存時に行末の空白を削除
autocmd BufWritePre * :%s/\t/ /ge  " 保存時にタブ文字をスペースに変換

if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('~/.dein')

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" Add or remove your plugins here:
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('nathanaelkane/vim-indent-guides')
call dein#add('Shougo/neocomplete.vim')
call dein#add('altercation/vim-colors-solarized')
call dein#add('davidhalter/jedi-vim', {
    \   'build' : 'git submodule update --init',
    \   'on_ft' : [
    \     'python',
    \   ],
    \   'on_source' : [
    \     'vim-pyenv',
    \   ],
    \ })
call dein#add('lambdalisue/vim-pyenv', {
    \   'on_ft' : [
    \     'python',
    \   ],
    \ })
call dein#add('tpope/vim-fugitive')
call dein#add('airblade/vim-gitgutter')
call dein#add('itchyny/lightline.vim')
call dein#add('scrooloose/syntastic')
call dein#add('pmsorhaindo/syntastic-local-eslint.vim')


" You can specify revision/branch/tag.
call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable
colorscheme solarized
let g:solarized_termcolors=256

" vim-indent-guidesを自動的にオン
let g:indent_guides_enable_on_vim_startup = 1

" lightline

let g:lightline = {
    \   'colorscheme' : 'solarized',
    \   'mode_map' : {'c': 'NORMAL'},
    \   'active' : {
    \       'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'gitgutter', 'filename' ] ]
    \   },
    \   'component_function' : {
    \       'modified': 'LightLineModified',
    \       'readonly': 'LightLineReadonly',
    \       'fugitive': 'LightLineFugitive',
    \       'filename': 'LightLineFilename',
    \       'fileformat': 'LightLineFileformat',
    \       'filetype': 'LightLineFiletype',
    \       'fileencoding': 'LightLineFileencoding',
    \       'mode': 'LightLineMode'
    \   }
    \ }

function! LightLineModified()
      return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
      return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! LightLineFilename()
      return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
              \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
              \  &ft == 'unite' ? unite#get_status_string() :
              \  &ft == 'vimshell' ? vimshell#get_status_string() :
              \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
              \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
        return fugitive#head()
    else
        return ''
    endif
endfunction

function! LightLineFileformat()
      return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
      return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
      return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
      return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

" Neocomplete

imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" For conceal markers.
if has('conceal')
    set conceallevel=2 concealcursor=niv
endif

let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
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
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" 構文チェック
let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_python_checkers = ['pyflakes', 'pep8']
let g:syntastic_enable_signs = 1  " エラー行にサインを表示
let g:syntastic_always_populate_loc_list = 0  " location listを常に更新
let g:syntastic_auto_loc_list = 0  " location listを常に表示
let g:syntastic_check_on_open = 1  " ファイルを開いたときにチェックを実行
let g:syntastic_check_on_wq = 0  " wqの際にもチェック

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

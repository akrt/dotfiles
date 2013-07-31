set nocompatible
set number "行番号表示
set showmode "モード表示
set title "編集中のファイル名を表示
set ruler "ルーラーの表示
set showcmd "入力中のコマンドをステータスに表示する
set showmatch "括弧入力時の対応する括弧を表示
set laststatus=2
set expandtab
set smartindent

syntax on
colorscheme molokai
highlight CursorLine term=reverse cterm=reverse

".rhtml, .html, でタブ幅を2に変更
au BufNewFile,BufRead *.rhtml set nowrap tabstop=4 shiftwidth=4
au BufNewFile,BufRead *.rb set nowrap tabstop=4 shiftwidth=4
au BufNewFile,BufRead *.html set nowrap tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.css set nowrap tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.tpl set nowrap tabstop=4 shiftwidth=4
au BufNewFile,BufRead *.js set nowrap tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.php set nowrap tabstop=4 shiftwidth=4
set nowrap
set tabstop=4
set shiftwidth=4

" 起動時に前回編集した部分からはじめる
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

"PHP文法チェック
au FileType php setlocal makeprg=php\ -l\ %
au FileType php setlocal errorformat=%m\ in\ %f\ on\ line\ %l

"PHP文法オプション
let php_sql_query=1
let php_htmlInStrings=1
let php_noShortTags=1
let php_folding=1

"macmetaオプションを有効に
if exists('+macmeta')
          set macmeta
endif

"json整形
map <Leader>j !python -m json.tool<CR>

"コンパイラープラグインの使用
"if !exists('g:flymake_enabled')
"     let g:flymake_enabled = 1
"     autocmd BufWritePost *.rb,*.pl,*.php,*.pm silent make
"endif

" kaoriya patch
if has('gui_macvim')
"set showtabline=2     " タブを常に表示
set imdisable     " IMを無効化
set transparency=10     " 透明度を指定
set antialias
set guifont=Monaco:h14
set nobackup
"
" gt, gT コマンドでタブを切り替え
map <silent> tn :tabnext<CR>
map <silent> tp :tabprev<CR>
"
" colorscheme oceanlight
" " colorscheme macvim
" endif

" open with fullscreen
"if has("gui_running")
"set fuoptions=maxvert,maxhorz
"au GUIEnter * set fullscreen
endif



"#######################

" 検索系

"#######################
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis

set ignorecase "検索文字列が小文字の場合は大文字小文字を区別なく検索する

set smartcase "検索文字列に大文字が含まれている場合は区別して検索する

set wrapscan "検索時に最後まで行ったら最初に戻る

set noincsearch "検索文字列入力時に順次対象文字列にヒットさせない

set nohlsearch "検索結果文字列の非ハイライト表示set nocompatible

set foldmethod=syntax
let perl_fold=1
set foldlevel=100

"#################
"ctrlp.vim
"#################
set runtimepath^=~/.vim/bundle/ctrlp.vim
"#######################

" Project.vim設定

"#######################

"# 1-1
" ファイルが選択されたら、ウィンドウを閉じる
let g:proj_flags = "imstc"

" <Leader>Pで、プロジェクトをトグルで開閉する
nmap <silent> <Leader>P <Plug>ToggleProject

" <Leader>pで、デフォルトのプロジェクトを開く
:nmap <silent> <Leader>p :Project<CR>

" git add
let g:proj_run1='!git add %f'
let g:proj_runf_fold1='*!git add %f'

" git checkout--
let g:proj_run2='!git checkout -- %f'
let g:proj_runf_fold2='*!git add %f'

" git status
let g:proj_run3='!git status'

" テストーーls
let g:proj_run4='!ls'

"# 1-2
"if getcwd() != $HOME
"          if filereadable(getcwd(). '/.vimprojects')
"               Project .vimprojects
"          endif
"endif

"#################
"matchit.vim
"#################
:source $VIMRUNTIME/macros/matchit.vim
let b:match_words = "if:endif,(:),{:},[:]"
let b:match_ignorecase = 1

"#################
"rtputil.vim (pathogen.vimの改良版)
"#################

"bundleをruntimepathに追加
call rtputil#bundle()

":helptagsする
call rtputil#helptags()

" RTP object を取得
let r = rtputil#new()

"apply()を呼んだ時点で初めてruntimepathの更新
call r.reset().bundle().append('~/myruntimepath').apply()

"別の名前のものを追加
"call rtputil#append('~/myruntimepath')
"runtimepathから、パスの末尾のディレクトリ名が some-pluginであるものを削除
"call rtputil#remove('some-plugin')

"#################
"yanktmp.vim
"#################
map <silent> sy :call YanktmpYank()<CR>
map <silent> sp :call YanktmpPaste_p()<CR>
map <silent> sP :call YanktmpPaste_P()<CR>

"#################
"indent-guides.vim
"#################
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=grey ctermbg=grey
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=lightgrey ctermbg=lightgrey
let g:indent_guides_color_change_percent = 30
let g:indent_guides_guide_size = 2

"#################
"alice.vim
"#################
function s:UE()
     let l:line = getline('.')
     let l:encoded = AL_urlencode(l:line)
     call setline('.', l:encoded)
endfunction

function s:UD()
     let l:line = getline('.')
     let l:encoded = AL_urldecode(l:line)
     call setline('.', l:encoded)
endfunction
command! -nargs=0 -range UE : <line1>,<line2>call <SID>UE()
command! -nargs=0 -range UD : <line1>,<line2>call <SID>UD()

"#################
"vim-funlib.vim
"#################
function Random(a, b)
     return random#randint(a:a, a:b)
endfunction

function MD5(data)
     return hashlib#md5(a:data)
endfunction

function Sha1(data)
     return hashlib#sha1(a:data)
endfunction

function Sha256(data)
     return hashlib#sha256(a:data)
endfunction

"#################
" vim-funlib.vim
"#################
" for japanese string
let g:Align_xstrlen = 3
" remove DrChip menu
let g:DrChipTopLvlMenu = ''

"#################
" errormaker.vim
"#################
let g:errormaker_errortext    = '!!'
let g:errormaker_warningtext  = '??'
let g:errormaker_errorgroup   = 'Error'
let g:errormaker_warninggroup = 'ToDo'

"error画像用意しなきゃだ
"if has('win32') || has('win64')
"     let g:errormaker_erroricon   = expand('~/.vim/signs/err.bmp');
"     let g:errormaker_warningicon = expand('~/.vim/signs/warn.bmp');
"     else
"     let g:errormaker_erroricon   = expand('~/.vim/signs/err.png');
"     let g:errormaker_warningicon = expand('~/.vim/signs/warn.png');
"endif

"#################
" zencoding.vim
"#################
let g:user_zen_settings = {
\     'lang' : 'ja',
\     'indentation' : '\t',
\     'html' : {
\          'indentation' : '\t',
\     },
\     'css' : {
\          'filters' : 'fc',
\     },
\     'javascript' : {
\          'snippets' : {
\               'jq' : "$(function() {\n\t${cursor}${child}\n});",
\               'jq:each' : "$.each(${cursor}, function(index, item)\n\t${child}\n);",
\               'fn' : "(function() {\n\t${cursor}\n})();",
\               'tm' : "setTimeout(function() {\n\t${cursor}\n}, 100);",
\          },
\     },
\     'php' : {
\          'expands' : 'html',
\          'filters' : 'html,c',
\     },
\}

let g:use_zen_complete_tag = 1

"#################
" neocomplcache.vim
"#################
let g:neocomplcache_enable_at_startup = 1
if !exists('g:neocomplcache_keyword_patterns')
     let g:neocomplcache_keyword_patterns = {}
endif
" phpの場合はどうすんだろね
let g:neocomplcache_keyword_patterns['python'] = '\h\w*'

if !exists('g:neocomplcache_omni_patterns')
     let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

"あんまりいい色じゃなかったんだぜ
"highlight Pmenu ctermbg=8
"highlight PmenuSel ctermbg=1
"highlight PmenuSbar ctermbg=0

"can't work this version of neocomplcache だそうな
"let g:neocomplcache_enable_quick_match = 1


"うまく入れられなかったpluginたち(´・ω・｀)
"#################
"pathogen.vim
"#################
"call pathogen#runtime_append_all_bundles()

"#################
"vimfiler.vim
"#################
"let g:vimfiler_safe_mode_by_default = 0


" スニペットファイルの配置場所
"let g:NeoComplCache_SnippetsDir = '~/.vim/snippets'

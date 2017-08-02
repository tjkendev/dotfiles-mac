" .vimrc for mac
scriptencoding utf-8

" autocmdは一度だけ
augroup vimrc
  autocmd!
augroup END

""" Editor """
"set clipboard=unnamed,autoselect  " '*'とクリップボード共有
set smarttab
set tabstop=2    " タブ幅
set shiftwidth=2 " タブを挿入するときの幅
set expandtab    " タブをスペースとして扱う
set softtabstop=0 "
set shiftround   " インデントはshiftwidthの倍数
set infercase
"set virtualedit=all
set hidden
set backspace=indent,eol,start " Backspaceによる削除有効化
set autoindent  " オートインデント
"set cindent     " オートインデントより賢いインデント(C用?)
set nowrap      " 長いテキストを折り返さない
set formatoptions-=r    " 改行時コメント無効
set formatoptions-=o
set fileformats=unix,dos,mac " 改行コードの自動認識

""" Visual """
set ruler       " ルーラー表示
set nu          " 行番号
set list        " 不可視文字の可視化
set cursorline  " カーソルのある行を強調(7.4~)
"set cursorcolumn " カーソルのある列を強調
set laststatus=2 " ステータスラインを常に表示
if !has('gui_running')
  set t_Co=256
endif
set showmatch   " 対応するカッコをハイライト表示
set matchtime=3 " 対応括弧のハイライト表示を3秒に
" set title       " > Vim を使ってくれてありがとう <
set notitle     " タイトル変更しない

""" Search """
set ignorecase  " 検索時大文字小文字区別しない
set smartcase   " 大文字が含まれている場合は区別して検索
set hlsearch    " 検索結果文字列のハイライト有効
set incsearch   " インクリメントサーチ
set wrapscan    " 最後まで検索したら先頭に

""" encoding """
set encoding=utf-8
set ambw=double
set termencoding=utf-8
set fileencoding=utf-8
"set fileencodings=ucs-bom,euc-jp,cp932,iso-2022-jp
"set fileencodings+=,ucs-2le,ucs-2,utf-8

""" System """
set mouse=a     " マウス機能有効化
set backup    " バックアップ生成
set backupdir=~/.vimbackup " バックアップディレクトリ
set swapfile  " スワップファイル生成
set directory=~/.vim/swap " スワップファイルのディレクトリ
set vb t_vb=    " ビープ音Off
set shortmess& shortmess+=I     " 起動時のメッセージを消す
set noimdisable " IMを使う
set iminsert=0  " 入力モードで自動的に日本語を使わない
set imsearch=0  " 検索で自動的に日本語を使わない
set autoread    " ファイルが変更された時自動で読みなおす
set noerrorbells  " エラー時のSE無効

""" CommandLine """
set wildmenu    " コマンドラインモードでTabキーでファイル名保管を有効
set showcmd     " 入力中のコマンドをステータスに表示
set magic       " 検索時に正規表現を利用する

" ESC2回で検索ハイライト消す
nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR><Esc>

"" カーソル操作で o+(A|B|C|D) しない ""
if !has('gui_running')
  set notimeout
  set ttimeout
  set timeoutlen=100
endif

""" Detail """
" 不可視文字の設定
set listchars=tab:▸\ ,eol:\ ,trail:-,extends:»,precedes:«,nbsp:%

" 行末空白
augroup HighlightTrailingSpaces
  autocmd!
  autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
  autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END

" java highlight setting
let g:java_highlight_all=1
let g:java_highlight_debug=1
let g:java_allow_cpp_keywords=1
let g:java_space_errors=1
let g:java_highlight_functions=1

" COBOL
"let cobol_legacy_code = 1

" coffeescript
au BufRead,BufNewFile,BufReadPre *.coffee   set filetype=coffee
autocmd vimrc FileType coffee     setlocal sw=2 sts=2 ts=2 et

" Jython
autocmd BufRead,BufNewFile,BufReadPre *.jy set filetype=python

" source ~/.vimrc
ca svimrc source<Space>~/.vimrc
ca vdiffsplit vertical<Space>diffsplit

" copy-paste
vnoremap <C-y> "*y
vnoremap <C-d> "*d
nnoremap <C-y><C-y> "*yy
nnoremap <C-d><C-d> "*dd
nnoremap <C-p> "*p
nnoremap <C-P> "*P

"" -b付きでバイナリモード
"" http://d.hatena.ne.jp/rdera/20081022/1224682665
augroup BinaryXXD
  autocmd!
  autocmd BufReadPre  *.bin let &binary =1
  autocmd BufReadPost * if &binary | silent %!xxd -g 1
  autocmd BufReadPost * set ft=xxd | endif
  autocmd BufWritePre * if &binary | execute "%!xxd -r" | endif
  autocmd BufWritePost * if &binary | silent %!xxd -g 1
  autocmd BufWritePost * set nomod | endif
augroup END
"" BinaryXXDを無効にしたい場合
command InvalidBinary :autocmd! BinaryXXD

augroup cpp-path
  autocmd!
  autocmd FileType cpp setlocal path+=.,/usr/include,/usr/local/include,/usr/include/c++/4.8.1
augroup END

" pyenv
let $PATH = "~/.pyenv/shims:".$PATH

""" NeoBundle """
filetype off

if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#begin(expand('~/.vim/bundle/'))

" Installation check
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
  "finish
endif

" base
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'tools\\update-dll-mingw',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'osyo-manga/vim-anzu'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'Shougo/vimshell'
NeoBundle 'thinca/vim-quickrun'
NeoBundle "jceb/vim-hier"
NeoBundle 'scrooloose/syntastic'
NeoBundle 'vim-scripts/VimClojure'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'sudo.vim'
NeoBundle 'soramugi/auto-ctags.vim'
NeoBundle 'AnsiEsc.vim'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundleLazy 'osyo-manga/vim-marching', {
      \ 'depends' : ['Shougo/vimproc.vim', 'osyo-manga/vim-reunions'],
      \ 'autoload' : {'filetypes' : ['c', 'cpp']}
      \ }
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'honza/vim-snippets'
NeoBundleLazy 'osyo-manga/vim-stargate', {
      \ 'autoload' : {'filetypes' : 'cpp'}
      \ }
NeoBundle 'jpalardy/vim-slime'
NeoBundle 'troydm/easybuffer.vim'
NeoBundle 'osyo-manga/vim-over'
NeoBundle 'vim-scripts/nginx.vim'
NeoBundle 'rollxx/vim-antlr'
"NeoBundle 'https://bitbucket.org/kovisoft/slimv'
" git
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'
" ruby
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'bbatsov/rubocop'
NeoBundle 'basyura/unite-rails'
" c++
NeoBundleLazy 'vim-jp/cpp-vim', {
      \ 'autoload' : {'filetypes' : 'cpp'}
      \}
" javacomplete
NeoBundleLazy 'vim-scripts/javacomplete', {
      \   'build': {
      \       'cygwin': 'javac autoload/Reflection.java',
      \       'mac': 'javac autoload/Reflection.java',
      \       'unix': 'javac autoload/Reflection.java',
      \   },
      \}
" python
NeoBundleLazy "lambdalisue/vim-django-support", {
      \ "autoload": {
      \   "filetypes": ["python", "python3", "djangohtml"]
      \ }}
NeoBundleLazy "jmcantrell/vim-virtualenv", {
      \ "autoload": {
      \   "filetypes": ["python", "python3", "djangohtml"]
      \ }}
NeoBundle 'davidhalter/jedi-vim'
NeoBundleLazy "lambdalisue/vim-pyenv", {
      \ "depends": ['davidhalter/jedi-vim'],
      \ "autoload": {
      \   "filetypes": ["python", "python3", "djangohtml"]
      \ }}
"" javascript / node.js
NeoBundle 'jelera/vim-javascript-syntax'
NeoBundle 'mxw/vim-jsx'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'groenewege/vim-less'
NeoBundle 'moll/vim-node'
NeoBundle 'digitaltoad/vim-jade'
"" typescript
NeoBundleLazy 'leafgarland/typescript-vim', {
      \ 'autoload' : {
      \   'filetypes' : ['typescript'] }
      \}
NeoBundleLazy 'clausreinke/typescript-tools.vim', {
      \ 'autoload' : {
      \   'filetypes' : ['typescript'] }
      \}
"" Haskell
NeoBundle 'kana/vim-filetype-haskell'
NeoBundle 'eagletmt/ghcmod-vim'
NeoBundle 'ujihisa/neco-ghc'
NeoBundle 'ujihisa/ref-hoogle'
NeoBundle 'ujihisa/unite-haskellimport'
"" Scala
NeoBundle 'derekwyatt/vim-scala'
" html
NeoBundle 'mattn/emmet-vim'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'hail2u/vim-css3-syntax'
"NeoBundle 'AtsushiM/search-parent.vim'
"NeoBundle 'AtsushiM/sass-compile.vim'
NeoBundle 'othree/html5.vim'
NeoBundle 'lilydjwg/colorizer'
" Elixir
NeoBundle 'elixir-lang/vim-elixir'
" css
"NeoBundle 'skammer/vim-css-color'
"" gnuplot
NeoBundle 'vim-scripts/gnuplot.vim'
"" plantuml
NeoBundle 'aklt/plantuml-syntax'
"" colorscheme
NeoBundle 'nanotech/jellybeans.vim'
"NeoBundle 'vim-scripts/twilight'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'altercation/vim-colors-solarized'
" LaTeX
"NeoBundle 'git://git.code.sf.net/p/vim-latex/vim-latex'
" ASM
NeoBundle 'shiracamus/vim-syntax-x86-objdump-d'
" Web
NeoBundle 'mattn/webapi-vim'
NeoBundle 'basyura/bitly.vim'
" Twitter
NeoBundle 'basyura/twibill.vim'
NeoBundle 'basyura/TweetVim'

call neobundle#end()

filetype plugin indent on

" プラグインのチェック
NeoBundleCheck

syntax on

" git protocol
let g:neobundle_default_git_protocol='git'

"" ----- unite.vim -----
" The prefix key.
nnoremap    [unite]   <Nop>
nmap    <Leader>f [unite]

" unite.vim keymap
" https://github.com/alwei/dotfiles/blob/3760650625663f3b08f24bc75762ec843ca7e112/.vimrc
nnoremap [unite]u  :<C-u>Unite -no-split<Space>
nnoremap <silent> [unite]f :<C-u>Unite<Space>buffer<CR>
nnoremap <silent> [unite]b :<C-u>Unite<Space>bookmark<CR>
nnoremap <silent> [unite]m :<C-u>Unite<Space>file_mru<CR>
nnoremap <silent> [unite]r :<C-u>UniteWithBufferDir file<CR>
nnoremap <silent> ,vr :UniteResume<CR>

" vinarise
let g:vinarise_enable_auto_detect = 1

" unite-build map
nnoremap <silent> ,vb :Unite build<CR>
nnoremap <silent> ,vcb :Unite build:!<CR>
nnoremap <silent> ,vch :UniteBuildClearHighlight<CR>

"" ----- neocomplete -----
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_fuzzy_completion = 1
let g:neocomplete#sources#syntax#min_keyword_length = 2
let g:neocomplete#auto_completion_start_length = 2
let g:neocomplete#manual_completion_start_length = 0
let g:neocomplete#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

inoremap <expr> <C-g> neocomplete#undo_completion()
inoremap <expr> <C-l> neocomplete#complete_common_string()
" <TAB>: completion.
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

let g:neocomplete#enable_auto_select = 0
let g:neocomplete#enable_refresh_always = 0

let g:neocomplcache_enable_quick_match = 1

let g:neocomplete#enable_auto_delimiter = 1
let g:neocomplete#enable_auto_close_preview = 1
let g:neocomplete#enable_ignore_case = 1
"let g:neocomplete#enable_fuzzy_completion = 0

let g:neocomplete#auto_completion_start_length = 2
"let g:neocomplete#manual_completion_start_length = 0

let g:neocomplete#skip_auto_completion_time = ""

if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns._ = '\h\w*'
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif

if !exists('g:neocomplete#sources#dictionary#dictionaries')
  let g:neocomplete#sources#dictionary#dictionaries = {}
endif
let dict = g:neocomplete#sources#dictionary#dictionaries

let g:neocomplete#sources#buffer#disabled_pattern = '\.log\|\.log\.\|\.jax\|Log.txt'
call neocomplete#custom_source('_', 'sorters',  ['sorter_length'])
call neocomplete#custom_source('_', 'matchers', ['matcher_head'])

"let g:neocomplete#sources#include#paths = {
"      \ 'cpp' : '.,/usr/include,/usr/include/c++/4.8.1,/usr/local/include'
"      \ }

"" ----- jedi-vim -----
autocmd vimrc FileType python setlocal omnifunc=jedi#completions
let g:jedi#completions_enabled = 0 " 勝手に自動補完しない
let g:jedi#auto_vim_configuration = 0
let g:neocomplete#force_omni_input_patterns.python = '\%(\<[^. \t/]\+\>\|[^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
"let g:jedi#popup_select_first = 0
" docstringは表示しない
autocmd vimrc FileType python setlocal completeopt-=preview

"" ----- vim-marching -----
let g:marching_enable_neocomplete = 1
let g:marching_clang_command_option="-std=c++1y"
let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'

"" ----- vim-easymotion -----
" Smartcase & Smartsign
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_jp = 1
" Migemo feature
let g:EasyMotion_use_migemo = 1
" ホームポジションに近いキーを使う
let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB'
" ";" + 何かにマッピング
let g:EasyMotion_leader_key=";"
" 1 ストローク選択を優先する
let g:EasyMotion_grouping=1
" カラー設定変更
hi EasyMotionTarget ctermbg=none ctermfg=red
hi EasyMotionShade  ctermbg=none ctermfg=blue

"" ----- lightline.vim -----
set guifont=Ricty\ for\ Powerline\ 10
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \  'left': [
      \    ['mode', 'paste'],
      \    ['fugitive', 'gitgutter', 'readonly', 'filename', 'modified', 'anzu']
      \  ]
      \ },
      \ 'component': {
      \   'readonly': '%{&readonly?"x":""}',
      \ },
      \ 'component_function': {
      \   'anzu': 'anzu#search_status',
      \   'fugitive': 'MyFugitive',
      \   'gitgutter': 'MyGitGutter'
      \ },
      \ 'separator': { 'left': "\u2b80", 'right': "\u2b82" },
      \ 'subseparator': { 'left': "\u2b81", 'right': "\u2b83" }
      \ }

"" ----- vim-fugitive -----
function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      let _ = fugitive#head()
      return strlen(_) ? '⭠ '._ : ''
    endif
  catch
  endtry
  return ''
endfunction

"" ----- vim-gitgutter -----
function! MyGitGutter()
  if ! exists('*GitGutterGetHunkSummary')
        \ || ! get(g:, 'gitgutter_enabled', 0)
        \ || winwidth('.') <= 90
    return ''
  endif
  let symbols = [
        \ g:gitgutter_sign_added . ' ',
        \ g:gitgutter_sign_modified . ' ',
        \ g:gitgutter_sign_removed . ' '
        \ ]
  let hunks = GitGutterGetHunkSummary()
  let ret = []
  for i in [0, 1, 2]
    if hunks[i] > 0
      call add(ret, symbols[i] . hunks[i])
    endif
  endfor
  return join(ret, ' ')
endfunction

"" ----- vim-anzu -----
" mapping
nmap n <Plug>(anzu-n)
nmap N <Plug>(anzu-N)
nmap * <Plug>(anzu-star)
nmap # <Plug>(anzu-sharp)

" clear status
nmap <Esc><Esc> <Plug>(anzu-clear-search-status)
augroup vim-anzu
  autocmd!
  autocmd CursorHold,CursorHoldI,WinLeave,TabLeave * call anzu#clear_search_status()
augroup END

" statusline
set statusline=%{anzu#search_status()}

"" ----- neosnippet -----
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

"" ----- indentLine -----
let g:indentLine_char = '¦'
let g:indentLine_color_term = 239

"" ----- vim-quickrun -----
let g:quickrun_config = {
      \ "_" : {
      \     "runner" : "vimproc",
      \     "runner/vimproc/updatetime" : 60,
      \     "hook/time/enable" : 1,
      \     "hook/time/dest": "buffer",
      \     "outputter/error/success": "buffer",
      \     "outputter/buffer/split": ":botright 4sp",
      \     "outputter/buffer/close_on_empty": 1,
      \ },
      \ "cpp/g++" : {
      \     "cmdopt" : "-std=c++11"
      \ },
      \ "asm" : {
      \     "command" : "gcc",
      \     "exec" : [
      \       "%c -m32 %s -o q.out", "./q.out"
      \     ]
      \ },
      \ "html" : {
      \     "exec" : "open %s:p",
      \ },
      \ "tex": {
      \     "command" : "platex",
      \     "exec" : [
      \         "%c %s", "%c %s",
      \         "dvipdfmx %s:r.dvi",
      \         "open %s:r.pdf"
      \     ],
      \ },
      \ "javascript.jsx": {
      \     "command" : "node",
      \ },
      \}
" <C-c>でquickrunを強制終了
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_scessions() : "\<C-c>"
" F5 running
nnoremap <silent><F5> :QuickRun -mode n<CR>
vnoremap <silent><F5> :QuickRun -mode v<CR>
" Vim-LaTeX用にF6
autocmd vimrc FileType tex nnoremap <silent><F6> :QuickRun -mode n<CR>
autocmd vimrc FileType tex vnoremap <silent><F6> :QuickRun -mode v<CR>
" qr = QuickRun
ca qr QuickRun
" 出力結果のエスケープシーケンス変換
autocmd vimrc FileType quickrun AnsiEsc

"" quickfix
autocmd QuickFixCmdPost *grep* cwindow

"" ----- syntastic -----
" use c++11
let g:syntastic_cpp_compiler_options = '-std=c++11 -stdlib=libc++'
" ASM use -m32
let g:syntastic_asm_compiler_options = '-m32'
" use pyflakes and pep8 to check python program
" require pyflakes and pep8 (pip)
let g:syntastic_python_checkers = ['pyflakes', 'pep8']
" pep8のErrorCheck僕には厳しいので少し緩めに
let g:syntastic_python_pep8_args='--ignore=E302,E501,E225,E226,E228,E265,E702,E703'
" use eslint to check js program
" require eslint and babel-eslint (npm)
let g:syntastic_javascript_checkers = ['eslint']
" SyntasticToggleMode を F4 で切り替え
noremap <silent><F4> :SyntasticToggleMode<CR>

" ----- auto-ctags -----
" 保存時に勝手にtagsファイルを作成する
let g:auto_ctags = 1
" tagsを作成するディレクトリを指定
let g:auto_ctags_directory_list = ['.git', '.svn']
" 作成されたtagsを別途読み取る
let g:auto_ctags_filetype_mode = 1

" ----- nginx.vim -----
autocmd vimrc BufRead,BufNewFile /etc/nginx/* set ft=nginx

" ----- gnuplot.vim ----
autocmd vimrc BufRead,BufNewFile *.plt set filetype=gnuplot

"" vim-antlr
autocmd BufRead,BufNewFile *.g :set syntax=antlr3

" ----- Vim-LaTeX -----
set shellslash
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
let g:Imap_UsePlaceHolders = 1
let g:Imap_DeleteEmptyPlaceHolders = 1
let g:Imap_StickyPlaceHolders = 0
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats='dvi,pdf'
"let g:Tex_FormatDependency_pdf = 'pdf'
let g:Tex_FormatDependency_pdf = 'dvi,pdf'
"let g:Tex_FormatDependency_pdf = 'dvi,ps,pdf'
let g:Tex_FormatDependency_ps = 'dvi,ps'
let g:Tex_CompileRule_pdf = 'ptex2pdf -u -l -ot "-synctex=1 -interaction=nonstopmode -file-line-error-style" $*'
"let g:Tex_CompileRule_pdf = 'pdflatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"let g:Tex_CompileRule_pdf = 'lualatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"let g:Tex_CompileRule_pdf = 'luajitlatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"let g:Tex_CompileRule_pdf = 'xelatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"let g:Tex_CompileRule_pdf = 'ps2pdf $*.ps'
let g:Tex_CompileRule_ps = 'dvips -Ppdf -o $*.ps $*.dvi'
let g:Tex_CompileRule_dvi = 'uplatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
let g:Tex_BibtexFlavor = 'upbibtex'
let g:Tex_MakeIndexFlavor = 'mendex -U $*.idx'
let g:Tex_UseEditorSettingInDVIViewer = 1
let g:Tex_ViewRule_pdf = 'open'
"let g:Tex_ViewRule_pdf = 'evince'
"let g:Tex_ViewRule_pdf = 'okular --unique'
"let g:Tex_ViewRule_pdf = 'zathura -s -x "vim --servername synctex -n --remote-silent +\%{line} \%{input}"'
"let g:Tex_ViewRule_pdf = 'qpdfview --unique'
"let g:Tex_ViewRule_pdf = 'texworks'
"let g:Tex_ViewRule_pdf = 'mupdf'
"let g:Tex_ViewRule_pdf = 'firefox -new-window'
"let g:Tex_ViewRule_pdf = 'chromium --new-window'
let g:tex_conceal=''

"" TweetVim
" ツイート内容は改行する
autocmd FileType tweetvim :set wrap

"" ==== JavaScript ====
let g:jsx_ext_required = 0

"" ==== html5.vim ====
let g:html5_event_handler_attributes_complete = 1
let g:html5_rdfa_attributes_complete = 1
let g:html5_microdata_attributes_complete = 1
let g:html5_aria_attributes_complete = 1

" after command
set showcmd

""" colorscheme """
colorscheme jellybeans

" colorschemeからの変更
highlight Comment ctermfg=70
hi CursorLine term=none cterm=none ctermbg=236


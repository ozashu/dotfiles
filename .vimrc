" ファイル読み込み時の文字コードの設定
set encoding=utf-8
" Vim script内でマルチバイト文字を使う場合の設定
scriptencoding utf-8

" vi互換モードは切る
if &compatible
    set nocompatible
endif

"+---------------+
"| Run time path |
"+---------------+

" dein.vimに関するディレクトリ
let s:dein_dir = expand('~/.vim/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
    let s:rc_dir = expand('~/dotfiles')

if has('vim_starting')
    " 起動にかかる読み込み時のみ以下を実行
    if &runtimepath !~# '/dein.vim'
        if !isdirectory(s:dein_repo_dir)
            " dein.vimがcloneされていない場合はcloneする
            execute '!git clone https://github.com/Shougo/dein.vim ' . s:dein_repo_dir
        endif
        " runtimepathの先頭にdein.vimを追加
        execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
    endif
endif

if dein#load_state(s:dein_dir)
    " キャッシュされたdeinの状態を読み込めなかった場合だけ以下を実行
    call dein#begin(s:dein_dir)
    " 必ず読み込むプラグインのリスト
    call dein#load_toml(s:rc_dir . '/dein.toml', { 'lazy': 0 })
    " 状況に応じて読み込むプラグインのリスト
    call dein#load_toml(s:rc_dir . '/dein_lazy.toml', { 'lazy': 1 })
    call dein#end()
    " 次回起動時のために状態をキャッシュする
    call dein#save_state()
endif

if dein#check_install()
    " インストールされていないパッケージがある場合にはインストールを行う
    call dein#install()
endif

"+----------------------+
"| Vim default settings |
"+----------------------+

" シンタックスハイライトをON
syntax enable
" 行番号を表示
set number
" マッチするカッコを強調表示
set showmatch matchtime=1
" タブと行の折り返しを可視化
set list listchars=tab:>\ ,extends:<
" 常にタブをスペースに展開
set tabstop=4 " 画面上でタブ文字が占める幅
set shiftwidth=4 " smartindentで増減する幅
set expandtab " タブ入力を複数の空白入力に置き換える
set smarttab 
" 自動インデントをON
set smartindent " 改行時に前の行の構文をチェックし次の行のインデントを増減する
" 新しいウィンドウを開く際に現在のウィンドウの位置が変わらないように
set splitright
set splitbelow
" バックアップファイルを作成しない
set nobackup
" 検索でマッチしたワードをハイライト
set hlsearch
" インクリメンタルサーチを有効化
set incsearch
" 大文字を含まない文字列での検索では大文字小文字を区別しない
set ignorecase " 検索パターンに大文字小文字を区別しない
set smartcase " 検索パターンに大文字を含んでいたら大文字小文字を区別する
" 常にステータスラインを表示
set laststatus=2
" 常にコマンドを表示
set showcmd
" \+pでPasteモードと切り替え
set pastetoggle=<leader>p
" Insertモード中に<BS>で直前の文字を消せるように
set backspace=indent,eol,start
" マーカーで折り畳む
set foldmethod=marker
" 常にコマンドを表示
set showcmd
" ヤンクをクリップボードに保持
set clipboard+=unnamed
set fileencoding=utf-8 " 保存時の文字コード
set fileencodings=ucs-boms,utf-8,euc-jp,cp932 " 読み込み時の文字コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac " 改行コードの自動判別. 左側が優先される
set ambiwidth=double " □や○文字が崩れる問題を解決
set wildmenu " コマンドモードの補完
set history=5000 " 保存するコマンド履歴の数

"+--------------+
"| Key mappings |
"+--------------+

" Returnキーは常に新しい行を追加するように
noremap <CR> o<Esc>
" シェルのカーソル移動コマンドを有効化
" 折り返した行を複数行として移動
nnoremap <silent> j gj
nnoremap <silent> k gk
" ウィンドウの移動をCtrlキーと方向指定でできるように
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" Esc2回で検索のハイライトを消す
nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>
nnoremap <silent> <C-n> :NERDTreeToggle<CR>
" ツリーと編集領域を移動する
" nnoremap <C-t> <C-w>w
"+----------------+
"| Color settings |
"+----------------+

" 折り畳んだ箇所を行番号と同じ色にする
highlight Folded ctermfg=130 ctermbg=0

" enable 256 colors
set t_Co=256

"+----------------+
"| Other settings |
"+----------------+

" autocmd VimEnter * execute 'NERDTree'
" 不可視ファイルを表示する
let NERDTreeShowHidden = 1
" コーナーを + に変更
let g:table_mode_corner_corner='+'
" ヘッダーの次の区切りを = にする
let g:table_mode_header_fillchar='='
" terraform
let g:terraform_align=1
"|--------------------|
"| File type settings |
"|--------------------|


"+--------------------+
"| File type settings |
"+--------------------+

" filetypeを有効にする
filetype plugin indent on
augroup FileTypeVimrcCommands
    autocmd!
    " NeoComplcacheのオムニ補完を有効化
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    " Esc2回でUniteウィンドウを閉じる
    autocmd FileType unite nnoremap <buffer> <silent> <ESC><ESC> :q<CR>
    autocmd FileType unite inoremap <buffer> <silent> <ESC><ESC> <ESC>:q<CR>
    " Goでは行の折り返しだけを可視化
    autocmd FileType go setlocal nolist
    autocmd FileType go setlocal listchars=extends:<
    " Rubyではタブをスペース2つに展開
    autocmd FileType ruby setlocal tabstop=2 shiftwidth=2
    " SCSSではタブをスペース2つに展開
    autocmd FileType scss setlocal tabstop=2 shiftwidth=2
    " YAMLではタブをスペース2つに展開
    autocmd FileType yaml setlocal tabstop=2 shiftwidth=2
    " Gemfile, GuardfileをRubyファイルとして認識
    autocmd BufRead,BufNewFile Gemfile setlocal filetype=ruby
    autocmd BufRead,BufNewFile Guardfile setlocal filetype=ruby
    " .coffeeをCoffeeScriptとして認識
    autocmd BufRead,BufNewFile *.coffee setlocal filetype=coffee
    " CoffeeScriptではタブをスペース2つに展開
    autocmd FileType coffee setlocal tabstop=2 shiftwidth=2
    " .llをLLVM-IRファイルとして認識
    autocmd BufRead,BufNewFile *.ll setlocal filetype=llvm
    " .inをOtterファイルとして認識
    autocmd BufRead,BufNewFile *.in setlocal filetype=otter
    autocmd Syntax otter source ~/.vim/bundle/Otter.vim/syntax/otter\[1\].vim
    " TweetVim内でsを押すと新規ツイート作成
    autocmd FileType tweetvim nnoremap <buffer> <silent> s :<C-u>TweetVimSay<CR>
    " 常に文字数による自動改行は行わない
    autocmd FileType * setlocal textwidth=0
augroup END

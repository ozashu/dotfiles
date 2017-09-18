set encoding=utf-8
scriptencoding utf-8

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
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
" 自動インデントをON
set smartindent
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
set ignorecase
set smartcase
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

"+----------------+
"| Color settings |
"+----------------+

" 折り畳んだ箇所を行番号と同じ色にする
highlight Folded ctermfg=130 ctermbg=0

" enable 256 colors
set t_Co=256

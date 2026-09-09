# dotfiles

macOSとUbuntuで共通設定を利用し、OS固有の設定だけを個別に読み込みます。

## セットアップ

設定ファイルのシンボリックリンクだけを作成します。

```sh
./setup.sh
```

パッケージとNeovimプラグインもインストールする場合は次を実行します。

```sh
./setup.sh --packages
```

macOSではHomebrewがインストール済みである必要があります。`Brewfile`と
`Brewfile.macos`からNeovimを含むパッケージを導入します。Ubuntuでは
`packages/ubuntu.txt`のパッケージに加え、Neovim公式のstableバイナリを
`/opt`へインストールします。x86_64とARM64に対応しています。

Neovimの設定は`~/.config/nvim`へ、tmuxの設定は`~/.tmux.conf`へリンクされます。
初回セットアップ時に`lazy.nvim`と各プラグインが自動でインストールされます。

シェル設定は`zsh/common.zsh`、`zsh/macos.zsh`、`zsh/ubuntu.zsh`に分かれています。
端末や会社固有の設定は、Git管理外の`~/.zshrc.local`と
`~/.gitconfig.local`へ記述できます。

## Neovimのよく使う操作

`<Leader>`はSpaceキーです。

| 操作 | キー/コマンド |
|---|---|
| ファイルツリーを開閉 | `Ctrl-n` |
| 現在のファイルをツリー内で表示 | `<Leader> e` |
| ファイルを検索 | `<Leader> f f` |
| ファイル内容を全文検索 | `<Leader> f g` |
| 開いているバッファを検索 | `<Leader> f b` |
| ウィンドウ間を移動 | `Ctrl-h/j/k/l` |
| ファイルを保存 / ウィンドウを閉じる | `<Leader> w` / `<Leader> q` |
| 定義 / 参照へ移動 | `gd` / `gr` |
| シンボル名を変更 | `<Leader> r n` |
| コードアクション / フォーマット | `<Leader> c a` / `<Leader> f m` |
| 診断を表示 / 前後へ移動 | `<Leader> d` / `[d` / `]d` |
| 行コメントを切り替え | `gcc`（範囲選択時は`gc`） |
| Git操作画面 | `:Git` |

補完候補は`Ctrl-n`/`Ctrl-p`で選択し、`Enter`で確定します。Goでは`gopls`、
Rustでは`rust-analyzer`が利用可能な場合にLSPが自動起動します。

プラグイン管理には`lazy.nvim`を使用します。

| 操作 | コマンド |
|---|---|
| 管理画面を開く | `:Lazy` |
| 更新を確認 | `:Lazy check` |
| 全プラグインを更新 | `:Lazy update` |
| 不要なプラグインを削除 | `:Lazy clean` |
| Neovim/LSPの状態を確認 | `:checkhealth` / `:LspInfo` |

## tmuxのよく使う操作

プレフィックスキーはデフォルトの`Ctrl-b`ではなく`Ctrl-t`です。以下の操作は、
特記がない限り`Ctrl-t`を押して離してから次のキーを押します。

| 操作 | キー |
|---|---|
| 新しいウィンドウを作成 | `Ctrl-c` |
| 次のウィンドウへ移動 | `Ctrl-t` |
| 前後のウィンドウへ移動 | `Ctrl-h` / `Ctrl-l` |
| ペインを左右に分割 | `i` |
| ペインを上下に分割 | `v` |
| ペイン間を移動 | `h` / `j` / `k` / `l` |
| ペインをリサイズ | `H` / `J` / `K` / `L` |
| 全ペインへ同じ入力を送る / 解除 | `s` / `p` |
| コピーモードを開始 | `[` |
| 選択開始 / コピー | `v` / `y` |
| 設定を再読み込み | `r` |

tmuxセッションの基本操作は、`tmux new -s <名前>`で作成、
`Ctrl-t d`でデタッチ、`tmux ls`で一覧、`tmux attach -t <名前>`で再接続です。

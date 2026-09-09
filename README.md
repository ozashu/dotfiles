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

Neovimの設定は`~/.config/nvim`へ、tmuxの設定は`~/.tmux.conf`へ、
Herdrの設定は`~/.config/herdr`へリンクされます。初回セットアップ時に
`lazy.nvim`と各プラグインが自動でインストールされます。

HerdrはmacOSではHomebrew、Ubuntuでは公式インストーラーを使って
`~/.local/bin/herdr`へ導入します。既存のHerdrがある場合、Ubuntuのセットアップは
上書きしません。直接インストール版の更新は`herdr update`、Homebrew版は
`brew upgrade herdr`を使用してください。HerdrとCopilot CLIが利用可能な場合は、
両者のセッション連携も未導入時に自動でインストールします。

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

## Herdrのよく使う操作

Herdrはtmuxと同様にプロセスをバックグラウンドで維持しながら、AI coding agentの
状態をworkspace横断で表示できるmultiplexerです。プロジェクトのディレクトリで
`herdr`を実行すると起動し、デタッチ後にもう一度`herdr`を実行すると再接続します。

プレフィックスはtmuxと同じ`Ctrl-t`です。以下は`Ctrl-t`を押して離してから
次のキーを押します。

| 操作 | キー |
|---|---|
| 新しいタブを作成 | `Ctrl-c`（または`c`） |
| 次のタブへ移動 | `Ctrl-t` / `Ctrl-l` / `n` |
| 前のタブへ移動 | `Ctrl-h` / `p` |
| ペインを左右に分割 | `i` |
| ペインを上下に分割 | `v` |
| ペイン間を移動 | `h` / `j` / `k` / `l` |
| ペインをリサイズ | `H` / `J` / `K` / `L` |
| ペインを閉じる / ズーム | `x` / `z` |
| コピーモードを開始 | `[` |
| workspace一覧を開く | `w` |
| 新しいworkspaceを作成 | `N` |
| サイドバーを開閉 | `b` |
| 設定を再読み込み | `r` |
| デタッチ | `d`（または`q`） |
| 有効なキー一覧を表示 | `?` |

コピーモードもtmuxのvi操作に近く、`h/j/k/l`で移動、`v`で選択開始、
`y`でコピー、`q`で終了します。マウスでペイン選択、境界のドラッグ、
右クリックからの分割も可能です。tmuxの同期入力に相当する標準操作はないため、
複数agentへの作業依頼には後述のHerdr skillまたはCLIを使用します。

タブ右側には、現在時刻、アクティブなペインのGit branch、現在のKubernetes
context/namespaceを表示します。Kubernetesへ接続していない場合やGit管理外では
該当項目を省略します。サイドバーのworkspace行にもGit branchとahead/behind、
agent行にはagent名と`working` / `blocked` / `done` / `idle`の状態を表示します。

### おすすめの使い方

1. リポジトリごとにworkspaceを1つ作り、実装、テスト、ログ、agentを別ペインまたは
   タブに分けます。`Ctrl-t w`でプロジェクト間を移動すると、停止中のagentを
   探し回らずに済みます。
2. サイドバーのGit workspaceからworktreeを作成し、機能や修正ごとにagentの
   作業ディレクトリを分離します。branchの衝突や未コミット変更の混在を避けられます。
3. 長時間処理はデタッチして継続し、戻ったらagentの状態を確認します。マシン再起動後は
   レイアウトが復元され、対応agentはintegrationが記録したセッションを再開できます。
4. SSH先も扱う場合は`herdr --remote <host>`を使います。時刻、hostname、
   Kubernetes接続先はリモート側の値として表示されます。

### Agent skillとintegration

Herdr内のcoding agentがペイン作成、コマンド実行、出力確認、他agentとの協調を
安全に行えるよう、公式skillのグローバル導入を推奨します。

```sh
npx skills add herdrdev/herdr --skill herdr -g
```

skillは`HERDR_ENV=1`のときだけHerdrを操作する安全策を含みます。プロジェクト単位で
導入する場合は`-g`を外してください。GitHub Copilot CLI用の公式integrationは
`setup.sh`が自動で導入します。手動で導入または状態確認する場合は次を実行します。

```sh
herdr integration install copilot
herdr integration status
```

Claude CodeやCodexなどを使う場合は、`copilot`を`claude`または`codex`へ
置き換えます。設定変更後は`herdr server reload-config`、現在の全キー確認は
Herdr内で`Ctrl-t ?`を使用してください。

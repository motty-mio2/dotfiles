# シェル設定ファイル構成

Unix（Bash / Zsh）と Windows（PowerShell）のシェル設定ファイルの構成と役割をまとめたドキュメントです。

## 基本構造と読み込みの流れ

1. **環境変数の定義元**: [.chezmoidata/environment_variables.toml](../.chezmoidata/environment_variables.toml) に XDG ディレクトリ・アプリ設定・`PATH` を集約し、ログインプロファイルや Linux の `systemd`（`environment.d`）へ展開します。
2. **共通初期化と AI / 非対話シェルの分離**:
   - Unix は [.chezmoitemplates/shell_common.tmpl](../.chezmoitemplates/shell_common.tmpl)、PowerShell は [Microsoft.PowerShell_profile.ps1.tmpl](../dot_config/powershell/Microsoft.PowerShell_profile.ps1.tmpl) の前半で `env.sh` 読込と `mise activate` を実行します。
   - AI エージェント環境（`is_ai` / `Test-IsAi`）ではエディタやページャでハングしないようフェイルセーフ（`EDITOR=true`、`PAGER=cat` 等）を設定して早期リターンします。通常の非対話シェルも同様に早期リターンします。
3. **人間向け設定**:
   - 対話シェルでのみプロンプト（Starship / Powerlevel10k）、`zoxide`、各種エイリアス・ヘルパー関数、補完、`mise tasks` エントリポイントを読み込みます。

## 配置ディレクトリ

- **Unix 共通**: `~/.config/shell`（[dot_config/shell/](../dot_config/shell/)）
- **Bash**: `~/.bash_profile` / `~/.bashrc` / `~/.bash_logout` / `~/.config/bash/plugins`
- **Zsh**: `~/.zshenv`（`ZDOTDIR=~/.config/zsh`）配下の `.zprofile` / `.zshrc` / `.zlogout` / `plugins/`
- **Windows (PowerShell)**: `~/.config/powershell`（[dot_config/powershell/](../dot_config/powershell/)）

## ファイル一覧

| 役割 | 説明 | Unix (Bash / Zsh) | Windows (PowerShell) |
| --- | --- | --- | --- |
| 環境変数データ | XDG・アプリ設定・`PATH` の定義元 | [.chezmoidata/environment_variables.toml](../.chezmoidata/environment_variables.toml) | 同左 |
| ログインプロファイル | 環境変数・`PATH` の読み込み | [dot_profile.tmpl](../dot_profile.tmpl)（[dot_bash_profile.tmpl](../dot_bash_profile.tmpl) / [dot_zprofile.tmpl](../dot_config/zsh/dot_zprofile.tmpl) から展開） | [profile.ps1.tmpl](../dot_config/powershell/profile.ps1.tmpl) |
| systemd 環境変数 | Linux ユーザーセッション向けの環境変数 | [99-zz-env.conf.tmpl](../dot_config/environment.d/99-zz-env.conf.tmpl) | なし |
| Zsh エントリ | `ZDOTDIR` を `~/.config/zsh` に設定 | [dot_zshenv](../dot_zshenv) | なし |
| 対話シェル入口 | シェル固有設定・補完・プラグイン読込 | [dot_bashrc.tmpl](../dot_bashrc.tmpl) / [dot_zshrc.tmpl](../dot_config/zsh/dot_zshrc.tmpl) | [Microsoft.PowerShell_profile.ps1.tmpl](../dot_config/powershell/Microsoft.PowerShell_profile.ps1.tmpl) |
| ログアウト処理 | ログアウト時の後処理 | [dot_bash_logout](../dot_bash_logout) / [dot_zlogout.tmpl](../dot_config/zsh/dot_zlogout.tmpl) | なし |
| 共通初期化 | `mise activate`・AI / 非対話シェル早期リターン | [shell_common.tmpl](../.chezmoitemplates/shell_common.tmpl) | `Microsoft.PowerShell_profile.ps1.tmpl` 内に統合 |
| 人間向け共通設定 | `EDITOR`・`shell/*.sh`・Starship・`zoxide`・`mise tasks` | [shell_human.tmpl](../.chezmoitemplates/shell_human.tmpl) | `Microsoft.PowerShell_profile.ps1.tmpl` 内に統合 |
| 環境固有設定 | WSL 連携・SSH agent ソケット管理・VS Code Remote CLI | [env.sh.tmpl](../dot_config/shell/env.sh.tmpl) | なし |
| 日常エイリアス・関数 | 日常利用のエイリアスや補助関数 | [shell.sh](../dot_config/shell/shell.sh) | [shell.ps1](../dot_config/powershell/conf/shell.ps1) |
| パッケージ管理ヘルパー | 各パッケージマネージャの更新・導入関数 | [packages.sh](../dot_config/shell/packages.sh) | [packages.ps1](../dot_config/powershell/conf/packages.ps1) |
| 開発環境ヘルパー | Windows 向けの環境変数・Scoop 初期化関数 | なし | [devenv.ps1](../dot_config/powershell/conf/devenv.ps1) |
| プロンプト・補完設定 | PSReadLine・posh-git・PSFzf・Starship 設定 | `dot_zshrc.tmpl` / `shell_human.tmpl` に統合 | [prompt.ps1.tmpl](../dot_config/powershell/conf/prompt.ps1.tmpl) |
| `mise tasks` 連携 | [tasks.toml](../dot_config/mise/tasks/tasks.toml) からシェル関数を生成 | [mise_tasks.tmpl](../.chezmoitemplates/mise_tasks.tmpl) | [mise_tasks_pwsh.tmpl](../.chezmoitemplates/mise_tasks_pwsh.tmpl) |
| 補完スクリプト | CLI ツールのシェル補完定義 | [bash-completion](../dot_local/private_share/bash-completion/completions/) / [zsh site-functions](../dot_local/private_share/zsh/site-functions/) | [powershell/completion](../dot_config/powershell/completion/) |
| プラグイン定義 | `ble.sh` や Zsh プラグインの外部取得定義 | [bash plugins](../dot_config/bash/plugins/.chezmoiexternal.toml) / [zsh plugins](../dot_config/zsh/plugins/.chezmoiexternal.toml) | なし |

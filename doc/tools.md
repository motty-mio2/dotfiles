# パッケージマネージャ運用方針

各 OS でのパッケージマネージャの使い分けと、chezmoi による一元管理の構成をまとめたドキュメントです。

## 一元管理と優先順位の仕組み

- **定義元（Single Source of Truth）**: パッケージ一覧は [.chezmoidata/dependencies.toml](../.chezmoidata/dependencies.toml) に集約し、各パッケージマネージャ向けの設定ファイル（Nix Flake / Scoop JSON / WinGet DSC / `mise` 設定 / `packages.sh` 等）を chezmoi テンプレートで生成しています。
- **プライマリ選択**: 初回セットアップ時に [.chezmoi.toml.tmpl](../.chezmoi.toml.tmpl) でプライマリの `package_manager` を選択します。
  - Windows: `scoop`（既定）または `mise`
  - Linux / macOS: `nix`（既定）または `mise`
- **`mise` によるフォールバック**: [dot_config/mise/config.toml.tmpl](../dot_config/mise/config.toml.tmpl) では、プライマリに `nix` や `scoop` を選んだ場合でも、**プライマリ側に定義が無い CLI / 開発ツールを自動で `mise` から導入**します。あわせて `npm:` / `pipx:` ツールや一部単体 GitHub バイナリも `mise` が管理します。

## パッケージマネージャ対応表

| ツール | Windows | Linux | macOS | システム系 | デスクトップ GUI | 主な用途・設定ファイル |
| --- | :---: | :---: | :---: | :---: | :---: | --- |
| mise | o | o | o | x | x | 共通ランタイム・未対応ツールのフォールバック・`npm:` / `pipx:`（[config.toml.tmpl](../dot_config/mise/config.toml.tmpl)） |
| nix | x | o | o | o | o | Linux / macOS のメイン CLI・開発ツール・macOS 構成（[nix/](../dot_local/private_share/nix/)） |
| Homebrew / mas | x | x | △ | o | o | macOS の GUI アプリ等（`nix-darwin` 経由で宣言管理） |
| apt / pacman | x | o | x | o | o | Linux の基盤パッケージ・Hyprland 等（[packages.sh](../dot_config/shell/packages.sh)） |
| AUR (`yay` / `paru`) | x | o | x | o | o | Arch Linux 向け追加パッケージ（[packages.sh](../dot_config/shell/packages.sh)） |
| flatpak / snap | x | o | x | x | o | Linux のデスクトップアプリ（[dependencies.toml](../.chezmoidata/dependencies.toml)） |
| scoop | o | x | x | x | o | Windows の CLI・開発ツール・一部 GUI（[scoop/](../dot_config/scoop/)） |
| winget (DSC) | o | x | x | o | o | Windows の GUI アプリ・レジストリ設定（[winget/](../dot_config/winget/)） |

### 言語・エコシステム固有のツール管理

[.chezmoidata/dependencies.toml](../.chezmoidata/dependencies.toml) では上記に加えて以下も管理しています。

- **`npm` / `pip`**: [dot_config/mise/config.toml.tmpl](../dot_config/mise/config.toml.tmpl) で `mise`（`npm:` / `pipx:`）から導入（Python ツールは `packages.sh` / `packages.ps1` の `uv tool` 補助関数にも対応）
- **`rustup`**: コンポーネント一覧（`clippy`, `rust-analyzer` 等）を `install-rust-tools` / `Install-rust-Tools` から導入
- **`gh_extension`**: GitHub CLI 拡張を `install-gh-extension` / `Install-gh-extension` から導入

## OS ごとの運用方針

### 共通

- どの環境でも `mise` を補助（またはプライマリ）として併用し、プライマリ側で未対応のツールや Node / Python 系 CLI を統一管理します。

### Windows

- CLI・開発ツールは **`scoop`**（または `mise`）、GUI アプリや OS 設定は **`winget`（DSC）** をメインにします。
  - Scoop マニフェスト: [cli.json.tmpl](../dot_config/scoop/cli.json.tmpl) / [dev.json.tmpl](../dot_config/scoop/dev.json.tmpl) / [gui.json.tmpl](../dot_config/scoop/gui.json.tmpl)
  - WinGet DSC: [packages.dsc.yaml.tmpl](../dot_config/winget/packages.dsc.yaml.tmpl) / [registry.dsc.yaml.tmpl](../dot_config/winget/registry.dsc.yaml.tmpl)

### macOS

- **`nix`**（`nix-darwin`）をメインにします。
- GUI アプリや Mac App Store 製アプリは [applications.nix](../dot_local/private_share/nix/darwin/applications.nix) から Homebrew / `mas` を宣言的に管理します。

### Linux

- **`nix`** をメインにし、Flake（[cli](../dot_local/private_share/nix/cli/) / [dev](../dot_local/private_share/nix/dev/) / [hyprland](../dot_local/private_share/nix/hyprland/)）で `nix profile` 管理します。
- root 権限が使えない環境や Nix を入れない環境では、プライマリに **`mise`** を選択します。
- OS 基盤や Hyprland・デスクトップ GUI アプリはディストリビューションに応じて `apt` / `pacman` / `AUR` / `flatpak` を併用します。

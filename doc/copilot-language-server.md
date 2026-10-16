# GitHub Copilot Language Server と mise / Neovim の連携に関する調査記録

## 概要
`@github/copilot-language-server` を mise の npm バックエンド経由でインストールした際に実行ファイル（shim）が生成されない問題、および Neovim 0.12+ の組み込み LSP / インライン補完機能（`vim.lsp.inline_completion`）を用いた設定・運用方法についての調査まとめ。

---

## 1. mise で executable が生成されない問題

### 原因
`@github/copilot-language-server` の `package.json` 内における `bin` 定義が以下のようになっている：

```json
"bin": {
  "copilot-language-server": "../dist/language-server.js"
}
```

* 実際のファイル配置: `node_modules/@github/copilot-language-server/dist/language-server.js`
* 定義上のパス: `../dist/language-server.js`（親階層 `node_modules/@github/dist/...` を参照してしまう）

### npm と mise の挙動の差異

* **Web メタデータ (packument) と配布 tarball の乖離**:
  * Web API (`https://registry.npmjs.org/@github/copilot-language-server`) 上の JSON メタデータでは `"bin": { "copilot-language-server": "dist/language-server.js" }` となっており、`../` が見えない。
  * しかし、実際にレジストリから配布される tarball（`1.553.0.tgz` や `1.554.0.tgz`）を展開した内部の生ファイル `package/package.json` は **`"../dist/language-server.js"`** となっている。
  * これは `npm publish` 時に npm がレジストリ DB へメタデータを書き出す際、`npm-normalize-package-bin` が適用されて `../` がサニタイズされた値が保存される一方、アップロードされた tarball 内のファイルは未加工のまま残るため。

* **npm の場合（成功）**:
  npm の内部モジュール [`npm-normalize-package-bin`](https://github.com/npm/npm-normalize-package-bin) が、セキュリティ対策として `..` を含む相対パスをルート内にサニタイズ（正規化）する：
  ```javascript
  const binTarget = join('/', orig[binKey].replace(/\\/g, '/')).replace(/\\/g, '/').slice(1)
  ```
  これにより tarball 内の `../dist/language-server.js` は自動的に `dist/language-server.js` に補正され、正常に `node_modules/.bin/copilot-language-server`（および `.cmd` / `.ps1`）が生成される。
  
* **mise の場合（失敗・aube 固有の問題）**:
  mise のデフォルトの npm バックエンド（組み込みの `aube`）はこの正規化を行わず、記述通りのパスをそのまま解決しようとするため、実体ファイルが存在しないと判断して以下の警告を出力し、shim の作成をスキップする：
  ```text
  mise WARN npm:@github/copilot-language-server installed no executables, so mise created no shims for it.
  ```
  **検証実証**: mise の設定で `[settings] npm.package_manager = "npm"` に切り替えると、警告は出ず正常に `copilot-language-server.cmd` 等の shim が生成され、実行可能になることを確認済み。

### 本家 Issue / PR の状況
* `github/copilot-language-server-release`: npm 環境ではサニタイズされて問題が顕在化しないため、本バグに関する Issue/PR は未作成。
* `jdx/mise`: 同様に本パッケージに関する報告は未作成。
* 追跡用 Issue: [#108](https://github.com/motty-mio2/dotfiles/issues/108)

---

## 2. Neovim (nvim) での設定方針

`copilot.lua` や `copilot.vim` などのサードパーティプラグインに依存せず、Neovim 0.12+ の組み込み機能と `nvim-lspconfig` を利用する。

### 構成
1. **LSP サーバー起動 (`vim.lsp.config`)**:
   * `copilot-language-server` が PATH 上にあればそれを直接使用する。
   * PATH 上に見つからない場合（mise 管理下など）、`~/.local/share/mise/i/copilot-language-server-*/node_modules/@github/copilot-language-server/dist/language-server.js` を探索し、`node <path> --stdio` でフォールバック起動する。
2. **サーバーの有効化**:
   * `vim.lsp.enable("copilot")`
3. **インライン補完（Ghost Text）の有効化**:
   * `vim.lsp.inline_completion.enable(true)`
4. **補完確定キーマップ**:
   * `vim.lsp.inline_completion.get()` を呼び出して候補を採用する（例: `<C-f>`）。
5. **認証**:
   * 起動後に `:LspCopilotSignIn` を実行して GitHub 認証を完了する。

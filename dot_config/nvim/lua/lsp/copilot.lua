-- lua/lsp/copilot.lua
-- GitHub Copilot Language Server (built-in LSP + inline_completion)

-- copilot-language-server の実行コマンド設定
-- 1. PATH 上に実行可能ファイルが存在すればデフォルト設定 (copilot-language-server --stdio) を使用
-- 2. 存在しない場合 (miseのnpmバックエンド不具合等) は、miseでダウンロードされた実体のJSファイルをnodeで起動
if vim.fn.executable("copilot-language-server") == 0 then
	local mise_js = vim.fn.glob(
		"~/.local/share/mise/i/copilot-language-server-*/node_modules/@github/copilot-language-server/dist/language-server.js",
		true,
		true
	)
	if #mise_js > 0 then
		vim.lsp.config("copilot", {
			cmd = { "node", mise_js[1], "--stdio" },
		})
	end
end

-- copilot LSP サーバーを有効化
vim.lsp.enable("copilot")

-- Neovim 0.12+ のインライン補完（ゴーストテキスト）を有効化
if vim.lsp.inline_completion then
	vim.lsp.inline_completion.enable(true)

	-- インライン補完の候補確定キーマップ (<C-f> で採用)
	vim.keymap.set("i", "<C-f>", function()
		vim.lsp.inline_completion.get()
	end, { silent = true, desc = "LSP: Accept inline completion (Copilot)" })
end

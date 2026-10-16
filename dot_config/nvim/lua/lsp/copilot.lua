-- lua/lsp/copilot.lua
-- GitHub Copilot Language Server (built-in LSP + inline_completion)

-- copilot LSP サーバーを有効化 (デフォルト設定: cmd = { 'copilot-language-server', '--stdio' })
vim.lsp.enable("copilot")

-- Neovim 0.12+ のインライン補完（ゴーストテキスト）を有効化
if vim.lsp.inline_completion then
	vim.lsp.inline_completion.enable(true)

	-- インライン補完の候補確定キーマップ (<C-f> で採用)
	vim.keymap.set("i", "<C-f>", function()
		vim.lsp.inline_completion.get()
	end, { silent = true, desc = "LSP: Accept inline completion (Copilot)" })
end

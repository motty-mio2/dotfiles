-- lua/keymap.lua

-- 1. Diagnostics (診断・エラー・警告) のグローバルキーマップ
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Diagnostic: Open float" }))
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Diagnostic: Go to previous" }))
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Diagnostic: Go to next" }))
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, vim.tbl_extend("force", opts, { desc = "Diagnostic: Set loclist" }))

-- 2. LSP バッファローカルキーマップ (LspAttach autocmd: Neovim 0.10+ / 0.12+ 推奨方式)
local lsp_group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
	group = lsp_group,
	callback = function(args)
		local bufnr = args.buf
		local bufopts = { noremap = true, silent = true, buffer = bufnr }

		-- ナビゲーション (定義・宣言・実装・型定義・参照)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", bufopts, { desc = "LSP: Go to definition" }))
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", bufopts, { desc = "LSP: Go to declaration" }))
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", bufopts, { desc = "LSP: Go to implementation" }))
		vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, vim.tbl_extend("force", bufopts, { desc = "LSP: Type definition" }))
		vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", bufopts, { desc = "LSP: References" }))

		-- ドキュメント・シグネチャヘルプ
		vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", bufopts, { desc = "LSP: Hover documentation" }))
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", bufopts, { desc = "LSP: Signature help" }))

		-- リネーム & コードアクション
		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, vim.tbl_extend("force", bufopts, { desc = "LSP: Rename symbol" }))
		vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", bufopts, { desc = "LSP: Code action" }))

		-- ワークスペースフォルダ
		vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, vim.tbl_extend("force", bufopts, { desc = "LSP: Add workspace folder" }))
		vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, vim.tbl_extend("force", bufopts, { desc = "LSP: Remove workspace folder" }))
		vim.keymap.set("n", "<space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, vim.tbl_extend("force", bufopts, { desc = "LSP: List workspace folders" }))

		-- フォーマット
		vim.keymap.set("n", "<space>f", function()
			vim.lsp.buf.format({ async = true })
		end, vim.tbl_extend("force", bufopts, { desc = "LSP: Format buffer" }))
	end,
})

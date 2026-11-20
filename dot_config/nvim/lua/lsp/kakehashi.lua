-- lua/lsp/kakehashi.lua
-- Tree-sitter ベースの埋め込み言語 LSP ブリッジ (kakehashi.nvim で有効済み LSP を自動継承)

vim.lsp.config("kakehashi", {
	filetypes = { "markdown" },
	init_options = {
		languages = {
			_ = {
				autoInstall = true,
			},
		},
	},
})
vim.lsp.enable("kakehashi")

local has_kakehashi, kakehashi = pcall(require, "kakehashi")
if has_kakehashi then
	local group = vim.api.nvim_create_augroup("UserKakehashiConfig", { clear = true })
	vim.api.nvim_create_autocmd("LspAttach", {
		group = group,
		callback = function(ev)
			local client = vim.lsp.get_client_by_id(ev.data.client_id)
			if client and client.name == "kakehashi" then
				kakehashi.inherit_nvim_lsp_config(client, vim.tbl_keys(vim.lsp._enabled_configs), "keep")
			end
		end,
	})
end

local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 150,
}

local nvim_lsp = require("lspconfig")

require("lspconfig").arduino_language_server.setup({
	on_attach = on_attach,
	flags = lsp_flags,
})
require("lspconfig").bashls.setup({
	on_attach = on_attach,
	flags = lsp_flags,
})
require("lspconfig").biome.setup({
	on_attach = on_attach,
	flags = lsp_flags,
})
require("lspconfig").clangd.setup({
	on_attach = on_attach,
	flags = lsp_flags,
})
require("lspconfig").pyright.setup({
	on_attach = on_attach,
	flags = lsp_flags,
	root_dir = nvim_lsp.util.root_pattern(".git", "pyproject.toml", ".python-version"),
})
require("lspconfig").rust_analyzer.setup({
	on_attach = on_attach,
	flags = lsp_flags,
})
require("lspconfig").svls.setup({
	on_attach = on_attach,
	flags = lsp_flags,
	root_dir = nvim_lsp.util.root_pattern(".git"),
})

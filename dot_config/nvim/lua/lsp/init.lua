local has_schemastore, schemastore = pcall(require, "schemastore")

-- Builtin
vim.lsp.enable("arduino_language_server")
vim.lsp.enable("basedpyright")
vim.lsp.enable("bashls")
vim.lsp.enable("buf_ls")
vim.lsp.enable("biome")
vim.lsp.enable("clangd")
vim.lsp.enable("cmake")
require("lsp.copilot")
vim.lsp.enable("denols")
vim.lsp.enable("docker_language_server")
vim.lsp.enable("eslint")
vim.lsp.enable("gopls")
if has_schemastore then
	vim.lsp.config.jsonls = {
		settings = {
			json = {
				schemas = schemastore.json.schemas(),
				validate = { enable = true },
			},
		},
	}
end
vim.lsp.enable("jsonls")
vim.lsp.enable("just")
vim.lsp.enable("lua_ls")
vim.lsp.enable("marksman")
vim.lsp.enable("protols")
vim.lsp.enable("ruff")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("stylua")
vim.lsp.enable("svelte")
vim.lsp.enable("svls")
vim.lsp.enable("tailwindcss")
vim.lsp.enable("tflint")
vim.lsp.enable("tombi")
vim.lsp.enable("ts_ls")
vim.lsp.enable("typos_lsp")
vim.lsp.enable("veryl_ls")
vim.lsp.enable("vimls")
if has_schemastore then
	vim.lsp.config.yamlls = {
		settings = {
			yaml = {
				schemaStore = {
					enable = false,
					url = "",
				},
				schemas = schemastore.yaml.schemas(),
			},
		},
	}
end
vim.lsp.enable("yamlls")

-- Custom
vim.lsp.enable("systemd_lsp")

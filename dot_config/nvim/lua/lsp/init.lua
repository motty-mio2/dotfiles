local has_schemastore, schemastore = pcall(require, "schemastore")
local has_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local has_lsp_file_operations, lsp_file_operations = pcall(require, "lsp-file-operations")

local capabilities = vim.lsp.protocol.make_client_capabilities()
if has_cmp_nvim_lsp then
	capabilities = vim.tbl_deep_extend("force", capabilities, cmp_nvim_lsp.default_capabilities())
end
if has_lsp_file_operations then
	capabilities = vim.tbl_deep_extend("force", capabilities, lsp_file_operations.default_capabilities())
end
vim.lsp.config("*", {
	capabilities = capabilities,
})

-- Builtin
vim.lsp.enable("arduino_language_server")
vim.lsp.enable("bashls")
vim.lsp.enable("buf_ls")
vim.lsp.enable("biome")
vim.lsp.enable("clangd")
require("lsp.copilot")
vim.lsp.enable("cssls")
vim.lsp.enable("denols")
vim.lsp.enable("docker_language_server")
vim.lsp.enable("eslint")
vim.lsp.enable("gopls")
vim.lsp.enable("html")
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
require("lsp.kakehashi")
vim.lsp.enable("lua_ls")
vim.lsp.enable("marksman")
vim.lsp.enable("neocmake")
vim.lsp.enable("protols")
vim.lsp.enable("pyrefly")
vim.lsp.enable("ruff")
vim.lsp.enable("rumdl")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("stylua")
vim.lsp.enable("svelte")
vim.lsp.enable("svls")
vim.lsp.enable("systemd_lsp")
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
vim.lsp.config.ryl = {
	cmd = { "ryl", "server" },
	filetypes = { "yaml" },
	root_markers = { ".ryl.toml", ".git" },
}
vim.lsp.enable("ryl")

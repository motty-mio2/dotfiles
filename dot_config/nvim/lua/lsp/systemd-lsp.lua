---@type vim.lsp.Config
return {
	cmd = { "systemd_lsp" },
	filetype = { "systemd" },
	root_dir = vim.fn.getcwd(),
}

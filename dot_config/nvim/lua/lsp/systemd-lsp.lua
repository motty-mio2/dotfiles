---@type vim.lsp.Config
return {
  cmd = { 'systemd-lsp' },
  filetype = { 'systemd'},
  root_dir = vim.fn.getcwd(),
}


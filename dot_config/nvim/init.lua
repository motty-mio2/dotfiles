local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

plugins = require("plugins")

require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
})

vim.cmd("source ~/.config/vim/option.vim")

require("completion")
require("keymap")
require("lsp")
require("neotree")
require("treesitter")
require("clipboard")
require("everforest").load()

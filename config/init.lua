-- 2バイト文字を描画する
vim.o.ambiwidth = "double"
-- メッセージ表示欄を1行確保
vim.o.cmdheight = 1
-- emoji
vim.o.emoji = true

-- 不可視文字を表示
vim.wo.list = true
vim.wo.listchars = "tab:¦ ,trail:･"

-- 行番号を表示する
vim.o.number = true

vim.opt.fileencoding = "utf-8" -- the encoding written to a file
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.cursorline = true -- highlight the current line
vim.opt.number = true -- set numbered lines
vim.opt.mouse = "a" -- allow the mouse to be used in neovim
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

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

require("lazy").setup(plugins)

require("lsp")
require("treesitter")

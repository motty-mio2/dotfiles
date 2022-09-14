-- 2バイト文字を描画する
vim.o.ambiwidth = 'double'
-- メッセージ表示欄を1行確保
vim.o.cmdheight = 1
-- emoji
vim.o.emoji = true

-- 不可視文字を表示
vim.wo.list = true
vim.wo.listchars = 'tab:¦ ,trail:･'

-- 行番号を表示する
vim.o.number = true

-- packerの読み込み
require 'plugins'
vim.cmd [[autocmd BufWritePost plugins.lua PackerCompile]]

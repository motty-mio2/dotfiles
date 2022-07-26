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



-- " set up the dein.vim directory
dein_dir = vim.env.HOME .. '/.cache/dein'
dein_repo_dir = dein_dir .. '/repos/github.com/Shougo/dein.vim'
rc_dir = vim.env.HOME .. '/.vim'

-- " automatic installation of dein.vim
if vim.fn.isdirectory(dein_repo_dir) ~= 1 then
  os.execute('!git clone https://github.com/Shougo/dein.vim '..dein_repo_dir)
end
vim.o.runtimepath = dein_repo_dir .. ',' .. vim.o.runtimepath

if vim.call('dein#load_state', dein_dir) == 1 then
  vim.call('dein#begin', dein_dir)
--  call dein#begin(s:dein_dir)

-- " load the file which contain the plugin list
  local toml      = rc_dir .. '/dein.toml'
  local lazy_toml = rc_dir .. '/dein_lazy.toml'

  vim.call('dein#load_toml', toml, {lazy = 0})
  vim.call('dein#load_toml', lazy_toml, {lazy = 1})

  vim.call('dein#end')
  vim.call('dein#save_state')
end

-- " automatically install any plug-ins that need to be installed.
if vim.call('dein#check_install') == 1 then
  vim.call('dein#install')
end


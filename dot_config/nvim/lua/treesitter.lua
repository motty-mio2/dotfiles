-- lua/treesitter.lua

-- 1. 基本的なTreesitter設定
require("nvim-treesitter").setup({
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	},
})

-- 2. オンデマンドでパーサーをインストールするためのヘルパー関数とAutocmd

---@param lang string The language to check
---@return boolean Whether the parser is installed
local function is_parser_installed(lang)
	-- nvim_get_runtime_fileはパスのリストを返す。リストが空ならファイルは見つからない。
	local found_files = vim.api.nvim_get_runtime_file("parser/" .. lang .. ".so", false)
	return #found_files > 0
end

local parser_installer_group = vim.api.nvim_create_augroup("OnDemandParserInstaller", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = parser_installer_group,
	callback = function(ctx)
		local bufnr = ctx.buf
		-- バッファリストに載っており、かつファイル名を持つバッファのみを対象とする
		-- これにより、notifyやTelescopeなどの特殊なウィンドウを無視する
		if not vim.bo[bufnr].buflisted or vim.api.nvim_buf_get_name(bufnr) == "" then
			return
		end

		local filetype = vim.bo[bufnr].filetype
		if filetype == "" then
			return
		end

		local lang = filetype
		if not is_parser_installed(lang) then
			vim.schedule(function()
				vim.notify("Treesitter: Parser for '" .. lang .. "' not found. Installing...", vim.log.levels.INFO)
				pcall(vim.cmd, "TSInstall " .. lang)
			end)
		end
	end,
})

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
	-- ログレベルを'error'に設定し、警告メッセージを非表示にする
	log = { level = "error" },
})

vim.schedule(function()
	local ok, install_func = pcall(function()
		return require("nvim-treesitter").install
	end)
	-- if ok and type(install_func) == 'function' then
	install_func({ "bash", "regex" })
	-- else
	--     vim.notify("Treesitter: New install API not found. Falling back to :TSInstall for initial languages.", vim.log.levels.WARN)
	--     pcall(vim.cmd, "TSInstall bash")
	--     pcall(vim.cmd, "TSInstall regex")
	-- end
end)

-- 3. オンデマンドでパーサーをインストールするためのヘルパー関数とAutocmd

---@param lang string The language to check
---@return boolean Whether the parser is installed
local function is_parser_installed(lang)
	local found_files = vim.api.nvim_get_runtime_file("parser/" .. lang .. ".so", false)
	return #found_files > 0
end

local parser_installer_group = vim.api.nvim_create_augroup("OnDemandParserInstaller", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = parser_installer_group,
	callback = function(ctx)
		local filetype = ctx.match

		-- インストールを試みるべきではない、ごく一部の特殊なファイルタイプを無視する
		local ignored_filetypes = {
			"",
			"checkhealth",
			"TelescopePrompt",
			"NvimTree",
			"help",
			"man",
			"lspinfo",
			"notify",
			"noice",
			"cmp_menu",
		}
		if vim.tbl_contains(ignored_filetypes, filetype) then
			return
		end

		local lang = filetype

		-- インストール済みでなければ、インストールを実行
		if not is_parser_installed(lang) then
			vim.schedule(function()
				-- 最新のAPIを使用してインストール
				local ok, install_func = pcall(function()
					return require("nvim-treesitter").install
				end)
				if ok and type(install_func) == "function" then
					install_func({ lang })
				else
					-- フォールバック: 新しいAPIが機能しない場合
					vim.notify(
						"Treesitter: New install API not found. Falling back to :TSInstall for " .. lang,
						vim.log.levels.WARN
					)
					pcall(vim.cmd, "TSInstall " .. lang)
				end
			end)
		end
	end,
})

-- lua/treesitter.lua
-- Neovim 0.12+ & nvim-treesitter (main branch) 向け設定

local ts = require("nvim-treesitter")

-- 1. 基本セットアップ
ts.setup({
	-- install_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "site"), -- デフォルト
})

-- 除外するファイルタイプ (特殊バッファやツール用)
local ignored_filetypes = {
	"",
	"checkhealth",
	"TelescopePrompt",
	"neo-tree",
	"NvimTree",
	"help",
	"man",
	"lspinfo",
	"notify",
	"noice",
	"cmp_menu",
	"qf",
}

-- セッション内での重複チェック防止用キャッシュ
local updated_langs = {}
local installing_langs = {}

local group = vim.api.nvim_create_augroup("TreesitterAutoSetup", { clear = true })

-- 2. 開いているファイルタイプに応じた自動インストール & 自動更新
vim.api.nvim_create_autocmd("FileType", {
	group = group,
	callback = function(args)
		local ft = args.match
		if vim.tbl_contains(ignored_filetypes, ft) or vim.bo[args.buf].buftype ~= "" then
			return
		end

		-- ファイルタイプに対応する Treesitter 言語名を取得
		local lang = vim.treesitter.language.get_lang(ft) or ft

		-- パーサーが利用可能（インストール済み）か確認 (Neovim 0.10+ / 0.12+ API)
		local has_parser = vim.treesitter.language.add(lang)

		if has_parser then
			-- Treesitter ハイライトを有効化
			pcall(vim.treesitter.start, args.buf, lang)

			-- インデントクエリが存在すれば Treesitter インデントを適用
			if vim.treesitter.query.get(lang, "indents") then
				vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end

			-- 開いた言語のパーサーを自動更新（1セッションにつき1回バックグラウンドでチェック）
			if not updated_langs[lang] then
				updated_langs[lang] = true
				vim.schedule(function()
					local available = ts.get_available()
					if vim.list_contains(available, lang) then
						ts.update({ lang }, nil, function(success)
							if success then
								-- 更新完了時、バッファがアクティブであれば再アタッチ
								vim.schedule(function()
									if vim.api.nvim_buf_is_valid(args.buf) and vim.bo[args.buf].filetype == ft then
										pcall(vim.treesitter.start, args.buf, lang)
									end
								end)
							end
						end)
					end
				end)
			end
		else
			-- パーサーが未インストールの場合はサポート対象か確認して自動インストール
			local available = ts.get_available()
			if vim.list_contains(available, lang) and not installing_langs[lang] then
				installing_langs[lang] = true
				vim.notify(string.format("Treesitter: '%s' のパーサーを自動インストール中...", lang), vim.log.levels.INFO)

				ts.install({ lang }, nil, function(success)
					installing_langs[lang] = nil
					if success then
						updated_langs[lang] = true
						vim.schedule(function()
							vim.notify(
								string.format("Treesitter: '%s' のインストールが完了しました", lang),
								vim.log.levels.INFO
							)
							-- インストール完了後、バッファが生きていれば即座にハイライト & インデントを有効化
							if vim.api.nvim_buf_is_valid(args.buf) and vim.bo[args.buf].filetype == ft then
								pcall(vim.treesitter.start, args.buf, lang)
								if vim.treesitter.query.get(lang, "indents") then
									vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
								end
							end
						end)
					else
						vim.schedule(function()
							vim.notify(
								string.format("Treesitter: '%s' のインストールに失敗しました", lang),
								vim.log.levels.ERROR
							)
						end)
					end
				end)
			end
		end
	end,
})

-- 3. 手動更新コマンド (:TSUpdateCurrent)
vim.api.nvim_create_user_command("TSUpdateCurrent", function()
	local ft = vim.bo.filetype
	local lang = vim.treesitter.language.get_lang(ft) or ft
	vim.notify(string.format("Treesitter: '%s' のパーサーを更新中...", lang), vim.log.levels.INFO)
	ts.update({ lang }, nil, function(success)
		vim.schedule(function()
			if success then
				vim.notify(string.format("Treesitter: '%s' の更新が完了しました", lang), vim.log.levels.INFO)
				pcall(vim.treesitter.start, 0, lang)
			else
				vim.notify(string.format("Treesitter: '%s' の更新に失敗しました", lang), vim.log.levels.ERROR)
			end
		end)
	end)
end, { desc = "Update treesitter parser for current buffer" })

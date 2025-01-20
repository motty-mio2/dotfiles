return {
	{ "nvimtools/none-ls-extras.nvim", dependencies = { "nvimtools/none-ls.nvim" } },
	{ "nvimtools/none-ls.nvim", dependencies = { "nvim-lua/plenary.nvim" }, config = true },
	{ "neovim/nvim-lspconfig" },
	{ "nvim-treesitter/nvim-treesitter" },
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lua",
		},
	},
	{
		"neanias/everforest-nvim",
		version = false,
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		-- Optional; default configuration will be used if setup isn't called.
		config = function()
			require("everforest").setup({
				-- Your config here
			})
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons", "MunifTanjim/nui.nvim" },
	},
	{
		"folke/lazy.nvim",
	},
	{
		"folke/noice.nvim",
		dependencies = {
			"rcarriga/nvim-notify",
			"MunifTanjim/nui.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		event = "VeryLazy",
		opts = {},
		config = function()
			require("noice").setup({})
		end,
	},
	{
		"numToStr/Comment.nvim",
		opts = {
			-- add any options here
		},
		lazy = false,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	{
		"lewis6991/gitsigns.nvim",
	},
	{
		"github/copilot.vim",
	},
}

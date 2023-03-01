return {
	{
		"motty-mio2/mason.nvim",
		branch = "hotfix/npm_exe",
	},
	{ "williamboman/mason-lspconfig.nvim" },
	{ "neovim/nvim-lspconfig" },
	{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
	{ "nvim-treesitter/nvim-treesitter" },
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/vim-vsnip" },
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons", "MunifTanjim/nui.nvim" },
	},
}

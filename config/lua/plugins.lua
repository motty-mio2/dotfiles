require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'neovim/nvim-lspconfig'
    use 'WhoIsSethDaniel/mason-tool-installer.nvim'

    use "nvim-treesitter/nvim-treesitter"

    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/vim-vsnip"

    use {
        'nvim-telescope/telescope.nvim',
        requires = {"nvim-lua/plenary.nvim"}
    }

    use {
        "nvim-neo-tree/neo-tree.nvim",
        requires = {"nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons", "MunifTanjim/nui.nvim"}
    }

end)

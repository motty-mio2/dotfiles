require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'neovim/nvim-lspconfig'

    use "nvim-treesitter/nvim-treesitter"

    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/vim-vsnip"

    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
end)


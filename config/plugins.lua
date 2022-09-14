vim.cmd [[packadd packer.nvim]]

require'packer'.startup(function()
    use {
        'neoclide/coc.nvim',
        branch = 'release'
    }
end)

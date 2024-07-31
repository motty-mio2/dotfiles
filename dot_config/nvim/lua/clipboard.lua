vim.g.clipboard = {
    name = 'copyq',
    copy = {
        ['+'] = 'copyq add -',
        ['*'] = 'copyq add -',
    },
    paste = {
        ['+'] = 'copyq read 0',
        ['*'] = 'copyq read 0',
    },
    cache_enabled = 1,
}


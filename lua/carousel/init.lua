require('carousel')

local carousel_keymap_forward = '<M-p>'
local carousel_keymap_backward = '<M-P>'



vim.api.nvim_set_keymap('n', carousel_keymap_forward, "<Cmd>lua require'carousel'.Carousel()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', carousel_keymap_backward, "<Cmd>lua require'carousel'.Lesuorac()<CR>", { noremap = true, silent = true })

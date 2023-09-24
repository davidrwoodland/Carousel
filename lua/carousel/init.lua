-- Default key mappings
local carousel_keymap_forward = '<M-p>'
local carousel_keymap_backward = '<M-P>'

-- Default timer duration (in milliseconds)
local carousel_timer_duration = 1500

-- carousel/lua/carousel/init.lua

local M = {}

-- User-configurable key mappings (override defaults)
M.keymap_forward = vim.g.carousel_keymap_forward or carousel_keymap_forward
M.keymap_backward = vim.g.carousel_keymap_backward or carousel_keymap_backward

-- User-configurable timer duration (override default)
M.timer_duration = vim.g.carousel_timer_duration or carousel_timer_duration

return M


local around = require("carousel.carousel")
local config = require("carousel.config")

local carouselKeymapForward = '<M-p>'
local lesuoracKeymapBackward = '<M-P>'

local carouselKeymapForward = config.customKeymapForward or carouselKeymapForward
local lesuoracKeymapBackward = config.customKeymapBackward or lesuoracKeymapBackward

vim.keymap.set("n", carouselKeymapForward, function() around.carousel() end)
vim.keymap.set("n", lesuoracKeymapBackward, function() around.lesuorac() end)

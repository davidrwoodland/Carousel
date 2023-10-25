local around = require("carousel.carousel")
local config = require("carousel.config")

local carouselKeymapForward = config.customKeymapForward or config.carouselKeymapForward
local lesuoracKeymapBackward = config.customKeymapBackward or config.lesuoracKeymapBackward

vim.keymap.set("n", carouselKeymapForward, function() around.carousel() end)
vim.keymap.set("n", lesuoracKeymapBackward, function() around.lesuorac() end)

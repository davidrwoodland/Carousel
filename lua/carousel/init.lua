local M = {}

function M.setup(userConfig)

    local around = require("carousel.carousel")
    local config = require("carousel.config")

    local carouselKeymapForward = userConfig.keymapForward or config.defaultKeymapForward
    local lesuoracKeymapBackward = userConfig.keymapBackward or config.defaultKeymapBackward

    vim.keymap.set("n", carouselKeymapForward, function() around.carousel() end)
    vim.keymap.set("n", lesuoracKeymapBackward, function() around.lesuorac() end)

    local customTimer = userConfig.carouselTimer or config.defaultCarouselTimer

    around.setTimer(customTimer)

end

M.setup({})

return M

local M = {}

--setup for userConfig or used to set default values 
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

--calling to set keymaps and timer on nvim load
M.setup({})

return M

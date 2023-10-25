local config = require("carousel.config")
local M = {}

local iterate = 0
local timer = nil
local forward = 1
local backward = -1
local temporaryRegister = ''
local currentRegisterContent = ''
M.defaultCarouselTimer = 1500

function M.carousel()
    M.emptyRegisterControl(forward, M.carousel)
    if iterate == 0 then
        vim.cmd('normal! "' .. iterate .. 'p')
        temporaryRegister = vim.fn.getreg('0')
        iterate = iterate + 1
        M.startOrResetTimer()
    elseif iterate <= 9 then
        vim.cmd('undo')
        vim.cmd('normal! "' .. iterate .. 'p')
        vim.cmd('let @" = @' .. iterate)
        iterate = iterate + 1
        M.startOrResetTimer()
    elseif iterate == 10 then
        iterate = 0
        vim.cmd('undo')
        vim.fn.setreg('0', temporaryRegister)
        M.carousel()
    else
        print('Carousel broke somehow')
    end
end

function M.lesuorac()
    M.emptyRegisterControl(backward, M.lesuorac)
    if iterate > 1 then
        vim.cmd('undo')
        vim.cmd('normal! "' .. iterate .. 'p')
        vim.cmd('let @" = @' .. iterate)
        iterate = iterate - 1
        M.startOrResetTimer()
    elseif iterate == 1 then
        vim.cmd('undo')
        vim.cmd('normal! "' .. iterate .. 'p')
        vim.cmd('let @" = @' .. iterate)
        vim.fn.setreg('0', temporaryRegister)
        iterate = iterate - 1
        M.startOrResetTimer()
    elseif iterate == 0 then
        if timer then
            vim.cmd('undo')
        end
        M.carousel()
        iterate = 9
    else
        print('Lesuorac broke somehow')
    end
end

function M.startOrResetTimer()
    if timer then
        vim.fn.timer_stop(timer)
        timer = nil
    end

    local timerMaxVal = config.customCarouselTimer or M.defaultCarouselTimer

    timer = vim.fn.timer_start(timerMaxVal, function ()
        vim.fn.setreg('0', temporaryRegister)
        iterate = 0
        print('timer has stopped after ' .. (timerMaxVal/ 1000) .. ' seconds')
        timer = nil
    end)
end

function M.emptyRegisterControl(direction, callBack)
    if iterate < 1 or iterate > 10 then
        return
    end
    currentRegisterContent = vim.fn.getreg(iterate)
    if currentRegisterContent == '' then
        iterate = iterate + direction
        callBack()
    end
end

return M

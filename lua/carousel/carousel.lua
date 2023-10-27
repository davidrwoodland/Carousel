-- default carousel configs 
local config = require("carousel.config")

local M = {}

-- local variables for functions 
local iterate = 0
local timer = nil
local forward = 1
local backward = -1
local temporaryRegister = ''
local currentRegisterContent = ''
local carouselTimer = config.defaultCarouselTimer

--carousel to cycle through registers sequentially 
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

--lesuorac to cycle through registers reversed 
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

--timer to return registers to original state, ensuring no data is lost and allows the pasting of the current register until the timer runs out 
function M.startOrResetTimer()
    if timer then
        vim.fn.timer_stop(timer)
        timer = nil
    end

    timer = vim.fn.timer_start(carouselTimer, function ()
        vim.fn.setreg('0', temporaryRegister)
        iterate = 0
        -- print('timer has stopped after ' .. (carouselTimer/ 1000) .. ' seconds')
        timer = nil
    end)
end

--skips over empty registers until at register containing a value
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

-- called to set the timer value from init.lua otherwise default value from config.lua is used 
function M.setTimer(time)
    carouselTimer = time
end

return M

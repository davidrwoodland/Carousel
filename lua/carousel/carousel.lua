local M = {}

local iterate = 0
local timer = nil
local forward = 1
local backward = -1
local temporaryRegister = ''
local currentRegisterContent = ''
local DefaultCarouselTimer = 1500

-- Exported functions
function M.Carousel()
    M.EmptyRegisterControl(forward, M.Carousel)
    if iterate == 0 then
        vim.cmd('normal! "' .. iterate .. 'p')
        temporaryRegister = vim.fn.getreg('0')
        iterate = iterate + 1
        M.StartOrResetTimer()
    elseif iterate <= 9 then
        vim.cmd('undo')
        vim.cmd('normal! "' .. iterate .. 'p')
        vim.cmd('let @" = @' .. iterate)
        iterate = iterate + 1
        M.StartOrResetTimer()
    elseif iterate == 10 then
        iterate = 0
        vim.cmd('undo')
        vim.fn.setreg('0', temporaryRegister)
        M.Carousel()
    else
        print('Carousel broke somehow')
    end
end

function M.Lesuorac()
    M.EmptyRegisterControl(backward, M.Lesuorac)
    if iterate > 1 then
        vim.cmd('undo')
        vim.cmd('normal! "' .. iterate .. 'p')
        vim.cmd('let @" = @' .. iterate)
        iterate = iterate - 1
        M.StartOrResetTimer()
    elseif iterate == 1 then
        vim.cmd('undo')
        vim.cmd('normal! "' .. iterate .. 'p')
        vim.cmd('let @" = @' .. iterate)
        vim.fn.setreg('0', temporaryRegister)
        iterate = iterate - 1
        M.StartOrResetTimer()
    elseif iterate == 0 then
        if timer then
            vim.cmd('undo')
        end
        M.Carousel()
        iterate = 9
    else
        print('Lesuorac broke somehow')
    end
end

function M.StartOrResetTimer()
    if timer then
        vim.fn.timer_stop(timer)
        timer = nil
    end
    timer = vim.fn.timer_start(DefaultCarouselTimer, function ()
        vim.fn.setreg('0', temporaryRegister)
        iterate = 0
        print('timer has stopped after ' .. (DefaultCarouselTimer / 1000) .. ' seconds')
        timer = nil
    end)
end

function M.EmptyRegisterControl(direction, callBack)
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


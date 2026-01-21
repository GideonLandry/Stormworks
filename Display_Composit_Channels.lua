-- Author: Gideon Landry (Dead Moose)
-- GitHub: https://github.com/GideonLandry/Stormworks
-- Workshop: https://steamcommunity.com/profiles/76561198077245598/myworkshopfiles/?appid=573090
--
--- Developed using LifeBoatAPI - Stormworks Lua plugin for VSCode - https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--- If you have any issues, please report them here: https://github.com/nameouschangey/STORMWORKS_VSCodeExtension/issues - by Nameous Changey


--[====[ IN-GAME CODE ]====]

--- This script displays all 32 analog input channels on the screen. Works best with a 3x3 screen or bigger.

channel = {}

function onTick()
    --- Read all 32 analog input channels
    for i = 1, 32, 1 do
        channel[i] = input.getNumber(i)
    end

end

function onDraw()

    x = 0
    y = 0
    j = 1
    h = screen.getHeight()

    --- Display all 32 channels on the screen
    for i = 1, 32, 1 do
        y = (j - 1) * 10
        j = j + 1
        local value = string.format("%.2f", channel[i])
        if y > h then
            x = x + 60
            y = 0
            j = 1
        end
        screen.drawText(x, y, "Ch " .. i .. ": " .. value)
    end
end

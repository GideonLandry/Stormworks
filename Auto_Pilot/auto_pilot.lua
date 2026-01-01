-- Author: Gideon Landry (Dead Moose)
-- GitHub: https://github.com/GideonLandry/Stormworks
-- Workshop: https://steamcommunity.com/profiles/76561198077245598/myworkshopfiles/?appid=573090
--
--- Developed using LifeBoatAPI - Stormworks Lua plugin for VSCode - https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--- If you have any issues, please report them here: https://github.com/nameouschangey/STORMWORKS_VSCodeExtension/issues - by Nameous Changey


--[====[ IN-GAME CODE ]====]

-- try require("Folder.Filename") to include code from another file in this, so you can store code in libraries
-- the "LifeBoatAPI" is included by default in /_build/libs/ - you can use require("LifeBoatAPI") to get this, and use all the LifeBoatAPI.<functions>!

airport_x =     {      -15959        }
airport_y =     {      -21043        }
airport_angle = {       0.125        }
airport_name =  {"Multiplayer Island"}

ticks = 0
function onTick()
    ticks = ticks + 1

end

function onDraw()
    screen.drawCircle(16,16,5)

end


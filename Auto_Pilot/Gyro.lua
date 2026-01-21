-- Author: Gideon Landry (Dead Moose)
-- GitHub: https://github.com/GideonLandry/Stormworks
-- Workshop: https://steamcommunity.com/profiles/76561198077245598/myworkshopfiles/?appid=573090
--
--- Developed using LifeBoatAPI - Stormworks Lua plugin for VSCode - https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--- If you have any issues, please report them here: https://github.com/nameouschangey/STORMWORKS_VSCodeExtension/issues - by Nameous Changey

--[====[ IN-GAME CODE ]====]

-- try require("Folder.Filename") to include code from another file in this, so you can store code in libraries
-- the "LifeBoatAPI" is included by default in /_build/libs/ - you can use require("LifeBoatAPI") to get this, and use all the LifeBoatAPI.<functions>!

--

function onTick()

    local ang_vel_x = input.getNumber(1)
    local ang_vel_y = input.getNumber(2)
    local ang_vel_z = input.getNumber(3)

    local yaw_in = getQuaternionYaw{
        w = input.getNumber(13),
        x = input.getNumber(14),
        y = input.getNumber(15),
        z = input.getNumber(16)
    }

    local yaw_pid = pid(1.5,0.0001,0.2)
    local pitch_pid = pid(1.5,0.0001,0.2)
    local roll_pid = pid(1.5,0.0001,0.2)
end

-- code is from https://www.reddit.com/r/Stormworks/comments/kei6pg/lua_code_for_a_basic_pid/

function pid(p,i,d)
return{p=p,i=i,d=d,error=0,derivative=0,integral=0,run=function(self,setpoint,process_variable)
		local error,derivative
		local integral = 0
		error = setpoint-process_variable
		derivative = error-self.error
		if math.abs(integral*self.i) < 1 then
			integral = self.integral+error
		else
			integral = integral*0.5
		end
		
		self.error = error
		self.derivative = derivative
		self.integral = integral
		
		return error*self.p + integral*self.i +derivative*self.d
	end
}
end

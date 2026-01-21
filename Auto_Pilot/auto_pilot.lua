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


function onTick()
    q = convEulerToQuaternion(input.getNumber(5),input.getNumber(4),input.getNumber(6))
    current_heading = getQuaternionYaw(q)
    if current_heading < 0 then
        current_heading = current_heading + (2 * math.pi)
    end
    current_heading = current_heading / (2 * math.pi)
    current_pitch = getQuaternionPitch(q)
    if current_pitch < 0 then
        current_pitch = current_pitch + (2 * math.pi)
    end 
    current_pitch = current_pitch / (2 * math.pi)
    current_roll = getQuaternionRoll(q)
    if current_roll < 0 then
        current_roll = current_roll + (2 * math.pi)
    end
    current_roll = current_roll / (2 * math.pi)

    output.setNumber(1,current_heading)
    output.setNumber(2,current_pitch)
    output.setNumber(3,current_roll)
end

function onDraw()
    screen.drawCircle(16,16,5)

end
function convEulerToQuaternion(yaw, pitch, roll)
    local cy = math.cos(yaw * 0.5)
    local sy = math.sin(yaw * 0.5)
    local cp = math.cos(pitch * 0.5)
    local sp = math.sin(pitch * 0.5)
    local cr = math.cos(roll * 0.5)
    local sr = math.sin(roll * 0.5)

    local q = {}
    q.w = cr * cp * cy + sr * sp * sy
    q.x = sr * cp * cy - cr * sp * sy
    q.y = cr * sp * cy + sr * cp * sy
    q.z = cr * cp * sy - sr * sp * cy

    return q
end
function getQuaternionYaw(q)
    -- yaw (z-axis rotation)
    local siny_cosp = 2 * (q.w * q.z + q.x * q.y)
    local cosy_cosp = 1 - 2 * (q.y * q.y + q.z * q.z)
    return math.atan(siny_cosp, cosy_cosp)
end

function getQuaternionPitch(q)
    -- pitch (y-axis rotation)
    local sinp = 2 * (q.w * q.y - q.z * q.x)
    if math.abs(sinp) >= 1 then
        if sinp < 0 then
            return -math.pi / 2
        else
            return math.pi / 2
        end
    else
        return math.asin(sinp)
    end
end

function getQuaternionRoll(q)
    -- roll (x-axis rotation)
    local sinr_cosp = 2 * (q.w * q.x + q.y * q.z)
    local cosr_cosp = 1 - 2 * (q.x * q.x + q.y * q.y)
    return math.atan(sinr_cosp, cosr_cosp)
end

function getHeading()
    local q = {}
    q.w = input.getNumber(13)
    q.x = input.getNumber(14)
    q.y = input.getNumber(15)
    q.z = input.getNumber(16)
    local yaw = getQuaternionYaw(q)
    if yaw < 0 then
        yaw = yaw + (2 * math.pi)
    end
    return yaw / (2 * math.pi)
end

function pid(p,i,d)
    return
    {   p=p,i=i,d=d,error=0,derivative=0,integral=0,run=function(self,setpoint,process_variable)
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


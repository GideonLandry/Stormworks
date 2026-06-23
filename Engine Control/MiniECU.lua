-- PID controller function
function pid(p,i,d)
return{p=p,i=i,d=d,error=0,derivative=0,integral=0,run=function(self,setpoint,process_variable)
		local error,derivative
		local integral
		error = setpoint-process_variable
		derivative = error-self.error
		integral = self.integral
		if math.abs(integral*self.i) < 1 then
			integral = integral + error
		else
			integral = integral * 0.5
		end

		self.error = error
		self.derivative = derivative
		self.integral = integral

		return error*self.p + integral*self.i +derivative*self.d
	end
}
end

throttle_output_pid = pid(0.1,0.05,0)
throttle_correction_pid = pid(0.5,0,0)

AIR_FUEL_RATIO = 14.7
RPS_MAX = 10
RPS_IDLE = 2.5
STOCHIOMETRIC = 0.2

-- Scale factor mapping throttle output (air-side command) to fuel-side command;
-- this is an empirical conversion factor used to convert the computed air throttle
-- command into the corresponding fuel throttle command.
FUEL_THROTTLE_SCALE = 2.12


function onTick()

	local on_off = input.getBool(1)

	if(on_off) then

		local air_volume_in = input.getNumber(1)
		local fuel_volume_in = input.getNumber(2)
		local engine_temperature = input.getNumber(3)
		local throttle_IN = input.getNumber(4)
		local rps_in = input.getNumber(5)
		local rps_set = throttle_IN * (RPS_MAX - RPS_IDLE) + RPS_IDLE
		local eps = 1e-6
		local throttle_output = throttle_output_pid:run(rps_set, rps_in)
		local throttle_correction = throttle_correction_pid:run(AIR_FUEL_RATIO, air_volume_in / (fuel_volume_in + eps))


		local air_throttle = throttle_output + throttle_correction
		air_throttle = math.max(0, math.min(1, air_throttle))
		output.setNumber(3, air_throttle)
		local fuel_throttle = (throttle_output / FUEL_THROTTLE_SCALE) - throttle_correction

		-- small compensation based on engine temperature to use the value without changing behavior significantly
		fuel_throttle = fuel_throttle * (1 + (20 - engine_temperature) * 0.0005)
		fuel_throttle = math.max(0, math.min(1, fuel_throttle))
		output.setNumber(2, fuel_throttle)
		air_throttle = math.max(0, math.min(1, air_throttle))
		output.setNumber(3, air_throttle)
		local fuel_throttle = (throttle_output / FUEL_THROTTLE_SCALE) - throttle_correction
		fuel_throttle = math.max(0, math.min(1, fuel_throttle))
		output.setNumber(2, fuel_throttle)

	end
end


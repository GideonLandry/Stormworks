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
pid_test = pid(1.2,0.0001,0.1)
function onTick()
	idle = 5
	max_rps = 20
	throttle = input.getNumber(4)
	rps_in = input.getNumber(1)
	rps_set = throttle*max_rps

	if rps_set < idle then
		rps_set = idle
	end
	
	value_out = pid_test:run(rps_set,rps_in)
	output.setNumber(1,value_out)
end
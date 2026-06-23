-- Code by Jyota_malcolm  Source: https://www.reddit.com/r/Stormworks/comments/kei6pg/lua_code_for_a_basic_pid/

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
pid_test = pid(0.2,0.0001,0.1)
function onTick()
	rps_set = input.getNumber(1)
	rps_in = input.getNumber(2)
	value_out = pid_test:run(rps_set,rps_in)
	output.setNumber(value_out)
end
local obj ={}
obj.telnet=net.createServer(net.TCP,180) 

obj.start = function()
								print("starting telnet")
								obj.telnet:listen(23,function(c) 
								con_std = c 
								function s_output(str) 
												if(con_std~=nil) 
												then con_std:send(str) 
												end 
								end 
								node.output(s_output, 0)   -- re-direct output to function s_ouput.
								c:on("receive",function(c,l) 
												node.input(l)           -- works like pcall(loadstring(l)) but support multiple separate line
								end) 
								c:on("disconnection",function(c) 
												con_std = nil 
												node.output(nil)        -- un-regist the redirect output function, output goes to serial
												func.autostart()
												end) 
								end)
end

obj.stop = function()
								print("stopping telnet")
								obj.telnet:close()
end

return obj

local obj = {  }
obj.http = net.createServer(net.TCP)

obj.start = function()
								print("starting webserver")
								obj.http:listen(80,function(conn)
								conn:on("receive",function(conn,payload)
								local send = true
								print("start")
								print(payload)
								print("end")
								local	upload=string.find(payload,'name="do".*upload')
								local	telnet=string.find(payload,'name="do".*telnet')
								if(telnet ~= nil) then send = false conn:send("HTTP/1.1 200 OK\n\n<html><body>starting Telnet</body></html>") func.startTelnet() end
								if(upload ~= nil) then send = false obj.uploadFile(payload) end
								if send  == true then
																print("sende")
																file.open("index.html")
																local datei = file.read()
																file.close()
																conn:send('HTTP/1.1 200 OK\n\n')
																conn:send(datei)
								end
				end)
end)
end

obj.stop = function()
								print("stopping webserver")
								obj.http:close()
end

obj.uploadFile = function(payload)
				local fileBegin, fileEnde = string.find(payload,"StartFileContent.*EndFileContent")
				if(fileBegin ~= nil) then
								local content = string.sub(payload,fileBegin+17,fileEnde-17)
								file.open("test.lua","w")
								file.close()
								file.remove("test.lua")
								file.open("test.lua","w+")
								file.writeline(content)
								file.flush()
								file.close()
				end
end


return obj

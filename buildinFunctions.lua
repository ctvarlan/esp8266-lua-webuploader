local f = {}
function f.showFile(fileName)
				file.open(fileName,"r")
				print(file.read())
				file.close()
end

function f.listFiles()
								for i, _ in pairs(file.list()) do
																print(i)
								end
end
function f.help()
								print("listFiles()")
								print("showFiles(<\"filename\">)")
end

function f.startHttp()
								telnet.stop()
								http.start()
end

function f.stopHttp()
								http.stop()
end

function f.startTelnet()
								http.stop()
								telnet.start()
end

function f.stopTelnet()
								telnet.stop()
								f.autostart()
end

function f.autostart()
								http.start()
end
return f

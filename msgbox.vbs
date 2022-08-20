Set shell = CreateObject("WScript.Shell")

prompt = "Please make sure that the variables in config.bat file are set properly."
title = "Config file is not set correctly!"

response = msgbox(prompt, 5, title)
if (response = 4) then shell.Run "prebuild.bat"
	
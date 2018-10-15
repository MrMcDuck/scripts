@echo off

:: set adsl config
set ConnName = "宽带连接"
set ConnUsr = "adsl"
set ConnPwd = "123456"

:loop
Echo Trying to connect to [Connection name] ...
rasdial %ConnName% %ConnUsr% %ConnPwd%

ping www.yahoo.com

if NOT %ERRORLEVEL% == 0 goto failed

:: wait 10 seconds and change the IP
wait 10

:: disconnect and re-dial
rasdial %ConnName% /disconnect
goto loop

:failed
Echo Failed to connect. %ConnName% are retarded.

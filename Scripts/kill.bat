@ECHO OFF
CALL :sub_close_if_running MATLAB.exe
CALL :sub_wait_for_it  MATLAB.exe

copy /Y %1\protobuf-net.dll %2
copy /Y %1\mForex.API.dll %2
copy /Y %1\mForex.API.Matlab.dll %2

CALL :sub_load_Matlab %wasRunning% %2 LoadDll

ECHO Koneic!
GOTO :eof

:sub_wait_for_it    
  CALL :sub_is_running %1
  if %isRunning%==1 (	
    CALL :sub_sleep 1
    CALL :sub_wait_for_it %1
  )
GOTO :eof

:sub_close_if_running	
	set wasRunning=0
	CALL :sub_is_running %1		
	if %isRunning%==1 (
    set wasRunning=1
    TASKKILL /FI "IMAGENAME eq  %1" >NUL
	)
GOTO :eof

:sub_is_running
  set programName=%1  
  set isRunning=0  
  FOR /F %%A IN ('tasklist /NH /FI "IMAGENAME eq %programName%"') DO (
    if not %%A==%programName% (
      set isRunning=0
    ) else (
      set isRunning=1
    )
  )
GOTO :eof

:sub_load_Matlab
	if %1==1 (
	  cd %2
	  MATLAB -r %3
	 )
GOTO :eof

:sub_sleep
	ping 127.0.0.1 -n %1 -w %1000 > nul
GOTO :eof
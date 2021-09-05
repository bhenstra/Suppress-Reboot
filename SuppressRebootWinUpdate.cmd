@ECHO OFF

 ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
 :: Suppress Reboot after the installation of updates | Windows Update ::
 ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

    ::: Because I don't like %systemroot%\system32\MusNotification.exe reboot
    ::: Use at your own risk!
    ::: License: MIT
    ::: Author: Bouke J. Henstra
    ::: Version 1.0

	::: Script Variables
	    SET ScriptDir=%~dp0
	    SET ScriptBin=%~dp0Bin
	    SET ScriptLogDir=%~dp0Log
	    SET ScriptLogFile=Log.txt
		
    ::: Task Variables
	    SET TaskSD=10/10/2090
	    SET TaskST=01:45
	    SET PsExec=PsExec64.exe
	    SET PsExecAcceptEULA=-accepteula -nobanner
	    SET PsExecCommand=-s %systemroot%\system32\schtasks.exe /change /tn ^"\Microsoft\Windows\UpdateOrchestrator\Reboot^" /SD %TaskSD% /ST %TaskST% /DISABLE

	::: SchTasks
	    SET SchTasksFldr=Suppression
        SET SchTasksName=SuppressRebootWinUpdate
		SET SchTaskMinutes=10
	
    ::: Script checks and init
	    IF NOT EXIST %ScriptBin%\. echo The location of the binaries does not exist. && goto :END
	    IF NOT EXIST %ScriptBin%\%PsExec% echo The file %PsExec% was not found. && goto :END
	    IF NOT EXIST "%ScriptLogDir%\." MKDIR "%ScriptLogDir%"
		
    ::: Modify and disable the Reboot task of the Windows Update Orchestrator

	::: Execute
	    %ScriptBin%\%PsExec% %PsExecAcceptEULA% %PsExecCommand%
	
	::: Create a task to repeat this script
	    %systemroot%\system32\schtasks.exe /RU "SYSTEM" /Create /F /SC minute /MO %SchTaskMinutes% /TN "%SchTasksFldr%\%SchTasksName%" /TR "%ScriptDir%%~nx0"

    ::: Create a task to ensure this script will start at system start
	    %systemroot%\system32\schtasks.exe /RU "SYSTEM" /Create /F /SC ONSTART /TN "%SchTasksFldr%\%SchTasksName%-Kick-in-at-System-Start" /TR "%ScriptDir%%~nx0"
		
	::: Write last run date and time to log file
	    echo Has been run on %date% at %time% > %ScriptLogDir%\%ScriptLogFile%
:END



@echo off
setlocal enabledelayedexpansion

rem set showName to parent directory
for %%I in ("%~dp0\.") do set showName=%%~nxI
echo([ renamer ] show name was found correctly : !showName!

rem ask for file extension
set /p fileExtension=[ renamer ] enter file extension : 

rem pause
pause
echo(

rem for every season dir
for /D %%D in (*) do (
    echo([ renamer ] processing directory : %%D
    rem go to the directory
    cd "%%D"
    rem set episode number to 1
	set "episodeNumber=1"
    rem for every directory
    for %%F in (*) do (
		rem if correct file extension
		if "%%~xF" == "!fileExtension!" (
			rem set new file name
			set "newFileName=!showName!_%%De!episodeNumber!"
			rem renaming
			ren "%%F" "!newFileName!!fileExtension!"
			rem notification
			echo([ renamer ] renamed %%F to !newFileName!!fileExtension!
			rem add +1 to episode number
			set /a episodeNumber+=1
		)
    )
    
    rem Change back to the parent directory
    cd ..
	
	echo(
)

pause

endlocal

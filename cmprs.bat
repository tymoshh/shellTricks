@echo off
title 10MB CLIP COMPRESSOR by tymoshh 
setlocal enabledelayedexpansion
mode con: cols=80 lines=39

echo 10MB CLIP COMPRESSOR
echo by tymoshh
echo(

curl https://raw.githubusercontent.com/tymoshh/clipCompressor/refs/heads/main/ascii.txt

echo(
pause

:checkFfmpeg
cls
echo(
ffmpeg -version >nul 2>&1
if %errorlevel% neq 0 (
    echo ffmpeg not found
	goto :installFfmpeg
)



set logOptions=-loglevel quiet

set sizeOptions=-fs 10M
set audioCodec=-c:a libopus
set audioBitrate=-b:a 48k
set framerateOptions=-r 45
set scalingOptions=-vf "scale=1280:720:flags=lanczos"

set inputPath=%1
set tempName=temp%random%.mp4
set outputName=clip%random%.mp4

copy "!inputPath!" "!tempName!" >NUL


:chooseEncoding

cls
echo encode using : Nvidia AV1 (1) / Nvidia HEVC (2) / Radeon AV1 (3) / CPU AV1 (4) ?
set /p userHardware="choose compression method : "

if "!userHardware!"=="1" (
	set currentCodec=av1_nvenc
	echo(
	echo COMPRESSING ...
	ffmpeg !logOptions! -i !tempName! !sizeOptions! -c:v !currentCodec! -preset 18 -cq 18 -b:v 5M -maxrate 5M -bufsize 10M !framerateOptions! !scalingOptions! !audioCodec! !audioBitrate! !outputName!
	if %errorlevel% equ 0 (
		goto :normalEnd
	) else (
		goto :installFfmpeg
	)
)

if "!userHardware!"=="2" (
	set currentCodec=hevc_nvenc
	echo(
	echo COMPRESSING ...
	ffmpeg !logOptions! -i "!tempName!" !sizeOptions! -c:v !currentCodec! -preset 18 -cq 22 -b:v 5M -maxrate 5M -bufsize 10M !framerateOptions! !scalingOptions! !audioCodec! !audioBitrate! "!outputName!"
	if %errorlevel% equ 0 (
		goto :normalEnd
	) else (
		goto :errorOcurred
	)
)

if "!userHardware!"=="3" (
	set currentCodec=av1_amf
	echo(
	echo NOTE : EXPERIMENTAL
	echo COMPRESSING ...
	ffmpeg !logOptions! -i "!tempName!" !sizeOptions! -c:v !currentCodec! -preset veryslow -quality 0 -b:v 5M -maxrate 5M -bufsize 10M !framerateOptions! !scalingOptions! !audioCodec! !audioBitrate! "!outputName!"
	if %errorlevel% equ 0 (
		goto :normalEnd
	) else (
		goto :errorOcurred
	)
)

if "!userHardware!"=="4" (
	echo NOT DONE YET
	echo(
)

echo WRONG OPTION!
echo(

goto :chooseEncoding




:normalEnd
del !tempName!
echo(
echo saved !outputName! encoded with !currentCodec!
echo(
echo note : if you can't open your file make sure your media player supports !currentCodec!
echo(
pause
exit

:errorOcurred
del !tempName!
echo(
echo unexpected error ocurred!
echo make sure your hardware supports codec you chose
echo(
pause
exit

:chocolateyStuff
choco -v >nul 2>&1
if %errorlevel% neq 0 (
	echo(
	echo chocolatey not installed
	set /p doInstallChoco="install chocolatey? (y/n) : "
	if !doInstallChoco!=="y" (
		@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
		echo restart needed to refresh enviromental variables
		echo(
		pause
		start "" /b "%comspec%" /c "%~f0"
		exit /b
	)
	if !doInstallChoco!=="n" (
		goto :errorOcurred
	)
	goto :chocolateyStuff
) else (
	goto :chocoInstalled
)

:installFfmpeg
echo(
set /p doInstallFfmpeg="install ffmpeg? (y/n) : "
if !doInstallFfmpeg!=="y" (
	goto :checkChocolatey
	:chocoInstalled
	choco install ffmpeg
	RefreshEnv.cmd
	goto :checkFfmpeg
)
if !doInstallFfmpeg!=="n" (
	goto :errorOcurred
)
echo WRONG OPTION!
goto :installFfmpeg

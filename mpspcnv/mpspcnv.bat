@echo off

echo(

if exist eula.txt (
     echo [ OK ] eula.txt detected
) else (
     echo [ ERROR ] no eula.txt! wrong directory
     exit
)

if exist spworld (
     rmdir spworld /q /s
)
mkdir spworld

xcopy world spworld

mkdir spworld\DIM1
mkdir spworld\DIM-1

xcopy world_nether spworld\DIM-1
xcopy world_the_end spworld\DIM1

echo(
echo DONE!

echo(
pause

exit

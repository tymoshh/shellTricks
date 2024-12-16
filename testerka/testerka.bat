cls

set exeName=a.exe

set /a testAmount=0
set /a passAmount=0

echo MARKER > tmp.out

for %%f in ("in\*.in") do (

    set fileName=%%~nf
    set /a testAmount+=1

    !exeName! < in\!fileName!.in > tmp.out

    fc out\!fileName!.out tmp.out >nul

    if errorlevel 1 (
        echo([ BAD ] !fileName!
    ) else (
        echo([ OK ] !fileName!
        set /a passAmount+=1
    )

    echo MARKER > tmp.out

)

echo(
echo(PASSED %passAmount% / %testAmount%

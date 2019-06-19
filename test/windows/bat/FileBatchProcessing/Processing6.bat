@setlocal
@echo off

rem echo %1
rem echo %2

echo "%~1" | find "%~2" >NUL
if %ERRORLEVEL% equ 0 (
    exit /b 1
)
echo change> %1

endlocal

exit /b 0

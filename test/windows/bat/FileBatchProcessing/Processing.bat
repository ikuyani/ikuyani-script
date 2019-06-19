@setlocal
@echo off

rem echo Processing
rem echo %1
rem echo %2
rem echo %3

set msg1=%~2
if not defined msg1 (
    set msg1=xxx
)
set msg2=%~3
if not defined msg2 (
    set msg2=yyy
)
echo %msg1%,%msg2%> %1

endlocal

exit /b 0

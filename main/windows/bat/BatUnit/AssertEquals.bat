@setlocal
@echo off

rem åüèÿÅFàÍív

set TEST_NAME=%~1
set EXPECTED=%2
set ACTUAL=%3

if not %EXPECTED%==%ACTUAL% (
    echo Failed %TEST_NAME%, Expected=%EXPECTED%, Actual=%ACTUAL%.
    endlocal
    exit /b 1
)
echo Successful %TEST_NAME%.

endlocal
exit /b 0

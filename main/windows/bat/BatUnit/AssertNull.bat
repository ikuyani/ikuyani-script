@setlocal
@echo off

rem ******************************************************************
rem * AssertNull.bat: 値がNULL(未定義)であるか検証する
rem *
rem * [説明]
rem *   値がNULLの場合、Successfulをコンソールに出力し、0を返す。
rem *   値がNULLではない場合、Failedをコンソールに出力し、1を返す。
rem * 
rem * [引数]
rem *   %1: テスト名
rem *   %2: 値
rem * 
rem * [バージョン]
rem *   1.0.0
rem ******************************************************************
rem echo AssertNull.bat %1 %2

set TEST_NAME=%~1
set ACTUAL=%2

if defined ACTUAL (
    echo Failed %TEST_NAME%, Actual=%ACTUAL%.
    endlocal
    exit /b 1
)

echo Successful %TEST_NAME%.

endlocal
exit /b 0

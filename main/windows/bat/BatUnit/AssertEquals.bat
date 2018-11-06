@setlocal
@echo off

rem ******************************************************************
rem * AssertEquals.bat: 2つの値(期待値と実際の値)が一致するか検証する
rem *
rem * [説明]
rem *   2つの値が一致する場合、Successfulをコンソールに出力し、0を返す。
rem *   2つの値が一致しない場合、Failedをコンソールに出力し、1を返す。
rem * 
rem * [引数]
rem *   %1: テスト名
rem *   %2: 期待値
rem *   %3: 実際の値
rem * 
rem * [バージョン]
rem *   1.0
rem ******************************************************************
rem echo AssertEquals.bat %1 %2 %3

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

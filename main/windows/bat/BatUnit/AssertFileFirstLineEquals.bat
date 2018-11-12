@setlocal
@echo off

rem ******************************************************************
rem * AssertFileFirstLineEquals.bat: ファイルの先頭行と期待値が一致するか検証する
rem *
rem * [説明]
rem *   一致する場合、Successfulをコンソールに出力し、0を返す。
rem *   一致しない、もしくはファイルが存在しない場合、Failedをコンソールに出力し、1を返す。
rem *   エラーの場合、Errorをコンソールに出力し、9を返す。
rem * 
rem * [引数]
rem *   %1: テスト名
rem *   %2: 期待値
rem *   %3: ファイルパス
rem * 
rem * [バージョン]
rem *   1.0.0
rem ******************************************************************
rem echo AssertFileFirstLineEquals.bat %1 %2 %3

set BAT_ASSERTFILEEXISTS="%~dp0\AssertFileExists.bat"
set BAT_ASSERTEQUALS="%~dp0\AssertEquals.bat"

set TEST_NAME=%~1
set EXPECTED=%~2
set FILE_PATH=%3

call %BAT_ASSERTFILEEXISTS% %1 %3
if %ERRORLEVEL% neq 0 (
    endlocal
    rem 即時展開なのでERRORLEVELはendlocal前の値となる
    exit /b %ERRORLEVEL%
)

set /p HEADER=<%FILE_PATH%
call %BAT_ASSERTEQUALS% %1 "%EXPECTED%" "%HEADER%"
if %ERRORLEVEL% neq 0 (
    endlocal
    rem 即時展開なのでERRORLEVELはendlocal前の値となる
    exit /b %ERRORLEVEL%
)

echo Successful %TEST_NAME%.

endlocal
exit /b 0

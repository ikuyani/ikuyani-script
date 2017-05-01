@setlocal enabledelayedexpansion
@echo off

rem ******************************************************************
rem * FileRotateSize.bat: ファイルサイズによるローテート
rem * %1: ファイルのフォルダ C:\work\log
rem * %2: ファイル名 Error.log
rem * %3: 最大の世代数
rem * %4: ファイルの最大バイト数
rem ******************************************************************
rem echo FileRotateSize %1 %2 %3 %4

for %%i in (%~1\%~2) do (
    rem echo %%~zi
    if %%~zi gtr %4 (
        call FileRotate.bat %1 %2 %3
    )
)

exit /b

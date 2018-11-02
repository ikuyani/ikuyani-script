@setlocal enabledelayedexpansion
@echo off

rem ******************************************************************
rem * FileRotateSize.bat: ファイルサイズによるファイルローテート
rem * 
rem * [説明]
rem * 
rem * [引数]
rem *   %1: ローテートするファイルのあるフォルダ
rem *   %2: ローテートするファイル名
rem *   %3: 世代数の上限
rem *   %4: ローテートの判断をするファイルのバイト数
rem * 
rem * [バージョン]
rem *   1.0
rem ******************************************************************
rem echo FileRotateSize %1 %2 %3 %4

for %%i in (%~1\%~2) do (
    rem echo %%~zi
    if %%~zi gtr %4 (
        call FileRotate.bat %1 %2 %3
    )
)

exit /b

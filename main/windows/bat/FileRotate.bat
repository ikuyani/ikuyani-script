@setlocal enabledelayedexpansion
@echo off

rem ******************************************************************
rem * FileRotate.bat: ファイルローテート処理 
rem * 
rem * [説明]
rem * 
rem * [引数]
rem *   %1: ローテートするファイルのあるフォルダ
rem *   %2: ローテートするファイル名
rem *   %3: 世代数の上限
rem * 
rem * [バージョン]
rem *   1.0
rem ******************************************************************
rem echo FileRotate.bat %1 %2 %3

rem ファイル名と世代番号の区切り文字
set DOT=.

for /l %%i in (%3,-1,1) do (
    set _FILE=%~2%DOT%%%i
    if exist !_FILE! (
        if %%i equ %3 (
            rem ファイルの世代番号が最大の場合、ファイルを削除する
            del /Q  "%~1\!_FILE!" >nul
        ) else (
            rem ファイルの世代番号が最大ではない場合、世代をアップする
            set /a _NEXT_COUNT=%%i+1 
            move /Y %~1\!_FILE! %~1\%~2%DOT%!_NEXT_COUNT! >nul
        )
    )
)

rem 最新のファイルは世代番号に1を付ける
set _FILE=%~2%
move /Y "%~1\!_FILE!" "%~1\%~2%DOT%1" >nul

endlocal
exit /b

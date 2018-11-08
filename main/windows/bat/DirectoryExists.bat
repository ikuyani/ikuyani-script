@setlocal enabledelayedexpansion
@echo off

rem ******************************************************************
rem * IsDirectoryExists.bat: 指定されたパスがフォルダであるか検証する
rem *
rem * [説明]
rem *   ＜戻り値＞
rem *   ・フォルダの場合、0を返す
rem *   ・フォルダ以外の場合、1を返す
rem * 
rem * [引数]
rem *   %1: フォルダパス
rem * 
rem * [バージョン]
rem *   1.0.0
rem ******************************************************************
rem echo IsDirectoryExists.bat %1

set FILE_PATH=%1

rem NULLの場合、1を返す
if not defined FILE_PATH (
    endlocal
    exit /b 1
)

rem フォルダが存在しない場合、1を返す
if not exist %FILE_PATH%\ (
    endlocal
    exit /b 1
)

endlocal
exit /b 0

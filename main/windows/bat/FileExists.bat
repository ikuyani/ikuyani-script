@setlocal
@echo off

rem ******************************************************************
rem * FileExists.bat: 指定されたパスがファイルであるか検証する
rem *
rem * [説明]
rem *   ＜戻り値＞
rem *   ・ファイルの場合、0を返す
rem *   ・ファイル以外の場合、1を返す
rem * 
rem * [引数]
rem *   %1: ファイルパス
rem * 
rem * [バージョン]
rem *   1.0.0
rem ******************************************************************
rem echo FileExists.bat %1

set FILE_PATH=%1

rem NULLの場合、1を返す
if not defined FILE_PATH (
    endlocal
    exit /b 1
)

rem ファイルパスに存在しない
if not exist %FILE_PATH% (
    endlocal
    exit /b 1
)

rem ファイルパスに存在するがフォルダ
if exist %FILE_PATH%\ (
    endlocal
    exit /b 1
)

endlocal
exit /b 0

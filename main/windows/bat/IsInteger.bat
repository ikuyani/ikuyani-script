@setlocal enabledelayedexpansion
@echo off

rem ******************************************************************
rem * IsInteger.bat: 整数であるかを判定する
rem *
rem * [説明]
rem *   ＜仕様・ルール＞
rem *   ・整数のうち、正数は記号無し、もしくは+記号を付ける
rem *   ・整数のうち、負数は-記号を付ける
rem * 
rem *   ＜戻り値＞
rem *   ・整数の場合、0を返す
rem *   ・整数以外の場合、1を返す
rem * 
rem * [引数]
rem *   %1: 判定する値
rem * 
rem * [バージョン]
rem *   1.0.0
rem ******************************************************************
rem echo IsInteger.bat %1

set INTEGER=%1

rem NULLの場合、1を返す
if not defined INTEGER (
    endlocal
    exit /b 1
)

rem 整数判定
echo %INTEGER%| findstr /x /r "^[0-9]*$" 1>nul
if %ERRORLEVEL% neq 0 (
    echo %INTEGER%| findstr /x /r "^[+-][0-9]*$" 1>nul
    if !ERRORLEVEL! neq 0 (
        rem 整数でない場合、1を返す
        endlocal
        exit /b 1
    )
)

rem 整数の場合、0を返す
endlocal
exit /b 0

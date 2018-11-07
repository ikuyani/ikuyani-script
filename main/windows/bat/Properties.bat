@echo off

rem ******************************************************************
rem * Properties.bat: プロパティファイルからプロパティ名と値のセットを取得し、環境変数に設定する
rem *
rem * [説明]
rem *   ＜仕様・ルール＞
rem *   ・１行に プロパティ名=値 の形式で記述する
rem *   ・プロパティ名に空白を含めることはできない
rem *   ・プロパティ名、値の前後の空白は除去される
rem *   ・値に空白を含めるには " で値を囲む(本処理中に囲い文字の除去はしない)
rem *   ・行の先頭に # がある場合、コメント行とする
rem *   ・空行は無視される
rem * 　・値が空の場合、環境変数は未設定となる
rem * 
rem *   ＜戻り値＞
rem *   ・正常に処理できた場合、0を返す
rem *   ・エラーなど不正の場合、9を返す
rem * 
rem * [引数]
rem *   %1: プロパティファイルのパス
rem * 
rem * [バージョン]
rem *   1.0.0
rem ******************************************************************
rem echo Properties.bat %1

set FILE_PATH=%1

rem NULL(不正)の場合、9を返す
if not defined FILE_PATH (
    endlocal
    exit /b 9
)

rem プロパティファイルが存在しない場合、9を返す
call "%~dp0\IsFileExists.bat" %FILE_PATH%
if not %ERRORLEVEL% equ 0 (
    endlocal
    exit /b 9
)

for /f "usebackq tokens=1,2* delims==" %%a in (%1) do (
    setlocal enabledelayedexpansion
    call :IsIgnore %%a
    if not !ERRORLEVEL! equ 0 (
        endlocal
        call :SetProperty %%a %%b
    ) else (
        endlocal
    )
)

exit /b 0

rem ******************************************************************
rem * IsIgnore: 環境変数への設定の除外対象かの判定
rem * 
rem * [説明]
rem * 
rem * [引数]
rem *   %1: プロパティ名
rem ******************************************************************
:IsIgnore
setlocal

set VARNAME=%1

rem プロパティ名未指定は除外
if "%VARNAME%"=="" (
rem    echo Exclude %VARNAME%
    endlocal
    exit /b 0
)

rem コメント行は除外
if "!VARNAME:~0,1!"=="#" (
rem    echo CommentLine %VARNAME%
    endlocal
    exit /b 0
)
endlocal
exit /b 1


rem ******************************************************************
rem * SetProperty: 環境変数に設定する
rem * 
rem * [説明]
rem *   関数化の理由は前後の空白除去のため。
rem * 
rem * [引数]
rem *   %1: プロパティ名
rem *   %2: 値
rem ******************************************************************
:SetProperty

rem echo %1=%2
set %1=%2

exit /b

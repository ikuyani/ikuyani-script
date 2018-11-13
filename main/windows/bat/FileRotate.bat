@setlocal enabledelayedexpansion
@echo off

rem ******************************************************************
rem * FileRotate.bat: ファイルローテート処理 
rem * 
rem * [説明]
rem *   ファイルもしくはフォルダに対し、世代番号を付与して名前を変更する。
rem *   世代番号は小さい番号ほど新しく、大きい番号ほど古くなる。
rem * 
rem *   ＜仕様・ルール＞
rem *   ・ファイルとフォルダに対してローテートする
rem *   ・ローテートする対象が存在しない場合、何もしない
rem *   ・バックアップ世代数より大きい番号のファイルに対しては何もしない
rem *   ・バックアップ世代数は1以上を指定する
rem * 
rem *   ＜戻り値＞
rem *   ・正常に処理した場合、0を返す
rem *   ・ローテートするファイルが存在しない場合、1を返す
rem *   ・引数が不正の場合、8を返す
rem *   ・その他、予期しないエラーなどの場合、9を返す
rem * 
rem * [引数]
rem *   %1: ローテートするファイル(必須)
rem *   %2: バックアップ世代数の上限(必須)
rem * 
rem * [バージョン]
rem *   1.1.0
rem ******************************************************************
rem echo FileRotate.bat %1 %2

rem 利用する外部バッチファイル
set BAT_DIRECTORYEXISTS="%~dp0\DirectoryExists.bat"
set BAT_ISINTEGER="%~dp0\IsInteger.bat"

rem ファイル名と世代番号の区切り文字
set DOT=.

set FILE_PATH=%~1
set MAX_BACKUP_NUMBER=%2

rem 引数チェック(引数が不正の場合、8を返す)
if not defined FILE_PATH (
    endlocal
    exit /b 8
)

rem バックアップ世代数の数字判定
call %BAT_ISINTEGER% %MAX_BACKUP_NUMBER%
if %ERRORLEVEL% neq 0 (
    endlocal
    exit /b 8
)
rem バックアップ世代数は1以上を指定する
if %MAX_BACKUP_NUMBER% lss 1 (
    endlocal
    exit /b 8
)


rem ローテートするファイルもしくはフォルダが存在しない場合、1を返す
if not exist "%FILE_PATH%" (
    endlocal
    exit /b 1
)

rem 世代数の上限の番号からローテート処理する
for /l %%i in (%MAX_BACKUP_NUMBER%,-1,1) do (
    set _FILE="%FILE_PATH%%DOT%%%i"
    if exist !_FILE! (
        if %%i equ %MAX_BACKUP_NUMBER% (
            rem ファイルの世代番号が最大の場合、ファイルを削除する
            call %BAT_DIRECTORYEXISTS% !_FILE!
            if !ERRORLEVEL! equ 0 (
                rem フォルダの場合
                rd /S /Q !_FILE! >nul
            ) else (
                rem ファイルの場合
                del /Q  !_FILE! >nul
            )
            if !ERRORLEVEL! neq 0 (
                endlocal
                exit /b 9
            )
        ) else (
            rem ファイルの世代番号が最大ではない場合、世代をアップする
            set /a _NEXT_COUNT=%%i+1 
            move /Y !_FILE! "%FILE_PATH%%DOT%!_NEXT_COUNT!" >nul
            if !ERRORLEVEL! neq 0 (
                endlocal
                exit /b 9
            )
        )
    )
)

rem 最新のファイルは世代番号に1を付ける
move /Y "%FILE_PATH%" "%FILE_PATH%%DOT%1" >nul
if %ERRORLEVEL% neq 0 (
    endlocal
    exit /b 9
)

endlocal
exit /b 0

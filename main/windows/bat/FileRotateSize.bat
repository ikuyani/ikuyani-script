@setlocal enabledelayedexpansion
@echo off

rem ******************************************************************
rem * FileRotateSize.bat: ファイルサイズによるファイルローテート
rem * 
rem * [説明]
rem *   ファイルのバイト数が上限値より大きい場合、ローテートする。
rem * 
rem *   ＜仕様・ルール＞
rem *   ・ファイルに対してのみローテートする
rem *   ・ローテートする対象が存在しない場合、何もしない
rem *   ・ファイルのバイト数の上限は1以上を指定する
rem *   ・バックアップ世代数など基本的な仕様はFileRotate.batに準ずる
rem * 
rem * [引数]
rem *   %1: ローテートするファイル(必須)
rem *   %2: バックアップ世代数の上限(必須)
rem *   %3: ファイルのバイト数上限
rem * 
rem * [バージョン]
rem *   1.0.0
rem ******************************************************************
rem echo FileRotateSize %1 %2 %3

rem 利用する外部バッチファイル
set BAT_FILEEXISTS="%~dp0\FileExists.bat"
set BAT_ISINTEGER="%~dp0\IsInteger.bat"
set BAT_FILEROTATE="%~dp0\FileRotate.bat"

set FILE_PATH=%~1
set MAX_BACKUP_NUMBER=%2
set MAX_BYTESIZE=%3

rem 引数チェック(引数が不正の場合、8を返す)
if not defined FILE_PATH (
    endlocal
    exit /b 8
)

rem ファイルのバイト数上限の数字判定
call %BAT_ISINTEGER% %MAX_BYTESIZE%
if %ERRORLEVEL% neq 0 (
    endlocal
    exit /b 8
)
rem ファイルのバイト数上限は1以上を指定する
if %MAX_BYTESIZE% lss 1 (
    endlocal
    exit /b 8
)
rem ローテートするファイルが存在しない場合、1を返す
call %BAT_FILEEXISTS% "%FILE_PATH%"
if %ERRORLEVEL% neq 0 (
    endlocal
    exit /b 1
)

rem ファイルのバイト数が上限値より大きい場合、ローテートする
for %%i in ("%FILE_PATH%") do (
    rem echo %%~zi
    if %%~zi gtr %MAX_BYTESIZE% (
        call %BAT_FILEROTATE% "%FILE_PATH%" %MAX_BACKUP_NUMBER%
        if !ERRORLEVEL! neq 0 (
            endlocal
            exit /b !ERRORLEVEL!
        ) 
    )
)

endlocal
exit /b 0

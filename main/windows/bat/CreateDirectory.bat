@setlocal enabledelayedexpansion
@echo off

rem ******************************************************************
rem * CreateDirectory.bat: フォルダを作成する
rem *
rem * [説明]
rem *   ＜仕様・ルール＞
rem *   ・同一パスのフォルダが存在する場合、作成しない
rem * 
rem *   ＜戻り値＞
rem *   ・正常に作成できた場合、0を返す
rem *   ・すでにフォルダが存在する場合、1を返す
rem *   ・同一パスにフォルダ以外がすでに存在する場合、2を返す
rem *   ・引数が不正の場合、8を返す
rem *   ・その他、予期しないエラーなどの場合、9を返す
rem * 
rem * [引数]
rem *   %1: 作成するフォルダのパス
rem * 
rem * [バージョン]
rem *   1.0.0
rem ******************************************************************
rem echo CreateDirectory.bat %1

set DIR_PATH=%1

rem NULL(不正)の場合、9を返す
if not defined DIR_PATH (
    endlocal
    exit /b 8
)

rem 同一パスにフォルダが存在しない場合、フォルダを作成する
if not exist %DIR_PATH%\ (
    rem 同一パスにフォルダ以外がすでに存在する場合、2を返す
    if exist %DIR_PATH% (
        endlocal
        exit /b 2
    )

    rem フォルダを作成する
    mkdir %DIR_PATH%
    if !ERRORLEVEL! neq 0 (
        endlocal
        exit /b 9
    )

    rem 正常に作成できた場合、0を返す
    endlocal
    exit /b 0
)

rem すでにフォルダが存在する場合、1を返す
endlocal
exit /b 1

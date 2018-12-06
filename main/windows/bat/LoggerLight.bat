@setlocal enabledelayedexpansion
@echo off

rem ******************************************************************
rem * LoggerLight.bat: ログを出力する(ログレベル無しの軽量版)
rem *
rem * [説明]
rem *   ＜ログ出力方法＞
rem *   ・ログの出力先は環境変数のLOGGER_HANDLERに指定する
rem *     - FILE: 環境変数のLOGGER_FILE_OUTPUTに指定したファイルに出力する
rem *     - CONSOLE: 標準出力する
rem *     - 上記以外: 出力しない
rem * 
rem *   ＜環境変数＞
rem *   ログの出力方法は環境変数に設定する。
rem *   ・必ず指定する
rem *     - LOGGER_HANDLER: 出力方法(FILE, CONSOLEのいずれかを指定、未指定の場合は出力しない)
rem *   ・LOGGER_HANDLERにFILEを指定した場合に設定する
rem *     - LOGGER_FILE_OUTPUT: 出力先ファイル
rem *     - LOGGER_FILE_ROTATE: ログファイルのローテート方式(SIZEを設定、未指定の場合はローテートしない)
rem *     - LOGGER_FILE_ROTATE_MAXNUMBER: ローテートのバックアップ世代数の上限
rem *     - LOGGER_FILE_ROTATE_MAXSIZE: ローテート方式にSIZEを指定した場合、最大サイズ(KB)を指定する
rem * 
rem *   ＜戻り値＞
rem *   ・ログ出力した場合、0を返す
rem *   ・ログ出力しなかった場合、1を返す
rem *   ・ログをファイルに出力する際にローテートを失敗した場合、2を返す
rem * 
rem * [引数]
rem *   %1: メッセージ(必須)
rem * 
rem * [バージョン]
rem *   1.0.0
rem ******************************************************************
rem echo LoggerLight.bat %1

rem 利用する外部バッチファイル
set BAT_FILEROTATESIZE="%~dp0\FileRotateSize.bat"
set BAT_ISINTEGER="%~dp0\IsInteger.bat"

set MESSAGE=%~1

rem メッセージ未指定の場合、何もせずに終わる
if not defined MESSAGE (
    endlocal
    exit /b 1
)

set time2=%time: =0%
set LOG_MESSAGE=%date% %time2% %MESSAGE%

if /i "%LOGGER_HANDLER%"=="CONSOLE" (
    echo %LOG_MESSAGE%
    endlocal
    exit /b 0
)
if /i "%LOGGER_HANDLER%"=="FILE" (
    if not defined LOGGER_FILE_OUTPUT (
        endlocal
        exit /b 1
    )
    rem ローテート
    if defined LOGGER_FILE_ROTATE (
        rem ファイルサイズによるローテート
        if /i "%LOGGER_FILE_ROTATE%"=="SIZE" (
            call %BAT_ISINTEGER% %LOGGER_FILE_ROTATE_MAXSIZE%
            if !ERRORLEVEL! neq 0 (
                endlocal
                exit /b 1
            )
            if !LOGGER_FILE_ROTATE_MAXSIZE! lss 1 (
                endlocal
                exit /b 1
            )
            call %BAT_ISINTEGER% %LOGGER_FILE_ROTATE_MAXNUMBER%
            if !ERRORLEVEL! neq 0 (
                endlocal
                exit /b 1
            )
            if !LOGGER_FILE_ROTATE_MAXNUMBER! lss 1 (
                endlocal
                exit /b 1
            )
            rem ローテート処理
            set /a SIZE=%LOGGER_FILE_ROTATE_MAXSIZE%*1024
            call %BAT_FILEROTATESIZE% %LOGGER_FILE_OUTPUT% %LOGGER_FILE_ROTATE_MAXNUMBER% !SIZE!
            if !ERRORLEVEL! neq 0 (
                if !ERRORLEVEL! neq 1 (
                    endlocal
                    exit /b 2
                )
            )
        )
    )
    echo %LOG_MESSAGE%>>"%LOGGER_FILE_OUTPUT%"
    if !ERRORLEVEL! neq 0 (
        endlocal
        exit /b 1
    )
    endlocal
    exit /b 0
)

endlocal
exit /b 1


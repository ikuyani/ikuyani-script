@setlocal enabledelayedexpansion
@echo off

rem ******************************************************************
rem * Logger.bat: ログを出力する
rem *
rem * [説明]
rem *   ＜ログレベル仕様＞
rem *   ・引数に指定したログレベル(%1)が環境変数に設定したログレベル(LOGGER_LEVEL)以上であればログを出力する
rem *   ・指定できるログレベルは下記のものとし、上から順にレベルが高い
rem *      - FATAL
rem *      - ERROR
rem *      - WARN
rem *      - INFO
rem *      - DEBUG
rem *      - TRACE
rem *   ・ログレベルの指定は大小文字の区別はしない
rem * 
rem *   ＜ログ出力方法＞
rem *   ・ログの出力先は環境変数のLOGGER_HANDLERに指定する
rem *     - FILE: 環境変数のLOGGER_FILE_OUTPUTに指定したファイルに出力する
rem *     - CONSOLE: 標準出力する
rem *     - 上記以外: 出力しない
rem * 
rem *   ＜環境変数＞
rem *   ログの出力方法やログレベルは環境変数に設定する。
rem *   ・必ず指定する
rem *     - LOGGER_LEVEL: ログレベル(FATAL, ERROR, WARN, INFO, DEBUG, TRACEのいずれかを指定)
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
rem *   %1: ログレベル(必須)
rem *   %2: メッセージ(必須)
rem * 
rem * [バージョン]
rem *   1.0.0
rem ******************************************************************
rem echo Logger.bat %1

rem 利用する外部バッチファイル
set BAT_LOGGERLIGHT="%~dp0\LoggerLight.bat"

set LEVEL=%1
set MESSAGE=%~2

rem ログレベル未指定の場合、何もせずに終わる
if not defined LEVEL (
    endlocal
    exit /b 1
)

rem メッセージ未指定の場合、何もせずに終わる
if not defined MESSAGE (
    endlocal
    exit /b 1
)

call :GetLevelNumber %LOGGER_LEVEL%
set LOGGER_LEVEL_NUMBER=%ERRORLEVEL%
if %LOGGER_LEVEL_NUMBER% equ 0 (
    endlocal
    exit /b 1
)

call :GetLevelNumber %LEVEL%
set LEVEL_NUMBER=%ERRORLEVEL%
if %LEVEL_NUMBER% equ 0 (
    endlocal
    exit /b 1
)

rem 引数に設定したログレベルが環境変数のログレベル未満の場合、ログを出力しない
if %LEVEL_NUMBER% lss %LOGGER_LEVEL_NUMBER% (
    endlocal
    exit /b 1
)

rem ログメッセージ用ログレベル
if %LEVEL_NUMBER% equ 1 (
    set LOG_MESSAGE=TRACE
)
if %LEVEL_NUMBER% equ 2 (
    set LOG_MESSAGE=DEBUG
)
if %LEVEL_NUMBER% equ 3 (
    set LOG_MESSAGE=INFO
)
if %LEVEL_NUMBER% equ 4 (
    set LOG_MESSAGE=WARN
)
if %LEVEL_NUMBER% equ 5 (
    set LOG_MESSAGE=ERROR
)
if %LEVEL_NUMBER% equ 6 (
    set LOG_MESSAGE=FATAL
)

rem ログ出力
call %BAT_LOGGERLIGHT% "%LOG_MESSAGE% %MESSAGE%"

endlocal
exit /b %ERRORLEVEL%


:GetLevelNumber
setlocal

set LEVEL=%1

if /i "%LEVEL%"=="TRACE" (
    endlocal
    exit /b 1
)
if /i "%LEVEL%"=="DEBUG" (
    endlocal
    exit /b 2
)
if /i "%LEVEL%"=="INFO" (
    endlocal
    exit /b 3
)
if /i "%LEVEL%"=="WARN" (
    endlocal
    exit /b 4
)
if /i "%LEVEL%"=="ERROR" (
    endlocal
    exit /b 5
)
if /i "%LEVEL%"=="FATAL" (
    endlocal
    exit /b 6
)

endlocal
exit /b 0


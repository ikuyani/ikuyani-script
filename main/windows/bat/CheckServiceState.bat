@setlocal enabledelayedexpansion
@echo off

rem ******************************************************************
rem * CheckServiceState.bat: サービスの状態をチェックし、ログに出力する
rem * 
rem * [説明]
rem * 
rem * [引数]
rem *   %1: サービス名
rem *   %2: 出力先ログファイルパス
rem * 
rem * [バージョン]
rem *   1.0.0
rem ******************************************************************
rem echo CheckServiceState.bat %1 %2

call :GetServiceState %1

if not "%SERVICE_STATE%"=="" (
    if not "%SERVICE_STATE%"=="RUNNING" (
        call :Log %2 "[ERROR] %~1 is not RUNNING, state = %SERVICE_STATE%."
    )
) else (
     call :Log %2 "[ERROR] %~1 is not found."
)

endlocal
exit /b


:GetServiceState
rem ******************************************************************
rem * GetServiceState: サービスの状態を取得する
rem * 
rem * [説明]
rem * 
rem * [引数]
rem *   %1: サービス名
rem ******************************************************************
rem echo GetServiceState %1

set SERVICE_STATE_CODE=
set SERVICE_STATE=

for /f "tokens=1,2* delims=:" %%i in ('sc query %1 ^| findstr /c:"STATE"') do (  
    for /f "tokens=1,2* delims= " %%A in ("%%j") do (  
        SET SERVICE_STATE_CODE=%%A
        SET SERVICE_STATE=%%B
        rem echo %SERVICE_STATE_CODE%
        rem echo %SERVICE_STATE%
    )
)

exit /b


rem ******************************************************************
rem * Log: ログを出力する
rem * 
rem * [説明]
rem * 
rem * [引数]
rem *   %1: ログファイルパス
rem *   %2: メッセージ
rem ******************************************************************
:Log
rem echo Log %1 %2

echo %date% %time% %~2 2>&1 >> %1

exit /b

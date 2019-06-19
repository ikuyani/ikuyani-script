@setlocal enabledelayedexpansion
@echo off

rem ******************************************************************
rem * FileBatchProcessing.bat: フォルダ内のファイルに対し一括処理をする
rem *
rem * [説明]
rem *   フォルダ内のファイルに対し任意の処理を一括で実行する。
rem *   任意の処理は別のバッチファイルで作成し、プロパティファイルにパスを記述する。
rem * 
rem *   ＜プロパティファイル＞
rem *   ・本バッチに必要な情報はプロパティファイルに定義する
rem *     - PROCESSING_BATCH_PATH: 対象ファイルに対して実行するバッチファイルのパス
rem *     - DEFAULT_TARGET_DIR: デフォルトの対象フォルダ(引数に未指定の場合に使用)
rem *     - DEFAULT_FILE_PATTERN: デフォルトの対象ファイル名のパターン(引数に未指定の場合に使用)
rem *                             未指定の場合、*が指定される
rem *     - ERROR_CONTINUE: PROCESSING_BATCH_PATHの実行中にエラーとなった場合、次ファイルの継続有無.
rem *                       継続する場合は0以外、継続しない場合は0.
rem *                       未指定の場合、1(継続)が指定される
rem *   ・プロパティファイルの情報は本バッチ実行中は環境変数に設定(上書き)される
rem * 
rem *   ＜戻り値＞
rem *   ・正常に処理できた場合、0を返す
rem *   ・プロパティファイルの読み込みに失敗した場合、1を返す
rem *   ・プロパティファイルの内容が不正の場合、2を返す
rem *   ・ファイルに対し任意の処理を実行するバッチファイルの戻り値が0以外の場合、3を返す
rem *   ・引数が不正の場合、8を返す
rem *   ・その他、予期しないエラーなどの場合、9を返す
rem * 
rem *   ＜任意の処理のバッチファイルでの注意＞
rem *   ・本バッチ実行中に環境変数が設定(上書き)されるため、事前に同一の変数名で設定し、
rem *     指定したバッチファイルでその環境変数を使う場合、上書きされた値が使われる
rem *     - BAT_CREATEDIRECTORY
rem *     - BAT_FILEEXISTS
rem *     - BAT_LOGGERLIGHT
rem *     - BAT_PROPERTIES
rem *     - ERROR_CONTINUE
rem *     - ERRORLEVEL_PROCESSING
rem *     - ERRORLEVEL2
rem *     - DEFAULT_FILE_PATTERN
rem *     - DEFAULT_TARGET_DIR
rem *     - FILE_PATTERN
rem *     - PROCESSING_BATCH_ARGUMENT
rem *     - PROCESSING_BATCH_PATH
rem *     - PROPERTIES_FILE
rem *     - TARGET_DIR
rem * 
rem * [引数]
rem *   %1: プロパティファイルのパス
rem *   %2: 対象フォルダのパス
rem *   %3: 対象のファイル名パターン
rem *   %4: 実行するバッチファイルに渡す引数
rem * 
rem * [バージョン]
rem *   1.0.0
rem ******************************************************************
rem echo FileBatchProcessing.bat %1

rem 利用する外部バッチファイル
set BAT_PROPERTIES="%~dp0\Properties.bat"
set BAT_CREATEDIRECTORY="%~dp0\CreateDirectory.bat"
set BAT_FILEEXISTS="%~dp0\FileExists.bat"
set BAT_LOGGERLIGHT="%~dp0\LoggerLight.bat"

rem プロパティファイルのパス(必須)
set PROPERTIES_FILE=%~1

rem 対象フォルダのパス
set TARGET_DIR=%~2
rem 対象ファイル名のパターン
set FILE_PATTERN=%~3
rem 実行するバッチファイルに渡す引数
set PROCESSING_BATCH_ARGUMENT=%~4

call :Log "---------------------------------------------------------"
call :Log "[Start] 引数チェック"
rem 引数チェック
rem プロパティファイル
if not defined PROPERTIES_FILE (
    call :ErrorLog "引数1[プロパティファイル]が未指定です。処理を終了します。"
    endlocal
    exit /b 8
)

call :Log "[End] 引数チェック"

call :Log "---------------------------------------------------------"
call :Log "[Start] プロパティファイルの読込"
rem プロパティファイルの読込
call %BAT_PROPERTIES% "%PROPERTIES_FILE%"
if %ERRORLEVEL% neq 0 (
    call :ErrorLog "プロパティファイルの読み込みに失敗しました。処理を終了します。"
    endlocal
    exit /b 1
)

rem 対象ファイルに対して実行する外部バッチファイル(必須)
call :Log "PROCESSING_BATCH_PATH=%PROCESSING_BATCH_PATH%"
rem デフォルトの対象フォルダ
call :Log "DEFAULT_TARGET_DIR=%DEFAULT_TARGET_DIR%"
rem デフォルトの対象のファイル名パターン
call :Log "DEFAULT_FILE_PATTERN=%DEFAULT_FILE_PATTERN%"
rem エラー時処理継続の有無(継続する場合は0以外、継続しない場合は0)
call :Log "ERROR_CONTINUE=%ERROR_CONTINUE%"

call :Log "[End] プロパティファイルの読み込み"

call :Log "---------------------------------------------------------"
call :Log "[Start] 実行環境/パラメータ等の検証、設定"
rem 対象ファイルに対して実行する外部バッチファイル(必須)
if not defined PROCESSING_BATCH_PATH (
    call :ErrorLog "プロパティファイルにPROCESSING_BATCH_PATHが未指定です。処理を終了します。"
    endlocal
    exit /b 2
)

rem 対象フォルダ
if not defined TARGET_DIR (
    if defined DEFAULT_TARGET_DIR (
        rem 引数に未指定の場合、デフォルトの対象フォルダを設定する
        set TARGET_DIR=%DEFAULT_TARGET_DIR%

    ) else (
        call :ErrorLog "対象フォルダTARGET_DIRが未指定です。処理を終了します。"
        endlocal
        exit /b 2
    )

    call :Log "対象フォルダTARGET_DIRが未指定のため[!TARGET_DIR!]を設定します。"
)

rem 対象のファイル名パターン
if not defined FILE_PATTERN (

    if defined DEFAULT_FILE_PATTERN (
        rem 引数に未指定の場合、デフォルトのファイルパターンを設定する
        set FILE_PATTERN=%DEFAULT_FILE_PATTERN%

    ) else (
        rem デフォルト値が未指定の場合、全てのファイルを対象とする
        set FILE_PATTERN=*
    )
    call :Log "対象ファイル名のパターンFILE_PATTERNが未指定のため[!FILE_PATTERN!]を設定します。"
)

rem 外部バッチファイルでエラーとなった場合、次ファイルの処理継続有無
if not defined ERROR_CONTINUE (
    rem 未指定の場合、継続とする
    set ERROR_CONTINUE=1
    call :Log "ERROR_CONTINUEが未指定のため[!ERROR_CONTINUE!]を設定します。"
)

call :Log "[End] 実行環境、パラメータ等の検証"

call :Log "---------------------------------------------------------"
call :Log "[Start] 一括処理"
call :PROCESSING
set ERRORLEVEL_PROCESSING=%ERRORLEVEL%
call :Log "[End] 一括処理"

if %ERRORLEVEL_PROCESSING% equ 0 (
    endlocal
    exit /b 0
) else (
    endlocal
    exit /b 3
)


rem ******************************************************************
rem * PROCESSING: 一括処理
rem * 
rem * [説明]
rem *   Break実装のため関数化する
rem * 
rem *   ＜戻り値＞
rem *   ・正常に処理できた場合、0を返す
rem *   ・ファイルに対し任意の処理を実行するバッチファイルの戻り値が0以外で
rem *     - 処理を継続する場合、3を返す
rem *     - 処理を中断する場合、バッチファイルの戻り値を返す
rem *   
rem * [引数]
rem *   
rem ******************************************************************
:PROCESSING
set ERRORLEVEL2=0
for %%f in ("%TARGET_DIR%\%FILE_PATTERN%") do (
    call %BAT_FILEEXISTS% %PROCESSING_BATCH_PATH%
    if !ERRORLEVEL! equ 0 (
        rem ファイルに対し任意の処理を実行する
        call %PROCESSING_BATCH_PATH% "%%f" %PROCESSING_BATCH_ARGUMENT%
        if !ERRORLEVEL! neq 0 (
            rem バッチファイルの戻り値が0以外
            if %ERROR_CONTINUE% equ 0 (
                rem 中断する
                set ERRORLEVEL2=!ERRORLEVEL!
                call :ErrorLog "%%fの処理中にエラー[!ERRORLEVEL!]が発生したため、処理を中断します。"
                exit /b !ERRORLEVEL2!
            ) else (
                rem 継続する
                set ERRORLEVEL2=3
                call :ErrorLog "%%fの処理中にエラー[!ERRORLEVEL!]が発生しましたが、処理を継続します。"
            )
        )
    )
)

exit /b %ERRORLEVEL2%

rem ******************************************************************
rem * Log: メッセージの出力処理
rem * 
rem * [説明]
rem *   自由にメッセージの出力処理を実装してください。
rem * 
rem * [引数]
rem *   %1: メッセージ
rem ******************************************************************
:Log

call %BAT_LOGGERLIGHT% %1

exit /b

rem ******************************************************************
rem * ErrorLog: エラーメッセージの出力処理
rem * 
rem * [説明]
rem *   自由にエラーメッセージの出力処理を実装してください。
rem * 
rem * [引数]
rem *   %1: エラーメッセージ
rem ******************************************************************
:ErrorLog

call %BAT_LOGGERLIGHT% "[ERROR] %~1"

exit /b

@setlocal
@echo off

rem ******************************************************************
rem * AssertNull.bat: 
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
rem * [引数]
rem *   %1: プロパティファイルのパス
rem * 
rem * [バージョン]
rem *   1.0
rem ******************************************************************
rem echo Properties.bat %1

set TEST_NAME=%~1
set ACTUAL=%2

if defined ACTUAL (
    echo Failed %TEST_NAME%, Actual=%ACTUAL%.
    endlocal
    exit /b 1
)

echo Successful %TEST_NAME%.

endlocal
exit /b 0

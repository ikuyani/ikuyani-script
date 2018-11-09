@setlocal
@echo off

call "%~dp0\test-config.bat"

rem テスト対象
set TEST_TARGET_PATH=%TEST_BAT_DIR%\Properties.bat
rem テストに必要なファイルのフォルダ
set TEST_APP_DIR=%TEST_HOME_DIR%\Properties\

rem 正常系
call %TEST_TARGET_PATH% %TEST_APP_DIR%\test.properties
call %TEST_ASSERT_EQUALS% "TEST1" 0 %ERRORLEVEL%

rem 通常
call %TEST_ASSERT_EQUALS% "TEST1-1" VALUE1 %PROP1%

rem プロパティ名に空白を含めることはできない
call %TEST_ASSERT_NULL% "TEST1-2" %PROP2%

rem プロパティ名、値の前後の空白は除去される
rem プロパティ名
call %TEST_ASSERT_EQUALS% "TEST1-3-1" VALUE3_1 %PROP3_1%
rem 値
call %TEST_ASSERT_EQUALS% "TEST1-3-2" "VALUE3_2" "%PROP3_2%"

rem 値に空白を含めるには " で値を囲む(本処理中に囲い文字の除去はしない)
call %TEST_ASSERT_EQUALS% "TEST1-4" "VA LU E4" %PROP4%

rem 行の先頭に # がある場合、コメント行とする
call %TEST_ASSERT_NULL% "TEST1-5" %PROP5%

rem 空行は無視される
rem エラーとならない

rem プロパティ名がない場合、無視される
rem エラーとならない

rem 値が空の場合、環境変数は未設定となる
call %TEST_ASSERT_NULL% "TEST1-8" %PROP8%

rem 異常系
rem NULL
call %TEST_TARGET_PATH% 
call %TEST_ASSERT_EQUALS% "TEST2" 9 %ERRORLEVEL%
rem プロパティファイルが存在しない
call %TEST_TARGET_PATH% %TEST_APP_DIR%\NotExists.properties
call %TEST_ASSERT_EQUALS% "TEST3" 9 %ERRORLEVEL%

endlocal
pause

exit /b

@setlocal
@echo off

call env.bat

rem テスト対象
set TEST_TARGET_PATH=%TEST_BAT_DIR%\Properties.bat
rem テストに必要なファイルのフォルダ
set TEST_APP_DIR=%TEST_HOME_DIR%\Properties\

echo %TEST_APP_DIR%

call %TEST_TARGET_PATH% %TEST_APP_DIR%\test.properties

rem TEST 1 通常
rem echo TEST 1 %PROP1%
call %TEST_ASSERT_EQUALS% "TEST 1" VALUE1 %PROP1%

rem TEST 2 プロパティ名に空白を含めることはできない
rem echo TEST 2 %PROP2%
call %TEST_ASSERT_NULL% "TEST 2" %PROP2%

rem TEST 3 プロパティ名、値の前後の空白は除去される
rem プロパティ名
rem echo TEST 3_1 %PROP3_1%
call %TEST_ASSERT_EQUALS% "TEST 3_1" VALUE3_1 %PROP3_1%
rem 値
rem echo TEST 3_2 %PROP3_2%
call %TEST_ASSERT_EQUALS% "TEST 3_2" "VALUE3_2" "%PROP3_2%"

rem TEST 4 値に空白を含めるには " で値を囲む(本処理中に囲い文字の除去はしない)
rem echo TEST 4 %PROP4%
call %TEST_ASSERT_EQUALS% "TEST 4" "VA LU E4" %PROP4%

rem TEST 5 行の先頭に # がある場合、コメント行とする
rem echo TEST 5 %PROP5%
call %TEST_ASSERT_NULL% "TEST 5" %PROP5%

rem TEST 6 空行は無視される
rem エラーとならない

rem TEST 7 プロパティ名がない場合、無視される
rem エラーとならない

rem TEST 8 値が空の場合、環境変数は未設定となる
rem echo TEST 8 %PROP8%
call %TEST_ASSERT_NULL% "TEST 8" %PROP8%

endlocal
pause

exit /b

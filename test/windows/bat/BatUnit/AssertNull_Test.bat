@setlocal
@echo off

rem 上位フォルダにあるBatUnit_Testから実行してください

set TEST_NULL=
set TEST_NOTNULL=AAA

rem 成功
call %TEST_ASSERT_NULL% AssertNull-Successful %TEST_NULL%
if not %ERRORLEVEL% equ 0 (
    echo AssertNull-Successful is invalid, return-code[%ERRORLEVEL%].
)

rem 失敗
call %TEST_ASSERT_NULL% AssertNull-Failed %TEST_NOTNULL%
if not %ERRORLEVEL% equ 1 (
    echo AssertNull-Successful is invalid, return-code[%ERRORLEVEL%].
)

endlocal

exit /b

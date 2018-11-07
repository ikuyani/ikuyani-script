@setlocal
@echo off

rem 上位フォルダにあるBatUnit_Testから実行してください

set TEST_NULL=

rem 成功
call %TEST_ASSERT_EQUALS% AssertEquals-Successful-1 1 1
if not %ERRORLEVEL% equ 0 (
    echo AssertEquals-Successful-1 is invalid, return-code[%ERRORLEVEL%].
)

call %TEST_ASSERT_EQUALS% AssertEquals-Successful-2 aaa aaa
if not %ERRORLEVEL% equ 0 (
    echo AssertEquals-Successful-2 is invalid, return-code[%ERRORLEVEL%].
)

call %TEST_ASSERT_EQUALS% AssertEquals-Successful-3 %TEST_NULL% %TEST_NULL%
if not %ERRORLEVEL% equ 0 (
    echo AssertEquals-Successful-3 is invalid, return-code[%ERRORLEVEL%].
)

rem 失敗
call %TEST_ASSERT_EQUALS% AssertEquals-Failed-1 %TEST_NOTNULL% 1 2
if not %ERRORLEVEL% equ 1 (
    echo AssertEquals-Failed-1 is invalid, return-code[%ERRORLEVEL%].
)

call %TEST_ASSERT_EQUALS% AssertEquals-Failed-2 %TEST_NOTNULL% aaa bbb
if not %ERRORLEVEL% equ 1 (
    echo AssertEquals-Failed-2 is invalid, return-code[%ERRORLEVEL%].
)

call %TEST_ASSERT_EQUALS% AssertEquals-Failed-3 %TEST_NOTNULL% %TEST_NULL% bbb
if not %ERRORLEVEL% equ 1 (
    echo AssertEquals-Failed-3 is invalid, return-code[%ERRORLEVEL%].
)

call %TEST_ASSERT_EQUALS% AssertEquals-Failed-4 %TEST_NOTNULL% aaa %TEST_NULL%
if not %ERRORLEVEL% equ 1 (
    echo AssertEquals-Failed-4 is invalid, return-code[%ERRORLEVEL%].
)

endlocal

exit /b

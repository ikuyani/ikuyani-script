@setlocal
@echo off

rem ��ʃt�H���_�ɂ���BatUnit_Test������s���Ă�������

set TEST_NULL=
set TEST_NOTNULL=AAA

rem ����
call %TEST_ASSERT_NULL% AssertNull-Successful %TEST_NULL%
if not %ERRORLEVEL% equ 0 (
    echo AssertNull-Successful is invalid, return-code[%ERRORLEVEL%].
)

rem ���s
call %TEST_ASSERT_NULL% AssertNull-Failed %TEST_NOTNULL%
if not %ERRORLEVEL% equ 1 (
    echo AssertNull-Successful is invalid, return-code[%ERRORLEVEL%].
)

endlocal

exit /b

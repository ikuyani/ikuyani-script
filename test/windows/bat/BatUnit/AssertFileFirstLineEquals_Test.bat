@setlocal
@echo off

rem ��ʃt�H���_�ɂ���BatUnit_Test������s���Ă�������

rem ��v����(�󔒖���)
set time2=%time: =0%
set FILE_PATH=%TEST_TEMP_DIR%\AssertFileFirstLineEquals_Test.%date:~0,4%%date:~5,2%%date:~8,2%%time2:~0,2%%time2:~3,2%%time2:~6,2%%time2:~9,2%
echo tests1> %FILE_PATH%
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% AssertFileFirstLineEquals-Successful-1 tests1 %FILE_PATH% 
if %ERRORLEVEL% neq 0 (
    echo AssertFileFirstLineEquals-Successful-1 is invalid, return-code[%ERRORLEVEL%].
)
del %FILE_PATH%

rem ��v����(�󔒂���)
set time2=%time: =0%
set FILE_PATH=%TEST_TEMP_DIR%\AssertFileFirstLineEquals_Test.%date:~0,4%%date:~5,2%%date:~8,2%%time2:~0,2%%time2:~3,2%%time2:~6,2%%time2:~9,2%
echo test s2> %FILE_PATH%
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% AssertFileFirstLineEquals-Successful-2 "test s2" %FILE_PATH%
if %ERRORLEVEL% neq 0 (
    echo AssertFileFirstLineEquals-Successful-2 is invalid, return-code[%ERRORLEVEL%].
)
del %FILE_PATH%

rem ��v���Ȃ�
set time2=%time: =0%
set FILE_PATH=%TEST_TEMP_DIR%\AssertFileFirstLineEquals_Test.%date:~0,4%%date:~5,2%%date:~8,2%%time2:~0,2%%time2:~3,2%%time2:~6,2%%time2:~9,2%
echo aaa> %FILE_PATH%
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% AssertFileFirstLineEquals-Failed-1 testf1 %FILE_PATH%
if %ERRORLEVEL% neq 1 (
    echo AssertFileFirstLineEquals-Failed-1 is invalid, return-code[%ERRORLEVEL%].
)
del %FILE_PATH%

rem ���݂��Ȃ�
set time2=%time: =0%
set FILE_PATH=%TEST_TEMP_DIR%\AssertFileFirstLineEquals_Test.%date:~0,4%%date:~5,2%%date:~8,2%%time2:~0,2%%time2:~3,2%%time2:~6,2%%time2:~9,2%
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% AssertFileFirstLineEquals-Failed-2 testf2 %FILE_PATH%
if %ERRORLEVEL% neq 1 (
    echo AssertFileFirstLineEquals-Failed-2 is invalid, return-code[%ERRORLEVEL%].
)

rem �t�H���_
set time2=%time: =0%
set FILE_PATH=%TEST_TEMP_DIR%\AssertFileFirstLineEquals_Test.%date:~0,4%%date:~5,2%%date:~8,2%%time2:~0,2%%time2:~3,2%%time2:~6,2%%time2:~9,2%
mkdir %FILE_PATH%
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% AssertFileFirstLineEquals-Failed-3 testf3 %FILE_PATH%
if %ERRORLEVEL% neq 1 (
    echo AssertFileFirstLineEquals-Failed-3 is invalid, return-code[%ERRORLEVEL%].
)
rd %FILE_PATH%

rem �ُ�n
rem NULL
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% AssertFileFirstLineEquals-Error-1
if %ERRORLEVEL% neq 9 (
    echo AssertFileFirstLineEquals-Error-1 is invalid, return-code[%ERRORLEVEL%].
)

endlocal

exit /b

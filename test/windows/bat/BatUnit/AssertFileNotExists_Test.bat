@setlocal
@echo off

rem ��ʃt�H���_�ɂ���BatUnit_Test������s���Ă�������

rem ���݂��Ȃ�
set time2=%time: =0%
set FILE_PATH=%TEST_TEMP_DIR%\AssertFileNotExists_Test.%date:~0,4%%date:~5,2%%date:~8,2%%time2:~0,2%%time2:~3,2%%time2:~6,2%%time2:~9,2%
call %TEST_ASSERT_FILE_NOT_EXISTS% AssertFileNotExists-Successful %FILE_PATH%
if %ERRORLEVEL% neq 0 (
    echo AssertFileNotExists-Successful is invalid, return-code[%ERRORLEVEL%].
)

rem �t�@�C�������݂���
set time2=%time: =0%
set FILE_PATH=%TEST_TEMP_DIR%\AssertFileNotExists_Test.%date:~0,4%%date:~5,2%%date:~8,2%%time2:~0,2%%time2:~3,2%%time2:~6,2%%time2:~9,2%
echo test > %FILE_PATH%
call %TEST_ASSERT_FILE_NOT_EXISTS% AssertFileNotExists-Failed-1 %FILE_PATH%
if %ERRORLEVEL% neq 1 (
    echo AssertFileNotExists-Failed-1 is invalid, return-code[%ERRORLEVEL%].
)
del %FILE_PATH%

rem �t�H���_�����݂���
set time2=%time: =0%
set FILE_PATH=%TEST_TEMP_DIR%\AssertFileNotExists_Test.%date:~0,4%%date:~5,2%%date:~8,2%%time2:~0,2%%time2:~3,2%%time2:~6,2%%time2:~9,2%
mkdir %FILE_PATH%
call %TEST_ASSERT_FILE_NOT_EXISTS% AssertFileNotExists-Failed-2 %FILE_PATH%
if %ERRORLEVEL% neq 1 (
    echo AssertFileNotExists-Failed-2 is invalid, return-code[%ERRORLEVEL%].
)
rd %FILE_PATH%

rem �ُ�n
rem NULL
call %TEST_ASSERT_FILE_NOT_EXISTS% AssertFileNotExists_Test-Error-1
if %ERRORLEVEL% neq 9 (
    echo AssertFileNotExists_Test-Error-1 is invalid, return-code[%ERRORLEVEL%].
)

endlocal

exit /b

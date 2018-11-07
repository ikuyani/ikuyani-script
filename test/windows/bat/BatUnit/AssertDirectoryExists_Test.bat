@setlocal
@echo off

rem ��ʃt�H���_�ɂ���BatUnit_Test������s���Ă�������

rem ���݂���
set time2=%time: =0%
set FILE_PATH=%TEST_TEMP_DIR%\AssertDirectoryExists_Test%date:~0,4%%date:~5,2%%date:~8,2%%time2:~0,2%%time2:~3,2%%time2:~6,2%%time2:~9,2%
mkdir %FILE_PATH%
call %TEST_ASSERT_DIRECTORY_EXISTS% AssertDirectoryExists-Successful %FILE_PATH%
if not %ERRORLEVEL% equ 0 (
    echo AssertDirectoryExists-Successful is invalid, return-code[%ERRORLEVEL%].
)
rd %FILE_PATH%

rem ���݂��Ȃ�
set time2=%time: =0%
set FILE_PATH=%TEST_TEMP_DIR%\AssertDirectoryExists_Test%date:~0,4%%date:~5,2%%date:~8,2%%time2:~0,2%%time2:~3,2%%time2:~6,2%%time2:~9,2%
call %TEST_ASSERT_DIRECTORY_EXISTS% AssertDirectoryExists-Failed-1 %FILE_PATH%
if not %ERRORLEVEL% equ 1 (
    echo AssertDirectoryExists-Failed-1 is invalid, return-code[%ERRORLEVEL%].
)

rem ���݂��邪�t�@�C��
set time2=%time: =0%
set FILE_PATH=%TEST_TEMP_DIR%\AssertDirectoryExists_Test%date:~0,4%%date:~5,2%%date:~8,2%%time2:~0,2%%time2:~3,2%%time2:~6,2%%time2:~9,2%
echo test > %FILE_PATH%
call %TEST_ASSERT_DIRECTORY_EXISTS% AssertDirectoryExists-Failed-2 %FILE_PATH%
if not %ERRORLEVEL% equ 1 (
    echo AssertDirectoryExists-Failed-2 is invalid, return-code[%ERRORLEVEL%].
)
del %FILE_PATH%

rem �ُ�n
rem NULL
call %TEST_ASSERT_DIRECTORY_EXISTS% AssertDirectoryExists-Error-1
if not %ERRORLEVEL% equ 9 (
    echo AssertDirectoryExists-Error-1 is invalid, return-code[%ERRORLEVEL%].
)

endlocal
exit /b

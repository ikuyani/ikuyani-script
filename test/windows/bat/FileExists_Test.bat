@setlocal
@echo off

call env.bat

rem �e�X�g�Ώ�
set TEST_TARGET_PATH=%TEST_BAT_DIR%\FileExists.bat

rem �t�@�C���̏ꍇ�A0��Ԃ�
rem ���݂���
set time2=%time: =0%
set FILE_PATH=%TEST_TEMP_DIR%\FileExists_Test.%date:~0,4%%date:~5,2%%date:~8,2%%time2:~0,2%%time2:~3,2%%time2:~6,2%%time2:~9,2%
echo test > %FILE_PATH%
call %TEST_TARGET_PATH% %FILE_PATH%
call %TEST_ASSERT_EQUALS% TEST1 0 %ERRORLEVEL%
del %FILE_PATH%

rem �t�H���_�ȊO�̏ꍇ�A1��Ԃ�
rem NULL
set FILE_PATH=
call %TEST_TARGET_PATH% %FILE_PATH%
call %TEST_ASSERT_EQUALS% TEST2 1 %ERRORLEVEL%

rem ���݂��Ȃ�
set time2=%time: =0%
set FILE_PATH=%TEST_TEMP_DIR%\FileExists_Test.%date:~0,4%%date:~5,2%%date:~8,2%%time2:~0,2%%time2:~3,2%%time2:~6,2%%time2:~9,2%
call %TEST_TARGET_PATH% %FILE_PATH%
call %TEST_ASSERT_EQUALS% TEST3 1 %ERRORLEVEL%

rem ���݂��邪�t�H���_
set time2=%time: =0%
set FILE_PATH=%TEST_TEMP_DIR%\FileExists_Test.%date:~0,4%%date:~5,2%%date:~8,2%%time2:~0,2%%time2:~3,2%%time2:~6,2%%time2:~9,2%
mkdir %FILE_PATH%
call %TEST_TARGET_PATH% %FILE_PATH%
call %TEST_ASSERT_EQUALS% TEST4 1 %ERRORLEVEL%
rd %FILE_PATH%

endlocal
pause

exit /b

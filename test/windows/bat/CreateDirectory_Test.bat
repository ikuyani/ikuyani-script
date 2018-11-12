@setlocal
@echo off

call "%~dp0\test-config.bat"

rem �e�X�g�Ώ�
set TEST_TARGET_PATH=%TEST_BAT_DIR%\CreateDirectory.bat

rem �e���|����
set time2=%time: =0%
set TEST_TEMP_DIR_2=%TEST_TEMP_DIR%\CreateDirectory_Test%date:~0,4%%date:~5,2%%date:~8,2%%time2:~0,2%%time2:~3,2%%time2:~6,2%%time2:~9,2%

rem TEST1 ����ɍ쐬�ł����ꍇ�A0��Ԃ�
set TEST_DIR_PATH=%TEST_TEMP_DIR_2%\TEST1_1\
call %TEST_TARGET_PATH% %TEST_DIR_PATH%
call %TEST_ASSERT_EQUALS% TEST1_1 0 %ERRORLEVEL%
call %TEST_ASSERT_DIRECTORY_EXISTS% TEST1_1 %TEST_DIR_PATH%

set TEST_DIR_PATH=%TEST_TEMP_DIR_2%\TEST1_2\aaa\
call %TEST_TARGET_PATH% %TEST_DIR_PATH%
call %TEST_ASSERT_EQUALS% TEST1_2 0 %ERRORLEVEL%
call %TEST_ASSERT_DIRECTORY_EXISTS% TEST1_2 %TEST_DIR_PATH%

rem TEST2 ���łɃt�H���_�����݂���ꍇ�A1��Ԃ�
set TEST_DIR_PATH=%TEST_TEMP_DIR_2%\TEST2\
mkdir %TEST_DIR_PATH%
call %TEST_TARGET_PATH% %TEST_DIR_PATH%
call %TEST_ASSERT_EQUALS% TEST2 1 %ERRORLEVEL%

rem TEST3 ����p�X�Ƀt�H���_�ȊO�����łɑ��݂���ꍇ�A2��Ԃ�
set TEST_DIR_PATH=%TEST_TEMP_DIR_2%\TEST3
echo test > %TEST_DIR_PATH%
call %TEST_TARGET_PATH% %TEST_DIR_PATH%
call %TEST_ASSERT_EQUALS% TEST3 2 %ERRORLEVEL%

rem �ُ�n
rem TEST4 NULL
set TEST_DIR_PATH=
call %TEST_TARGET_PATH% %TEST_DIR_PATH%
call %TEST_ASSERT_EQUALS% TEST4 8 %ERRORLEVEL%

rd /s /q %TEST_TEMP_DIR_2%

endlocal
pause

exit /b

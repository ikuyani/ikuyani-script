@setlocal
@echo off

call "%~dp0\test-config.bat"

rem テスト対象
set TEST_TARGET_PATH=%TEST_BAT_DIR%\CreateDirectory.bat

rem テンポラリ
set time2=%time: =0%
set TEST_TEMP_DIR_2=%TEST_TEMP_DIR%\CreateDirectory_Test%date:~0,4%%date:~5,2%%date:~8,2%%time2:~0,2%%time2:~3,2%%time2:~6,2%%time2:~9,2%

rem TEST1 正常に作成できた場合、0を返す
set TEST_DIR_PATH=%TEST_TEMP_DIR_2%\TEST1_1\
call %TEST_TARGET_PATH% %TEST_DIR_PATH%
call %TEST_ASSERT_EQUALS% TEST1_1 0 %ERRORLEVEL%
call %TEST_ASSERT_DIRECTORY_EXISTS% TEST1_1 %TEST_DIR_PATH%

set TEST_DIR_PATH=%TEST_TEMP_DIR_2%\TEST1_2\aaa\
call %TEST_TARGET_PATH% %TEST_DIR_PATH%
call %TEST_ASSERT_EQUALS% TEST1_2 0 %ERRORLEVEL%
call %TEST_ASSERT_DIRECTORY_EXISTS% TEST1_2 %TEST_DIR_PATH%

rem TEST2 すでにフォルダが存在する場合、1を返す
set TEST_DIR_PATH=%TEST_TEMP_DIR_2%\TEST2\
mkdir %TEST_DIR_PATH%
call %TEST_TARGET_PATH% %TEST_DIR_PATH%
call %TEST_ASSERT_EQUALS% TEST2 1 %ERRORLEVEL%

rem TEST3 同一パスにフォルダ以外がすでに存在する場合、2を返す
set TEST_DIR_PATH=%TEST_TEMP_DIR_2%\TEST3
echo test > %TEST_DIR_PATH%
call %TEST_TARGET_PATH% %TEST_DIR_PATH%
call %TEST_ASSERT_EQUALS% TEST3 2 %ERRORLEVEL%

rem 異常系
rem TEST4 NULL
set TEST_DIR_PATH=
call %TEST_TARGET_PATH% %TEST_DIR_PATH%
call %TEST_ASSERT_EQUALS% TEST4 8 %ERRORLEVEL%

rd /s /q %TEST_TEMP_DIR_2%

endlocal
pause

exit /b

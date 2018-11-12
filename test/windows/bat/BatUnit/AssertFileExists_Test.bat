@setlocal
@echo off

rem 上位フォルダにあるBatUnit_Testから実行してください

rem 存在する
set time2=%time: =0%
set FILE_PATH=%TEST_TEMP_DIR%\AssertFileExists_Test.%date:~0,4%%date:~5,2%%date:~8,2%%time2:~0,2%%time2:~3,2%%time2:~6,2%%time2:~9,2%
echo test > %FILE_PATH%
call %TEST_ASSERT_FILE_EXISTS% AssertFileExists-Successful %FILE_PATH%
if %ERRORLEVEL% neq 0 (
    echo AssertFileExists-Successful is invalid, return-code[%ERRORLEVEL%].
)
del %FILE_PATH%

rem 存在しない
set time2=%time: =0%
set FILE_PATH=%TEST_TEMP_DIR%\AssertFileExists_Test.%date:~0,4%%date:~5,2%%date:~8,2%%time2:~0,2%%time2:~3,2%%time2:~6,2%%time2:~9,2%
call %TEST_ASSERT_FILE_EXISTS% AssertFileExists-Failed-1 %FILE_PATH%
if %ERRORLEVEL% neq 1 (
    echo AssertFileExists-Failed-1 is invalid, return-code[%ERRORLEVEL%].
)

rem 存在するがフォルダ
set time2=%time: =0%
set FILE_PATH=%TEST_TEMP_DIR%\AssertFileExists_Test.%date:~0,4%%date:~5,2%%date:~8,2%%time2:~0,2%%time2:~3,2%%time2:~6,2%%time2:~9,2%
mkdir %FILE_PATH%
call %TEST_ASSERT_FILE_EXISTS% AssertFileExists-Failed-2 %FILE_PATH%
if %ERRORLEVEL% neq 1 (
    echo AssertFileExists-Failed-2 is invalid, return-code[%ERRORLEVEL%].
)
rd %FILE_PATH%

rem 異常系
rem NULL
call %TEST_ASSERT_FILE_EXISTS% AssertFileExists-Error-1
if %ERRORLEVEL% neq 9 (
    echo AssertFileExists-Error-1 is invalid, return-code[%ERRORLEVEL%].
)

endlocal

exit /b

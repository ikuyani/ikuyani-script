@setlocal
@echo off

call "%~dp0\test-config.bat"

rem テスト対象
set TEST_TARGET_PATH=%TEST_BAT_DIR%\FileRotate.bat

rem TEST1 ファイルのローテート(削除無し) 
set TESTNO=TEST1
set time2=%time: =0%
set TEST_TEMP_DIR_2=%TEST_TEMP_DIR%\FileRotate_Test_%TESTNO%_%date:~0,4%%date:~5,2%%date:~8,2%%time2:~0,2%%time2:~3,2%%time2:~6,2%%time2:~9,2%
mkdir "%TEST_TEMP_DIR_2%"
set FILE_PATH=%TEST_TEMP_DIR_2%\hoge.txt
echo test1> "%FILE_PATH%"
echo test2> "%FILE_PATH%.1"
echo test3> "%FILE_PATH%.2"
call %TEST_TARGET_PATH% "%FILE_PATH%" 5
call %TEST_ASSERT_EQUALS% %TESTNO% 0 %ERRORLEVEL%
call %TEST_ASSERT_FILE_NOT_EXISTS% %TESTNO%_1 "%FILE_PATH%"
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO%_2 test1 "%FILE_PATH%.1"
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO%_3 test2 "%FILE_PATH%.2"
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO%_4 test3 "%FILE_PATH%.3"
call %TEST_ASSERT_FILE_NOT_EXISTS% %TESTNO%_5 "%FILE_PATH%.4"
call %TEST_ASSERT_FILE_NOT_EXISTS% %TESTNO%_6 "%FILE_PATH%.5"
call %TEST_ASSERT_FILE_NOT_EXISTS% %TESTNO%_7 "%FILE_PATH%.6"
rd /s /q "%TEST_TEMP_DIR_2%"

rem TEST2 ファイルのローテート(削除あり)
set TESTNO=TEST2
set time2=%time: =0%
set TEST_TEMP_DIR_2=%TEST_TEMP_DIR%\FileRotate_Test_%TESTNO%_%date:~0,4%%date:~5,2%%date:~8,2%%time2:~0,2%%time2:~3,2%%time2:~6,2%%time2:~9,2%
mkdir "%TEST_TEMP_DIR_2%"
set FILE_PATH=%TEST_TEMP_DIR_2%\hoge.txt
echo test1> "%FILE_PATH%"
echo test2> "%FILE_PATH%.1"
echo test3> "%FILE_PATH%.2"
echo test4> "%FILE_PATH%.3"
echo test5> "%FILE_PATH%.4"
echo test6> "%FILE_PATH%.5"
call %TEST_TARGET_PATH% "%FILE_PATH%" 5
call %TEST_ASSERT_EQUALS% %TESTNO% 0 %ERRORLEVEL%
call %TEST_ASSERT_FILE_NOT_EXISTS% %TESTNO%_1 "%FILE_PATH%"
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO%_2 test1 "%FILE_PATH%.1"
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO%_3 test2 "%FILE_PATH%.2"
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO%_4 test3 "%FILE_PATH%.3"
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO%_5 test4 "%FILE_PATH%.4"
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO%_6 test5 "%FILE_PATH%.5"
call %TEST_ASSERT_FILE_NOT_EXISTS% %TESTNO%_7 "%FILE_PATH%.6"
rd /s /q "%TEST_TEMP_DIR_2%"

rem TEST3 ローテートするファイルが存在しない
set TESTNO=TEST3
set time2=%time: =0%
set TEST_TEMP_DIR_2=%TEST_TEMP_DIR%\FileRotate_Test_%TESTNO%_%date:~0,4%%date:~5,2%%date:~8,2%%time2:~0,2%%time2:~3,2%%time2:~6,2%%time2:~9,2%
mkdir "%TEST_TEMP_DIR_2%"
set FILE_PATH=%TEST_TEMP_DIR_2%\hoge.txt
echo test2> "%FILE_PATH%.1"
echo test3> "%FILE_PATH%.2"
echo test4> "%FILE_PATH%.3"
echo test5> "%FILE_PATH%.4"
call %TEST_TARGET_PATH% "%FILE_PATH%" 5
call %TEST_ASSERT_EQUALS% %TESTNO% 1 %ERRORLEVEL%
call %TEST_ASSERT_FILE_NOT_EXISTS% %TESTNO%_1 "%FILE_PATH%"
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO%_2 test2 "%FILE_PATH%.1"
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO%_3 test3 "%FILE_PATH%.2"
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO%_4 test4 "%FILE_PATH%.3"
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO%_5 test5 "%FILE_PATH%.4"
call %TEST_ASSERT_FILE_NOT_EXISTS% %TESTNO%_6 "%FILE_PATH%.5"
rd /s /q "%TEST_TEMP_DIR_2%"

rem TEST4 バックアップ世代数が0
set TESTNO=TEST4
set time2=%time: =0%
set TEST_TEMP_DIR_2=%TEST_TEMP_DIR%\FileRotate_Test_%TESTNO%_%date:~0,4%%date:~5,2%%date:~8,2%%time2:~0,2%%time2:~3,2%%time2:~6,2%%time2:~9,2%
mkdir "%TEST_TEMP_DIR_2%"
set FILE_PATH=%TEST_TEMP_DIR_2%\hoge.txt
echo test1> "%FILE_PATH%"
echo test2> "%FILE_PATH%.1"
echo test3> "%FILE_PATH%.2"
echo test4> "%FILE_PATH%.3"
call %TEST_TARGET_PATH% "%FILE_PATH%" 0
call %TEST_ASSERT_EQUALS% %TESTNO% 8 %ERRORLEVEL%
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO%_1 test1 "%FILE_PATH%"
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO%_2 test2 "%FILE_PATH%.1"
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO%_3 test3 "%FILE_PATH%.2"
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO%_4 test4 "%FILE_PATH%.3"
call %TEST_ASSERT_FILE_NOT_EXISTS% %TESTNO%_5 "%FILE_PATH%.4"
rd /s /q "%TEST_TEMP_DIR_2%"

rem TEST5 バックアップ世代数がマイナス値
set TESTNO=TEST5
set time2=%time: =0%
set TEST_TEMP_DIR_2=%TEST_TEMP_DIR%\FileRotate_Test_%TESTNO%_%date:~0,4%%date:~5,2%%date:~8,2%%time2:~0,2%%time2:~3,2%%time2:~6,2%%time2:~9,2%
mkdir "%TEST_TEMP_DIR_2%"
set FILE_PATH=%TEST_TEMP_DIR_2%\hoge.txt
echo test1> "%FILE_PATH%"
echo test2> "%FILE_PATH%.1"
echo test3> "%FILE_PATH%.2"
echo test4> "%FILE_PATH%.3"
call %TEST_TARGET_PATH% "%FILE_PATH%" -5
call %TEST_ASSERT_EQUALS% %TESTNO% 8 %ERRORLEVEL%
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO%_1 test1 "%FILE_PATH%"
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO%_2 test2 "%FILE_PATH%.1"
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO%_3 test3 "%FILE_PATH%.2"
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO%_4 test4 "%FILE_PATH%.3"
call %TEST_ASSERT_FILE_NOT_EXISTS% %TESTNO%_5 "%FILE_PATH%.4"
rd /s /q "%TEST_TEMP_DIR_2%"

rem TEST6 バックアップ世代数が数字以外
set TESTNO=TEST6
set time2=%time: =0%
set TEST_TEMP_DIR_2=%TEST_TEMP_DIR%\FileRotate_Test_%TESTNO%_%date:~0,4%%date:~5,2%%date:~8,2%%time2:~0,2%%time2:~3,2%%time2:~6,2%%time2:~9,2%
mkdir "%TEST_TEMP_DIR_2%"
set FILE_PATH=%TEST_TEMP_DIR_2%\hoge.txt
echo test1> "%FILE_PATH%"
echo test2> "%FILE_PATH%.1"
echo test3> "%FILE_PATH%.2"
echo test4> "%FILE_PATH%.3"
call %TEST_TARGET_PATH% "%FILE_PATH%" a
call %TEST_ASSERT_EQUALS% %TESTNO% 8 %ERRORLEVEL%
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO%_1 test1 "%FILE_PATH%"
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO%_2 test2 "%FILE_PATH%.1"
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO%_3 test3 "%FILE_PATH%.2"
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO%_4 test4 "%FILE_PATH%.3"
call %TEST_ASSERT_FILE_NOT_EXISTS% %TESTNO%_5 "%FILE_PATH%.4"
rd /s /q "%TEST_TEMP_DIR_2%"

rem TEST7 ファイルパスがNULL 
set TESTNO=TEST7
set time2=%time: =0%
set TEST_TEMP_DIR_2=%TEST_TEMP_DIR%\FileRotate_Test_%TESTNO%_%date:~0,4%%date:~5,2%%date:~8,2%%time2:~0,2%%time2:~3,2%%time2:~6,2%%time2:~9,2%
mkdir "%TEST_TEMP_DIR_2%"
set FILE_PATH=%TEST_TEMP_DIR_2%\hoge.txt
echo test1> "%FILE_PATH%"
echo test2> "%FILE_PATH%.1"
echo test3> "%FILE_PATH%.2"
echo test4> "%FILE_PATH%.3"
call %TEST_TARGET_PATH% "" 5
call %TEST_ASSERT_EQUALS% %TESTNO% 8 %ERRORLEVEL%
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO%_1 test1 "%FILE_PATH%"
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO%_2 test2 "%FILE_PATH%.1"
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO%_3 test3 "%FILE_PATH%.2"
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO%_4 test4 "%FILE_PATH%.3"
call %TEST_ASSERT_FILE_NOT_EXISTS% %TESTNO%_5 "%FILE_PATH%.4"
call %TEST_ASSERT_FILE_NOT_EXISTS% %TESTNO%_6 "%FILE_PATH%.5"
call %TEST_ASSERT_FILE_NOT_EXISTS% %TESTNO%_7 "%FILE_PATH%.6"
rd /s /q "%TEST_TEMP_DIR_2%"

rem TEST8 バックアップ世代数より大きい番号のファイルに対しては何もしない
set TESTNO=TEST8
set time2=%time: =0%
set TEST_TEMP_DIR_2=%TEST_TEMP_DIR%\FileRotate_Test_%TESTNO%_%date:~0,4%%date:~5,2%%date:~8,2%%time2:~0,2%%time2:~3,2%%time2:~6,2%%time2:~9,2%
mkdir "%TEST_TEMP_DIR_2%"
set FILE_PATH=%TEST_TEMP_DIR_2%\hoge.txt
echo test1> "%FILE_PATH%"
echo test2> "%FILE_PATH%.1"
echo test3> "%FILE_PATH%.2"
echo test4> "%FILE_PATH%.3"
echo test5> "%FILE_PATH%.4"
echo test6> "%FILE_PATH%.5"
call %TEST_TARGET_PATH% "%FILE_PATH%" 3
call %TEST_ASSERT_EQUALS% %TESTNO% 0 %ERRORLEVEL%
call %TEST_ASSERT_FILE_NOT_EXISTS% %TESTNO%_1 "%FILE_PATH%"
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO%_2 test1 "%FILE_PATH%.1"
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO%_3 test2 "%FILE_PATH%.2"
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO%_4 test3 "%FILE_PATH%.3"
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO%_5 test5 "%FILE_PATH%.4"
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO%_6 test6 "%FILE_PATH%.5"
rd /s /q "%TEST_TEMP_DIR_2%"

rem TEST2 フォルダのローテート
set TESTNO=TEST2
set time2=%time: =0%
set TEST_TEMP_DIR_2=%TEST_TEMP_DIR%\FileRotate_Test_%TESTNO%_%date:~0,4%%date:~5,2%%date:~8,2%%time2:~0,2%%time2:~3,2%%time2:~6,2%%time2:~9,2%
mkdir "%TEST_TEMP_DIR_2%"
set FILE_PATH=%TEST_TEMP_DIR_2%\hoge
mkdir "%FILE_PATH%"
echo aa> "%FILE_PATH%\a.txt"
mkdir "%FILE_PATH%.1"
echo bb> "%FILE_PATH%.1\b.txt"
echo cc> "%FILE_PATH%.2"
mkdir "%FILE_PATH%.3"
echo dd> "%FILE_PATH%.3\d.txt"
mkdir "%FILE_PATH%.4"
echo ee> "%FILE_PATH%.4\e.txt"
mkdir "%FILE_PATH%.5"
echo ff> "%FILE_PATH%.5\f.txt"
call %TEST_TARGET_PATH% "%FILE_PATH%" 5
call %TEST_ASSERT_EQUALS% %TESTNO% 0 %ERRORLEVEL%
call %TEST_ASSERT_FILE_NOT_EXISTS% %TESTNO%_1 "%FILE_PATH%"
call %TEST_ASSERT_DIRECTORY_EXISTS% %TESTNO%_2_1 "%FILE_PATH%.1"
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO%_2_2 aa "%FILE_PATH%.1\a.txt"
call %TEST_ASSERT_DIRECTORY_EXISTS% %TESTNO%_3_1 "%FILE_PATH%.2"
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO%_3_2 bb "%FILE_PATH%.2\b.txt"
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO%_4_1 cc "%FILE_PATH%.3"
call %TEST_ASSERT_DIRECTORY_EXISTS% %TESTNO%_5_1 "%FILE_PATH%.4"
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO%_5_2 dd "%FILE_PATH%.4\d.txt"
call %TEST_ASSERT_DIRECTORY_EXISTS% %TESTNO%_6_1 "%FILE_PATH%.5"
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO%_6_2 ee "%FILE_PATH%.5\e.txt"
call %TEST_ASSERT_FILE_NOT_EXISTS% %TESTNO%_7 "%FILE_PATH%.6"
rem rd /s /q "%TEST_TEMP_DIR_2%"


endlocal
pause

exit /b

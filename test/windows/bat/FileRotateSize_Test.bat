@setlocal
@echo off

call "%~dp0\test-config.bat"

rem �e�X�g�Ώ�
set TEST_TARGET_PATH=%TEST_BAT_DIR%\FileRotateSize.bat

rem TEST1 ���[�e�[�g����(�o�C�g�����+1)
set TESTNO=TEST1
set time2=%time: =0%
set TEST_TEMP_DIR_2=%TEST_TEMP_DIR%\FileRotateSize_Test_%TESTNO%_%date:~0,4%%date:~5,2%%date:~8,2%%time2:~0,2%%time2:~3,2%%time2:~6,2%%time2:~9,2%
mkdir "%TEST_TEMP_DIR_2%"
set FILE_PATH=%TEST_TEMP_DIR_2%\hoge.txt
echo 123456789> "%FILE_PATH%"
call %TEST_TARGET_PATH% "%FILE_PATH%" 3 10
call %TEST_ASSERT_EQUALS% %TESTNO% 0 %ERRORLEVEL%
call %TEST_ASSERT_FILE_NOT_EXISTS% %TESTNO%_1 "%FILE_PATH%"
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO%_2 123456789 "%FILE_PATH%.1"
rd /s /q "%TEST_TEMP_DIR_2%"

rem TEST2 ���[�e�[�g����(�o�C�g�����+10)
set TESTNO=TEST2
set time2=%time: =0%
set TEST_TEMP_DIR_2=%TEST_TEMP_DIR%\FileRotateSize_Test_%TESTNO%_%date:~0,4%%date:~5,2%%date:~8,2%%time2:~0,2%%time2:~3,2%%time2:~6,2%%time2:~9,2%
mkdir "%TEST_TEMP_DIR_2%"
set FILE_PATH=%TEST_TEMP_DIR_2%\hoge.txt
echo 123456789012345678> "%FILE_PATH%"
call %TEST_TARGET_PATH% "%FILE_PATH%" 3 10
call %TEST_ASSERT_EQUALS% %TESTNO% 0 %ERRORLEVEL%
call %TEST_ASSERT_FILE_NOT_EXISTS% %TESTNO%_1 "%FILE_PATH%"
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO%_2 123456789012345678 "%FILE_PATH%.1"
rd /s /q "%TEST_TEMP_DIR_2%"

rem TEST3 ���[�e�[�g����(�o�C�g�����)
set TESTNO=TEST3
set time2=%time: =0%
set TEST_TEMP_DIR_2=%TEST_TEMP_DIR%\FileRotateSize_Test_%TESTNO%_%date:~0,4%%date:~5,2%%date:~8,2%%time2:~0,2%%time2:~3,2%%time2:~6,2%%time2:~9,2%
mkdir "%TEST_TEMP_DIR_2%"
set FILE_PATH=%TEST_TEMP_DIR_2%\hoge.txt
echo 12345678> "%FILE_PATH%"
call %TEST_TARGET_PATH% "%FILE_PATH%" 3 10
call %TEST_ASSERT_EQUALS% %TESTNO% 0 %ERRORLEVEL%
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO% 12345678 "%FILE_PATH%"
call %TEST_ASSERT_FILE_NOT_EXISTS% %TESTNO%_2 "%FILE_PATH%.1"
rd /s /q "%TEST_TEMP_DIR_2%"

rem TEST4 ���[�e�[�g����(�o�C�g�����-5)
set TESTNO=TEST4
set time2=%time: =0%
set TEST_TEMP_DIR_2=%TEST_TEMP_DIR%\FileRotateSize_Test_%TESTNO%_%date:~0,4%%date:~5,2%%date:~8,2%%time2:~0,2%%time2:~3,2%%time2:~6,2%%time2:~9,2%
mkdir "%TEST_TEMP_DIR_2%"
set FILE_PATH=%TEST_TEMP_DIR_2%\hoge.txt
echo 123> "%FILE_PATH%"
call %TEST_TARGET_PATH% "%FILE_PATH%" 3 10
call %TEST_ASSERT_EQUALS% %TESTNO% 0 %ERRORLEVEL%
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO% 123 "%FILE_PATH%"
call %TEST_ASSERT_FILE_NOT_EXISTS% %TESTNO%_2 "%FILE_PATH%.1"
rd /s /q "%TEST_TEMP_DIR_2%"

rem TEST5 �t�@�C���p�X��NULL
set TESTNO=TEST5
set time2=%time: =0%
set TEST_TEMP_DIR_2=%TEST_TEMP_DIR%\FileRotateSize_Test_%TESTNO%_%date:~0,4%%date:~5,2%%date:~8,2%%time2:~0,2%%time2:~3,2%%time2:~6,2%%time2:~9,2%
mkdir "%TEST_TEMP_DIR_2%"
set FILE_PATH=%TEST_TEMP_DIR_2%\hoge.txt
echo 123456789012345678> "%FILE_PATH%"
call %TEST_TARGET_PATH% "" 3 10
call %TEST_ASSERT_EQUALS% %TESTNO% 8 %ERRORLEVEL%
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO% 123456789012345678 "%FILE_PATH%"
call %TEST_ASSERT_FILE_NOT_EXISTS% %TESTNO%_2 "%FILE_PATH%.1"
rd /s /q "%TEST_TEMP_DIR_2%"

rem TEST6 �o�C�g������������ȊO
set TESTNO=TEST6
set time2=%time: =0%
set TEST_TEMP_DIR_2=%TEST_TEMP_DIR%\FileRotateSize_Test_%TESTNO%_%date:~0,4%%date:~5,2%%date:~8,2%%time2:~0,2%%time2:~3,2%%time2:~6,2%%time2:~9,2%
mkdir "%TEST_TEMP_DIR_2%"
set FILE_PATH=%TEST_TEMP_DIR_2%\hoge.txt
echo 123456789012345678> "%FILE_PATH%"
call %TEST_TARGET_PATH% "%FILE_PATH%" 3 a
call %TEST_ASSERT_EQUALS% %TESTNO% 8 %ERRORLEVEL%
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO% 123456789012345678 "%FILE_PATH%"
call %TEST_ASSERT_FILE_NOT_EXISTS% %TESTNO%_2 "%FILE_PATH%.1"
rd /s /q "%TEST_TEMP_DIR_2%"

rem TEST7 �o�C�g�������0
set TESTNO=TEST7
set time2=%time: =0%
set TEST_TEMP_DIR_2=%TEST_TEMP_DIR%\FileRotateSize_Test_%TESTNO%_%date:~0,4%%date:~5,2%%date:~8,2%%time2:~0,2%%time2:~3,2%%time2:~6,2%%time2:~9,2%
mkdir "%TEST_TEMP_DIR_2%"
set FILE_PATH=%TEST_TEMP_DIR_2%\hoge.txt
echo 123456789012345678> "%FILE_PATH%"
call %TEST_TARGET_PATH% "%FILE_PATH%" 3 0
call %TEST_ASSERT_EQUALS% %TESTNO% 8 %ERRORLEVEL%
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO% 123456789012345678 "%FILE_PATH%"
call %TEST_ASSERT_FILE_NOT_EXISTS% %TESTNO%_2 "%FILE_PATH%.1"
rd /s /q "%TEST_TEMP_DIR_2%"

rem TEST8 �o�C�g��������}�C�i�X
set TESTNO=TEST8
set time2=%time: =0%
set TEST_TEMP_DIR_2=%TEST_TEMP_DIR%\FileRotateSize_Test_%TESTNO%_%date:~0,4%%date:~5,2%%date:~8,2%%time2:~0,2%%time2:~3,2%%time2:~6,2%%time2:~9,2%
mkdir "%TEST_TEMP_DIR_2%"
set FILE_PATH=%TEST_TEMP_DIR_2%\hoge.txt
echo 123456789012345678> "%FILE_PATH%"
call %TEST_TARGET_PATH% "%FILE_PATH%" 3 -10
call %TEST_ASSERT_EQUALS% %TESTNO% 8 %ERRORLEVEL%
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO% 123456789012345678 "%FILE_PATH%"
call %TEST_ASSERT_FILE_NOT_EXISTS% %TESTNO%_2 "%FILE_PATH%.1"
rd /s /q "%TEST_TEMP_DIR_2%"

rem TEST9 ���㐔�����0(FileRotate.bat���̏���)
set TESTNO=TEST9
set time2=%time: =0%
set TEST_TEMP_DIR_2=%TEST_TEMP_DIR%\FileRotateSize_Test_%TESTNO%_%date:~0,4%%date:~5,2%%date:~8,2%%time2:~0,2%%time2:~3,2%%time2:~6,2%%time2:~9,2%
mkdir "%TEST_TEMP_DIR_2%"
set FILE_PATH=%TEST_TEMP_DIR_2%\hoge.txt
echo 123456789012345678> "%FILE_PATH%"
call %TEST_TARGET_PATH% "%FILE_PATH%" 0 10
call %TEST_ASSERT_EQUALS% %TESTNO% 8 %ERRORLEVEL%
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO% 123456789012345678 "%FILE_PATH%"
call %TEST_ASSERT_FILE_NOT_EXISTS% %TESTNO%_2 "%FILE_PATH%.1"
rd /s /q "%TEST_TEMP_DIR_2%"

rem TEST10 ���[�e�[�g����t�@�C�������݂��Ȃ��ꍇ�A�������Ȃ�
set TESTNO=TEST10
set time2=%time: =0%
set TEST_TEMP_DIR_2=%TEST_TEMP_DIR%\FileRotateSize_Test_%TESTNO%_%date:~0,4%%date:~5,2%%date:~8,2%%time2:~0,2%%time2:~3,2%%time2:~6,2%%time2:~9,2%
mkdir "%TEST_TEMP_DIR_2%"
set FILE_PATH=%TEST_TEMP_DIR_2%\hoge.txt
echo 123456789012345678> "%FILE_PATH%.1"
call %TEST_TARGET_PATH% "%FILE_PATH%" 3 10
call %TEST_ASSERT_EQUALS% %TESTNO% 1 %ERRORLEVEL%
call %TEST_ASSERT_FILE_NOT_EXISTS% %TESTNO%_1 "%FILE_PATH%"
call %TEST_ASSERT_FILE_FIRST_LINE_EQUALS% %TESTNO%_2 123456789012345678 "%FILE_PATH%.1"
call %TEST_ASSERT_FILE_NOT_EXISTS% %TESTNO%_3 "%FILE_PATH%.2"
rd /s /q "%TEST_TEMP_DIR_2%"

endlocal
pause

exit /b

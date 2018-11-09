@setlocal
@echo off

call "%~dp0\test-config.bat"

rem �e�X�g�Ώ�
set TEST_TARGET_PATH=%TEST_BAT_DIR%\Properties.bat
rem �e�X�g�ɕK�v�ȃt�@�C���̃t�H���_
set TEST_APP_DIR=%TEST_HOME_DIR%\Properties\

rem ����n
call %TEST_TARGET_PATH% %TEST_APP_DIR%\test.properties
call %TEST_ASSERT_EQUALS% "TEST1" 0 %ERRORLEVEL%

rem �ʏ�
call %TEST_ASSERT_EQUALS% "TEST1-1" VALUE1 %PROP1%

rem �v���p�e�B���ɋ󔒂��܂߂邱�Ƃ͂ł��Ȃ�
call %TEST_ASSERT_NULL% "TEST1-2" %PROP2%

rem �v���p�e�B���A�l�̑O��̋󔒂͏��������
rem �v���p�e�B��
call %TEST_ASSERT_EQUALS% "TEST1-3-1" VALUE3_1 %PROP3_1%
rem �l
call %TEST_ASSERT_EQUALS% "TEST1-3-2" "VALUE3_2" "%PROP3_2%"

rem �l�ɋ󔒂��܂߂�ɂ� " �Œl���͂�(�{�������Ɉ͂������̏����͂��Ȃ�)
call %TEST_ASSERT_EQUALS% "TEST1-4" "VA LU E4" %PROP4%

rem �s�̐擪�� # ������ꍇ�A�R�����g�s�Ƃ���
call %TEST_ASSERT_NULL% "TEST1-5" %PROP5%

rem ��s�͖��������
rem �G���[�ƂȂ�Ȃ�

rem �v���p�e�B�����Ȃ��ꍇ�A���������
rem �G���[�ƂȂ�Ȃ�

rem �l����̏ꍇ�A���ϐ��͖��ݒ�ƂȂ�
call %TEST_ASSERT_NULL% "TEST1-8" %PROP8%

rem �ُ�n
rem NULL
call %TEST_TARGET_PATH% 
call %TEST_ASSERT_EQUALS% "TEST2" 9 %ERRORLEVEL%
rem �v���p�e�B�t�@�C�������݂��Ȃ�
call %TEST_TARGET_PATH% %TEST_APP_DIR%\NotExists.properties
call %TEST_ASSERT_EQUALS% "TEST3" 9 %ERRORLEVEL%

endlocal
pause

exit /b

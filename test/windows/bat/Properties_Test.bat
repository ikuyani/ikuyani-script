@setlocal
@echo off

call env.bat

rem �e�X�g�Ώ�
set TEST_TARGET_PATH=%TEST_BAT_DIR%\Properties.bat
rem �e�X�g�ɕK�v�ȃt�@�C���̃t�H���_
set TEST_APP_DIR=%TEST_HOME_DIR%\Properties\

echo %TEST_APP_DIR%

call %TEST_TARGET_PATH% %TEST_APP_DIR%\test.properties

rem TEST 1 �ʏ�
rem echo TEST 1 %PROP1%
call %TEST_ASSERT_EQUALS% "TEST 1" VALUE1 %PROP1%

rem TEST 2 �v���p�e�B���ɋ󔒂��܂߂邱�Ƃ͂ł��Ȃ�
rem echo TEST 2 %PROP2%
call %TEST_ASSERT_NULL% "TEST 2" %PROP2%

rem TEST 3 �v���p�e�B���A�l�̑O��̋󔒂͏��������
rem �v���p�e�B��
rem echo TEST 3_1 %PROP3_1%
call %TEST_ASSERT_EQUALS% "TEST 3_1" VALUE3_1 %PROP3_1%
rem �l
rem echo TEST 3_2 %PROP3_2%
call %TEST_ASSERT_EQUALS% "TEST 3_2" "VALUE3_2" "%PROP3_2%"

rem TEST 4 �l�ɋ󔒂��܂߂�ɂ� " �Œl���͂�(�{�������Ɉ͂������̏����͂��Ȃ�)
rem echo TEST 4 %PROP4%
call %TEST_ASSERT_EQUALS% "TEST 4" "VA LU E4" %PROP4%

rem TEST 5 �s�̐擪�� # ������ꍇ�A�R�����g�s�Ƃ���
rem echo TEST 5 %PROP5%
call %TEST_ASSERT_NULL% "TEST 5" %PROP5%

rem TEST 6 ��s�͖��������
rem �G���[�ƂȂ�Ȃ�

rem TEST 7 �v���p�e�B�����Ȃ��ꍇ�A���������
rem �G���[�ƂȂ�Ȃ�

rem TEST 8 �l����̏ꍇ�A���ϐ��͖��ݒ�ƂȂ�
rem echo TEST 8 %PROP8%
call %TEST_ASSERT_NULL% "TEST 8" %PROP8%

endlocal
pause

exit /b

@setlocal
@echo off

rem ******************************************************************
rem * AssertEquals.bat: 2�̒l(���Ғl�Ǝ��ۂ̒l)����v���邩���؂���
rem *
rem * [����]
rem *   2�̒l����v����ꍇ�ASuccessful���R���\�[���ɏo�͂��A0��Ԃ��B
rem *   2�̒l����v���Ȃ��ꍇ�AFailed���R���\�[���ɏo�͂��A1��Ԃ��B
rem * 
rem * [����]
rem *   %1: �e�X�g��
rem *   %2: ���Ғl
rem *   %3: ���ۂ̒l
rem * 
rem * [�o�[�W����]
rem *   1.0
rem ******************************************************************
rem echo AssertEquals.bat %1 %2 %3

set TEST_NAME=%~1
set EXPECTED=%2
set ACTUAL=%3

if not %EXPECTED%==%ACTUAL% (
    echo Failed %TEST_NAME%, Expected=%EXPECTED%, Actual=%ACTUAL%.
    endlocal
    exit /b 1
)
echo Successful %TEST_NAME%.

endlocal
exit /b 0

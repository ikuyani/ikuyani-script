@setlocal
@echo off

rem ******************************************************************
rem * AssertNull.bat: �l��NULL(����`)�ł��邩���؂���
rem *
rem * [����]
rem *   �l��NULL�̏ꍇ�ASuccessful���R���\�[���ɏo�͂��A0��Ԃ��B
rem *   �l��NULL�ł͂Ȃ��ꍇ�AFailed���R���\�[���ɏo�͂��A1��Ԃ��B
rem * 
rem * [����]
rem *   %1: �e�X�g��
rem *   %2: �l
rem * 
rem * [�o�[�W����]
rem *   1.0.0
rem ******************************************************************
rem echo AssertNull.bat %1 %2

set TEST_NAME=%~1
set ACTUAL=%2

if defined ACTUAL (
    echo Failed %TEST_NAME%, Actual=%ACTUAL%.
    endlocal
    exit /b 1
)

echo Successful %TEST_NAME%.

endlocal
exit /b 0

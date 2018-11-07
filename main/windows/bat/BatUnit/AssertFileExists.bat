@setlocal
@echo off

rem ******************************************************************
rem * AssertFileExists.bat: �t�@�C�������݂��邩���؂���
rem *
rem * [����]
rem *   ���݂���ꍇ�ASuccessful���R���\�[���ɏo�͂��A0��Ԃ��B
rem *   ���݂��Ȃ��ꍇ�AFailed���R���\�[���ɏo�͂��A1��Ԃ��B
rem *   �G���[�̏ꍇ�AError���R���\�[���ɏo�͂��A9��Ԃ��B
rem * 
rem * [����]
rem *   %1: �e�X�g��
rem *   %2: �t�@�C���p�X
rem * 
rem * [�o�[�W����]
rem *   1.0.0
rem ******************************************************************
rem echo AssertFileExists.bat %1 %2

set TEST_NAME=%~1
set FILE_PATH=%2

rem NULL
 if not defined FILE_PATH (
    echo Error %TEST_NAME%, File-path is NULL.
    endlocal
    exit /b 9
)

rem ���݂��Ȃ�
if not exist %FILE_PATH% (
    echo Failed %TEST_NAME%, File[%FILE_PATH%] is not found.
    endlocal
    exit /b 1
)

rem ���݂��邪�t�H���_
if exist %FILE_PATH%\ (
    echo Failed %TEST_NAME%, File[%FILE_PATH%] is a directory.
    endlocal
    exit /b 1
)

echo Successful %TEST_NAME%.

endlocal
exit /b 0

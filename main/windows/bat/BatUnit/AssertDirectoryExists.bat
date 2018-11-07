@setlocal
@echo off

rem ******************************************************************
rem * AssertDirectoryExists.bat: �t�H���_�����݂��邩���؂���
rem *
rem * [����]
rem *   ���݂���ꍇ�ASuccessful���R���\�[���ɏo�͂��A0��Ԃ��B
rem *   ���݂��Ȃ��ꍇ�AFailed���R���\�[���ɏo�͂��A1��Ԃ��B
rem *   �G���[�̏ꍇ�AError���R���\�[���ɏo�͂��A9��Ԃ��B
rem * 
rem * [����]
rem *   %1: �e�X�g��
rem *   %2: �t�@�C����
rem * 
rem * [�o�[�W����]
rem *   1.0.0
rem ******************************************************************
rem echo AssertDirectoryExists.bat %1 %2

set TEST_NAME=%~1
set FILE_PATH=%2

rem NULL
if not defined FILE_PATH (
    echo Error %TEST_NAME%, Directory-path is NULL.
    endlocal
    exit /b 9
)

rem ���݂��Ȃ�
if not exist %FILE_PATH% (
    echo Failed %TEST_NAME%, Directory[%FILE_PATH%] is not found.
    endlocal
    exit /b 1
)

rem ���݂��邪�t�@�C��
if not exist %FILE_PATH%\ (
    echo Failed %TEST_NAME%, Directory[%FILE_PATH%] is a file.
    endlocal
    exit /b 1
)

echo Successful %TEST_NAME%.

endlocal
exit /b 0

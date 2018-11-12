@setlocal
@echo off

rem ******************************************************************
rem * AssertFileNotExists.bat: �t�@�C���������̓t�H���_�����݂��Ȃ������؂���
rem *
rem * [����]
rem *   ���݂��Ȃ��ꍇ�ASuccessful���R���\�[���ɏo�͂��A0��Ԃ��B
rem *   ���݂���ꍇ�AFailed���R���\�[���ɏo�͂��A1��Ԃ��B
rem *   �G���[�̏ꍇ�AError���R���\�[���ɏo�͂��A9��Ԃ��B
rem * 
rem * [����]
rem *   %1: �e�X�g��
rem *   %2: �t�@�C���p�X
rem * 
rem * [�o�[�W����]
rem *   1.0.0
rem ******************************************************************
rem echo AssertFileNotExists.bat %1 %2

set TEST_NAME=%~1
set FILE_PATH=%2

rem NULL
 if not defined FILE_PATH (
    echo Error %TEST_NAME%, File-path is NULL.
    endlocal
    exit /b 9
)

rem ���݂���
if exist %FILE_PATH% (
    echo Failed %TEST_NAME%, File[%FILE_PATH%] exists.
    endlocal
    exit /b 1
)

echo Successful %TEST_NAME%.

endlocal
exit /b 0

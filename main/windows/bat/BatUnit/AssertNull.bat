@setlocal
@echo off

rem ******************************************************************
rem * AssertNull.bat: 
rem *
rem * [����]
rem *   ���d�l�E���[����
rem *   �E�P�s�� �v���p�e�B��=�l �̌`���ŋL�q����
rem *   �E�v���p�e�B���ɋ󔒂��܂߂邱�Ƃ͂ł��Ȃ�
rem *   �E�v���p�e�B���A�l�̑O��̋󔒂͏��������
rem *   �E�l�ɋ󔒂��܂߂�ɂ� " �Œl���͂�(�{�������Ɉ͂������̏����͂��Ȃ�)
rem *   �E�s�̐擪�� # ������ꍇ�A�R�����g�s�Ƃ���
rem *   �E��s�͖��������
rem * �@�E�l����̏ꍇ�A���ϐ��͖��ݒ�ƂȂ�
rem * 
rem * [����]
rem *   %1: �v���p�e�B�t�@�C���̃p�X
rem * 
rem * [�o�[�W����]
rem *   1.0
rem ******************************************************************
rem echo Properties.bat %1

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

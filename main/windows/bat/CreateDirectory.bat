@setlocal enabledelayedexpansion
@echo off

rem ******************************************************************
rem * CreateDirectory.bat: �t�H���_���쐬����
rem *
rem * [����]
rem *   ���d�l�E���[����
rem *   �E����p�X�̃t�H���_�����݂���ꍇ�A�쐬���Ȃ�
rem * 
rem *   ���߂�l��
rem *   �E����ɍ쐬�ł����ꍇ�A0��Ԃ�
rem *   �E���łɃt�H���_�����݂���ꍇ�A1��Ԃ�
rem *   �E����p�X�Ƀt�H���_�ȊO�����łɑ��݂���ꍇ�A2��Ԃ�
rem *   �E�������s���̏ꍇ�A8��Ԃ�
rem *   �E���̑��A�\�����Ȃ��G���[�Ȃǂ̏ꍇ�A9��Ԃ�
rem * 
rem * [����]
rem *   %1: �쐬����t�H���_�̃p�X
rem * 
rem * [�o�[�W����]
rem *   1.0.0
rem ******************************************************************
rem echo CreateDirectory.bat %1

set DIR_PATH=%1

rem NULL(�s��)�̏ꍇ�A9��Ԃ�
if not defined DIR_PATH (
    endlocal
    exit /b 8
)

rem ����p�X�Ƀt�H���_�����݂��Ȃ��ꍇ�A�t�H���_���쐬����
if not exist %DIR_PATH%\ (
    rem ����p�X�Ƀt�H���_�ȊO�����łɑ��݂���ꍇ�A2��Ԃ�
    if exist %DIR_PATH% (
        endlocal
        exit /b 2
    )

    rem �t�H���_���쐬����
    mkdir %DIR_PATH%
    if !ERRORLEVEL! neq 0 (
        endlocal
        exit /b 9
    )

    rem ����ɍ쐬�ł����ꍇ�A0��Ԃ�
    endlocal
    exit /b 0
)

rem ���łɃt�H���_�����݂���ꍇ�A1��Ԃ�
endlocal
exit /b 1

@echo off

rem ******************************************************************
rem * Properties.bat: �v���p�e�B�t�@�C������v���p�e�B���ƒl�̃Z�b�g���擾���A���ϐ��ɐݒ肷��
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
rem *   ���߂�l��
rem *   �E����ɏ����ł����ꍇ�A0��Ԃ�
rem *   �E�G���[�ȂǕs���̏ꍇ�A9��Ԃ�
rem * 
rem * [����]
rem *   %1: �v���p�e�B�t�@�C���̃p�X
rem * 
rem * [�o�[�W����]
rem *   1.0.0
rem ******************************************************************
rem echo Properties.bat %1

set FILE_PATH=%1

rem NULL(�s��)�̏ꍇ�A9��Ԃ�
if not defined FILE_PATH (
    endlocal
    exit /b 9
)

rem �v���p�e�B�t�@�C�������݂��Ȃ��ꍇ�A9��Ԃ�
call "%~dp0\IsFileExists.bat" %FILE_PATH%
if not %ERRORLEVEL% equ 0 (
    endlocal
    exit /b 9
)

for /f "usebackq tokens=1,2* delims==" %%a in (%1) do (
    setlocal enabledelayedexpansion
    call :IsIgnore %%a
    if not !ERRORLEVEL! equ 0 (
        endlocal
        call :SetProperty %%a %%b
    ) else (
        endlocal
    )
)

exit /b 0

rem ******************************************************************
rem * IsIgnore: ���ϐ��ւ̐ݒ�̏��O�Ώۂ��̔���
rem * 
rem * [����]
rem * 
rem * [����]
rem *   %1: �v���p�e�B��
rem ******************************************************************
:IsIgnore
setlocal

set VARNAME=%1

rem �v���p�e�B�����w��͏��O
if "%VARNAME%"=="" (
rem    echo Exclude %VARNAME%
    endlocal
    exit /b 0
)

rem �R�����g�s�͏��O
if "!VARNAME:~0,1!"=="#" (
rem    echo CommentLine %VARNAME%
    endlocal
    exit /b 0
)
endlocal
exit /b 1


rem ******************************************************************
rem * SetProperty: ���ϐ��ɐݒ肷��
rem * 
rem * [����]
rem *   �֐����̗��R�͑O��̋󔒏����̂��߁B
rem * 
rem * [����]
rem *   %1: �v���p�e�B��
rem *   %2: �l
rem ******************************************************************
:SetProperty

rem echo %1=%2
set %1=%2

exit /b

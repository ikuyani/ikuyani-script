@setlocal enabledelayedexpansion
@echo off

rem ******************************************************************
rem * FileRotate.bat: �t�@�C�����[�e�[�g���� 
rem * 
rem * [����]
rem *   �t�@�C���������̓t�H���_�ɑ΂��A����ԍ���t�^���Ė��O��ύX����B
rem *   ����ԍ��͏������ԍ��قǐV�����A�傫���ԍ��قǌÂ��Ȃ�B
rem * 
rem *   ���d�l�E���[����
rem *   �E�t�@�C���ƃt�H���_�ɑ΂��ă��[�e�[�g����
rem *   �E���[�e�[�g����Ώۂ����݂��Ȃ��ꍇ�A�������Ȃ�
rem *   �E�o�b�N�A�b�v���㐔���傫���ԍ��̃t�@�C���ɑ΂��Ă͉������Ȃ�
rem *   �E�o�b�N�A�b�v���㐔��1�ȏ���w�肷��
rem * 
rem *   ���߂�l��
rem *   �E����ɏ��������ꍇ�A0��Ԃ�
rem *   �E���[�e�[�g����t�@�C�������݂��Ȃ��ꍇ�A1��Ԃ�
rem *   �E�������s���̏ꍇ�A8��Ԃ�
rem *   �E���̑��A�\�����Ȃ��G���[�Ȃǂ̏ꍇ�A9��Ԃ�
rem * 
rem * [����]
rem *   %1: ���[�e�[�g����t�@�C��(�K�{)
rem *   %2: �o�b�N�A�b�v���㐔�̏��(�K�{)
rem * 
rem * [�o�[�W����]
rem *   1.1.0
rem ******************************************************************
rem echo FileRotate.bat %1 %2

rem ���p����O���o�b�`�t�@�C��
set BAT_DIRECTORYEXISTS="%~dp0\DirectoryExists.bat"
set BAT_ISINTEGER="%~dp0\IsInteger.bat"

rem �t�@�C�����Ɛ���ԍ��̋�؂蕶��
set DOT=.

set FILE_PATH=%~1
set MAX_BACKUP_NUMBER=%2

rem �����`�F�b�N(�������s���̏ꍇ�A8��Ԃ�)
if not defined FILE_PATH (
    endlocal
    exit /b 8
)

rem �o�b�N�A�b�v���㐔�̐�������
call %BAT_ISINTEGER% %MAX_BACKUP_NUMBER%
if %ERRORLEVEL% neq 0 (
    endlocal
    exit /b 8
)
rem �o�b�N�A�b�v���㐔��1�ȏ���w�肷��
if %MAX_BACKUP_NUMBER% lss 1 (
    endlocal
    exit /b 8
)


rem ���[�e�[�g����t�@�C���������̓t�H���_�����݂��Ȃ��ꍇ�A1��Ԃ�
if not exist "%FILE_PATH%" (
    endlocal
    exit /b 1
)

rem ���㐔�̏���̔ԍ����烍�[�e�[�g��������
for /l %%i in (%MAX_BACKUP_NUMBER%,-1,1) do (
    set _FILE="%FILE_PATH%%DOT%%%i"
    if exist !_FILE! (
        if %%i equ %MAX_BACKUP_NUMBER% (
            rem �t�@�C���̐���ԍ����ő�̏ꍇ�A�t�@�C�����폜����
            call %BAT_DIRECTORYEXISTS% !_FILE!
            if !ERRORLEVEL! equ 0 (
                rem �t�H���_�̏ꍇ
                rd /S /Q !_FILE! >nul
            ) else (
                rem �t�@�C���̏ꍇ
                del /Q  !_FILE! >nul
            )
            if !ERRORLEVEL! neq 0 (
                endlocal
                exit /b 9
            )
        ) else (
            rem �t�@�C���̐���ԍ����ő�ł͂Ȃ��ꍇ�A������A�b�v����
            set /a _NEXT_COUNT=%%i+1 
            move /Y !_FILE! "%FILE_PATH%%DOT%!_NEXT_COUNT!" >nul
            if !ERRORLEVEL! neq 0 (
                endlocal
                exit /b 9
            )
        )
    )
)

rem �ŐV�̃t�@�C���͐���ԍ���1��t����
move /Y "%FILE_PATH%" "%FILE_PATH%%DOT%1" >nul
if %ERRORLEVEL% neq 0 (
    endlocal
    exit /b 9
)

endlocal
exit /b 0

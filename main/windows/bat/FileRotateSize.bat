@setlocal enabledelayedexpansion
@echo off

rem ******************************************************************
rem * FileRotateSize.bat: �t�@�C���T�C�Y�ɂ��t�@�C�����[�e�[�g
rem * 
rem * [����]
rem *   �t�@�C���̃o�C�g��������l���傫���ꍇ�A���[�e�[�g����B
rem * 
rem *   ���d�l�E���[����
rem *   �E�t�@�C���ɑ΂��Ă̂݃��[�e�[�g����
rem *   �E���[�e�[�g����Ώۂ����݂��Ȃ��ꍇ�A�������Ȃ�
rem *   �E�t�@�C���̃o�C�g���̏����1�ȏ���w�肷��
rem *   �E�o�b�N�A�b�v���㐔�ȂǊ�{�I�Ȏd�l��FileRotate.bat�ɏ�����
rem * 
rem * [����]
rem *   %1: ���[�e�[�g����t�@�C��(�K�{)
rem *   %2: �o�b�N�A�b�v���㐔�̏��(�K�{)
rem *   %3: �t�@�C���̃o�C�g�����
rem * 
rem * [�o�[�W����]
rem *   1.0.0
rem ******************************************************************
rem echo FileRotateSize %1 %2 %3

rem ���p����O���o�b�`�t�@�C��
set BAT_FILEEXISTS="%~dp0\FileExists.bat"
set BAT_ISINTEGER="%~dp0\IsInteger.bat"
set BAT_FILEROTATE="%~dp0\FileRotate.bat"

set FILE_PATH=%~1
set MAX_BACKUP_NUMBER=%2
set MAX_BYTESIZE=%3

rem �����`�F�b�N(�������s���̏ꍇ�A8��Ԃ�)
if not defined FILE_PATH (
    endlocal
    exit /b 8
)

rem �t�@�C���̃o�C�g������̐�������
call %BAT_ISINTEGER% %MAX_BYTESIZE%
if %ERRORLEVEL% neq 0 (
    endlocal
    exit /b 8
)
rem �t�@�C���̃o�C�g�������1�ȏ���w�肷��
if %MAX_BYTESIZE% lss 1 (
    endlocal
    exit /b 8
)
rem ���[�e�[�g����t�@�C�������݂��Ȃ��ꍇ�A1��Ԃ�
call %BAT_FILEEXISTS% "%FILE_PATH%"
if %ERRORLEVEL% neq 0 (
    endlocal
    exit /b 1
)

rem �t�@�C���̃o�C�g��������l���傫���ꍇ�A���[�e�[�g����
for %%i in ("%FILE_PATH%") do (
    rem echo %%~zi
    if %%~zi gtr %MAX_BYTESIZE% (
        call %BAT_FILEROTATE% "%FILE_PATH%" %MAX_BACKUP_NUMBER%
        if !ERRORLEVEL! neq 0 (
            endlocal
            exit /b !ERRORLEVEL!
        ) 
    )
)

endlocal
exit /b 0

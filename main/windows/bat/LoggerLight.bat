@setlocal enabledelayedexpansion
@echo off

rem ******************************************************************
rem * LoggerLight.bat: ���O���o�͂���(���O���x�������̌y�ʔ�)
rem *
rem * [����]
rem *   �����O�o�͕��@��
rem *   �E���O�̏o�͐�͊��ϐ���LOGGER_HANDLER�Ɏw�肷��
rem *     - FILE: ���ϐ���LOGGER_FILE_OUTPUT�Ɏw�肵���t�@�C���ɏo�͂���
rem *     - CONSOLE: �W���o�͂���
rem *     - ��L�ȊO: �o�͂��Ȃ�
rem * 
rem *   �����ϐ���
rem *   ���O�̏o�͕��@�͊��ϐ��ɐݒ肷��B
rem *   �E�K���w�肷��
rem *     - LOGGER_HANDLER: �o�͕��@(FILE, CONSOLE�̂����ꂩ���w��A���w��̏ꍇ�͏o�͂��Ȃ�)
rem *   �ELOGGER_HANDLER��FILE���w�肵���ꍇ�ɐݒ肷��
rem *     - LOGGER_FILE_OUTPUT: �o�͐�t�@�C��
rem *     - LOGGER_FILE_ROTATE: ���O�t�@�C���̃��[�e�[�g����(SIZE��ݒ�A���w��̏ꍇ�̓��[�e�[�g���Ȃ�)
rem *     - LOGGER_FILE_ROTATE_MAXNUMBER: ���[�e�[�g�̃o�b�N�A�b�v���㐔�̏��
rem *     - LOGGER_FILE_ROTATE_MAXSIZE: ���[�e�[�g������SIZE���w�肵���ꍇ�A�ő�T�C�Y(KB)���w�肷��
rem * 
rem *   ���߂�l��
rem *   �E���O�o�͂����ꍇ�A0��Ԃ�
rem *   �E���O�o�͂��Ȃ������ꍇ�A1��Ԃ�
rem *   �E���O���t�@�C���ɏo�͂���ۂɃ��[�e�[�g�����s�����ꍇ�A2��Ԃ�
rem * 
rem * [����]
rem *   %1: ���b�Z�[�W(�K�{)
rem * 
rem * [�o�[�W����]
rem *   1.0.0
rem ******************************************************************
rem echo LoggerLight.bat %1

rem ���p����O���o�b�`�t�@�C��
set BAT_FILEROTATESIZE="%~dp0\FileRotateSize.bat"
set BAT_ISINTEGER="%~dp0\IsInteger.bat"

set MESSAGE=%~1

rem ���b�Z�[�W���w��̏ꍇ�A���������ɏI���
if not defined MESSAGE (
    endlocal
    exit /b 1
)

set time2=%time: =0%
set LOG_MESSAGE=%date% %time2% %MESSAGE%

if /i "%LOGGER_HANDLER%"=="CONSOLE" (
    echo %LOG_MESSAGE%
    endlocal
    exit /b 0
)
if /i "%LOGGER_HANDLER%"=="FILE" (
    if not defined LOGGER_FILE_OUTPUT (
        endlocal
        exit /b 1
    )
    rem ���[�e�[�g
    if defined LOGGER_FILE_ROTATE (
        rem �t�@�C���T�C�Y�ɂ�郍�[�e�[�g
        if /i "%LOGGER_FILE_ROTATE%"=="SIZE" (
            call %BAT_ISINTEGER% %LOGGER_FILE_ROTATE_MAXSIZE%
            if !ERRORLEVEL! neq 0 (
                endlocal
                exit /b 1
            )
            if !LOGGER_FILE_ROTATE_MAXSIZE! lss 1 (
                endlocal
                exit /b 1
            )
            call %BAT_ISINTEGER% %LOGGER_FILE_ROTATE_MAXNUMBER%
            if !ERRORLEVEL! neq 0 (
                endlocal
                exit /b 1
            )
            if !LOGGER_FILE_ROTATE_MAXNUMBER! lss 1 (
                endlocal
                exit /b 1
            )
            rem ���[�e�[�g����
            set /a SIZE=%LOGGER_FILE_ROTATE_MAXSIZE%*1024
            call %BAT_FILEROTATESIZE% %LOGGER_FILE_OUTPUT% %LOGGER_FILE_ROTATE_MAXNUMBER% !SIZE!
            if !ERRORLEVEL! neq 0 (
                if !ERRORLEVEL! neq 1 (
                    endlocal
                    exit /b 2
                )
            )
        )
    )
    echo %LOG_MESSAGE%>>"%LOGGER_FILE_OUTPUT%"
    if !ERRORLEVEL! neq 0 (
        endlocal
        exit /b 1
    )
    endlocal
    exit /b 0
)

endlocal
exit /b 1


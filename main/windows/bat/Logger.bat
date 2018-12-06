@setlocal enabledelayedexpansion
@echo off

rem ******************************************************************
rem * Logger.bat: ���O���o�͂���
rem *
rem * [����]
rem *   �����O���x���d�l��
rem *   �E�����Ɏw�肵�����O���x��(%1)�����ϐ��ɐݒ肵�����O���x��(LOGGER_LEVEL)�ȏ�ł���΃��O���o�͂���
rem *   �E�w��ł��郍�O���x���͉��L�̂��̂Ƃ��A�ォ�珇�Ƀ��x��������
rem *      - FATAL
rem *      - ERROR
rem *      - WARN
rem *      - INFO
rem *      - DEBUG
rem *      - TRACE
rem *   �E���O���x���̎w��͑召�����̋�ʂ͂��Ȃ�
rem * 
rem *   �����O�o�͕��@��
rem *   �E���O�̏o�͐�͊��ϐ���LOGGER_HANDLER�Ɏw�肷��
rem *     - FILE: ���ϐ���LOGGER_FILE_OUTPUT�Ɏw�肵���t�@�C���ɏo�͂���
rem *     - CONSOLE: �W���o�͂���
rem *     - ��L�ȊO: �o�͂��Ȃ�
rem * 
rem *   �����ϐ���
rem *   ���O�̏o�͕��@�⃍�O���x���͊��ϐ��ɐݒ肷��B
rem *   �E�K���w�肷��
rem *     - LOGGER_LEVEL: ���O���x��(FATAL, ERROR, WARN, INFO, DEBUG, TRACE�̂����ꂩ���w��)
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
rem *   %1: ���O���x��(�K�{)
rem *   %2: ���b�Z�[�W(�K�{)
rem * 
rem * [�o�[�W����]
rem *   1.0.0
rem ******************************************************************
rem echo Logger.bat %1

rem ���p����O���o�b�`�t�@�C��
set BAT_LOGGERLIGHT="%~dp0\LoggerLight.bat"

set LEVEL=%1
set MESSAGE=%~2

rem ���O���x�����w��̏ꍇ�A���������ɏI���
if not defined LEVEL (
    endlocal
    exit /b 1
)

rem ���b�Z�[�W���w��̏ꍇ�A���������ɏI���
if not defined MESSAGE (
    endlocal
    exit /b 1
)

call :GetLevelNumber %LOGGER_LEVEL%
set LOGGER_LEVEL_NUMBER=%ERRORLEVEL%
if %LOGGER_LEVEL_NUMBER% equ 0 (
    endlocal
    exit /b 1
)

call :GetLevelNumber %LEVEL%
set LEVEL_NUMBER=%ERRORLEVEL%
if %LEVEL_NUMBER% equ 0 (
    endlocal
    exit /b 1
)

rem �����ɐݒ肵�����O���x�������ϐ��̃��O���x�������̏ꍇ�A���O���o�͂��Ȃ�
if %LEVEL_NUMBER% lss %LOGGER_LEVEL_NUMBER% (
    endlocal
    exit /b 1
)

rem ���O���b�Z�[�W�p���O���x��
if %LEVEL_NUMBER% equ 1 (
    set LOG_MESSAGE=TRACE
)
if %LEVEL_NUMBER% equ 2 (
    set LOG_MESSAGE=DEBUG
)
if %LEVEL_NUMBER% equ 3 (
    set LOG_MESSAGE=INFO
)
if %LEVEL_NUMBER% equ 4 (
    set LOG_MESSAGE=WARN
)
if %LEVEL_NUMBER% equ 5 (
    set LOG_MESSAGE=ERROR
)
if %LEVEL_NUMBER% equ 6 (
    set LOG_MESSAGE=FATAL
)

rem ���O�o��
call %BAT_LOGGERLIGHT% "%LOG_MESSAGE% %MESSAGE%"

endlocal
exit /b %ERRORLEVEL%


:GetLevelNumber
setlocal

set LEVEL=%1

if /i "%LEVEL%"=="TRACE" (
    endlocal
    exit /b 1
)
if /i "%LEVEL%"=="DEBUG" (
    endlocal
    exit /b 2
)
if /i "%LEVEL%"=="INFO" (
    endlocal
    exit /b 3
)
if /i "%LEVEL%"=="WARN" (
    endlocal
    exit /b 4
)
if /i "%LEVEL%"=="ERROR" (
    endlocal
    exit /b 5
)
if /i "%LEVEL%"=="FATAL" (
    endlocal
    exit /b 6
)

endlocal
exit /b 0


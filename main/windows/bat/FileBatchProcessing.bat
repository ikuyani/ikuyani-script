@setlocal enabledelayedexpansion
@echo off

rem ******************************************************************
rem * FileBatchProcessing.bat: �t�H���_���̃t�@�C���ɑ΂��ꊇ����������
rem *
rem * [����]
rem *   �t�H���_���̃t�@�C���ɑ΂��C�ӂ̏������ꊇ�Ŏ��s����B
rem *   �C�ӂ̏����͕ʂ̃o�b�`�t�@�C���ō쐬���A�v���p�e�B�t�@�C���Ƀp�X���L�q����B
rem * 
rem *   ���v���p�e�B�t�@�C����
rem *   �E�{�o�b�`�ɕK�v�ȏ��̓v���p�e�B�t�@�C���ɒ�`����
rem *     - PROCESSING_BATCH_PATH: �Ώۃt�@�C���ɑ΂��Ď��s����o�b�`�t�@�C���̃p�X
rem *     - DEFAULT_TARGET_DIR: �f�t�H���g�̑Ώۃt�H���_(�����ɖ��w��̏ꍇ�Ɏg�p)
rem *     - DEFAULT_FILE_PATTERN: �f�t�H���g�̑Ώۃt�@�C�����̃p�^�[��(�����ɖ��w��̏ꍇ�Ɏg�p)
rem *                             ���w��̏ꍇ�A*���w�肳���
rem *     - ERROR_CONTINUE: PROCESSING_BATCH_PATH�̎��s���ɃG���[�ƂȂ����ꍇ�A���t�@�C���̌p���L��.
rem *                       �p������ꍇ��0�ȊO�A�p�����Ȃ��ꍇ��0.
rem *                       ���w��̏ꍇ�A1(�p��)���w�肳���
rem *   �E�v���p�e�B�t�@�C���̏��͖{�o�b�`���s���͊��ϐ��ɐݒ�(�㏑��)�����
rem * 
rem *   ���߂�l��
rem *   �E����ɏ����ł����ꍇ�A0��Ԃ�
rem *   �E�v���p�e�B�t�@�C���̓ǂݍ��݂Ɏ��s�����ꍇ�A1��Ԃ�
rem *   �E�v���p�e�B�t�@�C���̓��e���s���̏ꍇ�A2��Ԃ�
rem *   �E�t�@�C���ɑ΂��C�ӂ̏��������s����o�b�`�t�@�C���̖߂�l��0�ȊO�̏ꍇ�A3��Ԃ�
rem *   �E�������s���̏ꍇ�A8��Ԃ�
rem *   �E���̑��A�\�����Ȃ��G���[�Ȃǂ̏ꍇ�A9��Ԃ�
rem * 
rem *   ���C�ӂ̏����̃o�b�`�t�@�C���ł̒��Ӂ�
rem *   �E�{�o�b�`���s���Ɋ��ϐ����ݒ�(�㏑��)����邽�߁A���O�ɓ���̕ϐ����Őݒ肵�A
rem *     �w�肵���o�b�`�t�@�C���ł��̊��ϐ����g���ꍇ�A�㏑�����ꂽ�l���g����
rem *     - BAT_CREATEDIRECTORY
rem *     - BAT_FILEEXISTS
rem *     - BAT_LOGGERLIGHT
rem *     - BAT_PROPERTIES
rem *     - ERROR_CONTINUE
rem *     - ERRORLEVEL_PROCESSING
rem *     - ERRORLEVEL2
rem *     - DEFAULT_FILE_PATTERN
rem *     - DEFAULT_TARGET_DIR
rem *     - FILE_PATTERN
rem *     - PROCESSING_BATCH_ARGUMENT
rem *     - PROCESSING_BATCH_PATH
rem *     - PROPERTIES_FILE
rem *     - TARGET_DIR
rem * 
rem * [����]
rem *   %1: �v���p�e�B�t�@�C���̃p�X
rem *   %2: �Ώۃt�H���_�̃p�X
rem *   %3: �Ώۂ̃t�@�C�����p�^�[��
rem *   %4: ���s����o�b�`�t�@�C���ɓn������
rem * 
rem * [�o�[�W����]
rem *   1.0.0
rem ******************************************************************
rem echo FileBatchProcessing.bat %1

rem ���p����O���o�b�`�t�@�C��
set BAT_PROPERTIES="%~dp0\Properties.bat"
set BAT_CREATEDIRECTORY="%~dp0\CreateDirectory.bat"
set BAT_FILEEXISTS="%~dp0\FileExists.bat"
set BAT_LOGGERLIGHT="%~dp0\LoggerLight.bat"

rem �v���p�e�B�t�@�C���̃p�X(�K�{)
set PROPERTIES_FILE=%~1

rem �Ώۃt�H���_�̃p�X
set TARGET_DIR=%~2
rem �Ώۃt�@�C�����̃p�^�[��
set FILE_PATTERN=%~3
rem ���s����o�b�`�t�@�C���ɓn������
set PROCESSING_BATCH_ARGUMENT=%~4

call :Log "---------------------------------------------------------"
call :Log "[Start] �����`�F�b�N"
rem �����`�F�b�N
rem �v���p�e�B�t�@�C��
if not defined PROPERTIES_FILE (
    call :ErrorLog "����1[�v���p�e�B�t�@�C��]�����w��ł��B�������I�����܂��B"
    endlocal
    exit /b 8
)

call :Log "[End] �����`�F�b�N"

call :Log "---------------------------------------------------------"
call :Log "[Start] �v���p�e�B�t�@�C���̓Ǎ�"
rem �v���p�e�B�t�@�C���̓Ǎ�
call %BAT_PROPERTIES% "%PROPERTIES_FILE%"
if %ERRORLEVEL% neq 0 (
    call :ErrorLog "�v���p�e�B�t�@�C���̓ǂݍ��݂Ɏ��s���܂����B�������I�����܂��B"
    endlocal
    exit /b 1
)

rem �Ώۃt�@�C���ɑ΂��Ď��s����O���o�b�`�t�@�C��(�K�{)
call :Log "PROCESSING_BATCH_PATH=%PROCESSING_BATCH_PATH%"
rem �f�t�H���g�̑Ώۃt�H���_
call :Log "DEFAULT_TARGET_DIR=%DEFAULT_TARGET_DIR%"
rem �f�t�H���g�̑Ώۂ̃t�@�C�����p�^�[��
call :Log "DEFAULT_FILE_PATTERN=%DEFAULT_FILE_PATTERN%"
rem �G���[�������p���̗L��(�p������ꍇ��0�ȊO�A�p�����Ȃ��ꍇ��0)
call :Log "ERROR_CONTINUE=%ERROR_CONTINUE%"

call :Log "[End] �v���p�e�B�t�@�C���̓ǂݍ���"

call :Log "---------------------------------------------------------"
call :Log "[Start] ���s��/�p�����[�^���̌��؁A�ݒ�"
rem �Ώۃt�@�C���ɑ΂��Ď��s����O���o�b�`�t�@�C��(�K�{)
if not defined PROCESSING_BATCH_PATH (
    call :ErrorLog "�v���p�e�B�t�@�C����PROCESSING_BATCH_PATH�����w��ł��B�������I�����܂��B"
    endlocal
    exit /b 2
)

rem �Ώۃt�H���_
if not defined TARGET_DIR (
    if defined DEFAULT_TARGET_DIR (
        rem �����ɖ��w��̏ꍇ�A�f�t�H���g�̑Ώۃt�H���_��ݒ肷��
        set TARGET_DIR=%DEFAULT_TARGET_DIR%

    ) else (
        call :ErrorLog "�Ώۃt�H���_TARGET_DIR�����w��ł��B�������I�����܂��B"
        endlocal
        exit /b 2
    )

    call :Log "�Ώۃt�H���_TARGET_DIR�����w��̂���[!TARGET_DIR!]��ݒ肵�܂��B"
)

rem �Ώۂ̃t�@�C�����p�^�[��
if not defined FILE_PATTERN (

    if defined DEFAULT_FILE_PATTERN (
        rem �����ɖ��w��̏ꍇ�A�f�t�H���g�̃t�@�C���p�^�[����ݒ肷��
        set FILE_PATTERN=%DEFAULT_FILE_PATTERN%

    ) else (
        rem �f�t�H���g�l�����w��̏ꍇ�A�S�Ẵt�@�C����ΏۂƂ���
        set FILE_PATTERN=*
    )
    call :Log "�Ώۃt�@�C�����̃p�^�[��FILE_PATTERN�����w��̂���[!FILE_PATTERN!]��ݒ肵�܂��B"
)

rem �O���o�b�`�t�@�C���ŃG���[�ƂȂ����ꍇ�A���t�@�C���̏����p���L��
if not defined ERROR_CONTINUE (
    rem ���w��̏ꍇ�A�p���Ƃ���
    set ERROR_CONTINUE=1
    call :Log "ERROR_CONTINUE�����w��̂���[!ERROR_CONTINUE!]��ݒ肵�܂��B"
)

call :Log "[End] ���s���A�p�����[�^���̌���"

call :Log "---------------------------------------------------------"
call :Log "[Start] �ꊇ����"
call :PROCESSING
set ERRORLEVEL_PROCESSING=%ERRORLEVEL%
call :Log "[End] �ꊇ����"

if %ERRORLEVEL_PROCESSING% equ 0 (
    endlocal
    exit /b 0
) else (
    endlocal
    exit /b 3
)


rem ******************************************************************
rem * PROCESSING: �ꊇ����
rem * 
rem * [����]
rem *   Break�����̂��ߊ֐�������
rem * 
rem *   ���߂�l��
rem *   �E����ɏ����ł����ꍇ�A0��Ԃ�
rem *   �E�t�@�C���ɑ΂��C�ӂ̏��������s����o�b�`�t�@�C���̖߂�l��0�ȊO��
rem *     - �������p������ꍇ�A3��Ԃ�
rem *     - �����𒆒f����ꍇ�A�o�b�`�t�@�C���̖߂�l��Ԃ�
rem *   
rem * [����]
rem *   
rem ******************************************************************
:PROCESSING
set ERRORLEVEL2=0
for %%f in ("%TARGET_DIR%\%FILE_PATTERN%") do (
    call %BAT_FILEEXISTS% %PROCESSING_BATCH_PATH%
    if !ERRORLEVEL! equ 0 (
        rem �t�@�C���ɑ΂��C�ӂ̏��������s����
        call %PROCESSING_BATCH_PATH% "%%f" %PROCESSING_BATCH_ARGUMENT%
        if !ERRORLEVEL! neq 0 (
            rem �o�b�`�t�@�C���̖߂�l��0�ȊO
            if %ERROR_CONTINUE% equ 0 (
                rem ���f����
                set ERRORLEVEL2=!ERRORLEVEL!
                call :ErrorLog "%%f�̏������ɃG���[[!ERRORLEVEL!]�������������߁A�����𒆒f���܂��B"
                exit /b !ERRORLEVEL2!
            ) else (
                rem �p������
                set ERRORLEVEL2=3
                call :ErrorLog "%%f�̏������ɃG���[[!ERRORLEVEL!]���������܂������A�������p�����܂��B"
            )
        )
    )
)

exit /b %ERRORLEVEL2%

rem ******************************************************************
rem * Log: ���b�Z�[�W�̏o�͏���
rem * 
rem * [����]
rem *   ���R�Ƀ��b�Z�[�W�̏o�͏������������Ă��������B
rem * 
rem * [����]
rem *   %1: ���b�Z�[�W
rem ******************************************************************
:Log

call %BAT_LOGGERLIGHT% %1

exit /b

rem ******************************************************************
rem * ErrorLog: �G���[���b�Z�[�W�̏o�͏���
rem * 
rem * [����]
rem *   ���R�ɃG���[���b�Z�[�W�̏o�͏������������Ă��������B
rem * 
rem * [����]
rem *   %1: �G���[���b�Z�[�W
rem ******************************************************************
:ErrorLog

call %BAT_LOGGERLIGHT% "[ERROR] %~1"

exit /b

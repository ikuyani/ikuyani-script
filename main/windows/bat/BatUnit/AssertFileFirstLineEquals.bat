@setlocal
@echo off

rem ******************************************************************
rem * AssertFileFirstLineEquals.bat: �t�@�C���̐擪�s�Ɗ��Ғl����v���邩���؂���
rem *
rem * [����]
rem *   ��v����ꍇ�ASuccessful���R���\�[���ɏo�͂��A0��Ԃ��B
rem *   ��v���Ȃ��A�������̓t�@�C�������݂��Ȃ��ꍇ�AFailed���R���\�[���ɏo�͂��A1��Ԃ��B
rem *   �G���[�̏ꍇ�AError���R���\�[���ɏo�͂��A9��Ԃ��B
rem * 
rem * [����]
rem *   %1: �e�X�g��
rem *   %2: ���Ғl
rem *   %3: �t�@�C���p�X
rem * 
rem * [�o�[�W����]
rem *   1.0.0
rem ******************************************************************
rem echo AssertFileFirstLineEquals.bat %1 %2 %3

set BAT_ASSERTFILEEXISTS="%~dp0\AssertFileExists.bat"
set BAT_ASSERTEQUALS="%~dp0\AssertEquals.bat"

set TEST_NAME=%~1
set EXPECTED=%~2
set FILE_PATH=%3

call %BAT_ASSERTFILEEXISTS% %1 %3
if %ERRORLEVEL% neq 0 (
    endlocal
    rem �����W�J�Ȃ̂�ERRORLEVEL��endlocal�O�̒l�ƂȂ�
    exit /b %ERRORLEVEL%
)

set /p HEADER=<%FILE_PATH%
call %BAT_ASSERTEQUALS% %1 "%EXPECTED%" "%HEADER%"
if %ERRORLEVEL% neq 0 (
    endlocal
    rem �����W�J�Ȃ̂�ERRORLEVEL��endlocal�O�̒l�ƂȂ�
    exit /b %ERRORLEVEL%
)

echo Successful %TEST_NAME%.

endlocal
exit /b 0

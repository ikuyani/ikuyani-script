@setlocal enabledelayedexpansion
@echo off

rem ******************************************************************
rem * FileRotateSize.bat: �t�@�C���T�C�Y�ɂ�郍�[�e�[�g
rem * %1: �t�@�C���̃t�H���_ C:\work\log
rem * %2: �t�@�C���� Error.log
rem * %3: �ő�̐��㐔
rem * %4: �t�@�C���̍ő�o�C�g��
rem ******************************************************************
rem echo FileRotateSize %1 %2 %3 %4

for %%i in (%~1\%~2) do (
    rem echo %%~zi
    if %%~zi gtr %4 (
        call FileRotate.bat %1 %2 %3
    )
)

exit /b

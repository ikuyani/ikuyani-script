@setlocal enabledelayedexpansion
@echo off

rem ******************************************************************
rem * FileRotateSize.bat: �t�@�C���T�C�Y�ɂ��t�@�C�����[�e�[�g
rem * 
rem * [����]
rem * 
rem * [����]
rem *   %1: ���[�e�[�g����t�@�C���̂���t�H���_
rem *   %2: ���[�e�[�g����t�@�C����
rem *   %3: ���㐔�̏��
rem *   %4: ���[�e�[�g�̔��f������t�@�C���̃o�C�g��
rem * 
rem * [�o�[�W����]
rem *   1.0
rem ******************************************************************
rem echo FileRotateSize %1 %2 %3 %4

for %%i in (%~1\%~2) do (
    rem echo %%~zi
    if %%~zi gtr %4 (
        call FileRotate.bat %1 %2 %3
    )
)

exit /b

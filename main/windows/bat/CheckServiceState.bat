@setlocal enabledelayedexpansion
@echo off

rem ******************************************************************
rem * CheckServiceState.bat: �T�[�r�X�̏�Ԃ��`�F�b�N���A���O�ɏo�͂���
rem * 
rem * [����]
rem * 
rem * [����]
rem *   %1: �T�[�r�X��
rem *   %2: �o�͐惍�O�t�@�C���p�X
rem * 
rem * [�o�[�W����]
rem *   1.0.0
rem ******************************************************************
rem echo CheckServiceState.bat %1 %2

call :GetServiceState %1

if not "%SERVICE_STATE%"=="" (
    if not "%SERVICE_STATE%"=="RUNNING" (
        call :Log %2 "[ERROR] %~1 is not RUNNING, state = %SERVICE_STATE%."
    )
) else (
     call :Log %2 "[ERROR] %~1 is not found."
)

endlocal
exit /b


:GetServiceState
rem ******************************************************************
rem * GetServiceState: �T�[�r�X�̏�Ԃ��擾����
rem * 
rem * [����]
rem * 
rem * [����]
rem *   %1: �T�[�r�X��
rem ******************************************************************
rem echo GetServiceState %1

set SERVICE_STATE_CODE=
set SERVICE_STATE=

for /f "tokens=1,2* delims=:" %%i in ('sc query %1 ^| findstr /c:"STATE"') do (  
    for /f "tokens=1,2* delims= " %%A in ("%%j") do (  
        SET SERVICE_STATE_CODE=%%A
        SET SERVICE_STATE=%%B
        rem echo %SERVICE_STATE_CODE%
        rem echo %SERVICE_STATE%
    )
)

exit /b


rem ******************************************************************
rem * Log: ���O���o�͂���
rem * 
rem * [����]
rem * 
rem * [����]
rem *   %1: ���O�t�@�C���p�X
rem *   %2: ���b�Z�[�W
rem ******************************************************************
:Log
rem echo Log %1 %2

echo %date% %time% %~2 2>&1 >> %1

exit /b

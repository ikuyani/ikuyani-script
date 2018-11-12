@setlocal enabledelayedexpansion
@echo off

rem ******************************************************************
rem * IsInteger.bat: �����ł��邩�𔻒肷��
rem *
rem * [����]
rem *   ���d�l�E���[����
rem *   �E�����̂����A�����͋L�������A��������+�L����t����
rem *   �E�����̂����A������-�L����t����
rem * 
rem *   ���߂�l��
rem *   �E�����̏ꍇ�A0��Ԃ�
rem *   �E�����ȊO�̏ꍇ�A1��Ԃ�
rem * 
rem * [����]
rem *   %1: ���肷��l
rem * 
rem * [�o�[�W����]
rem *   1.0.0
rem ******************************************************************
rem echo IsInteger.bat %1

set INTEGER=%1

rem NULL�̏ꍇ�A1��Ԃ�
if not defined INTEGER (
    endlocal
    exit /b 1
)

rem ��������
echo %INTEGER%| findstr /x /r "^[0-9]*$" 1>nul
if %ERRORLEVEL% neq 0 (
    echo %INTEGER%| findstr /x /r "^[+-][0-9]*$" 1>nul
    if !ERRORLEVEL! neq 0 (
        rem �����łȂ��ꍇ�A1��Ԃ�
        endlocal
        exit /b 1
    )
)

rem �����̏ꍇ�A0��Ԃ�
endlocal
exit /b 0

@setlocal enabledelayedexpansion
@echo off

rem ******************************************************************
rem * IsDirectoryExists.bat: �w�肳�ꂽ�p�X���t�H���_�ł��邩���؂���
rem *
rem * [����]
rem *   ���߂�l��
rem *   �E�t�H���_�̏ꍇ�A0��Ԃ�
rem *   �E�t�H���_�ȊO�̏ꍇ�A1��Ԃ�
rem * 
rem * [����]
rem *   %1: �t�H���_�p�X
rem * 
rem * [�o�[�W����]
rem *   1.0.0
rem ******************************************************************
rem echo IsDirectoryExists.bat %1

set FILE_PATH=%1

rem NULL�̏ꍇ�A1��Ԃ�
if not defined FILE_PATH (
    endlocal
    exit /b 1
)

rem �t�H���_�����݂��Ȃ��ꍇ�A1��Ԃ�
if not exist %FILE_PATH%\ (
    endlocal
    exit /b 1
)

endlocal
exit /b 0

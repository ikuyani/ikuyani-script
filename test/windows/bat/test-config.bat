rem �e�X�g�p�o�b�`�t�@�C���̃z�[���t�H���_
set TEST_HOME_DIR=%~dp0
rem �o�b�`�t�@�C���̃z�[���t�H���_
set TEST_BAT_DIR=%TEST_HOME_DIR%\..\..\..\main\windows\bat\

rem �e�X�g�ɗ��p����e���|�����t�H���_
set TEST_TEMP_DIR=%TEMP%

rem �P�̃e�X�g
rem �P�̃e�X�g�o�b�`�̃t�H���_
set TEST_UNIT_DIR=%TEST_BAT_DIR%BatUnit\
rem ���؁F�l��v
set TEST_ASSERT_EQUALS=%TEST_UNIT_DIR%AssertEquals.bat
rem ���؁F����`
set TEST_ASSERT_NULL=%TEST_UNIT_DIR%AssertNull.bat
rem ���؁F�t�@�C������
set TEST_ASSERT_FILE_EXISTS=%TEST_UNIT_DIR%AssertFileExists.bat
rem ���؁F�t�H���_����
set TEST_ASSERT_DIRECTORY_EXISTS=%TEST_UNIT_DIR%AssertDirectoryExists.bat
rem ���؁F�t�@�C���E�t�H���_��������
set TEST_ASSERT_FILE_NOT_EXISTS=%TEST_UNIT_DIR%AssertFileNotExists.bat
rem ���؁F�t�@�C���̐擪�s�ƈ�v���邩����
set TEST_ASSERT_FILE_FIRST_LINE_EQUALS=%TEST_UNIT_DIR%AssertFileFirstLineEquals.bat

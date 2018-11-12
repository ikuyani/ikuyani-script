rem テスト用バッチファイルのホームフォルダ
set TEST_HOME_DIR=%~dp0
rem バッチファイルのホームフォルダ
set TEST_BAT_DIR=%TEST_HOME_DIR%\..\..\..\main\windows\bat\

rem テストに利用するテンポラリフォルダ
set TEST_TEMP_DIR=%TEMP%

rem 単体テスト
rem 単体テストバッチのフォルダ
set TEST_UNIT_DIR=%TEST_BAT_DIR%BatUnit\
rem 検証：値一致
set TEST_ASSERT_EQUALS=%TEST_UNIT_DIR%AssertEquals.bat
rem 検証：未定義
set TEST_ASSERT_NULL=%TEST_UNIT_DIR%AssertNull.bat
rem 検証：ファイル存在
set TEST_ASSERT_FILE_EXISTS=%TEST_UNIT_DIR%AssertFileExists.bat
rem 検証：フォルダ存在
set TEST_ASSERT_DIRECTORY_EXISTS=%TEST_UNIT_DIR%AssertDirectoryExists.bat
rem 検証：ファイル・フォルダ無し検証
set TEST_ASSERT_FILE_NOT_EXISTS=%TEST_UNIT_DIR%AssertFileNotExists.bat
rem 検証：ファイルの先頭行と一致するか検証
set TEST_ASSERT_FILE_FIRST_LINE_EQUALS=%TEST_UNIT_DIR%AssertFileFirstLineEquals.bat

rem テスト用バッチファイルのホームフォルダ
set TEST_HOME_DIR=%~dp0
rem バッチファイルのホームフォルダ
set TEST_BAT_DIR=%TEST_HOME_DIR%\..\..\..\main\windows\bat\

rem 単体テスト
rem 単体テストバッチのフォルダ
set TEST_UNIT_DIR=%TEST_BAT_DIR%BatUnit\
rem 検証：値一致
set TEST_ASSERT_EQUALS=%TEST_UNIT_DIR%AssertEquals.bat
rem 検証：環境変数未定義
set TEST_ASSERT_NULL=%TEST_UNIT_DIR%AssertNull.bat

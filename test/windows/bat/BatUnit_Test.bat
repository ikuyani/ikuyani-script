@setlocal
@echo off

call "%~dp0\test-config.bat"

echo ** AssertDirectoryExists_Test *************************************
rem call BatUnit\AssertDirectoryExists_Test.bat

echo ** AssertEquals_Test *************************************
rem call BatUnit\AssertEquals_Test.bat

echo ** AssertFileExists_Test *************************************
rem call BatUnit\AssertFileExists_Test.bat

echo ** AssertFileFirstLineEquals_Test *************************************
rem call BatUnit\AssertFileFirstLineEquals_Test.bat

echo ** AssertFileNotExists_Test *************************************
rem call BatUnit\AssertFileNotExists_Test.bat

echo ** AssertNull_Test *************************************
rem call BatUnit\AssertNull_Test.bat

endlocal
pause

exit /b

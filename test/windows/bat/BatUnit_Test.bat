@setlocal
@echo off

call "%~dp0\test-config.bat"

echo ** AssertDirectoryExists_Test *************************************
call BatUnit\AssertDirectoryExists_Test.bat

echo ** AssertEquals_Test *************************************
call BatUnit\AssertEquals_Test.bat

echo ** AssertFileExists_Test *************************************
call BatUnit\AssertFileExists_Test.bat

echo ** AssertNull_Test *************************************
call BatUnit\AssertNull_Test.bat

endlocal
pause

exit /b

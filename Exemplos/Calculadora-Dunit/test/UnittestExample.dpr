program UnittestExample;

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  DUnitTestRunner,
  testexample in 'testexample.pas',
  Example1 in '..\src\Example1.pas' {FormExample1};

{$R *.RES}

begin
  DUnitTestRunner.RunRegisteredTests;
end.


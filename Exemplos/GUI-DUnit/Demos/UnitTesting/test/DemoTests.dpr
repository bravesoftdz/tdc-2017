program DemoTests;

{.$DEFINE CONSOLE_TESTRUNNER}
{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  Forms,
  TestFramework,
  GUITestRunner,
  TextTestRunner,
  FutureWindows in '..\..\..\UnitTesting\FutureWindows.pas',
  uModel in '..\src\uModel.pas',
  uMainForm in '..\src\uMainForm.pas' {MainForm},
  uStudentEditDialog in '..\src\uStudentEditDialog.pas' {StudentEditDialog},
  TestCaseBase in 'TestCaseBase.pas',
  TestStudentEditDialog in 'TestStudentEditDialog.pas',
  TestMainForm in 'TestMainForm.pas',
  TestFutureWindows in 'TestFutureWindows.pas';

{$R *.RES}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  if IsConsole then
    with TextTestRunner.RunRegisteredTests do
      Free
  else
    GUITestRunner.RunRegisteredTests;
end.


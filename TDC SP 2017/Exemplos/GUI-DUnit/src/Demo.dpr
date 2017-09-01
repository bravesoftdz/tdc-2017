program Demo;

uses
  Forms,
  uModel in 'uModel.pas',
  uMainForm in 'uMainForm.pas' {MainForm},
  uStudentEditDialog in 'uStudentEditDialog.pas' {StudentEditDialog};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.

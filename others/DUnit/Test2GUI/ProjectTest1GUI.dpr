program ProjectTest1GUI;

uses
  Vcl.Forms,
  Test1GUI in 'Test1GUI.pas' {Form1},
  TestTest1GUI in 'Test\TestTest1GUI.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

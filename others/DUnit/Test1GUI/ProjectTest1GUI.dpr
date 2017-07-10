program ProjectTest1GUI;

uses
  Vcl.Forms,
  Test1GUI in 'Test1GUI.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

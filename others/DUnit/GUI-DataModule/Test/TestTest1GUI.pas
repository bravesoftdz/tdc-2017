unit TestTest1GUI;

interface

uses
  TestFramework, System.SysUtils, Vcl.Graphics, Vcl.StdCtrls, Winapi.Windows,
  System.Variants, Vcl.ExtCtrls, Vcl.Dialogs, Vcl.Controls, Test1GUI, Vcl.Forms,
  Winapi.Messages, DM, System.Classes;

type
  TestTForm1 = class(TTestCase)
  strict private
    FForm1: TForm1;
    FDM   : TDataModule1;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestQtdComboboxCachorro;
    procedure TestQtdComboboxAve;
    procedure TestClickConfirmarComboboxEdit;
    procedure TestClickBotaoCancelar;
    procedure TestClickBotaoCancelarNaoLimpa;
    procedure TestSelectBancoDados;
    procedure TestSelectBancoDadosIncorreto;
  end;

implementation

procedure TestTForm1.SetUp;
begin
  FForm1 := TForm1.Create(nil);
  FDM    := TDataModule1.Create(nil);
end;

procedure TestTForm1.TearDown;
begin
  FDM.Free;
  FDM := nil;
  FForm1.Free;
  FForm1 := nil;
end;

procedure TestTForm1.TestQtdComboboxCachorro;
var
  Sender: TObject;
begin
  inherited;
  FForm1.RadioGroup1.ItemIndex := 0;
  FForm1.RadioGroup1Click(Sender);
  CheckEquals(FForm1.ComboBox1.Items.Count, 6);
end;

procedure TestTForm1.TestQtdComboboxAve;
var
  Sender: TObject;
begin
  FForm1.RadioGroup1.ItemIndex := 1;
  FForm1.RadioGroup1Click(Sender);
  CheckEquals(FForm1.ComboBox1.Items.Count, 5);
end;

procedure TestTForm1.TestClickConfirmarComboboxEdit;
var
  Sender: TObject;
begin
  FForm1.RadioGroup1.ItemIndex := 0;
  FForm1.RadioGroup1Click(Sender);
  FForm1.ComboBox1.ItemIndex := 2;
  FForm1.Button1Click(Sender);
  CheckEquals(FForm1.ComboBox1.Text, FForm1.Edit1.Text);
end;

procedure TestTForm1.TestClickBotaoCancelar;
var
  Sender: TObject;
begin
  FForm1.Button2Click(Sender);
  CheckEquals(FForm1.Edit1.Text, '');
  CheckEquals(FForm1.ComboBox1.Items.Count, 0);
  CheckEquals(FForm1.ComboBox1.Text, '');
end;

procedure TestTForm1.TestClickBotaoCancelarNaoLimpa;
var
  Sender: TObject;
begin
  FForm1.Button2Click(Sender);
  CheckNotEquals(FForm1.Edit1.Text, 'Test1'); // Vazio
  CheckNotEquals(FForm1.ComboBox1.Items.Count, 1); // Zero
  CheckNotEquals(FForm1.ComboBox1.Text, 'Teste2'); // Vazio
end;

procedure TestTForm1.TestSelectBancoDados;
var
  Sender: TObject;
begin
  FForm1.RadioGroup1.ItemIndex := 0; // cachorro
  FForm1.RadioGroup1Click(Sender);

  try
     FDM.conFiredac.StartTransaction;
     FForm1.ADQuery.Close;
     FForm1.ADQuery.Sql.Clear;
     FForm1.ADQuery.Sql.Add('Insert into tbanimal values (10,''VIRA LATA''); ');
     FForm1.ADQuery.ExecSQL;
     fdm.conFiredac.Commit;
  finally
     if FDM.conFiredac.InTransaction then
        fdm.conFiredac.Rollback;
  end;

  FForm1.ADQuery.Close;
  FForm1.ADQuery.Sql.Clear;
  FForm1.ADQuery.Sql.Add('Select nome from tbanimal where id = 10');
  FForm1.ADQuery.Open();
  CheckTrue(FForm1.ADQuery.FieldByName('nome').AsString = 'VIRA LATA');
end;

procedure TestTForm1.TestSelectBancoDadosIncorreto;
begin
  FForm1.ADQuery.Close;
  FForm1.ADQuery.Sql.Clear;
  FForm1.ADQuery.Sql.Add('Select nome from tbave where id = 2');
  FForm1.ADQuery.Open();
  CheckFalse(FForm1.ADQuery.FieldByName('nome').AsString = 'Papagaio'); // correto = Gavião
end;

initialization
  RegisterTest(TestTForm1.Suite);
end.


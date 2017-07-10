unit TestTest1GUI;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit 
  being tested.

}

interface

uses
  TestFramework, System.SysUtils, Vcl.Graphics, Vcl.StdCtrls, Winapi.Windows,
  System.Variants, Vcl.ExtCtrls, Vcl.Dialogs, Vcl.Controls, Test1GUI, Vcl.Forms,
  Winapi.Messages, System.Classes;

type
  // Test methods for class TForm1

  TestTForm1 = class(TTestCase)
  strict private
    FForm1: TForm1;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestQtdValoresComboboxCachorro;
    procedure TestQtdValoresComboboxAves;
    procedure TestClickBotaoSelecionarCombobox;
    procedure TestClickBotaoCancelar;
    procedure TestClickBotaoCancelarNaoLimpa;
  end;

implementation

procedure TestTForm1.SetUp;
begin
  FForm1 := TForm1.Create(nil);
end;

procedure TestTForm1.TearDown;
begin
  FForm1.Free;
  FForm1 := nil;
end;

procedure TestTForm1.TestQtdValoresComboboxCachorro;
var
  Sender: TObject;
begin
  FForm1.RadioGroup1.ItemIndex := 0;
  FForm1.RadioGroup1Click(Sender);
  CheckEquals(FForm1.ComboBox1.Items.Count, 6);
end;

procedure TestTForm1.TestQtdValoresComboboxAves;
var
  Sender: TObject;
begin
  FForm1.RadioGroup1.ItemIndex := 1;
  FForm1.RadioGroup1Click(Sender);
  CheckEquals(FForm1.ComboBox1.Items.Count, 5);
end;

procedure TestTForm1.TestClickBotaoSelecionarCombobox;
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
  CheckNotEquals(FForm1.Edit1.Text, 'Test1');
  CheckNotEquals(FForm1.ComboBox1.Items.Count, 1);
  CheckNotEquals(FForm1.ComboBox1.Text, 'Teste2');
end;

initialization
  RegisterTest(TestTForm1.Suite);
end.


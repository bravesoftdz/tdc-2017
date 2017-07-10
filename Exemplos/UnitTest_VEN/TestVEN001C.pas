unit TestVEN001C;

interface

uses
  {Delphi}
  System.SysUtils, Vcl.Graphics, Vcl.StdCtrls, Winapi.Windows,
  Buttons, DBTables, System.Variants, Vcl.ExtCtrls, Vcl.Dialogs, Vcl.Controls,
  Vcl.Forms, Winapi.Messages, System.Classes, Db,
  {DUnit}
  TestFramework, TestExtensions, GUITesting,
  {Intesig}
  PAIDETODOS, PAIPRINCIPAL, PAIMDICHILD, VEN900A, UNI800M, VSEdit,
  AcsSistemas, AcsGeral, VEN001C;

type
  TFormSetup = class(TTestSetUp)
  private
    FVEN900A: TFVEN900A;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
end;

type
  TFVEN001CTests = class(TGUITestCase)
  private
  published
    procedure VEN001C_CadastrarNovaRegistradora100;
  end;

implementation

procedure TFormSetup.SetUp;
begin
  FUNI800M := TFUNI800M.Create(nil);
  if not(Assigned(FVEN900A)) then
     Application.CreateForm(TFVEN900A, FVEN900A);
  inherited;
end;

procedure TFormSetup.TearDown;
begin
  AcsSistemas.SisSistema := '';
  if (Assigned(FUNI800M)) then
  begin
     FUNI800M.Free;
     FUNI800M := nil;
  end;
end;

procedure TFVEN001CTests.VEN001C_CadastrarNovaRegistradora100;
var
  Sender: TObject;
begin
  // Abre o formulario
  AcsSistemas.SisSistema := 'VEN';
  FVEN900A.CaixaRegistradora1Click(Sender);

  // Pesquisa o código 100
  FVEN001C.VSEditRegistradora.Text := '100';
  FVEN001C.VSEditRegistradoraExit(Sender);

  // Altera o cadastro
  FVEN001C.VSEditDescricao.Text       := 'CAIXA TESTE INTESIG';
  FVEN001C.ComboBoxOperador.ItemIndex := ListaCombobox('MASTER', FVEN001C.ComboBoxOperador, 50);
  FVEN001C.CheckBoxEmiteCF.Checked    := False;
  FVEN001C.VSEditCaixa.Text           := '001';
  FVEN001C.CB01.Checked               := True;
  FVEN001C.CB02.Checked               := True;
  FVEN001C.CB03.Checked               := True;
  FVEN001C.CB04.Checked               := True;
  FVEN001C.CB05.Checked               := True;
  FVEN001C.CB06.Checked               := True;
  FVEN001C.CB07.Checked               := True;
  FVEN001C.CB08.Checked               := True;
  FVEN001C.CB09.Checked               := True;
  FVEN001C.CB10.Checked               := True;
  FVEN001C.CB11.Checked               := True;

  // Confirma o cadastro
  FVEN001C.BitBtnConfirmaClick(Sender);

  // Digita o código
  FVEN001C.VSEditRegistradora.Text := '100';
  FVEN001C.VSEditRegistradoraExit(Sender);

  // Confere o resultado do edit motivo
  CheckEquals('CAIXA TESTE INTESIG', FVEN001C.VSEditDescricao.Text);
end;

initialization
  RegisterTest('VEN001C', TFormSetup.Create(TFVEN001CTests.Suite));
end.


unit TestVEN000C;

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
  AcsSistemas, AcsGeral, VEN000C;

type
  TFormSetup = class(TTestSetUp)
  private
    FVEN900A: TFVEN900A;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
end;

type
  TFVEN000CTests = class(TGUITestCase)
  private
    VSEditVendaPerdida: TVSEdit;
    VSEditMotivo: TVSEdit;
  published
    procedure VEN000C_AtualizarCadastro001;
    procedure VEN000C_CadastrarMotivo100;
    procedure VEN000C_ExcluirMotivo100PerguntaN;
    procedure VEN000C_ExcluirMotivo100PerguntaS;
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

procedure TFVEN000CTests.VEN000C_AtualizarCadastro001;
var
  Sender: TObject;
begin
  // Abre o formulario
  AcsSistemas.SisSistema := 'VEN';
  FVEN900A.MotivoVendasPerdidas1Click(Sender);

  // Pesquisa e cadastra código 001
  FVEN000C.QueryPesquisa.Close;
  FVEN000C.QueryPesquisa.SQL.Clear;
  FVEN000C.QueryPesquisa.Sql.Add('Select * from tbvenmotivoperda where empresa=:empresa and codigo=''001'' ');
  FVEN000C.QueryPesquisa.ParamByName('empresa').AsString := AcsSistemas.SisCodEmpresa;
  FVEN000C.QueryPesquisa.Open();
  if FVEN000C.QueryPesquisa.IsEmpty then
  begin
     FUNI800M.DatabaseBDIntesig.StartTransaction;
     FVEN000C.QueryPesquisa.Close;
     FVEN000C.QueryPesquisa.SQL.Clear;
     FVEN000C.QueryPesquisa.Sql.Add('insert into tbvenmotivovenda values (:empresa, ''001'', ''ERRO NO PEDIDO'', ''UNITTEST''); ');
     FVEN000C.QueryPesquisa.ParamByName('empresa').AsString := AcsSistemas.SisCodEmpresa;
     FVEN000C.QueryPesquisa.ExecSQL;
     FUNI800M.DatabaseBDIntesig.Commit;
  end;

  // Digita o código
  FVEN000C.VSEditVendaPerdida.Text := '001';
  FVEN000C.VSEditVendaPerdidaExit(Sender);

  // Altera a descricao
  FVEN000C.VSEditMotivo.Text := 'ERRO NO PEDIDO DE VENDA';

  // Confirma o cadastro
  FVEN000C.BitBtnConfirmaClick(Sender);

  // Digita o código
  FVEN000C.VSEditVendaPerdida.Text := '001';
  FVEN000C.VSEditVendaPerdidaExit(Sender);

  // Confere o resultado do edit motivo
  CheckEquals(FVEN000C.VSEditMotivo.Text, 'ERRO NO PEDIDO DE VENDA');
end;

procedure TFVEN000CTests.VEN000C_CadastrarMotivo100;
var
  Sender: TObject;
begin
  // Abre o formulario
  AcsSistemas.SisSistema := 'VEN';
  FVEN900A.MotivoVendasPerdidas1Click(Sender);

  // Digita o código
  FVEN000C.VSEditVendaPerdidaEnter(Sender);
  FVEN000C.VSEditVendaPerdida.Text := '100';
  FVEN000C.VSEditVendaPerdidaExit(Sender);

  // Altera a descricao
  FVEN000C.VSEditMotivo.Text := 'TESTE INTESIG';

  // Confirma o cadastro
  FVEN000C.BitBtnConfirmaClick(Sender);

  // Digita o código
  FVEN000C.VSEditVendaPerdidaEnter(Sender);
  FVEN000C.VSEditVendaPerdida.Text := '100';
  FVEN000C.VSEditVendaPerdidaExit(Sender);

  // Confere o resultado do edit motivo
  CheckEquals(FVEN000C.VSEditMotivo.Text, 'TESTE INTESIG');

end;

procedure TFVEN000CTests.VEN000C_ExcluirMotivo100PerguntaN;
var
  Window: hWnd;
  TimerId: UINT_PTR;
  Sender: TObject;
begin
  // Abre o formulario
  AcsSistemas.SisSistema := 'VEN';
  FVEN900A.MotivoVendasPerdidas1Click(Sender);

  // Digita o código
  FVEN000C.VSEditVendaPerdidaEnter(Sender);
  FVEN000C.VSEditVendaPerdida.Text := '100';
  FVEN000C.VSEditVendaPerdidaExit(Sender);

  // Não Excluir cadastro
  TimerId := SetTimer(0, 0, 1 * 100, @AcsGeral.MessageBoxNO);
  FVEN000C.BitBtnEliminaClick(Sender);
  CheckFalse(KillTimer(0, TimerId));

  // Digita o código
  FVEN000C.VSEditVendaPerdidaEnter(Sender);
  FVEN000C.VSEditVendaPerdida.Text := '100';
  FVEN000C.VSEditVendaPerdidaExit(Sender);

  // Confere o resultado do edit motivo
  CheckEquals(FVEN000C.VSEditMotivo.Text, 'TESTE INTESIG');

end;

procedure TFVEN000CTests.VEN000C_ExcluirMotivo100PerguntaS;
var
  Window: hWnd;
  TimerId: UINT_PTR;
  Sender: TObject;
begin
  // Abre o formulario
  AcsSistemas.SisSistema := 'VEN';
  FVEN900A.MotivoVendasPerdidas1Click(Sender);

  // Digita o código
  FVEN000C.VSEditVendaPerdidaEnter(Sender);
  FVEN000C.VSEditVendaPerdida.Text := '100';
  FVEN000C.VSEditVendaPerdidaExit(Sender);

  // Excluir cadastro
  TimerId := SetTimer(0, 0, 1 * 100, @AcsGeral.MessageBoxYES);
  FVEN000C.BitBtnEliminaClick(Sender);
  CheckFalse(KillTimer(0, TimerId));

  // Digita o código
  FVEN000C.VSEditVendaPerdidaEnter(Sender);
  FVEN000C.VSEditVendaPerdida.Text := '100';
  FVEN000C.VSEditVendaPerdidaExit(Sender);

  // Confere o resultado do edit motivo
  CheckEquals(FVEN000C.VSEditMotivo.Text, '');

end;

initialization
  RegisterTest('VEN000C', TFormSetup.Create(TFVEN000CTests.Suite));
end.


unit TestVEN602E;

interface

uses
  {Delphi}
  System.SysUtils, Vcl.Graphics, Vcl.StdCtrls, Winapi.Windows,
  Buttons, DBTables, System.Variants, Vcl.ExtCtrls, Vcl.Dialogs,
  Vcl.Controls, Vcl.Forms, Winapi.Messages, System.Classes, Db,
  Datasnap.Provider, Datasnap.DBClient, Registry, Spin, Menus, Mask,

  RxCurrEdit, RxToolEdit, Grids, ComCtrls, rxTimerLst, numedit,
  RpRenderHTML, RpRenderRTF, RpConDS, RpDefine, RpRender, RpConBDE, RpCon,
  RpRave, RpRenderText, RpBase, RpSystem, RpRenderPDF,

  {DUnit}
  TestFramework, TestExtensions, GUITesting,

  {Intesig}
  PAIDETODOS, PAIPRINCIPAL, PAIMDICHILD, VEN900A, UNI800M, VSDEdit, VSEdit,
  AcsSistemas, AcsGeral, VEN602E;

type
  TFormSetup = class(TTestSetUp)
  private
    FVEN900A: TFVEN900A;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
end;

type
  TFVEN602ETests = class(TGUITestCase)
  private
  published
    procedure VEN602E_RadioGroupOperacaoClick;
    procedure VEN602E_InformaPedidoConfereInformacoes;
    procedure VEN602E_RegistraPedido_Dinheiro;
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

procedure TFVEN602ETests.VEN602E_RadioGroupOperacaoClick;
var
  Sender: TObject;
begin
  // Abre o formulario
  AcsSistemas.SisSistema := 'VEN';
  FVEN900A.Movimentao1Click(Sender);

  // Click no RadioGroup
  FVEN602E.RadioGroupOperacao.ItemIndex := 0;
  FVEN602E.LabelVlrFaturar.Caption := 'Valor à Faturar';
  CheckEquals(FVEN602E.LabelVlrFaturar.Caption, 'Valor à Faturar');

  FVEN602E.RadioGroupOperacao.ItemIndex := 1;
  FVEN602E.LabelVlrFaturar.Caption := 'Valor Movimento';
  CheckEquals(FVEN602E.LabelVlrFaturar.Caption, 'Valor Movimento');
end;

procedure TFVEN602ETests.VEN602E_InformaPedidoConfereInformacoes;
var
  Sender: TObject;
begin

  // Abre o formulario
  AcsSistemas.SisSistema := 'VEN';
  FVEN900A.Movimentao1Click(Sender);

  // Lançamento
  FVEN602E.RadioGroupOperacao.ItemIndex := 0;
  FVEN602E.VSEditCartao.Text := '';
  FVEN602E.VSEditPedidoEnter(FVEN602E.VSEditPedido);
  FVEN602E.VSEditPedidoExit(Sender);
  CheckFalse(FVEN602E.VSDEditCliente.Text = '');
  CheckFalse(StringGridVazia(FVEN602E.StringGridParcelas));

  // Limpa a tela
  FVEN602E.BitBtnCancelaClick(Sender);
  CheckTrue(FVEN602E.VSDEditCliente.Text = '');
  CheckTrue(StringGridVazia(FVEN602E.StringGridParcelas));

end;

procedure TFVEN602ETests.VEN602E_RegistraPedido_Dinheiro;
var
  Sender: TObject;
  Window: hWnd;
  TimerId: UINT_PTR;
  PedidoRegistrado: String;
begin

  // Abre o formulario
  AcsSistemas.SisSistema := 'VEN';
  FVEN900A.Movimentao1Click(Sender);

  // Lançamento
  FVEN602E.RadioGroupOperacao.ItemIndex := 0;
  FVEN602E.VSEditCartao.Text := '';
  FVEN602E.VSEditPedidoEnter(FVEN602E.VSEditPedido);
  FVEN602E.VSEditPedidoExit(Sender);
  PedidoRegistrado := FVEN602E.VSEditPedido.Text;
  CheckFalse(FVEN602E.VSDEditCliente.Text = '');
  CheckFalse(StringGridVazia(FVEN602E.StringGridParcelas));

  // Seleção de todas as parcelas
  FVEN602E.SelecionarTodos1Click(Sender);

  // seleciona a forma de recebimento
  FVEN602E.CboFormaPagto.ItemIndex := 1; // dinheiro

  // Carregar valor total a faturar
  FVEN602E.EdtFaturarEnter(Sender);
  CheckTrue(FVEN602E.EditValorTotal.value > 0);

  TimerId := SetTimer(0, 0, 1 * 100, @AcsGeral.MessageBoxYes);
  FVEN602E.BitBtnInsereClick(Sender);
  CheckFalse(KillTimer(0, TimerId));

  TimerId := SetTimer(0, 0, 1 * 100, @AcsGeral.MessageBoxYes);
  FVEN602E.BitBtnConfirmaClick(Sender);
  CheckFalse(KillTimer(0, TimerId));

  // Limpa a tela
  FVEN602E.BitBtnCancelaClick(Sender);
  CheckTrue(FVEN602E.VSDEditCliente.Text = '');
  CheckTrue(StringGridVazia(FVEN602E.StringGridParcelas));

  // conferencia da gravação do pedido
  FVEN602E.QueryPesquisa.Close;
  FVEN602E.QueryPesquisa.SQL.Clear;
  FVEN602E.QueryPesquisa.Sql.Add('Select *  '+
                                 'From tbvenpedido '+
                                 'Where Empresa = :empresa '+
                                 '  and pedido = :pedido ');
  FVEN602E.QueryPesquisa.ParamByName('EMPRESA').AsString := AcsSistemas.SisCodEmpresa;
  FVEN602E.QueryPesquisa.ParamByName('PEDIDO').AsString  := PedidoRegistrado;
  FVEN602E.QueryPesquisa.Open();
  if not(FVEN602E.QueryPesquisa.IsEmpty) then
     CheckEquals('Pedido ' + PedidoRegistrado + ' Registrado: S',
                 'Pedido ' + PedidoRegistrado + ' Registrado: ' + FVEN602E.QueryPesquisa.FieldByName('REGISTRADO').AsString)
  else
     CheckEquals('Não houve problemas no registro do pedido',
                 'Houve problemas no registro do pedido');

  // conferencia da gravação do pedido
  FVEN602E.QueryPesquisa.Close;
  FVEN602E.QueryPesquisa.SQL.Clear;
  FVEN602E.QueryPesquisa.Sql.Add('Select *  '+
                                 'From tbvenformarec '+
                                 'Where Empresa = :empresa '+
                                 '  and pedido = :pedido ');
  FVEN602E.QueryPesquisa.ParamByName('EMPRESA').AsString := AcsSistemas.SisCodEmpresa;
  FVEN602E.QueryPesquisa.ParamByName('PEDIDO').AsString  := PedidoRegistrado;
  FVEN602E.QueryPesquisa.Open();
  if not(FVEN602E.QueryPesquisa.IsEmpty) then
     CheckEquals('Pedido ' + PedidoRegistrado + ' Tipo Pagamento: 00',
                 'Pedido ' + PedidoRegistrado + ' Tipo Pagamento: ' + FVEN602E.QueryPesquisa.FieldByName('tipo_pagamento').AsString)
  else
     CheckEquals('Não houve problemas na forma de recebimento do pedido',
                 'Houve problemas na forma de recebimento do pedido');
end;

initialization
  RegisterTest('VEN602E', TFormSetup.Create(TFVEN602ETests.Suite));
end.


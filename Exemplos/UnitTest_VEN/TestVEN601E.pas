unit TestVEN601E;

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
  IniFiles, Contnrs, ImgList, RxHints,

  {DUnit}
  TestFramework, TestExtensions, GUITesting, TestCaseBase, FutureWindows,

  {Intesig}
  PAIDETODOS, PAIPRINCIPAL, PAIMDICHILD, VEN900A, UNI800M, VSDEdit, VSEdit,
  AcsSistemas, AcsGeral, VEN601E,
  IEF000F, REC000F, UsaPESQMODAL, UsaProduto, USACADEADO, VEN6013,
  ECF, UsaECF, UsaEcfDaruma, UsaEcfEpson, UsaECFElgin,
  IEF003P, IEF611X, UsaPesqProduto, UsaNFServico, VEN601W, REC001F, EST001F, EST087Z,
  EST000F, VEN601Z, VEN601Y, VEN601X, VEN601I, VEN601V, VEN400R, VEN401R,
  VEN402R, VEN601U, VEN601T, VEN601S, VEN601R, VEN415R, VEN414R, VEN601J, VEN000F,
  VEN417R, VEN601O, VEN601N, VEN601M, VEN601L, EST023U, EST016Z, VEN602E, EST023T,
  VEN601K, VEN022P, VEN601P, VEN601B, VEN601A, VEN601C, VEN601D, VEN601AC, VEN601AB,
  VEN438R, VEN640E, VEN601H, VEN601AD, VEN601AE, IAG000F, IAG453R, VEN6011,
  VEN6012, VEN654E, IAG037C, VEN601AF, VEN601AG, VEN601AH, VEN504R, AST605E,
  VEN6014, VEN601VA, IEF004E, VEN519R, VEN601AI, VEN601AJ, REC210P, REC220P, ICT000F,
  IEF611E, VEN639E, VEN639E1, VEN630Z, VEN601LA;

type
  TFormSetup = class(TTestSetUp)
  private
    FVEN900A: TFVEN900A;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
end;

type
  TFVEN601ETests = class(TGUITestCase)
  private
  published
    procedure VEN601E_AbreFechaForm;
    procedure VEN601E_RealizarVenda_Simples_5_Itens;
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

procedure TFVEN601ETests.VEN601E_AbreFechaForm;
var
  Sender: TObject;
begin
  AcsSistemas.SisSistema := 'VEN';
  FVEN900A.TerminaldeVenda1Click(Sender);
  CheckEquals('Terminal de Vendas', FVEN601E.Caption);
end;

procedure TFVEN601ETests.VEN601E_RealizarVenda_Simples_5_Itens;
var
  Sender: TObject;
  futureWindow: IFutureWindow;
  Window: hWnd;
  TimerId: UINT_PTR;
  Index: Integer;

  Msg,
  ComissionadoInformado,
  ClienteInformado,
  NaturezaInformado,
  CondicaoPagtoInformado: String;

begin
  // Abre o formulario
  AcsSistemas.SisSistema := 'VEN';
  FVEN900A.TerminaldeVenda1Click(Sender);

  CheckEquals('Terminal de Vendas', FVEN601E.Caption);

  // EditCartao
  if FVEN601E.VSEditCartao.Visible and
     FVEN601E.VSEditCartao.Enabled and
     FVEN601E.VSEditCartao.CanFocus then
  begin
     FVEN601E.VSEditCartao.Text := '';
     FVEN601E.VSEditCartaoExit(Sender);
  end;

  // EditComissionado
  if FVEN601E.VSEditComissionado.Visible and
     FVEN601E.VSEditComissionado.Enabled and
     FVEN601E.VSEditComissionado.CanFocus then
  begin
     try
        FVEN601E.QueryPesquisa.Close;
        FVEN601E.QueryPesquisa.SQL.Clear;
        FVEN601E.QueryPesquisa.Sql.Add('Select top 1 c.codigo as codigo, c.nome as nome '+
                                       'From TBESTCOMISSIONADO C, TBESTTIPOCOMISSIONADO TC '+
                                       'Where C.Tipo = TC.Codigo And C.Empresa = :empresa '+
                                       'And C.Ativo = ''S'' And TC.Tipo = ''C'' '+
                                       'Order by c.codigo ');
        FVEN601E.QueryPesquisa.ParamByName('EMPRESA').AsString := AcsSistemas.SisCodEmpresa;
        FVEN601E.QueryPesquisa.Open();
        if not(FVEN601E.QueryPesquisa.IsEmpty) then
        begin
           FVEN601E.VSEditComissionado.Text := IntToStr(FVEN601E.QueryPesquisa.FieldByName('CODIGO').AsInteger);
           FVEN601E.VSEditComissionadoExit(FVEN601E.VSEditComissionado);
           CheckEquals(FVEN601E.QueryPesquisa.FieldByName('CODIGO').AsString,
                       FVEN601E.VSEditComissionado.Text);
           CheckEquals('Terminal de Vendas  -  Vendedor(a): ' + FVEN601E.QueryPesquisa.FieldByName('NOME').AsString,
                       FVEN601E.Caption);
        end
        else
           CheckEquals('Código do comissionado válido!', 'Código do comissionado não está ativo para vender!');
        FVEN601E.QueryPesquisa.Close();
     finally
        ComissionadoInformado := FVEN601E.VSEditComissionado.Text;
     end;
  end;

  // VSEditCliente
  if FVEN601E.VSEditCliente.Visible and
     FVEN601E.VSEditCliente.Enabled and
     FVEN601E.VSEditCliente.CanFocus then
  begin
     try
        FVEN601E.QueryPesquisa.Close;
        FVEN601E.QueryPesquisa.SQL.Clear;
        FVEN601E.QueryPesquisa.Sql.Add('Select codigo, nome '+
                                       'From tbuniclifor '+
                                       'Where Empresa = :empresa And situacao=''A'' '+
                                       'order by 1 ');
        FVEN601E.QueryPesquisa.ParamByName('EMPRESA').AsString := AcsSistemas.SisCodEmpresa;
        FVEN601E.QueryPesquisa.Open();
        if not(FVEN601E.QueryPesquisa.IsEmpty) then
        begin
           FVEN601E.VSEditCliente.Text := IntToStr(FVEN601E.QueryPesquisa.FieldByName('CODIGO').AsInteger);
           FVEN601E.VSEditClienteExit(FVEN601E.VSEditCliente);
           CheckEquals(FVEN601E.QueryPesquisa.FieldByName('CODIGO').AsString,
                       FVEN601E.VSEditCliente.Text);

           CheckEquals(FVEN601E.QueryPesquisa.FieldByName('NOME').AsString,
                       FVEN601E.VSEditNomeCliente.Text);
        end
        else
           CheckEquals('Código do cliente válido!', 'Código do cliente não está ativo para vender!');
        FVEN601E.QueryPesquisa.Close();
     finally
        ClienteInformado := FVEN601E.VSEditCliente.Text;
     end;
  end;

  // abrir dados do cliente
  futureWindow := TFutureWindows.Expect(TFVEN601AJ.ClassName)
    .ExecProc(
      procedure (const AWindow: IWindow)
      var form: TFVEN601AJ;
      begin
         form := AWindow.AsControl as TFVEN601AJ;
         CheckNotNull(form);
         TTestCaseBase.ProcessMessages(0.2);

         CheckEquals('VEN601AJ-'+iif(form.VSEditCNPJ.Text='','Dados do Consumidor','Dados do Cliente'),
                     'VEN601AJ-'+form.Caption);
         form.VSEditNomeCliente.Text := FVEN601E.VSEditNomeCliente.Text;
         CheckEquals('VEN601AJ-'+FVEN601E.VSEditNomeCliente.Text, 'VEN601AJ-'+form.VSEditNomeCliente.Text);
         TTestCaseBase.ProcessMessages(0.2);
         form.BitBtnSairClick(Sender);
      end
  );
  if FVEN601E.BitBtnDadosCliente.Visible and
     FVEN601E.BitBtnDadosCliente.Enabled and
     FVEN601E.BitBtnDadosCliente.CanFocus then
  begin
     FVEN601AJ.ShowModal;
  end;

  // natureza de operacao
  if FVEN601E.VSEditNaturezaSaida.Visible and
     FVEN601E.VSEditNaturezaSaida.Enabled and
     FVEN601E.VSEditNaturezaSaida.CanFocus then
  begin
     try
        FVEN601E.QueryPesquisa.Close;
        FVEN601E.QueryPesquisa.SQL.Clear;
        FVEN601E.QueryPesquisa.Sql.Add('select * from tbestnatureza ' +
                                       'where empresa         = :empresa '+
                                       '  and DESATIVA        = ''N'' '+
                                       '  and tipo_natureza   = ''01'' '+
                                       '  and gera_financeiro = ''S'' '+
                                       '  and gera_estoque    = ''S'' '+
                                       '  and modelonota      = ''55'' '+
                                       '  and emite_nfe       = ''S'' ');
        FVEN601E.QueryPesquisa.ParamByName('EMPRESA').AsString := AcsSistemas.SisCodEmpresa;
        FVEN601E.QueryPesquisa.Open();
        if not(FVEN601E.QueryPesquisa.IsEmpty) then
        begin
           FVEN601E.VSEditNaturezaSaida.Text := IntToStr(FVEN601E.QueryPesquisa.FieldByName('CODIGO').AsInteger);
           FVEN601E.VSEditNaturezaSaidaExit(FVEN601E.VSEditNaturezaSaida);
           CheckEquals(FVEN601E.QueryPesquisa.FieldByName('CODIGO').AsString,
                       FVEN601E.VSEditNaturezaSaida.Text);

           CheckEquals(FVEN601E.QueryPesquisa.FieldByName('DESCRICAO').AsString,
                       FVEN601E.StaticTextStatusOp.Text);
        end
        else
           CheckEquals('Código da natureza de operação válida!', 'Código da natureza de operação não está ativa para vender!');
        FVEN601E.QueryPesquisa.Close();
     finally
        NaturezaInformado := FVEN601E.VSEditNaturezaSaida.Text;
     end;
  end;

  if FVEN601E.RadioGroupPedPro.Visible and
     FVEN601E.RadioGroupPedPro.Enabled and
     FVEN601E.RadioGroupPedPro.CanFocus then
  begin
     FVEN601E.RadioGroupPedProExit(FVEN601E.RadioGroupPedPro);
     CheckEquals('0', IntToStr(FVEN601E.RadioGroupPedPro.ItemIndex));
  end;

  if FVEN601E.ComboBoxPedido.Visible and
     FVEN601E.ComboBoxPedido.Enabled and
     FVEN601E.ComboBoxPedido.CanFocus then
  begin
     FVEN601E.ComboBoxPedidoExit(FVEN601E.ComboBoxPedido);
     CheckEquals('NOVO', FVEN601E.ComboBoxPedido.Text);
  end;

  // Condicao de pagamento
  if FVEN601E.VSEditCondicaoPagto.Visible and
     FVEN601E.VSEditCondicaoPagto.Enabled and
     FVEN601E.VSEditCondicaoPagto.CanFocus then
  begin
     try
        FVEN601E.QueryPesquisa.Close;
        FVEN601E.QueryPesquisa.SQL.Clear;
        FVEN601E.QueryPesquisa.Sql.Add('select first * ' +
                                       'from TBESTCONDICAOPAGTO '+
                                       'where empresa = :empresa '+
                                       '  and ATIVADO = ''S'' ');
        FVEN601E.QueryPesquisa.ParamByName('EMPRESA').AsString := AcsSistemas.SisCodEmpresa;
        FVEN601E.QueryPesquisa.Open();
        if not(FVEN601E.QueryPesquisa.IsEmpty) then
        begin
           FVEN601E.VSEditCondicaoPagto.Text := FVEN601E.QueryPesquisa.FieldByName('CODIGO').AsString;
           FVEN601E.VSEditCondicaoPagtoExit(FVEN601E.VSEditCondicaoPagto);
           CheckEquals(FVEN601E.QueryPesquisa.FieldByName('CODIGO').AsString, FVEN601E.VSEditCondicaoPagto.Text);
           CheckEquals(FVEN601E.QueryPesquisa.FieldByName('DESCRICAO').AsString, FVEN601E.VSDEditCondicaoPagto.Text);
        end
        else
           CheckEquals('Código da condição de pagamento válida!', 'Código da condição de pagamento não está ativa para vender!');
        FVEN601E.QueryPesquisa.Close();
     finally
        CondicaoPagtoInformado := FVEN601E.VSEditCondicaoPagto.Text;
     end;
  end;

  index := 0;
  repeat
     index := index + 1;

     // Produto
     if FVEN601E.VSEditProduto.Visible and
        FVEN601E.VSEditProduto.Enabled and
        FVEN601E.VSEditProduto.CanFocus then
     begin
        FVEN601E.QueryPesquisa.Close;
        FVEN601E.QueryPesquisa.SQL.Clear;

        FVEN601E.QueryPesquisa.Sql.Add('SELECT TOP 1 START AT :SEQUENCIA PROD.*, '+
                                       '       (select max((ESTOQUE_BALANCO + ESTOQUE_ORIGEM)) '+
                                       '        from TBESTPRODUTO_ALMOX '+
                                       '        where EMPRESA = prod.empresa and almox=''001'' and PRODUTO = prod.codigo_int) as estoque '+
                                       'From TBESTPRODUTO prod '+
                                       'where prod.empresa = :empresa '+
                                       '  and prod.STATUS = ''A'' '+
                                       '  and estoque > 1 '+
                                       'order by empresa, codigo_int ');

        FVEN601E.QueryPesquisa.ParamByName('EMPRESA').AsString := AcsSistemas.SisCodEmpresa;
        FVEN601E.QueryPesquisa.ParamByName('SEQUENCIA').AsInteger := index;
        Parametros(FVEN601E.QueryPesquisa);
        FVEN601E.QueryPesquisa.Open;
        if not(FVEN601E.QueryPesquisa.IsEmpty) then
        begin
           FVEN601E.VSEditProduto.Text := FVEN601E.QueryPesquisa.FieldByName('CODIGO_INT').AsString;
           FVEN601E.VSEditProdutoExit(FVEN601E.VSEditProduto);
           CheckEquals(FVEN601E.QueryPesquisa.FieldByName('CODIGO_INT').AsString, FVEN601E.VSEditProduto.Text);
           CheckEquals(FVEN601E.QueryPesquisa.FieldByName('DESCRICAO').AsString, FVEN601E.VSDEditProduto.Text);
        end
        else
           CheckEquals('Código do produto válido!', 'Código produto não está ativo para vender!');
        FVEN601E.QueryPesquisa.Close();
     end;

     (*
     if FVEN601E.VSEditCorProduto.Visible and
        FVEN601E.VSEditCorProduto.Enabled and
        FVEN601E.VSEditCorProduto.CanFocus and
        FVEN601E.VSEditTamanho.Visible and
        FVEN601E.VSEditCorProduto.Enabled and
        FVEN601E.VSEditCorProduto.CanFocus then
     begin
        CheckEquals('Implementado!', 'Não implementado!');
     end;
     *)

     // Informa a quantidade e valor unitario
     FVEN601E.NumberEditQuantidade.Value := 1.00;
     if FVEN601E.NumberEditPrecoUnitario.Value <= 0 then
        FVEN601E.NumberEditPrecoUnitario.Value := 1.00;

     // Insere o produto
     if FVEN601E.BitBtnInsereProduto.Visible and
        FVEN601E.BitBtnInsereProduto.Enabled and
        FVEN601E.BitBtnInsereProduto.CanFocus then
     begin
        FVEN601E.BitBtnInsereProdutoClick(FVEN601E.BitBtnInsereProduto);
        CheckEquals('Produto lançado e incluído na StringGrid',
                    iif(not(StringGridVazia(FVEN601E.StringGrid)),
                        'Produto lançado e incluído na StringGrid',
                        'Produto não lançado corretamente na StringGrid')
                   );
     end;
  until (index = 5);

  // Clica em parcelas
  futureWindow := TFutureWindows.Expect(TFVEN601X.ClassName)
    .ExecProc(
      procedure (const AWindow: IWindow)
      var form: TFVEN601X;
      begin
         form := AWindow.AsControl as TFVEN601X;
         CheckNotNull(form);
         TTestCaseBase.ProcessMessages(0.2);
         CheckEquals('VEN601X-StringGrid parcelas preenchida',
                     iif(not(StringGridVazia(form.StringGrid)),
                         'VEN601X-StringGrid parcelas preenchida',
                         'VEN601X-StringGrid parcelas não preenchida')
                    );
         form.ButtonFecharClick(Sender);
      end
  );
  if FVEN601E.BitBtnPrazo.Visible and
     FVEN601E.BitBtnPrazo.Enabled and
     FVEN601E.BitBtnPrazo.CanFocus then
  begin
     FVEN601E.BitBtnPrazoClick(Sender);
  end;

  // distribuição almoxarifados
  futureWindow := TFutureWindows.Expect(TFEST023U.ClassName)
    .ExecProc(
      procedure (const AWindow: IWindow)
      var form: TFEST023U;
      begin
         form := AWindow.AsControl as TFEST023U;
         CheckNotNull(form);
         TTestCaseBase.ProcessMessages(0.2);
         form.ButtonOKClick(Sender);
      end
    );

  // previsao de entrega
  futureWindow := TFutureWindows.Expect(TFVEN640E.ClassName)
    .ExecProc(
      procedure (const AWindow: IWindow)
      var form: TFVEN640E;
      begin
         form := AWindow.AsControl as TFVEN640E;
         CheckNotNull(form);
         TTestCaseBase.ProcessMessages(0.2);
         CheckEquals('VEN640E-StringGrid entregas preenchida',
                     iif(not(StringGridVazia(form.StringGrid)),
                         'VEN640E-StringGrid entregas preenchida',
                         'VEN640E-StringGrid entregas não preenchida')
                    );
         form.BitBtnSairClick(Sender);
      end
    );

  // fechar tela do messagebox para impressao do pedido
  futureWindow := TFutureWindows.Expect(MESSAGE_BOX_WINDOW_CLASS)
    .ExecProc(
      procedure (const AWindow: IWindow)
      var c: Char;
      begin
         TTestCaseBase.ProcessMessages(0.1);
         AWindow.BringToFront;
         CheckEquals('Impressão do Pedido-Informação', 'Impressão do Pedido-'+AWindow.Text);
      end
    )
    .ExecCloseWindow();

  // Confirma pedido
  futureWindow := TFutureWindows.Expect(TFVEN601V.ClassName)
    .ExecProc(
      procedure (const AWindow: IWindow)
      var form: TFVEN601V;
      begin
         form := AWindow.AsControl as TFVEN601V;
         CheckNotNull(form);
         TTestCaseBase.ProcessMessages(0.2);
         CheckEquals('Últimas definições',form.Caption);
         form.ButtonOKClick(Sender);
      end
  );
  if FVEN601E.BitBtnConfirma.Visible and
     FVEN601E.BitBtnConfirma.Enabled and
     FVEN601E.BitBtnConfirma.CanFocus then
  begin
     FVEN601E.BitBtnConfirmaClick(Sender);
  end;

  // conferencia de campo da gravação do pedido
  FVEN601E.QueryPesquisa.Close;
  FVEN601E.QueryPesquisa.SQL.Clear;
  FVEN601E.QueryPesquisa.Sql.Add('Select *  '+
                                 'From tbvenpedido '+
                                 'Where Empresa = :empresa '+
                                 '  and pedido = :pedido ');
  FVEN601E.QueryPesquisa.ParamByName('EMPRESA').AsString := AcsSistemas.SisCodEmpresa;
  FVEN601E.QueryPesquisa.ParamByName('PEDIDO').AsString  := FVEN601E.NumeroPedido;
  FVEN601E.QueryPesquisa.Open();
  if not(FVEN601E.QueryPesquisa.IsEmpty) then
  begin
     CheckEquals(ComissionadoInformado,  FVEN601E.QueryPesquisa.FieldByName('COMISSIONADO').AsString);
     CheckEquals(ClienteInformado,       FVEN601E.QueryPesquisa.FieldByName('CLIENTE').AsString);
     CheckEquals(NaturezaInformado,      FVEN601E.QueryPesquisa.FieldByName('NATUREZA_OPERACAO').AsString);
     CheckEquals(CondicaoPagtoInformado, FVEN601E.QueryPesquisa.FieldByName('CONDICAO_PAGAMENTO').AsString);
  end
  else
     CheckEquals('Não houve problemas na gravação do pedido', 'Houve problemas na gravação do pedido');

  // confere quantidade de itens
  FVEN601E.QueryPesquisa.Close;
  FVEN601E.QueryPesquisa.SQL.Clear;
  FVEN601E.QueryPesquisa.Sql.Add('Select count(*) as quantidade_itens '+
                                 'From tbvenitenspedido '+
                                 'Where Empresa = :empresa '+
                                 '  and pedido = :pedido ');
  FVEN601E.QueryPesquisa.ParamByName('EMPRESA').AsString := AcsSistemas.SisCodEmpresa;
  FVEN601E.QueryPesquisa.ParamByName('PEDIDO').AsString  := FVEN601E.NumeroPedido;
  FVEN601E.QueryPesquisa.Open();
  if not(FVEN601E.QueryPesquisa.IsEmpty) then
  begin
     CheckEquals('Quantidade de Itens do pedido ' + FVEN601E.NumeroPedido + ': ' + IntToStr(4),
                 'Quantidade de Itens do pedido ' + FVEN601E.NumeroPedido + ': ' + IntToStr(FVEN601E.QueryPesquisa.FieldByName('quantidade_itens').AsInteger));
  end
  else
     CheckEquals('Não houve problemas na gravação dos itens do pedido', 'Houve problemas na gravação dos itens do pedido');

  FVEN601E.BitBtnCancelaClick(FVEN601E.BitBtnCancela);
  FVEN601E.BitBtnSairClick(FVEN601E.BitBtnSair);

end;

initialization
  RegisterTest('VEN601E', TFormSetup.Create(TFVEN601ETests.Suite));
end.


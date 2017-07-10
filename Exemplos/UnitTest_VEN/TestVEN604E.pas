unit TestVEN604E;

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
  TestFramework, TestExtensions, GUITesting, TestCaseBase, FutureWindows,

  {Intesig}
  PAIDETODOS, PAIPRINCIPAL, PAIMDICHILD, VEN900A, UNI800M, VSDEdit, VSEdit,
  AcsSistemas, AcsGeral, VEN604E;

type
  TFormSetup = class(TTestSetUp)
  private
    FVEN900A: TFVEN900A;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
end;

type
  TFVEN604ETests = class(TTestCaseBase)
  private
  published
    procedure VEN604E_AbreCaixa100_ConfirmaNao;
    procedure VEN604E_AbreCaixa100_ConfirmaSim;
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

procedure TFVEN604ETests.VEN604E_AbreCaixa100_ConfirmaSim;
var
  futureWindow: IFutureWindow;
  FormVEN604E: TFVEN604E;
  Window: hWnd;
  TimerId: UINT_PTR;
  Sender: TObject;
  Msg: String;
begin
  // Chamando o Form Modal normalmente não funciona.
  // Tem que ser chamado com FutureWindows e função anônima.
  futureWindow := TFutureWindows.Expect(TFVEN604E.ClassName)
    .ExecProc(
      procedure (const AWindow: IWindow)
      var
        form: TFVEN604E;
      begin
        form := AWindow.AsControl as TFVEN604E;
        CheckNotNull(form);
        TTestCaseBase.ProcessMessages(0.2);

        form.VSEditRegistradora.Text := '100';
        form.VSEditRegistradoraExit(Sender);
        form.ComboBoxOperador.ItemIndex := ListaCombobox('MASTER', form.ComboBoxOperador, 50);

        TTestCaseBase.ProcessMessages(0.2); // let's see the changes

        TimerId := SetTimer(0, 0, 1 * 100, @AcsGeral.MessageBoxYES);
        form.BitBtnConfirmaClick(Sender);
        CheckFalse(KillTimer(0, TimerId));

        form.BitBtnSairClick(Sender);
      end
  );

  if not(Assigned(FVEN900A)) then
     Application.CreateForm(TFVEN900A, FVEN900A);
  AcsSistemas.SisSistema := 'VEN';

  // troca todas as registradoras para "N"
  FUNI800M.DatabaseBDIntesig.StartTransaction;
  FVEN900A.QueryConsulta.Close;
  FVEN900A.QueryConsulta.SQL.Clear;
  FVEN900A.QueryConsulta.Sql.Add('update TBVenRegistradora set em_uso=''N'' '+
                                 'where empresa=:empresa and usuario_operador=''MASTER'' ');
  FVEN900A.QueryConsulta.ParamByName('empresa').AsString := AcsSistemas.SisCodEmpresa;
  FVEN900A.QueryConsulta.ExecSQL;
  FUNI800M.DatabaseBDIntesig.Commit;
  FVEN900A.QueryConsulta.Close;

  // Abre o VEN604E dentro do TFutureWindows
  Application.CreateForm(TFVEN604E, FVEN604E);
  FVEN604E.ShowModal;

  // Pesquisa se cadastro ok
  FVEN900A.QueryConsulta.Close;
  FVEN900A.QueryConsulta.SQL.Clear;
  FVEN900A.QueryConsulta.Sql.Add('Select em_uso from TBVenRegistradora where empresa=:empresa and codigo=''100'' ');
  FVEN900A.QueryConsulta.ParamByName('empresa').AsString := AcsSistemas.SisCodEmpresa;
  FVEN900A.QueryConsulta.Open();
  if FVEN900A.QueryConsulta.FieldByName('em_uso').AsString = 'S' then
     Msg := 'Caixa 100 aberto'
  else Msg := 'Caixa 100 não foi aberto corretamente.';

  CheckEquals('Caixa 100 aberto', Msg);
  FVEN900A.QueryConsulta.Close;

end;

procedure TFVEN604ETests.VEN604E_AbreCaixa100_ConfirmaNao;
var
  futureWindow: IFutureWindow;
  FormVEN604E: TFVEN604E;
  Window: hWnd;
  TimerId: UINT_PTR;
  Sender: TObject;
  Msg: String;
begin
  // Chamando o Form Modal normalmente não funciona.
  // Tem que ser chamado com FutureWindows e função anônima.
  futureWindow := TFutureWindows.Expect(TFVEN604E.ClassName)
    .ExecProc(
      procedure (const AWindow: IWindow)
      var
        form: TFVEN604E;
      begin
        form := AWindow.AsControl as TFVEN604E;
        CheckNotNull(form);
        TTestCaseBase.ProcessMessages(0.2);

        form.VSEditRegistradora.Text := '100';
        form.VSEditRegistradoraExit(Sender);
        form.ComboBoxOperador.ItemIndex := ListaCombobox('MASTER', form.ComboBoxOperador, 50);

        TTestCaseBase.ProcessMessages(); // let's see the changes

        TimerId := SetTimer(0, 0, 1 * 100, @AcsGeral.MessageBoxNO);
        form.BitBtnConfirmaClick(Sender);
        CheckFalse(KillTimer(0, TimerId));

        form.BitBtnSairClick(Sender);
      end
  );

  if not(Assigned(FVEN900A)) then
     Application.CreateForm(TFVEN900A, FVEN900A);
  AcsSistemas.SisSistema := 'VEN';

  // troca todas as registradoras para "N"
  FUNI800M.DatabaseBDIntesig.StartTransaction;
  FVEN900A.QueryConsulta.Close;
  FVEN900A.QueryConsulta.SQL.Clear;
  FVEN900A.QueryConsulta.Sql.Add('update TBVenRegistradora set em_uso=''N'' '+
                                 'where empresa=:empresa and usuario_operador=''MASTER'' ');
  FVEN900A.QueryConsulta.ParamByName('empresa').AsString := AcsSistemas.SisCodEmpresa;
  FVEN900A.QueryConsulta.ExecSQL;
  FUNI800M.DatabaseBDIntesig.Commit;
  FVEN900A.QueryConsulta.Close;

  // Abre o VEN604E dentro do TFutureWindows
  Application.CreateForm(TFVEN604E, FVEN604E);
  FVEN604E.ShowModal;

  // Pesquisa se cadastro ok
  FVEN900A.QueryConsulta.Close;
  FVEN900A.QueryConsulta.SQL.Clear;
  FVEN900A.QueryConsulta.Sql.Add('Select em_uso from TBVenRegistradora where empresa=:empresa and codigo=''100'' ');
  FVEN900A.QueryConsulta.ParamByName('empresa').AsString := AcsSistemas.SisCodEmpresa;
  FVEN900A.QueryConsulta.Open();
  if FVEN900A.QueryConsulta.FieldByName('em_uso').AsString = 'N' then
     Msg := 'Caixa 100 não foi aberto'
  else Msg := 'Caixa 100 aberto incorretamente.';
  CheckEquals('Caixa 100 não foi aberto', Msg);
  FVEN900A.QueryConsulta.Close;

end;

initialization
  RegisterTest('VEN604E', TFormSetup.Create(TFVEN604ETests.Suite));
end.


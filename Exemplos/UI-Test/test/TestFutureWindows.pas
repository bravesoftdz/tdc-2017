unit TestFutureWindows;

interface

implementation
uses
  Windows,
  TestFramework,
  TestCaseBase,
  FutureWindows,
  SysUtils,
  Forms,
  Messages;

type
  TFutureWindowsTestCase = class(TTestCaseBase, IExceptionHandler)
  published
    //procedure TestAnonymousProc;
    //procedure TestExceptionInAnonymousProc;
    //procedure TestTimeOut;
    //procedure TestSample;
  end;

{ TFutureWindowsTestCase }
(*
procedure TFutureWindowsTestCase.TestAnonymousProc;
begin
  TFutureWindows.Expect(MESSAGE_BOX_WINDOW_CLASS)
    .ExecProc(
      procedure (const AWindow: IWindow)
      var
        c: Char;
      begin
        ProcessMessages(0.3);
        CheckEquals('', AWindow.Text);
        AWindow.Text := '';

        for c in Self.FTestName do
        begin
          AWindow.Text := AWindow.Text + c;

          // sometimes it gets hidden
          AWindow.BringToFront;

          ProcessMessages(0.1);
        end;
      end
    )
    .ExecCloseWindow();

  MessageBox(0, 'testing future window from anonymous proc', '', MB_OK);
end;

procedure TFutureWindowsTestCase.TestExceptionInAnonymousProc;
begin
  TFutureWindows.Expect(MESSAGE_BOX_WINDOW_CLASS)
    .SetExceptionHandler(Self)
    .ExecProc(
      procedure (const AWindow: IWindow)
      begin
        //Fail('This is intended failure!');
      end
    );
  MessageBox(0, '', '', MB_OK);
end;

procedure TFutureWindowsTestCase.TestSample;
begin
  TFutureWindows.Expect(TForm.ClassName)
    .ExecProc(
       procedure (const AWindow: IWindow)
       var
         myForm: TForm;
       begin
         myForm := AWindow.AsControl as TForm;
         myForm.Caption := 'test caption';
         myForm.Close();
       end
    );

  with TForm.Create(Application) do
  try
    Caption := '';

    ShowModal();

    CheckEquals('test caption', Caption);
  finally
    Free;
  end;
end;

procedure TFutureWindowsTestCase.TestTimeOut;
var
  futureMessageBox,
  fakeFutureWindow: IFutureWindow;
begin
  // this should timeout
  fakeFutureWindow := TFutureWindows.Expect('abc', 0.1)
    .ExecCloseWindow();

  futureMessageBox := TFutureWindows.Expect(MESSAGE_BOX_WINDOW_CLASS)
    .ExecPauseAction(0.5, Application.ProcessMessages)
    .ExecCloseWindow();

  MessageBox(0, 'test', 'test', MB_OK);

  Check(futureMessageBox.WindowFound, 'window not found: ' + futureMessageBox.Description);
  CheckFalse(futureMessageBox.TimedOut, 'window timed out: ' + futureMessageBox.Description);

  Check(fakeFutureWindow.TimedOut, 'window not timed out: ' + fakeFutureWindow.Description);
  CheckFalse(fakeFutureWindow.WindowFound, 'window found: ' + fakeFutureWindow.Description);
end;
*)

initialization
  //RegisterTest(TFutureWindowsTestCase.Suite);
end.

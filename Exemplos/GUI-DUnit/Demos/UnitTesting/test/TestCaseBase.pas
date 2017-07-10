unit TestCaseBase;

interface
uses
  TestFramework,
  SysUtils,
  FutureWindows;

type
  TTestCaseBase = class(TTestCase, IExceptionHandler)
  strict private
    FDeferedException: Exception;
    FDeferedExceptAddr: Pointer;
  private
    procedure HandleException(AExceptObject: TObject; AExceptAddr: Pointer);
  protected
    procedure TearDown; override;
  public
    class procedure ProcessMessages(AWaitSeconds: Double = 0.0);
  end;

implementation

uses
  Windows,
  Forms;

{ TTestCaseBase }

procedure TTestCaseBase.HandleException(AExceptObject: TObject; AExceptAddr: Pointer);
begin
  FDeferedException := AExceptObject as Exception;
  FDeferedExceptAddr := AExceptAddr;
end;

class procedure TTestCaseBase.ProcessMessages(AWaitSeconds: Double);
var
  now, finish: Cardinal;
begin
  if AWaitSeconds = 0 then
    Application.ProcessMessages()
  else
  begin
    now := GetTickCount;
    finish := now + Round(AWaitSeconds * 2000);
    while now < finish do
    begin
      Application.ProcessMessages();
      now := GetTickCount;
    end;
  end;
end;

procedure TTestCaseBase.TearDown;
var
  e: Exception;
begin
  if FDeferedException <> nil then
  begin
    e := FDeferedException;
    FDeferedException := nil;
    raise e at FDeferedExceptAddr;
  end;
  inherited;
end;

end.

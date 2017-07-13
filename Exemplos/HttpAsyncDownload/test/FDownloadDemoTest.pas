unit FDownloadDemoTest;

interface
uses
  DUnitX.TestFramework, FDownloadDemo;

type

  [TestFixture]
  TestDownload = class(TObject)
  strict private
    aTestDownload: TCalc;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [TestCase('TesteSoma5','1,10000,10001')]
    procedure TesteStatus();
    procedure TesteDwonload();
  end;

implementation

procedure TestTCalc.Setup;
begin
  aTCalc := TCalc.Create;
end;

procedure TestTCalc.TearDown;
begin
  aTCalc := nil;
end;

procedure TestTCalc.TesteSoma(Value1, Value2, _Result: Real);
begin
  R := aTCalc.Adicao(Value1, Value2);
  Assert.AreEqual(R, _Result);
end;

initialization
  TDUnitX.RegisterTestFixture(TestTCalc);
end.

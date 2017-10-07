unit TestDolar;

interface
uses
  DUnitX.TestFramework, uFact;

type
  [TestFixture]
  TestTDolar = class(TObject)
  strict private
    uDolar: TFact;
    MaiorZero: Boolean;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure TestesDolar();
  end;

implementation

procedure TestTDolar.Setup;
begin
  uDolar := TFact.Create;
end;

procedure TestTDolar.TearDown;
begin
  uDolar := nil;
end;

procedure TestTDolar.TestesDolar();
begin
  MaiorZero := uDolar.CalcularValorDeVenda(1) > 0;
  Assert.isTrue(MaiorZero);
end;

initialization
  TDUnitX.RegisterTestFixture(TestTDolar);
end.

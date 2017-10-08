unit TestCalcUnit;

interface
uses
  DUnitX.TestFramework, CalcUnit;

type

  [TestFixture]
  TestTCalc = class(TObject)
  strict private
    aTCalc: TCalc;
    R: Real;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [TestCase('TesteSoma1','8,2,10')]
    [TestCase('TesteSoma2','5,5,10')]
    [TestCase('TesteSoma3','4,2,6')]
    [TestCase('TesteSoma4','8000,2,8002')]
    [TestCase('TesteSoma5','1,10000,10001')]
    procedure TesteSoma(Value1, Value2, _Result: Real);

    [TestCase('TesteSubtracao1','3,4,-1')]
    [TestCase('TesteSubtracao2','5,4,1')]
    [TestCase('TesteSubtracao3','100,90,10')]
    [TestCase('TesteSubtracao4','100,80,20')]
    procedure TesteSubtracao(Value1, Value2, _Result: Real);

    [TestCase('TesteMultiplicacao1','3,4,12')]
    [TestCase('TesteMultiplicacao2','5,4,20')]
    [TestCase('TesteMultiplicacao3','100,90,9000')]
    [TestCase('TesteMultiplicacao4','-1,8,-8')]
    procedure TesteMultiplicacao(Value1, Value2, _Result: Real);

    [TestCase('TesteDivisao1','3,0,0')]
    [TestCase('TesteDivisao2','5,4,1.25')]
    [TestCase('TesteDivisao3','100,90,1.11')]
    [TestCase('TesteDivisao4','80,100,0.80')]
    procedure TesteDivisao(Value1, Value2, _Result: Real);
	
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

procedure TestTCalc.TesteSubtracao(Value1, Value2, _Result: Real);
begin
  R := aTCalc.Subtracao(Value1, Value2);
  Assert.AreEqual(R, _Result);
 end;

procedure TestTCalc.TesteMultiplicacao(Value1, Value2, _Result: Real);
begin
  R := aTCalc.Multiplicacao(Value1, Value2);
  Assert.AreEqual(R, _Result);
 end;

 procedure TestTCalc.TesteDivisao(Value1, Value2, _Result: Real);
begin
  R := aTCalc.Divisao(Value1, Value2);
  Assert.AreEqual(R, _Result);
 end;

initialization
  TDUnitX.RegisterTestFixture(TestTCalc);
end.

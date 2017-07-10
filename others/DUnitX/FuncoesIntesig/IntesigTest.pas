unit IntesigTest;

interface

uses
  Classes, Math, DateUtils, SysUtils, Forms, DUnitX.TestFramework, AcsMetodos;

type

  { TIntesigSoNumeros }
  TIntesigSoNumeros = class(TObject)
  public

    //1
    [TestCase('Teste1','1','1')]
    [TestCase('Teste2','100000','100000')]
    [TestCase('Teste3','15588','15588')]
    [TestCase('Teste4','aaaa','')]
    [TestCase('Teste5','xxx!','')]
    procedure SoNumerosValido(Value1, _Result: String);

    //2
    [TestCase('Teste6','123','23')]
    [TestCase('Teste7','A12AA','123')]
    [TestCase('Teste8','fdd33215588','2')]
    procedure SoNumerosInvalido(Value1, _Result: String);
  end;

implementation

{ TIntesigSoNumeros }

procedure TIntesigSoNumeros.SoNumerosValido(Value1, _Result: String);
begin
  Assert.AreEqual(AcsMetodos.Sonumeros(Value1), _Result);
end;

procedure TIntesigSoNumeros.SoNumerosInvalido(Value1, _Result: String);
begin
  Assert.AreNotEqual(AcsMetodos.Sonumeros(Value1), _Result);
end;

initialization
  TDUnitX.RegisterTestFixture(TIntesigSoNumeros);
end.


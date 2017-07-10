unit testexample;

interface

uses
  TestFramework, classes, SysUtils, Example1;

type
  TExampleTest = class(TTestCase)
  strict private
    FormExample1: TFormExample1;
    R: Real;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestSoma1;
    procedure TestSubtracao1;
  end;

implementation

{ TestExample }

procedure TExampleTest.SetUp;
begin
  //
end;

procedure TExampleTest.TearDown;
begin
  //
end;

procedure TExampleTest.TestSoma1;
begin
  R := TFormExample1.Soma(5,5);
  CheckEquals(10, R);

  R := TFormExample1.Soma(10,5);
  CheckEquals(15, R);

  R := TFormExample1.Soma(-1,-1);
  CheckEquals(-2, R);

end;

procedure TExampleTest.TestSubtracao1;
begin
  R := TFormExample1.Subtracao(5,5);
  CheckEquals(0, R);

  R := TFormExample1.Subtracao(10,5);
  CheckEquals(5, R);

  R := TFormExample1.Subtracao(-1,-1);
  CheckEquals(0, R);

end;

initialization
  RegisterTest(TExampleTest.Suite);
end.


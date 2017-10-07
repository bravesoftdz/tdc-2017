unit uFact;

interface

type
  TFact = class
  public
    function CalcularValorDeVenda(const Preco: Real): Real;
  end;

implementation

uses
  SysUtils, uCotacaoDolar;

{ TFact }

function TFact.CalcularValorDeVenda(const Preco: Real): Real;
var
  iCotacaoDolar: TCotacaoDolar;
  CotacaoDolar: Real;
  ValorVenda: Real;
begin
  iCotacaoDolar := TCotacaoDolar.Create;
  try
    CotacaoDolar := iCotacaoDolar.ConsultarCotacaoDolar;
    Result := Preco * CotacaoDolar;
  finally
    FreeAndNil(iCotacaoDolar);
  end;
end;

end.

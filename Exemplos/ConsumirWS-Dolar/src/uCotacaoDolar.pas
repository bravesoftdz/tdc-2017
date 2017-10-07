unit uCotacaoDolar;

interface

type
  TCotacaoDolar = class
  public
    function ConsultarCotacaoDolar: Real;
  end;

implementation

uses
  SysUtils, uWSDL_BCB, SOAPHTTPClient, Windows;

{ TCotacaoDolar }

function TCotacaoDolar.ConsultarCotacaoDolar: Real;
var
  WebServiceCotacao: FachadaWSSGS;
  HTTPRIO: THTTPRIO;
  FormatSettings : TFormatSettings;
begin
  HTTPRIO := THTTPRIO.Create(nil);
  WebServiceCotacao := GetFachadaWSSGS(True, '', HTTPRIO);
  FormatSettings.DecimalSeparator := '.';
  Result := StrToFloat(WebServiceCotacao.getUltimoValorVO(1).ultimoValor.sValor, FormatSettings);
end;

end.
 
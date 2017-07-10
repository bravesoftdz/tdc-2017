unit IntesigTest;

interface

uses
  (*Delphi*) Classes, Math, DateUtils, SysUtils, Forms,
  (*DUnit*) TestFramework,
  (*ACBr*) ACBrValidador, ACBrUtil, ACBrConsts,
  (*Intesig*) AcsMetodos, AcsGeral;

type

  { TIntesigSoNumeros }
  TIntesigSoNumeros = class(TTestCase)
  private
  protected
  published
    procedure SoNumerosValido;
    procedure SoNumerosInvalido;
  end;

  { TIntesigMascaraCPFCGC }
  TIntesigMascaraCPFCGC = class(TTestCase)
  private
  protected
  published
    procedure MascaraCPFCGCValido;
    procedure MascaraCPFCGCInvalido;
  end;

  { TIntesigMascaraStrTelefone }
  TIntesigMascaraStrTelefone = class(TTestCase)
  private
  protected
  published
    procedure FormatarVazio;
    procedure Formatar7digitos;
    procedure Formatar8digitos;
    procedure Formatar9digitos;
    procedure Formatar10digitos;
    procedure Formatar11digitos;
    procedure Formatar12digitos;
    procedure Formatar13digitos;
    procedure FormatarComDDD9Dig;
    procedure Formatar0800;
    procedure Formatar55ComDDD;
    procedure Formatar55ComDDD9Dig;
  end;

  { TIntesigExcelInstalado }
  TIntesigExcelInstalado = class(TTestCase)
  private
  protected
  published
    procedure ExcelInstalado;
    procedure ExcelNaoInstalado;
  end;

  { TIntesigTemConexaoInternet }
  TIntesigTemConexaoInternet = class(TTestCase)
   private
   protected
   published
     procedure TemConexaoInternet_Google;
     procedure TemConexaoInternet_Intelecto;
     procedure NaoTemConexaoInternet;
  end;

  TIntesigTemConexaoInternet_Ef = class(TTestCase)
   private
   protected
   published
      procedure TemConexaoInternet_ef_Google;
      procedure TemConexaoInternet_ef_Intelecto;
      procedure NaoTemConexaoInternet_ef;
  end;

  { TIntesigFindText }
  TIntesigFindText = class(TTestCase)
   private
   protected
   published
     procedure TextoEncontratoNoMeio;
     procedure TextoEncontratoNoInicio;
     procedure TextoEncontratoNoFinal;
     procedure TextNaoEncontrado;
  end;

  { TIntesigExistForm }
  TIntesigExistForm = class(TTestCase)
   private
   protected
   published
     procedure ExistForm_Encontrado;
     procedure ExistForm_NaoEncontrado;
  end;

  { TACBrValidadorCPF }
  TACBrValidadorCPF = class(TTestCase)
  private
    fACBrValidador : TACBrValidador;
    function MsgErroCPF: String;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure Valido;
    procedure ValidoComSeparadores;
    procedure Invalido;
    procedure NumerosSequenciais;
    procedure MenorOnzeDigitos;
    procedure MaiorOnzeDigitos;
    procedure ComLetras;
    procedure Formatar;
  end;

  { TACBrValidadorCNPJ }
  TACBrValidadorCNPJ = class(TTestCase)
  private
    fACBrValidador : TACBrValidador;
    function MsgErroCNPJ: String;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure Valido;
    procedure ValidoComSeparadores;
    procedure Invalido;
    procedure NumeroComZeros;
    procedure MenorQuatorzeDigitos;
    procedure MaiorQuatorzeDigitos;
    procedure ComLetras;
    procedure Formatar;
  end;

  { TACBrValidadorIE }
  TACBrValidadorIE = class(TTestCase)
  private
    fACBrValidador : TACBrValidador;
    function MsgErroIE: String;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure ValidoAC ;
    procedure InvalidoAC ;
    procedure FormatarAC;
    procedure ValidoAL ;
    procedure InvalidoAL ;
    procedure FormatarAL;
    procedure ValidoAP ;
    procedure InvalidoAP ;
    procedure FormatarAP;
    procedure ValidoAM ;
    procedure InvalidoAM ;
    procedure FormatarAM;
    procedure ValidoBA ;
    procedure InvalidoBA ;
    procedure FormatarBA;
    procedure ValidoCE ;
    procedure InvalidoCE ;
    procedure FormatarCE;
    procedure ValidoDF ;
    procedure InvalidoDF ;
    procedure FormatarDF;
    procedure ValidoES ;
    procedure InvalidoES ;
    procedure FormatarES;
    procedure ValidoGO ;
    procedure InvalidoGO ;
    procedure FormatarGO;
    procedure ValidoMA ;
    procedure InvalidoMA ;
    procedure FormatarMA;
    procedure ValidoMT ;
    procedure InvalidoMT ;
    procedure FormatarMT;
    procedure ValidoMS ;
    procedure InvalidoMS ;
    procedure FormatarMS;
    procedure ValidoMG ;
    procedure InvalidoMG ;
    procedure FormatarMG;
    procedure ValidoPA ;
    procedure InvalidoPA ;
    procedure FormatarPA;
    procedure ValidoPB ;
    procedure InvalidoPB ;
    procedure FormatarPB;
    procedure ValidoPR ;
    procedure InvalidoPR ;
    procedure FormatarPR;
    procedure ValidoPE ;
    procedure InvalidoPE ;
    procedure FormatarPE;
    procedure ValidoPI ;
    procedure InvalidoPI ;
    procedure FormatarPI;
    procedure ValidoRJ ;
    procedure InvalidoRJ ;
    procedure FormatarRJ;
    procedure ValidoRN ;
    procedure InvalidoRN ;
    procedure FormatarRN;
    procedure ValidoRS ;
    procedure InvalidoRS ;
    procedure FormatarRS;
    procedure ValidoRO ;
    procedure InvalidoRO ;
    procedure FormatarRO;
    procedure ValidoRR ;
    procedure InvalidoRR ;
    procedure FormatarRR;
    procedure ValidoSC ;
    procedure InvalidoSC ;
    procedure FormatarSC;
    procedure ValidoSP ;
    procedure InvalidoSP ;
    procedure FormatarSP;
    procedure ValidoSE ;
    procedure InvalidoSE ;
    procedure FormatarSE;
    procedure ValidoTO ;
    procedure InvalidoTO ;
    procedure FormatarTO;
  end;

  { TACBrLerTagXMLTest }
  TACBrLerTagXMLTest = class(TTestCase)
  published
    procedure Simples;
    procedure SemIgnorarCase;
    procedure ComVariasTags;
  end;

  { TACBrStripHTMLTest }
  TACBrStripHTMLTest = class(TTestCase)
  published
   procedure TesteSimples;
   procedure TesteCompleto;
  end;

  { TACBrEAN13Test }
  TACBrEAN13Test = class(TTestCase)
  published
    procedure Valido;
    procedure TamanhoMaior;
    procedure TamanhoMenor;
    procedure DigitoInvalido;
    procedure DigitoInvalidoComLetras;
  end;

  { TACBrValidadorTelefone }
  TACBrValidadorTelefone = class(TTestCase)
  private
    fACBrValidador : TACBrValidador;
  protected
    procedure TearDown; override;
  published
    procedure FormatarVazio;
    procedure FormatarZeros;
    procedure FormatarSemDDD;
    procedure FormatarComDDD;
    procedure FormatarComDDDPadrao;
    procedure FormatarSemDDD9Dig;
    procedure FormatarComDDD9Dig;
    procedure Formatar0300;
    procedure Formatar0500;
    procedure Formatar0800;
    procedure Formatar0900;
    procedure Formatar55ComDDD;
    procedure Formatar55ComDDD9Dig;
  end;

  function MsgErroAcsMetodos(error: String): String;

implementation

var Test: String;

function MsgErroAcsMetodos(error: String): String;
begin
   Result := 'Erro no Teste: ' + error;
end;

{ TIntesigSoNumeros }

procedure TIntesigSoNumeros.SoNumerosValido;
begin
  Test := '1';
  CheckEquals(Test, AcsMetodos.Sonumeros('aaaaa1aaaaaaaaaa'), MsgErroAcsMetodos(Test));

  Test := 'a1';
  CheckTrue(AcsMetodos.Sonumeros(Test) = '1', MsgErroAcsMetodos(Test));

  Test := 'abcdsededfdfdljkd987ahdfjsdhfkjfj';
  CheckTrue(AcsMetodos.Sonumeros(Test) = '987', MsgErroAcsMetodos(Test));

  Test := 'ab1cdsededf2dfdljk3dahdfj4sdhfkj5fj';
  CheckTrue(AcsMetodos.Sonumeros(Test) = '12345', MsgErroAcsMetodos(Test));

  Test := '22sdkfkdsfkffdjkdsjksda11';
  CheckTrue(AcsMetodos.Sonumeros(Test) = '2211', MsgErroAcsMetodos(Test));
end;

procedure TIntesigSoNumeros.SoNumerosInvalido;
begin
  Test := '1';
  CheckNotEquals(Test, AcsMetodos.Sonumeros('aaaaa12aaaa'), MsgErroAcsMetodos(Test));

  Test := 'a1';
  CheckFalse(AcsMetodos.Sonumeros(Test) = 'a', MsgErroAcsMetodos(Test));

  Test := 'abcdsededfdfdljkd987ahdfjsdhfkjfj';
  CheckFalse(AcsMetodos.Sonumeros(Test) = 'a987', MsgErroAcsMetodos(Test));

  Test := 'ab1cdsededf2dfdljk3dahdfj4sdhfkj5fj';
  CheckFalse(AcsMetodos.Sonumeros(Test) = '12', MsgErroAcsMetodos(Test));

  Test := '22sdkfkdsfkffdjkdsjksda11';
  CheckFalse(AcsMetodos.Sonumeros(Test) = 'a2211', MsgErroAcsMetodos(Test));
end;

{ TIntesigMascaraCPFCGC }

procedure TIntesigMascaraCPFCGC.MascaraCPFCGCValido;
begin
  Test := '000.000.000-00';
  CheckTrue(AcsMetodos.MascaraCPFCGC(Test) = '000.000.000-00', MsgErroAcsMetodos(Test));

  Test := '00000000000';
  CheckTrue(AcsMetodos.MascaraCPFCGC(Test) = '000.000.000-00', MsgErroAcsMetodos(Test));

  Test := '00.000.000/0000-00';
  CheckTrue(AcsMetodos.MascaraCPFCGC(Test) = '00.000.000/0000-00', MsgErroAcsMetodos(Test));

  Test := '00000000000000';
  CheckTrue(AcsMetodos.MascaraCPFCGC(Test) = '00.000.000/0000-00', MsgErroAcsMetodos(Test));
end;

procedure TIntesigMascaraCPFCGC.MascaraCPFCGCInvalido;
var Test: String;
begin
  Test := '000.000.000-00';
  CheckFalse(AcsMetodos.MascaraCPFCGC(Test) = '0', MsgErroAcsMetodos(Test));

  Test := '000.000.000-00';
  CheckFalse(AcsMetodos.MascaraCPFCGC(Test) = '0000000000-0', MsgErroAcsMetodos(Test));

  Test := '00000000000000';
  CheckFalse(AcsMetodos.MascaraCPFCGC(Test) = '0', MsgErroAcsMetodos(Test));

  Test := '00000000000000';
  CheckFalse(AcsMetodos.MascaraCPFCGC(Test) = '00000000000000', MsgErroAcsMetodos(Test));
end;

(*
{ TIntesigGetAmbienteNFe }

procedure TIntesigGetAmbienteNFe.GetAmbienteNFEValido;
var Test: String;
begin
  Test := '0';
  CheckTrue(GetAmbienteNFE = 0, '');
end;

procedure TIntesigGetAmbienteNFe.GetAmbienteNFEInvalido;
var Test: String;
begin
  Test := '0';
  CheckTrue(GetAmbienteNFE = 1, '');
end;
*)

{ TIntesigMascaraStrTelefone }

procedure TIntesigMascaraStrTelefone.FormatarVazio;
begin
  Test := ''; // Vazio
  CheckEquals('', AcsMetodos.MascaraStrTelefone(''), MsgErroAcsMetodos(Test));
end;

procedure TIntesigMascaraStrTelefone.Formatar7digitos;
begin
  Test := '3143300'; // 7 digitos
  CheckEquals('314-3300', AcsMetodos.MascaraStrTelefone(Test), MsgErroAcsMetodos(Test));
end;

procedure TIntesigMascaraStrTelefone.Formatar8digitos;
begin
  Test := '33143300'; // 8 digitos
  CheckEquals('3314-3300', AcsMetodos.MascaraStrTelefone(Test), MsgErroAcsMetodos(Test));
end;

procedure TIntesigMascaraStrTelefone.Formatar9digitos;
begin
  Test := '653143300'; // 9 digitos
  CheckEquals('(65) 314-3300', AcsMetodos.MascaraStrTelefone(Test), MsgErroAcsMetodos(Test));
end;

procedure TIntesigMascaraStrTelefone.Formatar10digitos;
begin
  Test := '6533143300'; // 10 digitos
  CheckEquals('(65) 3314-3300', AcsMetodos.MascaraStrTelefone(Test), MsgErroAcsMetodos(Test));
end;

procedure TIntesigMascaraStrTelefone.Formatar11digitos;
begin
  Test := '06533143300'; // 11 digitos
  CheckEquals('(065) 3314-3300', AcsMetodos.MascaraStrTelefone(Test), MsgErroAcsMetodos(Test));
end;

procedure TIntesigMascaraStrTelefone.Formatar12digitos;
begin
  Test := '065553143300'; // 12 digitos
  CheckEquals('(065)55-314-3300', AcsMetodos.MascaraStrTelefone(Test), MsgErroAcsMetodos(Test));
end;

procedure TIntesigMascaraStrTelefone.Formatar13digitos;
begin
  Test := '0655533143300'; // 13 digitos
  CheckEquals('(065)55-3314-3300', AcsMetodos.MascaraStrTelefone(Test), MsgErroAcsMetodos(Test));
end;

procedure TIntesigMascaraStrTelefone.FormatarComDDD9Dig;
begin
  Test := '997012345'; // Celulares de Sao Paulo
  CheckEquals('99701-2345', AcsMetodos.MascaraStrTelefone(Test), MsgErroAcsMetodos(Test));
end;

procedure TIntesigMascaraStrTelefone.Formatar0800;
begin
  Test := '08001234567'; // 0800
  CheckEquals('0800-123-4567', AcsMetodos.MascaraStrTelefone(Test), MsgErroAcsMetodos(Test));
end;

procedure TIntesigMascaraStrTelefone.Formatar55ComDDD;
begin
  Test := '556533143300';
  CheckEquals('+55(65)3314-3300', AcsMetodos.MascaraStrTelefone(Test), MsgErroAcsMetodos(Test));
end;

procedure TIntesigMascaraStrTelefone.Formatar55ComDDD9Dig;
begin
  Test := '5511999220000';
  CheckEquals('+55(11)99922-0000', AcsMetodos.MascaraStrTelefone(Test), MsgErroAcsMetodos(Test));
end;

{ TACBrValidadorCPF }

function TACBrValidadorCPF.MsgErroCPF: String;
begin
  Result := fACBrValidador.MsgErro + ' - '+fACBrValidador.Documento;
end;

procedure TACBrValidadorCPF.SetUp;
begin
  fACBrValidador := TACBrValidador.Create(nil);
  fACBrValidador.TipoDocto := docCPF;
  fACBrValidador.ExibeDigitoCorreto := True;
end;

procedure TACBrValidadorCPF.TearDown;
begin
  FreeAndNil( fACBrValidador );
end;

procedure TACBrValidadorCPF.Valido;
begin
  fACBrValidador.Documento := '12345678909';
  CheckTrue(fACBrValidador.Validar, MsgErroCPF);
end;

procedure TACBrValidadorCPF.ValidoComSeparadores;
begin
  fACBrValidador.Documento := '123.456.789-09';
  CheckTrue(fACBrValidador.Validar, MsgErroCPF);
  fACBrValidador.Documento := '191';
  fACBrValidador.AjustarTamanho := True;
  CheckTrue(fACBrValidador.Validar, MsgErroCPF);
end;

procedure TACBrValidadorCPF.Invalido;
begin
  fACBrValidador.Documento := '12345678901';
  CheckFalse(fACBrValidador.Validar, MsgErroCPF)
end;

procedure TACBrValidadorCPF.NumerosSequenciais;
var
  I: Char;
begin
  For I := '1' to '9' do
  begin
    fACBrValidador.Documento := StringOfChar(I,11);
    CheckFalse(fACBrValidador.Validar, MsgErroCPF);
  end;
end;

procedure TACBrValidadorCPF.MenorOnzeDigitos;
begin
  fACBrValidador.Documento := '123456789';
  fACBrValidador.AjustarTamanho := False;
  CheckFalse(fACBrValidador.Validar, MsgErroCPF)
end;

procedure TACBrValidadorCPF.MaiorOnzeDigitos;
begin
  fACBrValidador.Documento := '1234567890123';
  fACBrValidador.AjustarTamanho := False;
  CheckFalse(fACBrValidador.Validar, MsgErroCPF)
end;

procedure TACBrValidadorCPF.ComLetras;
begin
  fACBrValidador.Documento := '123456789AB';
  CheckFalse(fACBrValidador.Validar, MsgErroCPF)
end;

procedure TACBrValidadorCPF.Formatar;
begin
  fACBrValidador.Documento := '191';
  fACBrValidador.AjustarTamanho := True;
  CheckEquals('000.000.001-91', fACBrValidador.Formatar);
  fACBrValidador.Documento := '12345678909';
  CheckEquals('123.456.789-09', fACBrValidador.Formatar);
end;

{ TACBrValidadorCNPJ }

function TACBrValidadorCNPJ.MsgErroCNPJ: String;
begin
  Result := fACBrValidador.MsgErro + ' - '+fACBrValidador.Documento;
end;

procedure TACBrValidadorCNPJ.SetUp;
begin
  fACBrValidador := TACBrValidador.Create(nil);
  fACBrValidador.TipoDocto := docCNPJ;
  fACBrValidador.ExibeDigitoCorreto := True;
end;

procedure TACBrValidadorCNPJ.TearDown;
begin
  FreeAndNil( fACBrValidador );
end;

procedure TACBrValidadorCNPJ.Valido;
begin
  fACBrValidador.Documento := '12345678000195';
  CheckTrue(fACBrValidador.Validar, MsgErroCNPJ);
  fACBrValidador.Documento := '191';
  fACBrValidador.AjustarTamanho := True;
  CheckTrue(fACBrValidador.Validar, MsgErroCNPJ);
end;

procedure TACBrValidadorCNPJ.ValidoComSeparadores;
begin
  fACBrValidador.Documento := '12.345.678/0001-95';
  CheckTrue(fACBrValidador.Validar, MsgErroCNPJ);
end;

procedure TACBrValidadorCNPJ.Invalido;
begin
  fACBrValidador.Documento := '12345678901234';
  CheckFalse(fACBrValidador.Validar, MsgErroCNPJ);
end;

procedure TACBrValidadorCNPJ.NumeroComZeros;
begin
  fACBrValidador.Documento := StringOfChar('0',14);
  CheckFalse(fACBrValidador.Validar, MsgErroCNPJ);
end;

procedure TACBrValidadorCNPJ.MenorQuatorzeDigitos;
begin
  fACBrValidador.Documento := '1234567890';
  fACBrValidador.AjustarTamanho := False;
  CheckFalse(fACBrValidador.Validar, MsgErroCNPJ);
end;

procedure TACBrValidadorCNPJ.MaiorQuatorzeDigitos;
begin
  fACBrValidador.Documento := '123456789012345';
  fACBrValidador.AjustarTamanho := False;
  CheckFalse(fACBrValidador.Validar, MsgErroCNPJ);
end;

procedure TACBrValidadorCNPJ.ComLetras;
begin
  fACBrValidador.Documento := '1234567890ABCD';
  CheckFalse(fACBrValidador.Validar, MsgErroCNPJ);
end;

procedure TACBrValidadorCNPJ.Formatar;
begin
  fACBrValidador.Documento := '191';
  fACBrValidador.AjustarTamanho := True;
  CheckEquals('00.000.000/0001-91', fACBrValidador.Formatar);
  fACBrValidador.Documento := '12345678000195';
  CheckEquals('12.345.678/0001-95', fACBrValidador.Formatar);
end;

{ TACBrValidadorIE }

function TACBrValidadorIE.MsgErroIE: String;
begin
  Result := fACBrValidador.MsgErro + ' - '+fACBrValidador.Documento;
end;

procedure TACBrValidadorIE.SetUp;
begin
  fACBrValidador := TACBrValidador.Create(nil);
  fACBrValidador.TipoDocto := docInscEst;
  fACBrValidador.ExibeDigitoCorreto := True;
end;

procedure TACBrValidadorIE.TearDown;
begin
  FreeAndNil( fACBrValidador );
end;

procedure TACBrValidadorIE.ValidoAC;
begin
  fACBrValidador.Complemento := 'AC';
  fACBrValidador.Documento := '01.004.823/001-12';  // 13 dígitos
  CheckTrue(fACBrValidador.Validar, MsgErroIE);
  fACBrValidador.Documento := '013456784';          // 9 dígitos
  CheckTrue(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.InvalidoAC;
begin
  fACBrValidador.Complemento := 'AC';
  fACBrValidador.Documento := '';             // Testando Vazio apenas 1 vez
  CheckFalse(fACBrValidador.Validar, MsgErroIE);
  fACBrValidador.Documento := '99999';        // Testando menos dígitos apenas 1 vez
  fACBrValidador.AjustarTamanho := True;
  CheckFalse(fACBrValidador.Validar, MsgErroIE);
  fACBrValidador.Documento := '01.004.823/001-99';
  CheckFalse(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.FormatarAC;
begin
  fACBrValidador.Complemento := 'AC';
  fACBrValidador.Documento := '0100482300112';
  CheckEquals('01.004.823/001-12', fACBrValidador.Formatar);
end;

procedure TACBrValidadorIE.ValidoAL;
begin
  fACBrValidador.Complemento := 'AL';
  fACBrValidador.Documento := '240123450';
  CheckTrue(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.InvalidoAL;
begin
  fACBrValidador.Complemento := 'AL';
  fACBrValidador.Documento := '240123456';
  CheckFalse(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.FormatarAL;
begin
  fACBrValidador.Complemento := 'AL';
  fACBrValidador.Documento := '240123450';
  CheckEquals('240123450', fACBrValidador.Formatar);
end;

procedure TACBrValidadorIE.ValidoAP;
begin
  fACBrValidador.Complemento := 'AP';
  fACBrValidador.Documento := '030123459';
  CheckTrue(fACBrValidador.Validar, MsgErroIE);
  fACBrValidador.Documento := '030170011';
  CheckTrue(fACBrValidador.Validar, MsgErroIE);
  fACBrValidador.Documento := '030190225';
  CheckTrue(fACBrValidador.Validar, MsgErroIE);
  fACBrValidador.Documento := '030190231';
  CheckTrue(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.InvalidoAP;
begin
  fACBrValidador.Complemento := 'AP';
  fACBrValidador.Documento := '123456789';
  CheckFalse(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.FormatarAP;
begin
  fACBrValidador.Complemento := 'AP';
  fACBrValidador.Documento := '030123459';
  CheckEquals('030123459', fACBrValidador.Formatar);
end;

procedure TACBrValidadorIE.ValidoAM;
begin
  fACBrValidador.Complemento := 'AM';
  fACBrValidador.Documento := '123123127';
  CheckTrue(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.InvalidoAM;
begin
  fACBrValidador.Complemento := 'AM';
  fACBrValidador.Documento := '123123123';
  CheckFalse(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.FormatarAM;
begin
  fACBrValidador.Complemento := 'AM';
  fACBrValidador.Documento := '123123127';
  CheckEquals('12.312.312-7', fACBrValidador.Formatar);
end;

procedure TACBrValidadorIE.ValidoBA;
begin
  fACBrValidador.Complemento := 'BA';
  fACBrValidador.Documento := '123456-63';
  CheckTrue(fACBrValidador.Validar, MsgErroIE);
  fACBrValidador.Complemento := 'BA';
  fACBrValidador.Documento := '173456-13';
  CheckTrue(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.InvalidoBA;
begin
  fACBrValidador.Complemento := 'BA';
  fACBrValidador.Documento := '123456-78';
  CheckFalse(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.FormatarBA;
begin
  fACBrValidador.Complemento := 'BA';
  fACBrValidador.Documento := '12345663';
  CheckEquals('0123456-63', fACBrValidador.Formatar);
end;

procedure TACBrValidadorIE.ValidoCE;
begin
  fACBrValidador.Complemento := 'CE';
  fACBrValidador.Documento := '023456787';
  CheckTrue(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.InvalidoCE;
begin
  fACBrValidador.Complemento := 'CE';
  fACBrValidador.Documento := '123456789';
  CheckFalse(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.FormatarCE;
begin
  fACBrValidador.Complemento := 'CE';
  fACBrValidador.Documento := '023456787';
  CheckEquals('02345678-7', fACBrValidador.Formatar);
end;

procedure TACBrValidadorIE.ValidoDF;
begin
  fACBrValidador.Complemento := 'DF';
  fACBrValidador.Documento := '0734567890103';
  CheckTrue(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.InvalidoDF;
begin
  fACBrValidador.Complemento := 'DF';
  fACBrValidador.Documento := '12345678901';
  CheckFalse(fACBrValidador.Validar, MsgErroIE);  // Tamanho inválido
  fACBrValidador.Documento := '1234567890123';
  CheckFalse(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.FormatarDF;
begin
  fACBrValidador.Complemento := 'DF';
  fACBrValidador.Documento := '0734567890103';
  CheckEquals('07345678901-03', fACBrValidador.Formatar);
end;

procedure TACBrValidadorIE.ValidoES;
begin
  fACBrValidador.Complemento := 'ES';
  fACBrValidador.Documento := '123123127';
  CheckTrue(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.InvalidoES;
begin
  fACBrValidador.Complemento := 'ES';
  fACBrValidador.Documento := '123123123';
  CheckFalse(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.FormatarES;
begin
  fACBrValidador.Complemento := 'ES';
  fACBrValidador.Documento := '123123127';
  CheckEquals('123123127', fACBrValidador.Formatar);
end;

procedure TACBrValidadorIE.ValidoGO;
begin
  fACBrValidador.Complemento := 'GO';
  fACBrValidador.Documento := '10.987.654-7';
  CheckTrue(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.InvalidoGO;
begin
  fACBrValidador.Complemento := 'GO';
  fACBrValidador.Documento := '12.312.312-3';
  CheckFalse(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.FormatarGO;
begin
  fACBrValidador.Complemento := 'GO';
  fACBrValidador.Documento := '109876547';
  CheckEquals('10.987.654-7', fACBrValidador.Formatar);
end;

procedure TACBrValidadorIE.ValidoMA;
begin
  fACBrValidador.Complemento := 'MA';
  fACBrValidador.Documento := '120000385';
  CheckTrue(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.InvalidoMA;
begin
  fACBrValidador.Complemento := 'MA';
  fACBrValidador.Documento := '123123123';
  CheckFalse(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.FormatarMA;
begin
  fACBrValidador.Complemento := 'MA';
  fACBrValidador.Documento := '120000385';
  CheckEquals('120000385', fACBrValidador.Formatar);
end;

procedure TACBrValidadorIE.ValidoMT;
begin
  fACBrValidador.Complemento := 'MT';
  fACBrValidador.Documento := '0013000001-9';
  CheckTrue(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.InvalidoMT;
begin
  fACBrValidador.Complemento := 'MT';
  fACBrValidador.Documento := '1234567890-1';
  CheckFalse(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.FormatarMT;
begin
  fACBrValidador.Complemento := 'MT';
  fACBrValidador.Documento := '130000019';
  CheckEquals('0013000001-9', fACBrValidador.Formatar);
end;

procedure TACBrValidadorIE.ValidoMS;
begin
  fACBrValidador.Complemento := 'MS';
  fACBrValidador.Documento := '28.312.312-5';
  CheckTrue(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.InvalidoMS;
begin
  fACBrValidador.Complemento := 'MS';
  fACBrValidador.Documento := '123123123';
  CheckFalse(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.FormatarMS;
begin
  fACBrValidador.Complemento := 'MS';
  fACBrValidador.Documento := '283123125';
  CheckEquals('28.312.312-5', fACBrValidador.Formatar);
end;

procedure TACBrValidadorIE.ValidoMG;
begin
  fACBrValidador.Complemento := 'MG';
  fACBrValidador.Documento := '062.307.904/0081';
  CheckTrue(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.InvalidoMG;
begin
  fACBrValidador.Complemento := 'MG';
  fACBrValidador.Documento := '123.123.123/9999';
  CheckFalse(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.FormatarMG;
begin
  fACBrValidador.Complemento := 'MG';
  fACBrValidador.Documento := '0623079040081';
  CheckEquals('062.307.904/0081', fACBrValidador.Formatar);
end;

procedure TACBrValidadorIE.ValidoPA;
begin
  fACBrValidador.Complemento := 'PA';
  fACBrValidador.Documento := '15999999-5';
  CheckTrue(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.InvalidoPA;
begin
  fACBrValidador.Complemento := 'PA';
  fACBrValidador.Documento := '15999999-9';
  CheckFalse(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.FormatarPA;
begin
  fACBrValidador.Complemento := 'PA';
  fACBrValidador.Documento := '159999995';
  CheckEquals('15-999999-5', fACBrValidador.Formatar);
end;

procedure TACBrValidadorIE.ValidoPB;
begin
  fACBrValidador.Complemento := 'PB';
  fACBrValidador.Documento := '16000001-7';
  CheckTrue(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.InvalidoPB;
begin
  fACBrValidador.Complemento := 'PB';
  fACBrValidador.Documento := '06000001-9';
  CheckFalse(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.FormatarPB;
begin
  fACBrValidador.Complemento := 'PB';
  fACBrValidador.Documento := '160000017';
  CheckEquals('16000001-7', fACBrValidador.Formatar);
end;

procedure TACBrValidadorIE.ValidoPR;
begin
  fACBrValidador.Complemento := 'PR';
  fACBrValidador.Documento := '123.45678-50';
  CheckTrue(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.InvalidoPR;
begin
  fACBrValidador.Complemento := 'PR';
  fACBrValidador.Documento := '123.45678-99';
  CheckFalse(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.FormatarPR;
begin
  fACBrValidador.Complemento := 'PR';
  fACBrValidador.Documento := '1234567850';
  CheckEquals('123.45678-50', fACBrValidador.Formatar);
end;

procedure TACBrValidadorIE.ValidoPE;
begin
  fACBrValidador.Complemento := 'PE';
  fACBrValidador.Documento := '0321418-40';
  CheckTrue(fACBrValidador.Validar, MsgErroIE);
  fACBrValidador.Documento := '18.1.001.0000004-9';    // Antigo formato
  CheckTrue(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.InvalidoPE;
begin
  fACBrValidador.Complemento := 'PE';
  fACBrValidador.Documento := '0321418-99';
  CheckFalse(fACBrValidador.Validar, MsgErroIE);
  fACBrValidador.Documento := '18.1.001.0000004-0';
  CheckFalse(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.FormatarPE;
begin
  fACBrValidador.Complemento := 'PE';
  fACBrValidador.Documento := '032141899';
  CheckEquals('0321418-99', fACBrValidador.Formatar);
  fACBrValidador.Documento := '18100100000040';
  CheckEquals('18.1.001.0000004-0', fACBrValidador.Formatar);
end;

procedure TACBrValidadorIE.ValidoPI;
begin
  fACBrValidador.Complemento := 'PI';
  fACBrValidador.Documento := '192345672';
  CheckTrue(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.InvalidoPI;
begin
  fACBrValidador.Complemento := 'PI';
  fACBrValidador.Documento := '012345678';
  CheckFalse(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.FormatarPI;
begin
  fACBrValidador.Complemento := 'PI';
  fACBrValidador.Documento := '192345672';
  CheckEquals('192345672', fACBrValidador.Formatar);
end;

procedure TACBrValidadorIE.ValidoRJ;
begin
  fACBrValidador.Complemento := 'RJ';
  fACBrValidador.Documento := '12.123.12-4';
  CheckTrue(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.InvalidoRJ;
begin
  fACBrValidador.Complemento := 'RJ';
  fACBrValidador.Documento := '12.123.12-9';
  CheckFalse(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.FormatarRJ;
begin
  fACBrValidador.Complemento := 'RJ';
  fACBrValidador.Documento := '12123124';
  CheckEquals('12.123.12-4', fACBrValidador.Formatar);
end;

procedure TACBrValidadorIE.ValidoRN;
begin
  fACBrValidador.Complemento := 'RN';
  fACBrValidador.Documento := '20.040.040-1';
  CheckTrue(fACBrValidador.Validar, MsgErroIE);
  fACBrValidador.Documento := '20.0.040.040-0';
  CheckTrue(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.InvalidoRN;
begin
  fACBrValidador.Complemento := 'RN';
  fACBrValidador.Documento := '20.040.040-9';
  CheckFalse(fACBrValidador.Validar, MsgErroIE);
  fACBrValidador.Documento := '20.0.040.040-9';
  CheckFalse(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.FormatarRN;
begin
  fACBrValidador.Complemento := 'RN';
  fACBrValidador.Documento := '200400401';
  CheckEquals('20.040.040-1', fACBrValidador.Formatar);
  fACBrValidador.Documento := '2000400400';
  CheckEquals('20.0.040.040-0', fACBrValidador.Formatar);
end;

procedure TACBrValidadorIE.ValidoRS;
begin
  fACBrValidador.Complemento := 'RS';
  fACBrValidador.Documento := '224/3658792';
  CheckTrue(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.InvalidoRS;
begin
  fACBrValidador.Complemento := 'RS';
  fACBrValidador.Documento := '224/1234567';
  CheckFalse(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.FormatarRS;
begin
  fACBrValidador.Complemento := 'RS';
  fACBrValidador.Documento := '2243658792';
  CheckEquals('224/3658792', fACBrValidador.Formatar);
end;

procedure TACBrValidadorIE.ValidoRO;
begin
  fACBrValidador.Complemento := 'RO';
  fACBrValidador.Documento := '101.62521-3';
  CheckTrue(fACBrValidador.Validar, MsgErroIE);
  fACBrValidador.Documento := '0000000062521-3';
  CheckTrue(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.InvalidoRO;
begin
  fACBrValidador.Complemento := 'RO';
  fACBrValidador.Documento := '101.12345-6';
  CheckFalse(fACBrValidador.Validar, MsgErroIE);
  fACBrValidador.Documento := '1234567890521-3';
  CheckFalse(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.FormatarRO;
begin
  fACBrValidador.Complemento := 'RO';
  fACBrValidador.Documento := '101625213';
  CheckEquals('101.62521-3', fACBrValidador.Formatar);
  fACBrValidador.Documento := '0000000062521-3';
  CheckEquals('0000000062521-3', fACBrValidador.Formatar);
end;

procedure TACBrValidadorIE.ValidoRR;
begin
  fACBrValidador.Complemento := 'RR';
  fACBrValidador.Documento := '24008266-8';
  CheckTrue(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.InvalidoRR;
begin
  fACBrValidador.Complemento := 'RR';
  fACBrValidador.Documento := '12345678-8';
  CheckFalse(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.FormatarRR;
begin
  fACBrValidador.Complemento := 'RR';
  fACBrValidador.Documento := '240082668';
  CheckEquals('24008266-8', fACBrValidador.Formatar);
end;

procedure TACBrValidadorIE.ValidoSC;
begin
  fACBrValidador.Complemento := 'SC';
  fACBrValidador.Documento := '251.040.852';
  CheckTrue(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.InvalidoSC;
begin
  fACBrValidador.Complemento := 'SC';
  fACBrValidador.Documento := '123.123.123';
  CheckFalse(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.FormatarSC;
begin
  fACBrValidador.Complemento := 'SC';
  fACBrValidador.Documento := '251040852';
  CheckEquals('251.040.852', fACBrValidador.Formatar);
end;

procedure TACBrValidadorIE.ValidoSP;
begin
  fACBrValidador.Complemento := 'SP';
  fACBrValidador.Documento := '110.042.490.114';
  CheckTrue(fACBrValidador.Validar, MsgErroIE);
  fACBrValidador.Documento := 'P-01100424.3/002';  // Produtor Rural
  CheckTrue(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.InvalidoSP;
begin
  fACBrValidador.Complemento := 'SP';
  fACBrValidador.Documento := '123.123.123.123';
  CheckFalse(fACBrValidador.Validar, MsgErroIE);
  fACBrValidador.Documento := 'P-12345678.9/002';  // Produtor Rural
  CheckFalse(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.FormatarSP;
begin
  fACBrValidador.Complemento := 'SP';
  fACBrValidador.Documento := '110042490114';
  CheckEquals('110.042.490.114', fACBrValidador.Formatar);
  fACBrValidador.Documento := 'P011004243123';
  CheckEquals('P-01100424.3/123', fACBrValidador.Formatar);
end;

procedure TACBrValidadorIE.ValidoSE;
begin
  fACBrValidador.Complemento := 'SE';
  fACBrValidador.Documento := '27123456-3';
  CheckTrue(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.InvalidoSE;
begin
  fACBrValidador.Complemento := 'SE';
  fACBrValidador.Documento := '12312312-3';
  CheckFalse(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.FormatarSE;
begin
  fACBrValidador.Complemento := 'SE';
  fACBrValidador.Documento := '271234563';
  CheckEquals('27.123.456-3', fACBrValidador.Formatar);
end;

procedure TACBrValidadorIE.ValidoTO;
begin
  fACBrValidador.Complemento := 'TO';
  fACBrValidador.Documento := '01.022.783-0';
  CheckTrue(fACBrValidador.Validar, MsgErroIE);
  fACBrValidador.Documento := '29.01.022783-6';
  CheckTrue(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.InvalidoTO;
begin
  fACBrValidador.Complemento := 'TO';
  fACBrValidador.Documento := '12.123.123-9';
  CheckFalse(fACBrValidador.Validar, MsgErroIE);
  fACBrValidador.Documento := '12.34.567890-6';
  CheckFalse(fACBrValidador.Validar, MsgErroIE);
end;

procedure TACBrValidadorIE.FormatarTO;
begin
  fACBrValidador.Complemento := 'TO';
  fACBrValidador.Documento := '010227830';
  CheckEquals('01.022.783-0', fACBrValidador.Formatar);
  fACBrValidador.Documento := '29010227836';
  CheckEquals('29.01.022783-6', fACBrValidador.Formatar);
end;

{ TACBrEAN13Test }

procedure TACBrEAN13Test.Valido;
begin
  CheckEquals( '8', EAN13_DV('123456789012'));
  CheckEquals( '5', EAN13_DV('789835741001'));

  CheckTrue( EAN13Valido('1234567890128') );
  CheckTrue( EAN13Valido('7898357410015') );
end;

procedure TACBrEAN13Test.TamanhoMaior;
begin
   CheckFalse( EAN13Valido('78983574100156'));
end;

procedure TACBrEAN13Test.TamanhoMenor;
begin
  CheckFalse( EAN13Valido('789835741001'));
end;

procedure TACBrEAN13Test.DigitoInvalido;
begin
  CheckFalse( EAN13Valido('7898357410010'));
  CheckFalse( EAN13Valido('1234567890129'));
end;

procedure TACBrEAN13Test.DigitoInvalidoComLetras;
begin
  CheckFalse( EAN13Valido('A89835741001D'));
end;

{ TStripHTMLTest }

procedure TACBrStripHTMLTest.TesteSimples;
begin
  CheckEquals('Teste string em html', StripHTML('<br><b>Teste string em html</b><br>'));
end;

procedure TACBrStripHTMLTest.TesteCompleto;
begin
  CheckEquals('FPCUnit de TestesACBrUtil, Testes Unitários', StripHTML('<!DOCTYPE html>'
                           +'<html>'
                               +'<head>'
                                   +'FPCUnit de Testes'
                               +'</head>'
                               +'<body>'
                                   +'ACBrUtil, Testes Unitários'
                               +'</body>'
                           +'</html>'));
end;

{ TACBrLerTagXMLTest }

procedure TACBrLerTagXMLTest.Simples;
begin
  CheckEquals('Teste Simples', LerTagXML('<ACBr>Teste Simples</ACBr>', 'acbr'));
end;

procedure TACBrLerTagXMLTest.SemIgnorarCase;
begin
  CheckEquals('Teste sem ignorar case', LerTagXML('<ACBr>Teste sem ignorar case</ACBr>', 'ACBr', false));
  CheckEquals('', LerTagXML('<ACBr>Teste sem ignorar case</ACBr>', 'acbr', false));
  CheckEquals('Ler Aqui', LerTagXML('<ACBr>Teste sem <acbr>Ler Aqui</acbr> ignorar case</ACBr>', 'acbr', false));
end;

procedure TACBrLerTagXMLTest.ComVariasTags;
begin
  CheckEquals('mais um teste', LerTagXML('<ACBr> teste <br> outro teste </br> <b>mais um teste</b> </ACBr>', 'b'));
end;

{ TACBrValidadorTelefone }

procedure TACBrValidadorTelefone.TearDown;
begin
  FreeAndNil(fACBrValidador);
end;

procedure TACBrValidadorTelefone.FormatarVazio;
begin
  CheckEquals('', ACBrValidador.FormatarFone(''));
end;

procedure TACBrValidadorTelefone.FormatarZeros;
begin
  CheckEquals('', ACBrValidador.FormatarFone('0000000000', ''));
end;

procedure TACBrValidadorTelefone.FormatarSemDDD;
begin
  CheckEquals('3322-0000', ACBrValidador.FormatarFone('33220000', ''));
  CheckEquals('4004-1234', ACBrValidador.FormatarFone('40041234', ''));
end;

procedure TACBrValidadorTelefone.FormatarComDDD;
begin
  CheckEquals('(15)3322-0000', ACBrValidador.FormatarFone('01533220000', ''));
  CheckEquals('(15)3322-0000', ACBrValidador.FormatarFone('1533220000', ''));
  CheckEquals('(15)4004-1234', ACBrValidador.FormatarFone('01540041234', ''));
  CheckEquals('(15)4004-1235', ACBrValidador.FormatarFone('1540041235', ''));
end;

procedure TACBrValidadorTelefone.FormatarComDDDPadrao;
begin
  CheckEquals('(15)3322-0000', ACBrValidador.FormatarFone('33220000', '15'));
  CheckEquals('(15)4422-0000', ACBrValidador.FormatarFone('044220000', '15'));
end;

procedure TACBrValidadorTelefone.FormatarSemDDD9Dig;
begin
  CheckEquals('99701-2345', ACBrValidador.FormatarFone('997012345', ''));
end;

procedure TACBrValidadorTelefone.FormatarComDDD9Dig;
begin
  CheckEquals('(15)99701-2345', ACBrValidador.FormatarFone('015997012345',''));
  CheckEquals('(15)99701-2346', ACBrValidador.FormatarFone('15997012346',''));
  CheckEquals('(15)99701-2347', ACBrValidador.FormatarFone('997012347','15'));
end;

procedure TACBrValidadorTelefone.Formatar0300;
begin
  CheckEquals('0300-123-4567', ACBrValidador.FormatarFone('03001234567', ''));
end;

procedure TACBrValidadorTelefone.Formatar0500;
begin
  CheckEquals('0500-123-4567', ACBrValidador.FormatarFone('05001234567', ''));
end;

procedure TACBrValidadorTelefone.Formatar0800;
begin
  CheckEquals('0800-123-4567', ACBrValidador.FormatarFone('08001234567', ''));
end;

procedure TACBrValidadorTelefone.Formatar0900;
begin
  CheckEquals('0900-123-4567', ACBrValidador.FormatarFone('09001234567', ''));
end;

procedure TACBrValidadorTelefone.Formatar55ComDDD;
begin
  CheckEquals('+55(11)3322-0000', ACBrValidador.FormatarFone('551133220000', ''));
  CheckEquals('+55(11)3323-0000', ACBrValidador.FormatarFone('5501133230000', ''));
  CheckEquals('+55(11)4004-1234', ACBrValidador.FormatarFone('551140041234', ''));
  CheckEquals('+55(11)4004-1235', ACBrValidador.FormatarFone('5501140041235', ''));
end;

procedure TACBrValidadorTelefone.Formatar55ComDDD9Dig;
begin
  CheckEquals('+55(11)99922-0000', ACBrValidador.FormatarFone('5511999220000', ''));
  CheckEquals('+55(11)99923-0000', ACBrValidador.FormatarFone('55011999230000', ''));
end;

{ TIntesigExcelInstalado }

procedure TIntesigExcelInstalado.ExcelInstalado;
begin
   if AcsGeral.isExcelInstalado then
      CheckTrue(True)
   else CheckFalse(False);
end;

procedure TIntesigExcelInstalado.ExcelNaoInstalado;
begin
   if not(AcsGeral.isExcelInstalado) then
      CheckFalse(False)
   else CheckTrue(True);
end;

{ TIntesigFindText }

procedure TIntesigFindText.TextoEncontratoNoMeio;
begin
   CheckEquals(True, FindText('Estou procurando um texto que contenha texto encontrado, sdafjldksaflsaf', 'texto encontrado'));
end;

procedure TIntesigFindText.TextoEncontratoNoFinal;
begin
   CheckEquals(True, FindText('aqui está o texto encontrado', 'texto encontrado'));
end;

procedure TIntesigFindText.TextoEncontratoNoInicio;
begin
   CheckEquals(True, FindText('texto encontrado aqui', 'texto encontrado'));
end;

procedure TIntesigFindText.TextNaoEncontrado;
begin
   CheckEquals(False, FindText('Estou procurando um texto que nao contenha o que eu quero', 'texto encontrado'));
end;


{ TIntesigTemConexaoInternet }

procedure TIntesigTemConexaoInternet.TemConexaoInternet_Google;
begin
   CheckTrue(AcsMetodos.TemConexaoInternet('http://www.google.com'));
end;

procedure TIntesigTemConexaoInternet.TemConexaoInternet_Intelecto;
begin
   CheckTrue(AcsMetodos.TemConexaoInternet('http://www.intelecto.com.br'));
end;

procedure TIntesigTemConexaoInternet.NaoTemConexaoInternet;
begin
   CheckFalse(AcsMetodos.TemConexaoInternet('http://www.nao_existe_esse_endereco.com'));
end;

{ TIntesigTemConexaoInternet_Ef }

procedure TIntesigTemConexaoInternet_Ef.TemConexaoInternet_ef_Google;
begin
   CheckTrue(AcsMetodos.TemConexaoInternet_ef('http://www.google.com'));
end;

procedure TIntesigTemConexaoInternet_Ef.TemConexaoInternet_ef_Intelecto;
begin
   CheckTrue(AcsMetodos.TemConexaoInternet_ef('http://www.intelecto.com.br'));
end;

procedure TIntesigTemConexaoInternet_Ef.NaoTemConexaoInternet_ef;
begin
   CheckFalse(AcsMetodos.TemConexaoInternet_ef('http://www.nao_existe_esse_endereco.com'));
end;


{ TIntesigExistForm }

procedure TIntesigExistForm.ExistForm_Encontrado;
begin
   CheckTrue(AcsMetodos.ExisteForm('GUITestRunner'));
end;

procedure TIntesigExistForm.ExistForm_NaoEncontrado;
begin
   CheckFalse(AcsMetodos.ExisteForm('FREC900A'));
end;

initialization
  RegisterTest('Intesig.AcsMetodos', TIntesigSoNumeros.Suite);
  RegisterTest('Intesig.AcsMetodos', TIntesigMascaraCPFCGC.Suite);
  RegisterTest('Intesig.AcsMetodos', TIntesigMascaraStrTelefone.Suite);
  RegisterTest('Intesig.AcsMetodos', TIntesigTemConexaoInternet.Suite);
  RegisterTest('Intesig.AcsMetodos', TIntesigTemConexaoInternet_ef.Suite);
  RegisterTest('Intesig.AcsMetodos', TIntesigExistForm.Suite);
  RegisterTest('Intesig.AcsGeral', TIntesigExcelInstalado.Suite);
  RegisterTest('Intesig.AcsGeral', TIntesigFindText.Suite);
  RegisterTest('ACBr', TACBrValidadorCPF.Suite);
  RegisterTest('ACBr', TACBrValidadorCNPJ.Suite);
  RegisterTest('ACBr', TACBrValidadorIE.Suite);
  RegisterTest('ACBr', TACBrLerTagXMLTest.Suite);
  RegisterTest('ACBr', TACBrStripHTMLTest.Suite);
  RegisterTest('ACBr', TACBrEAN13Test.suite);
  RegisterTest('ACBr', TACBrValidadorTelefone.suite);
end.


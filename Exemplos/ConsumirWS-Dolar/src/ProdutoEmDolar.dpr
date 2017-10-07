program ProdutoEmDolar;

uses
  Forms,
  uForm in 'uForm.pas' {fForm},
  uFact in 'uFact.pas',
  uWSDL_BCB in 'uWSDL_BCB.pas',
  uCotacaoDolar in 'uCotacaoDolar.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Produtos em Dólar';
  Application.CreateForm(TfForm, fForm);
  Application.Run;
end.

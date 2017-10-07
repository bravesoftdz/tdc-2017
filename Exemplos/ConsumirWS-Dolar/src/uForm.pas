unit uForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, StdCtrls, Buttons, Grids, DBGrids;

type
  TfForm = class(TForm)
    BitBtnCalcularValorDaVenda: TBitBtn;
    ClientDataSetProdutos: TClientDataSet;
    ClientDataSetProdutosCodigo: TIntegerField;
    ClientDataSetProdutosProduto: TStringField;
    ClientDataSetProdutosPreco: TFloatField;
    DBGridProdutos: TDBGrid;
    LabelProduto: TLabel;
    DataSourceProdutos: TDataSource;
    Memo: TMemo;
    LabelHistorico: TLabel;
    procedure BitBtnCalcularValorDaVendaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  end;

var
  fForm: TfForm;

implementation

uses
  System.UITypes, uFact;

{$R *.dfm}

procedure TfForm.FormCreate(Sender: TObject);
begin
  ClientDataSetProdutos.Insert;
  ClientDataSetProdutosCodigo.AsInteger := 1;
  ClientDataSetProdutosProduto.AsString := 'Produto 1';
  ClientDataSetProdutosPreco.AsFloat    := 1;
  ClientDataSetProdutos.Post;

  ClientDataSetProdutos.Insert;
  ClientDataSetProdutosCodigo.AsInteger := 2;
  ClientDataSetProdutosProduto.AsString := 'Produto 2';
  ClientDataSetProdutosPreco.AsFloat    := 10.50;
  ClientDataSetProdutos.Post;

  ClientDataSetProdutos.Insert;
  ClientDataSetProdutosCodigo.AsInteger := 3;
  ClientDataSetProdutosProduto.AsString := 'Produto 3';
  ClientDataSetProdutosPreco.AsFloat    := 123.15;
  ClientDataSetProdutos.Post;
end;

procedure TfForm.BitBtnCalcularValorDaVendaClick(Sender: TObject);
var
  Preco: Real;
  uFact: TFact;
  Linha: String;
begin
  Preco := ClientDataSetProdutos.FieldByName('Preco').AsFloat;
  uFact := TFact.Create;
  try
    Linha := Format('%s-%s R$ %s U$ %s',
             [IntToStr(ClientDataSetProdutos.FieldByName('Codigo').AsInteger),
              ClientDataSetProdutos.FieldByName('Produto').AsString,
              FloatToStr(ClientDataSetProdutos.FieldByName('Preco').AsFloat),
              FloatToStr(uFact.CalcularValorDeVenda(Preco))]);
    Memo.Lines.Add(Linha);
  finally
    FreeAndNil(uFact);
  end;
end;

end.

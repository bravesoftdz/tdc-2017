unit Example1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFormExample1 = class(TForm)
    ButtonSoma: TButton;
    Value1: TLabeledEdit;
    Memo1: TMemo;
    Value2: TLabeledEdit;
    ButtonSubtracao: TButton;
    procedure ButtonSomaClick(Sender: TObject);
    procedure Value1Enter(Sender: TObject);
    procedure Value2Enter(Sender: TObject);
    procedure ButtonSubtracaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class function Soma(Valor1, Valor2: Real): Real;
    class function Subtracao(Valor1, Valor2: Real): Real;
  end;

var
  FormExample1: TFormExample1;

implementation

{$R *.dfm}

class function TFormExample1.Soma(Valor1, Valor2: Real): Real;
begin
   result := Valor1 + Valor2;
end;

class function TFormExample1.Subtracao(Valor1, Valor2: Real): Real;
begin
   result := Valor1 - Valor2;
end;

procedure TFormExample1.ButtonSomaClick(Sender: TObject);
var S: Real;
begin
   S := Soma(StrToFloatDef(Value1.Text,0), StrToFloatDef(Value2.Text,0));
   Memo1.Lines.Add(Value1.Text + ' + ' + Value2.Text + ' = ' +  FloatToStr(S));
end;

procedure TFormExample1.ButtonSubtracaoClick(Sender: TObject);
var S: Real;
begin
   S := Subtracao(StrToFloatDef(Value1.Text,0), StrToFloatDef(Value2.Text,0));
   Memo1.Lines.Add(Value1.Text + ' - ' + Value2.Text + ' = ' +  FloatToStr(S));
end;

procedure TFormExample1.Value1Enter(Sender: TObject);
begin
   Value1.SelectAll;
end;

procedure TFormExample1.Value2Enter(Sender: TObject);
begin
   Value2.SelectAll;
end;

end.
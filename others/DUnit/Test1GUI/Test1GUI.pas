unit Test1GUI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    Edit3: TEdit;
    procedure Button1Click(Sender: TObject);
    function CalcularSoma(Value1, Value2: String): String;
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
   Edit3.Text := CalcularSoma(Edit1.Text, Edit2.Text);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
   Edit1.Clear;
   Edit2.Clear;
   Edit3.Clear;
end;

function TForm1.CalcularSoma(Value1, Value2: String): String;
begin
   Result := FloatToStr( (StrToFloatDef(Value1,0) + StrToFloatDef(Value2,0)) );
end;

end.

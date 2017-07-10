unit Test1GUI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, DM,
  uADStanIntf, uADStanOption, uADStanParam, uADStanError, uADDatSManager,
  uADPhysIntf, uADDAptIntf, uADStanAsync, uADDAptManager, Data.DB,
  uADCompDataSet, uADCompClient;

type
  TForm1 = class(TForm)
    RadioGroup1: TRadioGroup;
    ComboBox1: TComboBox;
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    ADQuery: TADQuery;
    procedure RadioGroup1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
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

procedure TForm1.RadioGroup1Click(Sender: TObject);
begin
   case RadioGroup1.ItemIndex of
     0: begin
          ComboBox1.Items.Clear;
          ADQuery.Close;
          ADQuery.Sql.Clear;
          ADQuery.Sql.Add('Select nome from tbanimal');
          ADQuery.Open;
          while not(ADQuery.EoF) do
          begin
             ComboBox1.Items.Add(ADQuery.FieldByName('nome').AsString);
             ADQuery.Next;
          end;
     end;
     1: begin
          ComboBox1.Items.Clear;
          ADQuery.Close;
          ADQuery.Sql.Clear;
          ADQuery.Sql.Add('Select nome from tbave');
          ADQuery.Open;
          while not(ADQuery.EoF) do
          begin
             ComboBox1.Items.Add(ADQuery.FieldByName('nome').AsString);
             ADQuery.Next;
          end;
     end;
   end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
   Edit1.Text := ComboBox1.Text;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
   Edit1.Clear;
   ComboBox1.Items.Clear;
   ComboBox1.Text := '';
end;

end.

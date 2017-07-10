unit Test1GUI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    RadioGroup1: TRadioGroup;
    ComboBox1: TComboBox;
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
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
   ComboBox1.Items.Clear;
   case RadioGroup1.ItemIndex of
     0: begin
         ComboBox1.Items.Add('Pitbull');
         ComboBox1.Items.Add('Beagle');
         ComboBox1.Items.Add('Boxer');
         ComboBox1.Items.Add('Bulldog');
         ComboBox1.Items.Add('Bullmastiff');
         ComboBox1.Items.Add('Chow Chow');
     end;
     1: begin
         ComboBox1.Items.Add('Papagaio');
         ComboBox1.Items.Add('Gavião');
         ComboBox1.Items.Add('Biguá');
         ComboBox1.Items.Add('Curió');
         ComboBox1.Items.Add('Gralha');
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

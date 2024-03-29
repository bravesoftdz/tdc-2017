unit uStudentEditDialog;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, ComCtrls, uModel;

type
  EValidationError = class(Exception);
  TStudentEditDialog = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    edName: TEdit;
    edEmail: TEdit;
    dtpDateOfBirth: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    procedure InitView(const AStudent: IStudent);
    procedure UpdateModel(const AStudent: IStudent);
    procedure ValidateView;
  public
    class function Edit(const AStudent: IStudent): Boolean;
  end;


implementation

{$R *.dfm}

{ TStudentEditDialog }

class function TStudentEditDialog.Edit(const AStudent: IStudent): Boolean;
var
  dlg: TStudentEditDialog;
begin
  dlg := TStudentEditDialog.Create(Application);
  try
    dlg.InitView(AStudent);
    Result := dlg.ShowModal = mrOk;
    if Result then
      dlg.UpdateModel(AStudent);
  finally
    dlg.Free;
  end;
end;

procedure TStudentEditDialog.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if ModalResult = mrOk then
    ValidateView;
end;

procedure TStudentEditDialog.InitView(const AStudent: IStudent);
begin
  edName.Text := AStudent.Name;
  edEmail.Text := AStudent.Email;
  dtpDateOfBirth.Date := AStudent.DateOfBirth;
  if Trunc(dtpDateOfBirth.Date) = 0 then
    dtpDateOfBirth.Date := Now;
end;

procedure TStudentEditDialog.UpdateModel(const AStudent: IStudent);
begin
  AStudent.Name := edName.Text;
  AStudent.Email := edEmail.Text;
  AStudent.DateOfBirth := Int(dtpDateOfBirth.Date);
end;

procedure TStudentEditDialog.ValidateView;
begin
  if edName.Text = '' then
  begin
    edName.SetFocus;
    raise EValidationError.Create('Nome n�o pode ser vazio!');
  end;
  if edEmail.Text = '' then
  begin
    edEmail.SetFocus;
    raise EValidationError.Create('Email n�o poder ser vazio!');
  end;
  if dtpDateOfBirth.Date < EncodeDate(1960, 1, 1) then
  begin
    dtpDateOfBirth.SetFocus;
    raise EValidationError.Create('Data inv�lida');
  end;
end;

end.

unit uMainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, uModel, ComCtrls, StdCtrls, System.Actions;

type
  TMainForm = class(TForm)
    alActions: TActionList;
    acNewStudent: TAction;
    acEditStudent: TAction;
    acDeleteStudent: TAction;
    lvStudents: TListView;
    btnAddStudent: TButton;
    btnEditStudent: TButton;
    btnDeleteStudent: TButton;
    procedure FormCreate(Sender: TObject);
    procedure lvStudentsData(Sender: TObject; Item: TListItem);
    procedure acNewStudentExecute(Sender: TObject);
    procedure acDeleteStudentUpdate(Sender: TObject);
    procedure acEditStudentUpdate(Sender: TObject);
    procedure lvStudentsEditing(Sender: TObject; Item: TListItem; var AllowEdit: Boolean);
    procedure acDeleteStudentExecute(Sender: TObject);
    procedure acEditStudentExecute(Sender: TObject);
    procedure lvStudentsDblClick(Sender: TObject);
  strict private
    FCurrentCourse: ICourse;
    function Confirm(const AMessage: string): Boolean;
    function EditStudent(const AStudent: IStudent): Boolean;
    function GetCurrentStudent: IStudent;
    function ListItemToStudent(AItem: TListItem): IStudent;
    procedure UpdateStudentView(const AStudent: IStudent);
    procedure UpdateView;
    procedure SetCurrentStudent(const Value: IStudent);
    procedure EditCurrentStudent;
  public
    { Public declarations }
    property CurrentCourse: ICourse read FCurrentCourse;
    property CurrentStudent: IStudent read GetCurrentStudent write SetCurrentStudent;
  end;

var
  MainForm: TMainForm;

implementation

uses
  Menus, uStudentEditDialog;

{$R *.dfm}

procedure TMainForm.acDeleteStudentExecute(Sender: TObject);
var
  student: IStudent;
begin
  student := CurrentStudent;
  Assert(student <> nil);
  if (student <> nil) and Confirm('Tem certeza?') then
  begin
    CurrentCourse.RemoveStudent(student);
    UpdateView;
  end;
end;

procedure TMainForm.acDeleteStudentUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := CurrentStudent <> nil
end;

procedure TMainForm.acEditStudentExecute(Sender: TObject);
begin
  EditCurrentStudent;
end;

procedure TMainForm.acEditStudentUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := CurrentStudent <> nil
end;

procedure TMainForm.acNewStudentExecute(Sender: TObject);
var
  student: IStudent;
begin
  student := TModel.CreateStudent;
  if EditStudent(student) then
  begin
    CurrentCourse.AddStudent(student);
    UpdateView;
  end;
end;

function TMainForm.Confirm(const AMessage: string): Boolean;
begin
  Result := MessageBox(Handle, PChar(AMessage), PChar(Caption), MB_ICONQUESTION or MB_YESNO) = ID_YES
end;

procedure TMainForm.EditCurrentStudent;
var
  student: IStudent;
begin
  student := CurrentStudent;
  if (student <> nil) then
  begin
    if EditStudent(student) then
      UpdateStudentView(student);
  end;
end;

function TMainForm.EditStudent(const AStudent: IStudent): Boolean;
begin
  Result := TStudentEditDialog.Edit(AStudent)
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FCurrentCourse := TModel.CreateCourse;
end;

function TMainForm.GetCurrentStudent: IStudent;
begin
  Result := ListItemToStudent(lvStudents.Selected);
end;

function TMainForm.ListItemToStudent(AItem: TListItem): IStudent;
begin
  if AItem = nil then
    Result := nil
  else
    Result := CurrentCourse.Students[AItem.Index]
end;

procedure TMainForm.lvStudentsData(Sender: TObject; Item: TListItem);
var
  student: IStudent;
begin
  student := ListItemToStudent(Item);
  if student <> nil then
  begin
    Item.Caption := student.Name;
    Item.SubItems.Add(student.Email);
    Item.SubItems.Add(DateToStr(student.DateOfBirth));
  end;
end;

procedure TMainForm.lvStudentsDblClick(Sender: TObject);
begin
  EditCurrentStudent;
end;

procedure TMainForm.lvStudentsEditing(Sender: TObject; Item: TListItem;
  var AllowEdit: Boolean);
begin
  AllowEdit := False;
end;

procedure TMainForm.UpdateStudentView(const AStudent: IStudent);
var
  idx: Integer;
begin
  idx := CurrentCourse.IndexOfStudent(AStudent);
  if idx > -1 then
  begin
    lvStudents.Items[idx].Update;
  end;
end;

procedure TMainForm.SetCurrentStudent(const Value: IStudent);
var
  idx: Integer;
begin
  idx := CurrentCourse.IndexOfStudent(Value);
  if idx = -1 then
    lvStudents.Selected := nil
  else
    lvStudents.Selected := lvStudents.Items[idx]
end;

procedure TMainForm.UpdateView;
begin
  lvStudents.Items.Count := CurrentCourse.StudentsCount;
end;

end.

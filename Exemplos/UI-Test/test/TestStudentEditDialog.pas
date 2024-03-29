unit TestStudentEditDialog;

interface
uses
  Controls,
  uStudentEditDialog,
  FutureWindows;

implementation
uses
  Windows,
  Messages,
  SysUtils,
  TestFramework,
  TestCaseBase,
  uModel,
  Forms;

type
  TStudentEditDialogTestCase = class(TTestCaseBase)
  published
    procedure TestEditCadastro1;
    procedure TestEditCadastro2;
    procedure TestCloseForm;
  end;

  TEditStudentFutureWindowAction = class(TAbstractWindowAction)
  strict private
    FName: string;
    FEmail: string;
    FDate: TDate;
  protected
    procedure Execute(const AWindow: IWindow); override;
  public
    constructor Create(const AName, AEmail: string; ADate: TDate);
  end;

{ TStudentEditDialogTestCase }

procedure TStudentEditDialogTestCase.TestCloseForm;
var
  student: IStudent;
  futureWindow: IFutureWindow;
begin
  student := TModel.CreateStudent();

  futureWindow := TFutureWindows.Expect(TStudentEditDialog.ClassName)
    .ExecPauseAction(0.5, Application.ProcessMessages)
    .ExecCloseWindow()
    ;

  CheckFalse(TStudentEditDialog.Edit(student));
end;

procedure TStudentEditDialogTestCase.TestEditCadastro1;
var
  student: IStudent;
  futureWindow: IFutureWindow;
  dateOfBirth: TDate;
const
  NAME  = 'Jo�o da Silva';
  EMAIL = 'joao@dasilva.com';
begin
  dateOfBirth := EncodeDate(1980, 1, 1);

  student := TModel.CreateStudent();

  futureWindow := TFutureWindows.Expect(TStudentEditDialog.ClassName);
  futureWindow.ExecAction(TEditStudentFutureWindowAction.Create(
    NAME, EMAIL, dateOfBirth
  ));

  Check(TStudentEditDialog.Edit(student));

  Check(futureWindow.WindowFound, 'window not found: ' + futureWindow.Description);

  CheckEquals(NAME, student.Name);
  CheckEquals(EMAIL, student.Email);
  CheckEquals(dateOfBirth, student.DateOfBirth, 0.1);
end;

procedure TStudentEditDialogTestCase.TestEditCadastro2;
var
  student: IStudent;
  futureWindow: IFutureWindow;
  dateOfBirth: TDate;
const
  NAME  = 'Leonardo Gregianin';
  EMAIL = 'leogregianin@gmail.com';
begin
  dateOfBirth := EncodeDate(1980, 1, 1);

  student := TModel.CreateStudent();

  futureWindow := TFutureWindows.Expect(TStudentEditDialog.ClassName);
  futureWindow.ExecAction(TEditStudentFutureWindowAction.Create(
    NAME, EMAIL, dateOfBirth
  ));

  Check(TStudentEditDialog.Edit(student));

  Check(futureWindow.WindowFound, 'window not found: ' + futureWindow.Description);

  CheckEquals(NAME, student.Email, 'Campo nome');
  CheckEquals(EMAIL, student.Email, 'Campo email');
  CheckEquals(dateOfBirth, student.DateOfBirth, 0.1);
end;

{ TTestEditAction }
constructor TEditStudentFutureWindowAction.Create(const AName, AEmail: string; ADate: TDate);
begin
  FName := AName;
  FEmail := AEmail;
  FDate := ADate;
end;

procedure TEditStudentFutureWindowAction.Execute(const AWindow: IWindow);
var
  dlg: TStudentEditDialog;
begin
  Assert(AWindow.AsControl is TStudentEditDialog);
  dlg := AWindow.AsControl as TStudentEditDialog;

  dlg.edName.Text := FName;
  dlg.edEmail.Text := FEmail;
  dlg.dtpDateOfBirth.Date := FDate;

  // let us see the changes
  TTestCaseBase.ProcessMessages(0);

  dlg.OKBtn.Click;
end;

initialization
  RegisterTest(TStudentEditDialogTestCase.Suite);
end.

unit TestMainForm;

interface

implementation
uses
  Classes,
  Forms,
  ActnList,
  TestFramework,
  FutureWindows,
  TestCaseBase,
  uMainForm,
  uStudentEditDialog,
  TestStudentEditDialog,
  SysUtils,
  uModel,
  Windows,
  Messages;

type
  TMainFormTestCase = class(TTestCaseBase)
  strict private
    FMainForm: TMainForm;
    procedure ExecuteMainFormAction(AAction: TAction);
    procedure AddStudent_Slow(const AName, AEmail: string; ADateOfBirth: TDate);
    procedure AddStudent_Fast(const AName, AEmail: string; ADateOfBirth: TDate);
    procedure AddStudents_Fast(ACount: Cardinal);
    procedure AddStudents_Slow(ACount: Cardinal);
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestAddNewStudent;
    procedure TestAddManyStudents_Slow;
    procedure TestAddManyStudents_Fast;
    procedure TestDeleteStudents;
    procedure TestDeleteOneStudent;
    procedure TestValidation_NameEmpty;
    procedure TestValidation_EmailEmpty;
  end;

{ TMainFormTestCase }

procedure TMainFormTestCase.AddStudent_Slow(const AName, AEmail: string;
  ADateOfBirth: TDate);
begin
  TFutureWindows.Expect(TStudentEditDialog.ClassName, 1)
    .ExecProc(
      procedure (const AWindow: IWindow)
      var
        form: TStudentEditDialog;
      begin
        form := AWindow.AsControl as TStudentEditDialog;
        form.edName.Text := AName;
        form.edEmail.Text := AEmail;
        form.dtpDateOfBirth.Date := ADateOfBirth;

        TTestCaseBase.ProcessMessages(0.2);

        form.OKBtn.Click;
      end
    );

  ExecuteMainFormAction(FMainForm.acNewStudent);
end;

procedure TMainFormTestCase.AddStudent_Fast(const AName, AEmail: string;
  ADateOfBirth: TDate);
begin
  TFutureWindows.Expect(TStudentEditDialog.ClassName, 1)
    .ExecProc(
      procedure (const AWindow: IWindow)
      var
        form: TStudentEditDialog;
      begin
        form := AWindow.AsControl as TStudentEditDialog;
        form.edName.Text := AName;
        form.edEmail.Text := AEmail;
        form.dtpDateOfBirth.Date := ADateOfBirth;

        TTestCaseBase.ProcessMessages(0);

        form.OKBtn.Click;
      end
    );

  ExecuteMainFormAction(FMainForm.acNewStudent);
end;

procedure TMainFormTestCase.AddStudents_Slow(ACount: Cardinal);
var
  i: Integer;
begin
  for i := 1 to ACount do
  begin
    AddStudent_Slow(
      'Estudante ' + Uppercase(Char(65 + i)),
      'email' + IntToStr(i) + '@teste_rad.com',
      EncodeDate(2000, 1, 1)
    );
  end;
end;

procedure TMainFormTestCase.AddStudents_Fast(ACount: Cardinal);
var
  i: Integer;
begin
  for i := 1 to ACount do
  begin
    AddStudent_Fast(
      'Estudante ' + Uppercase(Char(65 + i)),
      'email' + IntToStr(i) + '@teste_rad.com',
      EncodeDate(2000, 1, 1)
    );
  end;
end;

procedure TMainFormTestCase.ExecuteMainFormAction(AAction: TAction);
begin
  ProcessMessages();
  AAction.Update;
  Check(AAction.Enabled, AAction.Name + ' disabled');
  AAction.Execute;
end;

type
  TFormHack = class(TForm);

procedure TMainFormTestCase.Setup;
begin
  inherited;
  FMainForm := TMainForm.Create(Application);
  FMainForm.Show;
  FMainForm.BringToFront;
  TFormHack(FMainForm).UpdateActions;
end;

procedure TMainFormTestCase.TearDown;
begin
  FMainForm.Free;
  FMainForm := nil;
  inherited;
end;

procedure TMainFormTestCase.TestAddManyStudents_Slow;
const
  NUM_STUDENTS = 10;
begin
  CheckEquals(0, FMainForm.CurrentCourse.StudentsCount);

  AddStudents_Slow(NUM_STUDENTS);

  CheckEquals(NUM_STUDENTS, FMainForm.CurrentCourse.StudentsCount);

  ProcessMessages(0.5);

end;

procedure TMainFormTestCase.TestAddManyStudents_Fast;
const
  NUM_STUDENTS = 100;
begin
  CheckEquals(0, FMainForm.CurrentCourse.StudentsCount);

  AddStudents_Fast(NUM_STUDENTS);

  CheckEquals(NUM_STUDENTS, FMainForm.CurrentCourse.StudentsCount);

  ProcessMessages(0.5);
end;

procedure TMainFormTestCase.TestAddNewStudent;
const
  NAME  = 'Jo�o da Silva';
  EMAIL = 'joao@dasilva.com';
var
  dateOfBirth: TDate;
begin
  CheckFalse(FMainForm.acEditStudent.Enabled);
  CheckFalse(FMainForm.acDeleteStudent.Enabled);

  dateOfBirth := EncodeDate(2000, 1, 1);

  CheckEquals(0, FMainForm.CurrentCourse.StudentsCount);

  AddStudent_Slow(NAME, EMAIL, dateOfBirth);

  CheckEquals(1, FMainForm.CurrentCourse.StudentsCount);

  ProcessMessages(0.5);
end;

procedure TMainFormTestCase.TestDeleteOneStudent;
const
  NUM_STUDENTS = 1;
var
  delCount: Integer;
  student: IStudent;
begin
  AddStudents_Slow(NUM_STUDENTS);
  CheckEquals(NUM_STUDENTS, FMainForm.CurrentCourse.StudentsCount);

  delCount := 0;
  while FMainForm.CurrentCourse.StudentsCount > 0 do
  begin
    student := FMainForm.CurrentCourse.Students[0];

    FMainForm.CurrentStudent := student;
    Check(student = FMainForm.CurrentStudent);

    TFutureWindows.ExpectChild(FMainForm.Handle, MESSAGE_BOX_WINDOW_CLASS, 1)
      .ExecSendKey(VK_RETURN);

    ExecuteMainFormAction(FMainForm.acDeleteStudent);

    Inc(delCount);
  end;

  CheckEquals(NUM_STUDENTS, delCount);

  ProcessMessages(0.5);

end;

procedure TMainFormTestCase.TestDeleteStudents;
const
  NUM_STUDENTS = 5;
var
  delCount: Integer;
  student: IStudent;
begin
  AddStudents_Slow(NUM_STUDENTS);
  CheckEquals(NUM_STUDENTS, FMainForm.CurrentCourse.StudentsCount);

  delCount := 0;
  while FMainForm.CurrentCourse.StudentsCount > 0 do
  begin
    student := FMainForm.CurrentCourse.Students[0];

    FMainForm.CurrentStudent := student;
    Check(student = FMainForm.CurrentStudent);

    // close future confirmation dialog by hitting [Enter]
    TFutureWindows.ExpectChild(FMainForm.Handle, MESSAGE_BOX_WINDOW_CLASS, 1)
      .ExecSendKey(VK_RETURN);

    ExecuteMainFormAction(FMainForm.acDeleteStudent);

    Inc(delCount);
    TTestCaseBase.ProcessMessages(0.2);
  end;

  CheckEquals(NUM_STUDENTS, delCount);

  ProcessMessages(0.5);
end;

procedure TMainFormTestCase.TestValidation_NameEmpty;
var
  studentEditForm: TStudentEditDialog;
  exceptionErrorDlg: IFutureWindow;
begin
  studentEditForm := nil;

  // wait for exception dialog
  exceptionErrorDlg := TFutureWindows.Expect(MESSAGE_BOX_WINDOW_CLASS)
    .ExecProc(
      procedure (const AWindow: IWindow)
      var
        errorMsg: string;
      begin
        ProcessMessages(0.3);

        errorMsg := AWindow.Text;

        // first close the error dialog
        AWindow.SendMessage(WM_CLOSE, 0, 0);

        CheckNotNull(studentEditForm, 'studentEditForm');

        // close the student editor
        studentEditForm.CancelBtn.Click;
      end
    );

  TFutureWindows.Expect(TStudentEditDialog.ClassName, 1)
    .ExecProc(
      procedure (const AWindow: IWindow)
      begin
        studentEditForm := AWindow.AsControl as TStudentEditDialog;
        studentEditForm.edName.Text := '';

        // let us see the changes
        TTestCaseBase.ProcessMessages(0.2);

        // this should raise a validation exception
        studentEditForm.OKBtn.Click;
      end
    );

  ExecuteMainFormAction(FMainForm.acNewStudent);
  Check(exceptionErrorDlg.WindowFound, 'Exception dialog was not shown');
  ProcessMessages(0.5);
end;

procedure TMainFormTestCase.TestValidation_EmailEmpty;
var
  studentEditForm: TStudentEditDialog;
  exceptionErrorDlg: IFutureWindow;
begin
  studentEditForm := nil;

  // wait for exception dialog
  exceptionErrorDlg := TFutureWindows.Expect(MESSAGE_BOX_WINDOW_CLASS)
    .ExecProc(
      procedure (const AWindow: IWindow)
      var
        errorMsg: string;
      begin
        ProcessMessages(0.3);

        errorMsg := AWindow.Text;

        // first close the error dialog
        AWindow.SendMessage(WM_CLOSE, 0, 0);

        CheckNotNull(studentEditForm, 'studentEditForm');

        // close the student editor
        studentEditForm.CancelBtn.Click;
      end
    );

  TFutureWindows.Expect(TStudentEditDialog.ClassName, 1)
    .ExecProc(
      procedure (const AWindow: IWindow)
      begin
        studentEditForm := AWindow.AsControl as TStudentEditDialog;
        studentEditForm.edEmail.Text := '';

        // let us see the changes
        TTestCaseBase.ProcessMessages(0.2);

        // this should raise a validation exception
        studentEditForm.OKBtn.Click;
      end
    );

  ExecuteMainFormAction(FMainForm.acNewStudent);
  Check(exceptionErrorDlg.WindowFound, 'Exception dialog was not shown');
  ProcessMessages(0.5);
end;

initialization
  RegisterTest(TMainFormTestCase.Suite);
end.

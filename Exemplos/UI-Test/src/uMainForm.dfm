object MainForm: TMainForm
  Left = 412
  Top = 113
  Caption = 'Demonstra'#231#227'o 1'
  ClientHeight = 510
  ClientWidth = 745
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    745
    510)
  PixelsPerInch = 96
  TextHeight = 13
  object lvStudents: TListView
    Left = 8
    Top = 39
    Width = 729
    Height = 463
    Anchors = [akLeft, akTop, akRight, akBottom]
    Columns = <
      item
        AutoSize = True
        Caption = 'Nome'
      end
      item
        AutoSize = True
        Caption = 'Email'
      end
      item
        Alignment = taRightJustify
        AutoSize = True
        Caption = 'Data de nascimento'
      end>
    OwnerData = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    OnData = lvStudentsData
    OnDblClick = lvStudentsDblClick
    OnEditing = lvStudentsEditing
  end
  object btnAddStudent: TButton
    Left = 8
    Top = 8
    Width = 89
    Height = 25
    Action = acNewStudent
    Caption = '&Novo'
    TabOrder = 1
  end
  object btnEditStudent: TButton
    Left = 103
    Top = 8
    Width = 89
    Height = 25
    Action = acEditStudent
    Caption = '&Editar'
    TabOrder = 2
  end
  object btnDeleteStudent: TButton
    Left = 198
    Top = 8
    Width = 89
    Height = 25
    Action = acDeleteStudent
    Caption = '&Excluir'
    TabOrder = 3
  end
  object alActions: TActionList
    Left = 88
    Top = 432
    object acNewStudent: TAction
      Caption = '&New Student...'
      ShortCut = 45
      OnExecute = acNewStudentExecute
    end
    object acEditStudent: TAction
      Caption = '&Edit Student...'
      ShortCut = 113
      OnExecute = acEditStudentExecute
      OnUpdate = acEditStudentUpdate
    end
    object acDeleteStudent: TAction
      Caption = '&Delete Student'
      ShortCut = 46
      OnExecute = acDeleteStudentExecute
      OnUpdate = acDeleteStudentUpdate
    end
  end
end

object StudentEditDialog: TStudentEditDialog
  Left = 539
  Top = 179
  BorderStyle = bsDialog
  Caption = 'Estudante'
  ClientHeight = 227
  ClientWidth = 497
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  DesignSize = (
    497
    227)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 473
    Height = 161
    Anchors = [akLeft, akTop, akRight, akBottom]
    Shape = bsFrame
  end
  object Label1: TLabel
    Left = 16
    Top = 24
    Width = 31
    Height = 13
    Caption = '&Nome:'
    FocusControl = edName
  end
  object Label2: TLabel
    Left = 16
    Top = 70
    Width = 28
    Height = 13
    Caption = '&Email:'
    FocusControl = edEmail
  end
  object Label3: TLabel
    Left = 16
    Top = 118
    Width = 99
    Height = 13
    Caption = '&Data de nascimento:'
    FocusControl = dtpDateOfBirth
  end
  object OKBtn: TButton
    Left = 167
    Top = 183
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object CancelBtn: TButton
    Left = 278
    Top = 183
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Cancel = True
    Caption = 'Cancelar'
    ModalResult = 2
    TabOrder = 4
  end
  object edName: TEdit
    Left = 16
    Top = 40
    Width = 425
    Height = 21
    TabOrder = 0
  end
  object edEmail: TEdit
    Left = 16
    Top = 86
    Width = 425
    Height = 21
    TabOrder = 1
  end
  object dtpDateOfBirth: TDateTimePicker
    Left = 16
    Top = 134
    Width = 186
    Height = 21
    Date = 40762.733315000000000000
    Time = 40762.733315000000000000
    TabOrder = 2
  end
end

object FormExample1: TFormExample1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'FormExample1'
  ClientHeight = 341
  ClientWidth = 425
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ButtonSoma: TButton
    Left = 202
    Top = 16
    Width = 63
    Height = 41
    Caption = 'Soma'
    TabOrder = 0
    OnClick = ButtonSomaClick
  end
  object Value1: TLabeledEdit
    Left = 16
    Top = 32
    Width = 65
    Height = 21
    EditLabel.Width = 32
    EditLabel.Height = 13
    EditLabel.Caption = 'Value1'
    TabOrder = 1
    Text = '5'
    OnEnter = Value1Enter
  end
  object Memo1: TMemo
    Left = 16
    Top = 72
    Width = 377
    Height = 248
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object Value2: TLabeledEdit
    Left = 104
    Top = 32
    Width = 65
    Height = 21
    EditLabel.Width = 32
    EditLabel.Height = 13
    EditLabel.Caption = 'Value2'
    TabOrder = 3
    Text = '5'
    OnEnter = Value2Enter
  end
  object ButtonSubtracao: TButton
    Left = 274
    Top = 16
    Width = 63
    Height = 41
    Caption = 'Subtra'#231#227'o'
    TabOrder = 4
    OnClick = ButtonSubtracaoClick
  end
end
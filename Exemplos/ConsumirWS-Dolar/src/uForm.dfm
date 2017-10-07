object fForm: TfForm
  Left = 192
  Top = 125
  AutoSize = True
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Produtos em D'#243'lar'
  ClientHeight = 311
  ClientWidth = 726
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LabelProduto: TLabel
    Left = 0
    Top = 0
    Width = 126
    Height = 13
    Caption = 'Selecione um produto:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabelHistorico: TLabel
    Left = 334
    Top = 0
    Width = 42
    Height = 13
    Caption = 'Extrato'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object BitBtnCalcularValorDaVenda: TBitBtn
    Left = 55
    Top = 267
    Width = 187
    Height = 38
    Caption = 'Calcular'
    TabOrder = 0
    OnClick = BitBtnCalcularValorDaVendaClick
  end
  object DBGridProdutos: TDBGrid
    Left = 0
    Top = 16
    Width = 320
    Height = 237
    DataSource = DataSourceProdutos
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Codigo'
        Title.Alignment = taCenter
        Title.Caption = 'C'#243'digo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Produto'
        Title.Alignment = taCenter
        Width = 145
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Preco'
        Title.Alignment = taCenter
        Title.Caption = 'Pre'#231'o (USD)'
        Width = 75
        Visible = True
      end>
  end
  object Memo: TMemo
    Left = 334
    Top = 16
    Width = 392
    Height = 295
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object ClientDataSetProdutos: TClientDataSet
    PersistDataPacket.Data = {
      530000009619E0BD010000001800000003000000000003000000530006436F64
      69676F04000100000000000750726F6475746F01004900000001000557494454
      4802000200320005507265636F08000400000000000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 68
    Top = 82
    object ClientDataSetProdutosCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object ClientDataSetProdutosProduto: TStringField
      FieldName = 'Produto'
      Size = 50
    end
    object ClientDataSetProdutosPreco: TFloatField
      FieldName = 'Preco'
      DisplayFormat = ',0.00'
      EditFormat = ',0.00'
    end
  end
  object DataSourceProdutos: TDataSource
    DataSet = ClientDataSetProdutos
    Left = 180
    Top = 82
  end
end

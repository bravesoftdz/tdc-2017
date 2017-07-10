object DataModule1: TDataModule1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 567
  Top = 196
  Height = 299
  Width = 461
  object conFiredac: TADConnection
    ConnectionName = 'ADConnBDINTESIG'
    Params.Strings = (
      'Database=BDINTESIG'
      'User_Name=dba'
      'Password=iticba0402br'
      'ODBCAdvanced=CommLinks=TCPIP{}'
      'Server=BDINTESIG_B'
      'OSAuthent=no'
      'DriverID=ASA')
    FormatOptions.AssignedValues = [fvMapRules]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <
      item
        SourceDataType = dtBCD
        TargetDataType = dtDouble
      end
      item
        SourceDataType = dtFmtBCD
        TargetDataType = dtDouble
      end
      item
        SourceDataType = dtDateTimeStamp
        TargetDataType = dtDateTime
      end>
    UpdateOptions.AssignedValues = [uvCheckRequired, uvCheckReadOnly]
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    Connected = True
    LoginPrompt = False
    Left = 55
    Top = 28
  end
  object asaLink: TADPhysASADriverLink
    ODBCDriver = 'Adaptive Server Anywhere 9.0'
    Left = 142
    Top = 32
  end
  object ADQy: TADQuery
    Connection = conFiredac
    Left = 283
    Top = 127
  end
end

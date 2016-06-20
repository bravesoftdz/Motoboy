object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 458
  Width = 554
  object FDConexao: TFDConnection
    Params.Strings = (
      'Database=D:\Projetos\Motoboy\Database\MOTOBOY.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Protocol=TCPIP'
      'Server=127.0.0.1'
      'Port=3050'
      'CharacterSet=WIN1252'
      'DriverID=FB')
    LoginPrompt = False
    Left = 32
    Top = 8
  end
  object FDPhysFBDriverLink: TFDPhysFBDriverLink
    VendorLib = 'C:\Windows\System32\fbclient.dll'
    Embedded = True
    Left = 120
    Top = 12
  end
  object FDTransaction: TFDTransaction
    Connection = FDConexao
    Left = 32
    Top = 64
  end
  object SQLGeral: TFDQuery
    Connection = FDConexao
    Left = 96
    Top = 112
  end
end

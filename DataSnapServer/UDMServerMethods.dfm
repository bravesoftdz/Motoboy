object DMServerMethods: TDMServerMethods
  OldCreateOrder = False
  Height = 329
  Width = 373
  object FDConexao: TFDConnection
    Params.Strings = (
      'Database=C:\Anexar_Anexo\DBANEXAR_ANEXO.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'OSAuthent=No'
      'Protocol=TCPIP'
      'Server=chucknorris'
      'Port=3050'
      'CharacterSet=WIN1252'
      'DriverID=FB')
    LoginPrompt = False
    Left = 36
    Top = 8
  end
  object FDPhysFBDriverLink: TFDPhysFBDriverLink
    VendorLib = 'C:\Windows\System32\fbclient.dll'
    Embedded = True
    Left = 168
    Top = 12
  end
  object FDTransaction: TFDTransaction
    Connection = FDConexao
    Left = 224
    Top = 256
  end
end

object FPrincipal: TFPrincipal
  Left = 271
  Top = 114
  Caption = 'Servidor'
  ClientHeight = 247
  ClientWidth = 421
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 48
    Width = 26
    Height = 13
    Caption = 'Porta'
  end
  object Label2: TLabel
    Left = 24
    Top = 113
    Width = 40
    Height = 13
    Caption = 'Servidor'
  end
  object Label3: TLabel
    Left = 24
    Top = 157
    Width = 88
    Height = 13
    Caption = 'Caminho do Banco'
  end
  object ButtonStart: TButton
    Left = 24
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Iniciar'
    TabOrder = 0
    OnClick = ButtonStartClick
  end
  object ButtonStop: TButton
    Left = 105
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Parar'
    TabOrder = 1
    OnClick = ButtonStopClick
  end
  object EditPort: TEdit
    Left = 24
    Top = 67
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '8600'
  end
  object ButtonOpenBrowser: TButton
    Left = 160
    Top = 65
    Width = 107
    Height = 25
    Caption = 'Abrir Browser'
    TabOrder = 3
    OnClick = ButtonOpenBrowserClick
  end
  object BtnSalvar: TButton
    Left = 24
    Top = 207
    Width = 107
    Height = 25
    Caption = 'Salvar Configura'#231#227'o'
    TabOrder = 4
    OnClick = BtnSalvarClick
  end
  object EdtServidor: TEdit
    Left = 24
    Top = 132
    Width = 121
    Height = 21
    TabOrder = 5
  end
  object EdtCaminhoBanco: TEdit
    Left = 24
    Top = 176
    Width = 348
    Height = 21
    TabOrder = 6
  end
  object BtnLoc: TBitBtn
    Left = 374
    Top = 176
    Width = 21
    Height = 21
    Hint = 'Localizar o banco'
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      1800000000000003000000000000000000000000000000000000C0C0C0C0C0C0
      C0C0C0C0C0C0C0C0C0C0C0C0000000000000000000000000C0C0C0C0C0C0C0C0
      C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C01A859962
      6158DE5B365B1B04000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C0C0C0C0C0C0000000052D3655A9AC917565BB5D3FC2441D5B1B04000000C0C0
      C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C00000000D2F34622711B14727E8
      8569E58262E28061E066415B1903000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C0C0C01A8599635B519FC5C0B6735CE58263E48568E5815FC55C38EE7A585B1A
      03000000C0C0C0C0C0C0C0C0C0000000052D3655A8AB917666BB5D42E58466E4
      886FE4805FE48264E67E5CEFC6AAEB73505B1A03000000C0C0C00000000D2F34
      622712B14828E88C75E58566E48B74E48263E5886DE68565C75732FFD9B6FFEB
      D3E05129000000C0C0C01A8599635B509FC6C0B67561E58364E48E78E48263D9
      8973E69176CC5F3BFFE0C0FFE1C4F08666571802C0C0C0C0C0C058AFB3917666
      BB5D42E48162E48D77E8957AEDAC9BB68176B258416EA1BDBAA694F288695618
      02C0C0C0C0C0C0C0C0C0C74B27F1AC97EEB4A5EEB9ABEFB4A2EEBAADF0B8A6BA
      5E447FDBFF129FFA2491FC3A0C00C0C0C0C0C0C0C0C0C0C0C0C0A82D03EAAD9D
      F3C6B9F3CAC0F3CBC1F5CCBEC9684BF7E3D613EFFF00BAFF19A2FA2995FF0000
      00C0C0C0C0C0C0C0C0C0C0C0C0C55634F1CCC2F7D9D0F9E2DCCA6A4CFFEEDAFF
      FFFF57D3D71DEEFF00BAFF19A2FA2996FF000000C0C0C0C0C0C0C0C0C0A72D01
      F9DCD5FAE9E4CE6E4FFFFFFFFFFFFFF1926F580A001BF2FF1DEEFF00BBFF19A2
      FA2995FF000000C0C0C0C0C0C0C0C0C0BD4924C96647AD3107FFE5D4F1967456
      1801C0C0C0C0C0C01CEDFF1DEEFF00BBFF18A2FA349FFF000000C0C0C0C0C0C0
      AA3208000000C0C0C0AB30055B1A03C0C0C0C0C0C0C0C0C0C0C0C01CEDFF1CEE
      FF2EAEE069AED0000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C0C0C0C0C0C0C0C0C0C0C0C0C0C01DE9FF78C5EF000000C0C0C0}
    TabOrder = 7
    TabStop = False
    OnClick = BtnLocClick
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    Left = 288
    Top = 24
  end
  object OpenDlg: TOpenDialog
    Filter = 'Banco de Dados (.fdb)|*.fdb|Banco de Dados (.gdb)|*.gdb'
    InitialDir = 'c:\'
    Title = 'Selecione o banco de dados'
    Left = 371
    Top = 24
  end
end

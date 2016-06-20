object FLogin: TFLogin
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Login'
  ClientHeight = 159
  ClientWidth = 303
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 24
    Width = 40
    Height = 13
    Caption = 'Usu'#225'rio:'
  end
  object Label2: TLabel
    Left = 24
    Top = 56
    Width = 34
    Height = 13
    Caption = 'Senha:'
  end
  object EdtUsuario: TEdit
    Left = 69
    Top = 21
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object EdtSenha: TEdit
    Left = 69
    Top = 53
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object BtnLogar: TBitBtn
    Left = 80
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Logar'
    TabOrder = 2
    OnClick = BtnLogarClick
  end
  object BtnSair: TBitBtn
    Left = 176
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Sair'
    TabOrder = 3
    OnClick = BtnSairClick
  end
end

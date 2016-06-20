object FPrincipal: TFPrincipal
  Left = 0
  Top = 0
  Caption = 'Sistema de Motoboy'
  ClientHeight = 431
  ClientWidth = 681
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu: TMainMenu
    Left = 40
    Top = 56
    object MICadastros: TMenuItem
      Caption = 'Cadastros'
      object MICliente: TMenuItem
        Caption = 'Cliente'
      end
      object MIMotoboy: TMenuItem
        Caption = 'Motoboy'
      end
    end
    object MIMovimentacao: TMenuItem
      Caption = 'Movimenta'#231#227'o'
    end
  end
end

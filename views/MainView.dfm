object frmMainView: TfrmMainView
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Tela Principal - Loves Motel'
  ClientHeight = 600
  ClientWidth = 800
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = fMainMenu1
  Position = poScreenCenter
  ShowInTaskBar = True
  OnActivate = FormActivate
  TextHeight = 15
  object pnlBackground: TPanel
    Left = 0
    Top = 0
    Width = 800
    Height = 600
    Align = alClient
    TabOrder = 0
  end
  object fMainMenu1: TMainMenu
    Left = 256
    Top = 24
    object Cadastros1: TMenuItem
      Caption = 'Cadastros'
      object Suites1: TMenuItem
        Caption = 'Suites'
        OnClick = Suites1Click
      end
      object Suites2: TMenuItem
        Caption = 'Produtos'
        OnClick = Suites2Click
      end
      object Servios3: TMenuItem
        Caption = 'Servi'#231'os'
        OnClick = Servios3Click
      end
      object Servios4: TMenuItem
        Caption = 'Usu'#225'rios'
        OnClick = Servios4Click
      end
    end
    object Cadastros2: TMenuItem
      Caption = 'Relat'#243'rios'
      object Movimento1: TMenuItem
        Caption = 'Movimento'
        OnClick = Movimento1Click
      end
      object Movimento2: TMenuItem
        Caption = 'Consumos'
        OnClick = Movimento2Click
      end
      object Financeiro1: TMenuItem
        Caption = 'Financeiro'
        OnClick = Financeiro1Click
      end
    end
    object Servios1: TMenuItem
      Caption = 'Financeiro'
      object Contasapagarareceber1: TMenuItem
        Caption = 'Contas a pagar / a receber'
        OnClick = Contasapagarareceber1Click
      end
    end
    object Servios2: TMenuItem
      Caption = 'Ajuda'
      object Sobre1: TMenuItem
        Caption = 'Sobre'
        OnClick = Sobre1Click
      end
    end
  end
  object qrySuitesMain: TFDQuery
    Connection = uDM.FDConnection
    SQL.Strings = (
      
        '                  SELECT numero, status FROM suites ORDER BY num' +
        'ero')
    Left = 480
    Top = 96
  end
  object tmrInicial: TTimer
    Enabled = False
    Interval = 100
    OnTimer = tmrInicialTimer
    Left = 408
    Top = 200
  end
end

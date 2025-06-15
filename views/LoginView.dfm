object fLoginView: TfLoginView
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Love'#39's Motel '
  ClientHeight = 484
  ClientWidth = 704
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 15
  object pnlFundo: TPanel
    Left = 0
    Top = 0
    Width = 704
    Height = 484
    Align = alClient
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object gppLogin: TGroupBox
      Left = 120
      Top = 80
      Width = 441
      Height = 297
      TabOrder = 0
      object lblTitulo1: TLabel
        Left = 176
        Top = 16
        Width = 57
        Height = 28
        Caption = 'Love'#39's'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblTitulo2: TLabel
        Left = 239
        Top = 16
        Width = 52
        Height = 28
        Caption = 'Motel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lblLogin: TLabel
        Left = 100
        Top = 96
        Width = 42
        Height = 21
        Caption = 'Login:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lblSenha: TLabel
        Left = 96
        Top = 149
        Width = 46
        Height = 21
        Caption = 'Senha:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object edtLogin: TEdit
        Left = 151
        Top = 98
        Width = 203
        Height = 23
        TabOrder = 0
      end
      object edtSenha: TEdit
        Left = 151
        Top = 147
        Width = 203
        Height = 23
        PasswordChar = '*'
        TabOrder = 1
      end
      object btnEntrar: TButton
        Left = 184
        Top = 208
        Width = 113
        Height = 33
        Caption = 'Entrar'
        Default = True
        TabOrder = 2
        OnClick = btnEntrarClick
      end
    end
  end
  object qryLogin: TFDQuery
    Connection = uDM.FDConnection
    Left = 608
    Top = 24
  end
end

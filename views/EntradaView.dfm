object frmEntradaView: TfrmEntradaView
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Entrada de Ve'#237'culo'
  ClientHeight = 317
  ClientWidth = 400
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object pnlBackgroundEntrada: TPanel
    Left = 0
    Top = 0
    Width = 400
    Height = 317
    Align = alClient
    TabOrder = 0
    object lblTitulo: TLabel
      Left = 1
      Top = 1
      Width = 398
      Height = 30
      Align = alTop
      Alignment = taCenter
      Caption = 'ENTRADA DE VEICULOS'
      Color = clBackground
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      ExplicitWidth = 235
    end
    object lblSuite: TLabel
      Left = 144
      Top = 37
      Width = 114
      Height = 23
      Caption = 'Entrada - Suite'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblPlacaVeiculo: TLabel
      Left = 40
      Top = 208
      Width = 31
      Height = 15
      Caption = 'Placa:'
    end
    object lblNomeVeiculo: TLabel
      Left = 40
      Top = 88
      Width = 36
      Height = 15
      Caption = 'Nome:'
    end
    object lblMarcaVeiculo: TLabel
      Left = 40
      Top = 126
      Width = 36
      Height = 15
      Caption = 'Marca:'
    end
    object lblCorVeiculo: TLabel
      Left = 40
      Top = 168
      Width = 22
      Height = 15
      Caption = 'Cor:'
    end
    object lblHorarioEntrada: TLabel
      Left = 40
      Top = 248
      Width = 106
      Height = 15
      Caption = 'Hor'#225'rio de entrada:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'LblEntrada'
      Font.Style = []
      ParentFont = False
    end
    object lblHorarioValor: TLabel
      Left = 182
      Top = 248
      Width = 3
      Height = 15
      OnClick = lblHorarioValorClick
    end
    object btnSalvar: TButton
      Left = 120
      Top = 284
      Width = 75
      Height = 25
      Caption = 'Salvar'
      TabOrder = 0
      OnClick = btnSalvarClick
    end
  end
  object cbMarca: TComboBox
    Left = 120
    Top = 123
    Width = 217
    Height = 23
    TabOrder = 1
    Text = 'Clique aqui...'
    OnChange = cbMarcaChange
    Items.Strings = (
      'Chevrolet'
      'Fiat'
      'Volkswagen'
      'Toyota'
      'Hyundai'
      'Honda'
      'Renault'
      'Ford'
      'Nissan'
      'Jeep'
      'Peugeot'
      'Citro'#235'n'
      'Mitsubishi'
      'Kia'
      'BMW'
      'Mercedes-Benz'
      'Audi'
      'Volvo'
      'Land Rover'
      'Chery (ou Caoa Chery)'
      'JAC Motors'
      'BYD'
      'GWM (Great Wall Motors)'
      'Porsche'
      'Lexus'
      'Mini'
      'RAM'
      'Iveco'
      'Subaru')
  end
  object cbNomeVeiculo: TComboBox
    Left = 120
    Top = 85
    Width = 217
    Height = 23
    TabOrder = 2
    Text = 'Clique aqui...'
  end
  object edtCorVeiculo: TEdit
    Left = 120
    Top = 165
    Width = 217
    Height = 23
    TabOrder = 3
  end
  object edtPlaca: TEdit
    Left = 120
    Top = 205
    Width = 217
    Height = 23
    TabOrder = 4
  end
  object btnLimpar: TButton
    Left = 232
    Top = 284
    Width = 75
    Height = 25
    Caption = 'Limpar'
    TabOrder = 5
    OnClick = btnLimparClick
  end
  object qryEntrada: TFDQuery
    Connection = uDM.FDConnection
    Left = 320
    Top = 24
  end
end

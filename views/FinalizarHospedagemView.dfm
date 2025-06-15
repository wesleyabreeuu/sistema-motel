object fFinalizarHospedagemView: TfFinalizarHospedagemView
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Finalizar Hospedagem'
  ClientHeight = 593
  ClientWidth = 770
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
    Width = 770
    Height = 593
    Align = alClient
    TabOrder = 0
    object lblGestao: TLabel
      Left = 256
      Top = 8
      Width = 254
      Height = 28
      Caption = 'GEST'#195'O DA HOSPEDAGEM'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblValorHospedagem: TLabel
      Left = 0
      Top = 351
      Width = 172
      Height = 21
      Caption = 'Valor da Hospedagem:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblValorConsumo: TLabel
      Left = 304
      Top = 351
      Width = 144
      Height = 21
      Caption = 'Valor do Consumo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblValorTotal: TLabel
      Left = 577
      Top = 351
      Width = 86
      Height = 21
      Caption = 'Valor Total:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblTotalHospedagem: TLabel
      Left = 176
      Top = 351
      Width = 4
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblTotalConsumo: TLabel
      Left = 454
      Top = 351
      Width = 4
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblTotal: TLabel
      Left = 669
      Top = 351
      Width = 4
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object gppDados: TGroupBox
      Left = 16
      Top = 42
      Width = 737
      Height = 119
      TabOrder = 0
      object lblSuite: TLabel
        Left = 16
        Top = 16
        Width = 43
        Height = 21
        Caption = 'Suite:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblDadosEntrada: TLabel
        Left = 64
        Top = 56
        Width = 63
        Height = 21
        Caption = 'Entrada:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblHoraAtual: TLabel
        Left = 387
        Top = 56
        Width = 86
        Height = 21
        Caption = 'Hora Atual:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblVeiculo: TLabel
        Left = 240
        Top = 16
        Width = 61
        Height = 21
        Caption = 'Veiculo:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblPlaca: TLabel
        Left = 488
        Top = 16
        Width = 45
        Height = 21
        Caption = 'Placa:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblTempoTotal: TLabel
        Left = 174
        Top = 87
        Width = 177
        Height = 21
        Caption = 'Tempo de Pemanencia:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblSuiteUsada: TLabel
        Left = 73
        Top = 16
        Width = 4
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lblVeiculoUsado: TLabel
        Left = 313
        Top = 16
        Width = 4
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lblPlacaUsada: TLabel
        Left = 547
        Top = 16
        Width = 4
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lblEntrada: TLabel
        Left = 133
        Top = 56
        Width = 4
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lblHoraAtualUsada: TLabel
        Left = 492
        Top = 56
        Width = 4
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lblTempoPermanencia: TLabel
        Left = 363
        Top = 87
        Width = 4
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
    end
    object dbgConsumo: TDBGrid
      Left = 16
      Top = 167
      Width = 737
      Height = 161
      DataSource = dsConsumos
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'quantidade'
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nome'
          Width = 600
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'valor'
          Visible = True
        end>
    end
    object gppForma1: TGroupBox
      Left = 0
      Top = 400
      Width = 361
      Height = 105
      Caption = 'Forma de Pagamento 1'
      TabOrder = 2
      object lblTipoPag1: TLabel
        Left = 20
        Top = 32
        Width = 167
        Height = 21
        Caption = 'Forma de Pagamento:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblValorPago1: TLabel
        Left = 101
        Top = 67
        Width = 86
        Height = 21
        Caption = 'Valor Total:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object cbbFormaPag1: TComboBox
        Left = 193
        Top = 32
        Width = 145
        Height = 23
        TabOrder = 0
      end
      object edtValorTotal1: TEdit
        Left = 193
        Top = 68
        Width = 145
        Height = 23
        TabOrder = 1
      end
    end
    object gppForma2: TGroupBox
      Left = 376
      Top = 400
      Width = 377
      Height = 105
      Caption = 'Forma de Pagamento 2'
      TabOrder = 3
      object lblTipoPag2: TLabel
        Left = 27
        Top = 32
        Width = 167
        Height = 21
        Caption = 'Forma de Pagamento:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblValorPago2: TLabel
        Left = 109
        Top = 67
        Width = 86
        Height = 21
        Caption = 'Valor Total:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object cbbFormaPag2: TComboBox
        Left = 208
        Top = 32
        Width = 145
        Height = 23
        TabOrder = 0
      end
      object edtValorTotal2: TEdit
        Left = 208
        Top = 68
        Width = 145
        Height = 23
        TabOrder = 1
      end
    end
    object btnFinalizarHospedagem: TButton
      Left = 193
      Top = 528
      Width = 192
      Height = 41
      Caption = 'Finalizar Hospedagem'
      TabOrder = 4
      OnClick = btnFinalizarHospedagemClick
    end
    object btnCancelar: TButton
      Left = 409
      Top = 528
      Width = 192
      Height = 41
      Caption = 'Cancelar'
      TabOrder = 5
      OnClick = btnCancelarClick
    end
  end
  object qryAuxiliar: TFDQuery
    Connection = uDM.FDConnection
    Left = 568
    Top = 8
  end
  object qryConsumos: TFDQuery
    Active = True
    Connection = uDM.FDConnection
    SQL.Strings = (
      'SELECT c.quantidade, '
      '       CASE '
      '         WHEN c.tipo IN ('#39'frigobar'#39', '#39'estoque'#39') THEN p.nome '
      '         WHEN c.tipo = '#39'servico'#39' THEN s.nome '
      '         ELSE '#39'Desconhecido'#39' '
      '       END AS nome, '
      '       c.valor '
      'FROM consumos c '
      
        'LEFT JOIN produtos p ON (c.tipo IN ('#39'frigobar'#39', '#39'estoque'#39') AND c' +
        '.item_id = p.id) '
      
        'LEFT JOIN servicos s ON (c.tipo = '#39'servico'#39' AND c.item_id = s.id' +
        ')')
    Left = 640
    Top = 8
  end
  object dsConsumos: TDataSource
    DataSet = qryConsumos
    Left = 704
    Top = 16
  end
end

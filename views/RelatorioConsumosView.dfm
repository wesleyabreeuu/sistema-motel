object fRelatorioConsumosView: TfRelatorioConsumosView
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Relatorio de Consumos'
  ClientHeight = 499
  ClientWidth = 769
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
    Width = 769
    Height = 499
    Align = alClient
    TabOrder = 0
    object lblTitulo: TLabel
      Left = 264
      Top = 8
      Width = 227
      Height = 30
      Caption = 'Relat'#243'rio de Consumos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object gppFiltros: TGroupBox
      Left = 32
      Top = 36
      Width = 705
      Height = 165
      Caption = 'Filtros'
      TabOrder = 0
      object lblDataInicial: TLabel
        Left = 169
        Top = 24
        Width = 61
        Height = 15
        Caption = 'Data Inicial:'
      end
      object lblDataFinal: TLabel
        Left = 353
        Top = 24
        Width = 58
        Height = 15
        Caption = 'Data Final: '
      end
      object lblTipo: TLabel
        Left = 527
        Top = 24
        Width = 26
        Height = 15
        Caption = 'Tipo:'
      end
      object lblProduto: TLabel
        Left = 216
        Top = 72
        Width = 89
        Height = 15
        Caption = 'Produto/Servi'#231'o:'
      end
      object lblSuite: TLabel
        Left = 448
        Top = 72
        Width = 29
        Height = 15
        Caption = 'Suite:'
      end
      object dtpDataInicial: TDateTimePicker
        Left = 120
        Top = 43
        Width = 161
        Height = 23
        Date = 45813.000000000000000000
        Time = 0.977301319442631200
        TabOrder = 0
      end
      object dtpDataFinal: TDateTimePicker
        Left = 296
        Top = 43
        Width = 161
        Height = 23
        Date = 45813.000000000000000000
        Time = 0.977301319442631200
        TabOrder = 1
      end
      object cbTipoProduto: TComboBox
        Left = 472
        Top = 43
        Width = 145
        Height = 23
        TabOrder = 2
      end
      object cbProduto: TComboBox
        Left = 192
        Top = 93
        Width = 145
        Height = 23
        TabOrder = 3
      end
      object cbSuite: TComboBox
        Left = 392
        Top = 93
        Width = 145
        Height = 23
        TabOrder = 4
      end
      object btnFiltrar: TButton
        Left = 183
        Top = 128
        Width = 161
        Height = 29
        Caption = 'Filtrar'
        TabOrder = 5
        OnClick = btnFiltrarClick
      end
      object btnImprimir: TButton
        Left = 383
        Top = 128
        Width = 161
        Height = 29
        Caption = 'Imprimir'
        TabOrder = 6
        OnClick = btnImprimirClick
      end
    end
    object dbgConsumos: TDBGrid
      Left = 0
      Top = 207
      Width = 759
      Height = 292
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
          FieldName = 'data_consumo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'tipo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nome_item'
          Width = 160
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'quantidade'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'valor'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'total'
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'suite'
          Width = 200
          Visible = True
        end>
    end
  end
  object qryConsumos: TFDQuery
    Connection = uDM.FDConnection
    Left = 600
    Top = 8
  end
  object dsConsumos: TDataSource
    DataSet = qryConsumos
    Left = 664
    Top = 8
  end
  object qryProdutos: TFDQuery
    Connection = uDM.FDConnection
    Left = 56
    Top = 8
  end
  object qrySuites: TFDQuery
    Connection = uDM.FDConnection
    Left = 136
  end
end

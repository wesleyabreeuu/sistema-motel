object fRelatorioFinanceiroView: TfRelatorioFinanceiroView
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Relat'#243'rio Financeiro'
  ClientHeight = 507
  ClientWidth = 740
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
    Width = 740
    Height = 507
    Align = alClient
    TabOrder = 0
    object lblTitulo: TLabel
      Left = 264
      Top = 8
      Width = 197
      Height = 30
      Caption = 'Relat'#243'rio Financeiro'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object gppFiltros: TGroupBox
      Left = -4
      Top = 44
      Width = 733
      Height = 129
      Caption = 'Filtros'
      TabOrder = 0
      object lblTipo: TLabel
        Left = 52
        Top = 24
        Width = 26
        Height = 15
        Caption = 'Tipo:'
      end
      object lblStatus: TLabel
        Left = 304
        Top = 24
        Width = 35
        Height = 15
        Caption = 'Status:'
      end
      object lblDescricao: TLabel
        Left = 24
        Top = 64
        Width = 54
        Height = 15
        Caption = 'Descri'#231#227'o:'
      end
      object lblDataInicial: TLabel
        Left = 17
        Top = 104
        Width = 61
        Height = 15
        Caption = 'Data Inicial:'
      end
      object lblDataFinal: TLabel
        Left = 284
        Top = 104
        Width = 55
        Height = 15
        Caption = 'Data Final:'
      end
      object cbbTipo: TComboBox
        Left = 84
        Top = 21
        Width = 145
        Height = 23
        TabOrder = 0
      end
      object cbbStatus: TComboBox
        Left = 345
        Top = 21
        Width = 145
        Height = 23
        TabOrder = 1
      end
      object edtDescricao: TEdit
        Left = 84
        Top = 61
        Width = 406
        Height = 23
        TabOrder = 2
      end
      object dtpDataInicial: TDateTimePicker
        Left = 84
        Top = 98
        Width = 157
        Height = 23
        Date = 45820.000000000000000000
        Time = 0.962618587960605500
        TabOrder = 3
      end
      object dtpDataFinal: TDateTimePicker
        Left = 346
        Top = 98
        Width = 144
        Height = 23
        Date = 45820.000000000000000000
        Time = 0.963112581019231600
        TabOrder = 4
      end
      object btnFiltrar: TButton
        Left = 528
        Top = 20
        Width = 161
        Height = 37
        Caption = 'Filtrar'
        TabOrder = 5
        OnClick = btnFiltrarClick
      end
      object btnImprimir: TButton
        Left = 528
        Top = 76
        Width = 161
        Height = 37
        Caption = 'Imprimir'
        TabOrder = 6
        OnClick = btnImprimirClick
      end
    end
    object DBGrid1: TDBGrid
      Left = 0
      Top = 192
      Width = 729
      Height = 315
      DataSource = dsFinanceiro
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'tipo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'descricao'
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'valor'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'data'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'vencimento'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'data_pagamento'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'status'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'forma_pagamento'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'observacao'
          Visible = True
        end>
    end
  end
  object qryFinanceiro: TFDQuery
    Connection = uDM.FDConnection
    SQL.Strings = (
      
        'SELECT id, tipo, descricao, valor, data, vencimento, data_pagame' +
        'nto, status, forma_pagamento, observacao'
      'FROM financeiro')
    Left = 528
    Top = 8
    object qryFinanceiroid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = False
    end
    object qryFinanceirotipo: TWideStringField
      FieldName = 'tipo'
      Origin = 'tipo'
      Required = True
      FixedChar = True
      Size = 9
    end
    object qryFinanceirodescricao: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'descricao'
      Origin = 'descricao'
      Size = 340
    end
    object qryFinanceirovalor: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'valor'
      Origin = 'valor'
      Precision = 10
      Size = 2
    end
    object qryFinanceirodata: TDateField
      AutoGenerateValue = arDefault
      FieldName = 'data'
      Origin = '`data`'
    end
    object qryFinanceirovencimento: TDateField
      AutoGenerateValue = arDefault
      FieldName = 'vencimento'
      Origin = 'vencimento'
    end
    object qryFinanceirodata_pagamento: TDateField
      AutoGenerateValue = arDefault
      FieldName = 'data_pagamento'
      Origin = 'data_pagamento'
    end
    object qryFinanceirostatus: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'status'
      Origin = '`status`'
      FixedChar = True
      Size = 10
    end
    object qryFinanceiroforma_pagamento: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'forma_pagamento'
      Origin = 'forma_pagamento'
      Size = 66
    end
    object qryFinanceiroobservacao: TWideMemoField
      AutoGenerateValue = arDefault
      FieldName = 'observacao'
      Origin = 'observacao'
      BlobType = ftWideMemo
    end
  end
  object dsFinanceiro: TDataSource
    DataSet = qryFinanceiro
    Left = 592
  end
end

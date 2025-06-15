object fContasAPagarView: TfContasAPagarView
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Contas a Pagar/Receber'
  ClientHeight = 531
  ClientWidth = 726
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
    Width = 726
    Height = 531
    Align = alClient
    TabOrder = 0
    object lblTitulo: TLabel
      Left = 248
      Top = 8
      Width = 231
      Height = 30
      Caption = 'Contas a Pagar/Receber'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object gpbFiltros: TGroupBox
      Left = 0
      Top = 44
      Width = 713
      Height = 117
      Caption = 'Filtros'
      TabOrder = 0
      object lblTipoFiltro: TLabel
        Left = 65
        Top = 24
        Width = 26
        Height = 15
        Caption = 'Tipo:'
      end
      object lblStatusFiltro: TLabel
        Left = 56
        Top = 54
        Width = 35
        Height = 15
        Caption = 'Status:'
      end
      object lblDataInicial: TLabel
        Left = 274
        Top = 24
        Width = 61
        Height = 15
        Caption = 'Data Inicial:'
      end
      object lblDataFinal: TLabel
        Left = 280
        Top = 54
        Width = 55
        Height = 15
        Caption = 'Data Final:'
      end
      object lblDescricaoFiltro: TLabel
        Left = 37
        Top = 84
        Width = 54
        Height = 15
        Caption = 'Descri'#231#227'o:'
      end
      object cbFiltroTipo: TComboBox
        Left = 97
        Top = 21
        Width = 145
        Height = 23
        TabOrder = 0
      end
      object cbFiltroStatus: TComboBox
        Left = 97
        Top = 53
        Width = 145
        Height = 23
        TabOrder = 1
      end
      object dtpFiltroInicio: TDateTimePicker
        Left = 341
        Top = 21
        Width = 161
        Height = 23
        Date = 45814.000000000000000000
        Time = 0.949661203703726600
        TabOrder = 2
      end
      object dtpFiltroFim: TDateTimePicker
        Left = 341
        Top = 50
        Width = 161
        Height = 23
        Date = 45814.000000000000000000
        Time = 0.949783692129130900
        TabOrder = 3
      end
      object edtFiltroDescricao: TEdit
        Left = 97
        Top = 82
        Width = 405
        Height = 23
        TabOrder = 4
      end
      object btnFiltrar: TButton
        Left = 536
        Top = 20
        Width = 153
        Height = 37
        Caption = 'Filtrar'
        TabOrder = 5
        OnClick = btnFiltrarClick
      end
      object btnImprimir: TButton
        Left = 536
        Top = 63
        Width = 153
        Height = 37
        Caption = 'Imprimir'
        TabOrder = 6
        OnClick = btnImprimirClick
      end
    end
    object gpContas: TGroupBox
      Left = 0
      Top = 167
      Width = 713
      Height = 122
      Caption = 'Contas'
      TabOrder = 1
      object lblTipo: TLabel
        Left = 65
        Top = 24
        Width = 26
        Height = 15
        Caption = 'Tipo:'
      end
      object lblVencimento: TLabel
        Left = 264
        Top = 24
        Width = 66
        Height = 15
        Caption = 'Vencimento:'
      end
      object lblDescricao: TLabel
        Left = 37
        Top = 56
        Width = 54
        Height = 15
        Caption = 'Descri'#231#227'o:'
      end
      object lblValor: TLabel
        Left = 62
        Top = 88
        Width = 29
        Height = 15
        Caption = 'Valor:'
      end
      object lblObservacao: TLabel
        Left = 265
        Top = 88
        Width = 65
        Height = 15
        Caption = 'Observa'#231#227'o:'
      end
      object cbbTipo: TComboBox
        Left = 97
        Top = 21
        Width = 145
        Height = 23
        TabOrder = 0
      end
      object DateTimePicker1: TDateTimePicker
        Left = 341
        Top = 21
        Width = 161
        Height = 23
        Date = 45818.000000000000000000
        Time = 0.988435590275912500
        TabOrder = 1
      end
      object edtDescicao: TEdit
        Left = 97
        Top = 53
        Width = 405
        Height = 23
        TabOrder = 2
      end
      object edtValor: TEdit
        Left = 97
        Top = 85
        Width = 145
        Height = 23
        TabOrder = 3
      end
      object edtObservacao: TEdit
        Left = 341
        Top = 85
        Width = 161
        Height = 23
        TabOrder = 4
      end
      object btnSalvar: TButton
        Left = 536
        Top = 24
        Width = 153
        Height = 33
        Caption = 'Salvar'
        TabOrder = 5
        OnClick = btnSalvarClick
      end
      object btnMarcarComo: TButton
        Left = 536
        Top = 72
        Width = 153
        Height = 33
        Caption = 'Marcar como pago'
        TabOrder = 6
        OnClick = btnMarcarComoClick
      end
    end
    object DBGrid1: TDBGrid
      Left = 0
      Top = 295
      Width = 713
      Height = 236
      DataSource = dsFInanceiro
      TabOrder = 2
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
          Width = 140
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'valor'
          Width = 50
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
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'observacao'
          Width = 150
          Visible = True
        end>
    end
  end
  object qryFinanceiro: TFDQuery
    Active = True
    Connection = uDM.FDConnection
    SQL.Strings = (
      'SELECT * FROM financeiro LIMIT 1')
    Left = 536
  end
  object dsFInanceiro: TDataSource
    DataSet = qryFinanceiro
    Left = 600
  end
end

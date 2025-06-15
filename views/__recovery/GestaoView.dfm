object fGestao: TfGestao
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Gest'#227'o de Suites'
  ClientHeight = 535
  ClientWidth = 707
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object pnlFundo: TPanel
    Left = 0
    Top = 0
    Width = 707
    Height = 535
    Align = alClient
    Caption = 'uDM.FDConnection'
    TabOrder = 0
    object lblTitulo: TLabel
      Left = 184
      Top = 16
      Width = 171
      Height = 28
      Caption = 'GEST'#195'O DA SUITE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblSuiteUsada: TLabel
      Left = 368
      Top = 16
      Width = 6
      Height = 28
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object gppDadosSuite: TGroupBox
      Left = 20
      Top = 58
      Width = 625
      Height = 135
      TabOrder = 0
      object lblNome: TLabel
        Left = 24
        Top = 15
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
      object lblMarca: TLabel
        Left = 34
        Top = 55
        Width = 51
        Height = 21
        Caption = 'Marca:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblPlaca: TLabel
        Left = 392
        Top = 15
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
      object Label1: TLabel
        Left = 264
        Top = 55
        Width = 180
        Height = 21
        Caption = 'Data e Hora de entrada:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblCor: TLabel
        Left = 54
        Top = 95
        Width = 31
        Height = 21
        Caption = 'Cor:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblNomeUsado: TLabel
        Left = 104
        Top = 15
        Width = 4
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lblMarcaUsada: TLabel
        Left = 104
        Top = 55
        Width = 4
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lblCorUsada: TLabel
        Left = 104
        Top = 95
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
        Left = 456
        Top = 15
        Width = 4
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lblDataUsada: TLabel
        Left = 456
        Top = 55
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
    object pgcConsumos: TPageControl
      Left = 8
      Top = 224
      Width = 689
      Height = 217
      ActivePage = tabFrigobar
      TabOrder = 1
      object tabFrigobar: TTabSheet
        Caption = 'Frigobar'
        object dbgFrigobar: TDBGrid
          Left = -4
          Top = -8
          Width = 501
          Height = 193
          DataSource = dsFrigobar
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'nome'
              Width = 275
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'preco_unitario'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'quantidade_estoque'
              Visible = True
            end>
        end
        object btnConsumoFrigobar: TButton
          Left = 519
          Top = 74
          Width = 143
          Height = 41
          Caption = 'Adicionar Consumo'
          TabOrder = 1
          OnClick = btnConsumoFrigobarClick
        end
      end
      object tabEstoque: TTabSheet
        Caption = 'Estoque'
        ImageIndex = 1
        object dbgEstoque: TDBGrid
          Left = -4
          Top = -8
          Width = 501
          Height = 193
          DataSource = dsEstoque
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'nome'
              Width = 275
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'preco_unitario'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'quantidade_estoque'
              Visible = True
            end>
        end
        object btnConsumoEstoque: TButton
          Left = 519
          Top = 74
          Width = 143
          Height = 41
          Caption = 'Adicionar Consumo'
          TabOrder = 1
          OnClick = btnConsumoEstoqueClick
        end
      end
      object tabServicos: TTabSheet
        Caption = 'Servi'#231'os'
        ImageIndex = 2
        object dbgServico: TDBGrid
          Left = -4
          Top = -8
          Width = 501
          Height = 192
          DataSource = dsServico
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'nome'
              Width = 390
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'preco'
              Visible = True
            end>
        end
        object btnServiço: TButton
          Left = 524
          Top = 74
          Width = 146
          Height = 41
          Caption = 'Adicionar Servi'#231'o'
          TabOrder = 1
          OnClick = btnServicoClick
        end
      end
    end
    object btnFinalizar: TButton
      Left = 122
      Top = 487
      Width = 177
      Height = 34
      Caption = 'Finalizar '
      TabOrder = 2
      OnClick = btnFinalizarClick
    end
    object btnFechar: TButton
      Left = 386
      Top = 487
      Width = 177
      Height = 34
      Caption = 'Fechar'
      TabOrder = 3
      OnClick = btnFecharClick
    end
  end
  object qryVeiculo: TFDQuery
    Connection = uDM.FDConnection
    Left = 40
    Top = 8
  end
  object qryFrigobar: TFDQuery
    Active = True
    Connection = uDM.FDConnection
    SQL.Strings = (
      
        'SELECT id, nome, preco_unitario, quantidade_estoque FROM produto' +
        's WHERE tipo = '#39'frigobar'#39)
    Left = 392
    Top = 8
  end
  object dsFrigobar: TDataSource
    DataSet = qryFrigobar
    Left = 456
    Top = 8
  end
  object qryEstoque: TFDQuery
    Connection = uDM.FDConnection
    SQL.Strings = (
      
        'SELECT id, nome, preco_unitario, quantidade_estoque FROM produto' +
        's WHERE tipo = '#39'estoque'#39' ')
    Left = 552
    Top = 8
    object qryEstoqueid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = False
    end
    object qryEstoquenome: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'nome'
      Origin = 'nome'
      Size = 133
    end
    object qryEstoquepreco_unitario: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'preco_unitario'
      Origin = 'preco_unitario'
      Precision = 10
      Size = 2
    end
    object qryEstoquequantidade_estoque: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'quantidade_estoque'
      Origin = 'quantidade_estoque'
    end
  end
  object dsEstoque: TDataSource
    DataSet = qryEstoque
    Left = 624
    Top = 8
  end
  object qryServico: TFDQuery
    Active = True
    Connection = uDM.FDConnection
    SQL.Strings = (
      'SELECT id, nome, preco FROM servicos ORDER BY nome')
    Left = 664
    Top = 80
  end
  object dsServico: TDataSource
    DataSet = qryServico
    Left = 664
    Top = 152
  end
  object qryConsumo: TFDQuery
    Connection = uDM.FDConnection
    Left = 120
    Top = 16
  end
end

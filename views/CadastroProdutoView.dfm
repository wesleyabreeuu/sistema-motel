object fCadastroProdutoView: TfCadastroProdutoView
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastro de Produtos'
  ClientHeight = 498
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object pnlFundo: TPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 498
    Align = alClient
    TabOrder = 0
    object lblTitulo: TLabel
      Left = 192
      Top = 16
      Width = 212
      Height = 30
      Caption = 'Cadastro de Produtos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnNovo: TButton
      Left = 360
      Top = 70
      Width = 105
      Height = 43
      Caption = 'Novo'
      TabOrder = 0
      OnClick = btnNovoClick
    end
    object btnEditar: TButton
      Left = 480
      Top = 70
      Width = 105
      Height = 43
      Caption = 'Editar'
      TabOrder = 1
      OnClick = btnEditarClick
    end
    object btnLimpar: TButton
      Left = 360
      Top = 139
      Width = 105
      Height = 43
      Caption = 'Limpar'
      TabOrder = 2
      OnClick = btnLimparClick
    end
    object btnExcluir: TButton
      Left = 480
      Top = 139
      Width = 105
      Height = 43
      Caption = 'Excluir'
      TabOrder = 3
      OnClick = btnExcluirClick
    end
    object btnsalvar: TButton
      Left = 416
      Top = 200
      Width = 105
      Height = 43
      Caption = 'Salvar'
      TabOrder = 4
      OnClick = btnSalvarClick
    end
    object dbgProdutos: TDBGrid
      Left = 0
      Top = 255
      Width = 617
      Height = 234
      DataSource = dsProduto
      TabOrder = 5
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnCellClick = dbgProdutosCellClick
      Columns = <
        item
          Expanded = False
          FieldName = 'nome'
          Width = 320
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'tipo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'quantidade_estoque'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'preco_unitario'
          Visible = True
        end>
    end
  end
  object gpbCadastroProdutos: TGroupBox
    Left = 0
    Top = 56
    Width = 337
    Height = 193
    TabOrder = 1
    object lblNomeProduto: TLabel
      Left = 32
      Top = 24
      Width = 36
      Height = 15
      Caption = 'Nome:'
    end
    object lblTipo: TLabel
      Left = 42
      Top = 66
      Width = 26
      Height = 15
      Caption = 'Tipo:'
    end
    object lblQuantidade: TLabel
      Left = 3
      Top = 111
      Width = 65
      Height = 15
      Caption = 'Quantidade:'
    end
    object lblPreco: TLabel
      Left = 35
      Top = 157
      Width = 33
      Height = 15
      Caption = 'Pre'#231'o:'
    end
    object edtNomeProduto: TEdit
      Left = 80
      Top = 21
      Width = 225
      Height = 23
      TabOrder = 0
    end
    object cbbTipo: TComboBox
      Left = 80
      Top = 63
      Width = 225
      Height = 23
      TabOrder = 1
    end
    object edtQuantidade: TEdit
      Left = 80
      Top = 108
      Width = 225
      Height = 23
      TabOrder = 2
    end
    object editPreco: TEdit
      Left = 80
      Top = 152
      Width = 225
      Height = 23
      TabOrder = 3
    end
  end
  object queryProdutos: TFDQuery
    Connection = uDM.FDConnection
    SQL.Strings = (
      'SELECT * FROM produtos ORDER BY nome')
    Left = 440
    Top = 8
    object queryProdutosid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = False
    end
    object queryProdutosnome: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'nome'
      Origin = 'nome'
      Size = 133
    end
    object queryProdutostipo: TWideStringField
      FieldName = 'tipo'
      Origin = 'tipo'
      Required = True
      FixedChar = True
      Size = 10
    end
    object queryProdutosquantidade_estoque: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'quantidade_estoque'
      Origin = 'quantidade_estoque'
    end
    object queryProdutospreco_unitario: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'preco_unitario'
      Origin = 'preco_unitario'
      Precision = 10
      Size = 2
    end
  end
  object dsProduto: TDataSource
    DataSet = queryProdutos
    Left = 544
    Top = 8
  end
end

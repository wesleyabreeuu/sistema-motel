object fCadastroSuiteView: TfCadastroSuiteView
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastro de Suites'
  ClientHeight = 496
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClick = btnSalvarClick
  OnCreate = FormCreate
  TextHeight = 15
  object pnlFundo: TPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 496
    Align = alClient
    TabOrder = 0
    object lblTitulo: TLabel
      Left = 200
      Top = 8
      Width = 181
      Height = 30
      Caption = 'Cadastro de Suites'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object gpbCadastroSuites: TGroupBox
      Left = 24
      Top = 56
      Width = 329
      Height = 169
      TabOrder = 0
      object lblNumeroSuite: TLabel
        Left = 16
        Top = 16
        Width = 47
        Height = 15
        Caption = 'Numero:'
      end
      object lblNomeSuite: TLabel
        Left = 16
        Top = 48
        Width = 36
        Height = 15
        Caption = 'Nome:'
      end
      object lblPreco: TLabel
        Left = 16
        Top = 80
        Width = 33
        Height = 15
        Caption = 'Pre'#231'o:'
      end
      object lblStatus: TLabel
        Left = 16
        Top = 114
        Width = 35
        Height = 15
        Caption = 'Status:'
      end
      object edtNumero: TEdit
        Left = 88
        Top = 13
        Width = 177
        Height = 23
        TabOrder = 0
      end
      object edtNome: TEdit
        Left = 88
        Top = 45
        Width = 177
        Height = 23
        TabOrder = 1
      end
      object ediPreco: TEdit
        Left = 88
        Top = 77
        Width = 177
        Height = 23
        TabOrder = 2
      end
      object cbbStatus: TComboBox
        Left = 88
        Top = 111
        Width = 177
        Height = 23
        TabOrder = 3
      end
    end
    object btnNovo: TButton
      Left = 368
      Top = 56
      Width = 107
      Height = 36
      Caption = 'Novo'
      TabOrder = 1
      OnClick = btnNovoClick
    end
    object btnEditar: TButton
      Left = 504
      Top = 56
      Width = 107
      Height = 36
      Caption = 'Editar'
      TabOrder = 2
      OnClick = btnEditarClick
    end
    object btnLimpar: TButton
      Left = 368
      Top = 104
      Width = 107
      Height = 36
      Caption = 'Limpar'
      TabOrder = 3
      OnClick = btnLimparClick
    end
    object btnExcluir: TButton
      Left = 504
      Top = 104
      Width = 107
      Height = 36
      Caption = 'Excluir'
      TabOrder = 4
      OnClick = btnExcluirClick
    end
    object btnSalvar: TButton
      Left = 441
      Top = 161
      Width = 107
      Height = 36
      Caption = 'Salvar'
      TabOrder = 5
      OnClick = btnSalvarClick
    end
    object grdSuites: TDBGrid
      Left = 8
      Top = 248
      Width = 603
      Height = 241
      DataSource = dsSuites
      TabOrder = 6
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'numero'
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nome'
          Width = 370
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'pre'#231'o/hora'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'status'
          Visible = True
        end>
    end
  end
  object qrySuites: TFDQuery
    Active = True
    Connection = uDM.FDConnection
    SQL.Strings = (
      'SELECT * FROM suites')
    Left = 432
    Top = 16
  end
  object dsSuites: TDataSource
    DataSet = qrySuites
    Left = 496
    Top = 24
  end
end

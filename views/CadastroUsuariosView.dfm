object fCadastroUsuarioView: TfCadastroUsuarioView
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastro de Usu'#225'rios'
  ClientHeight = 441
  ClientWidth = 624
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
    Width = 624
    Height = 441
    Align = alClient
    TabOrder = 0
    object lblTituloUsuario: TLabel
      Left = 200
      Top = 8
      Width = 206
      Height = 30
      Caption = 'Cadastro de Usu'#225'rios'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object gpbUsuarios: TGroupBox
      Left = 0
      Top = 44
      Width = 309
      Height = 165
      TabOrder = 0
      object lblNome: TLabel
        Left = 16
        Top = 16
        Width = 36
        Height = 15
        Caption = 'Nome:'
      end
      object lblLogin: TLabel
        Left = 19
        Top = 48
        Width = 33
        Height = 15
        Caption = 'Login:'
      end
      object lblSenha: TLabel
        Left = 17
        Top = 80
        Width = 35
        Height = 15
        Caption = 'Senha:'
      end
      object lblTIpo: TLabel
        Left = 26
        Top = 112
        Width = 26
        Height = 15
        Caption = 'Tipo:'
      end
      object edtNome: TEdit
        Left = 72
        Top = 13
        Width = 217
        Height = 23
        Enabled = False
        TabOrder = 0
      end
      object edtLogin: TEdit
        Left = 72
        Top = 45
        Width = 217
        Height = 23
        Enabled = False
        TabOrder = 1
      end
      object edtSenha: TEdit
        Left = 72
        Top = 77
        Width = 217
        Height = 23
        Enabled = False
        PasswordChar = '*'
        TabOrder = 2
      end
      object cbbTipo: TComboBox
        Left = 72
        Top = 109
        Width = 217
        Height = 23
        Enabled = False
        TabOrder = 3
      end
    end
    object btnNovo: TButton
      Left = 344
      Top = 57
      Width = 107
      Height = 38
      Caption = 'Novo'
      TabOrder = 1
      OnClick = btnNovoClick
    end
    object btnEditar: TButton
      Left = 480
      Top = 57
      Width = 107
      Height = 38
      Caption = 'Editar'
      TabOrder = 2
      OnClick = btnEditarClick
    end
    object btnLimpar: TButton
      Left = 344
      Top = 114
      Width = 107
      Height = 38
      Caption = 'Limpar'
      TabOrder = 3
      OnClick = btnLimparClick
    end
    object btnExcluir: TButton
      Left = 480
      Top = 114
      Width = 107
      Height = 38
      Caption = 'Excluir'
      TabOrder = 4
      OnClick = btnExcluirClick
    end
    object btnSalvar: TButton
      Left = 416
      Top = 171
      Width = 107
      Height = 38
      Caption = 'Salvar'
      TabOrder = 5
      OnClick = btnSalvarClick
    end
    object DBGrid1: TDBGrid
      Left = 0
      Top = 224
      Width = 613
      Height = 217
      DataSource = dsUsuarios
      TabOrder = 6
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnCellClick = DBGrid1CellClick
      Columns = <
        item
          Expanded = False
          FieldName = 'nome'
          Width = 230
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'login'
          Width = 240
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'tipo'
          Visible = True
        end>
    end
  end
  object qryUsuarios: TFDQuery
    Active = True
    Connection = uDM.FDConnection
    SQL.Strings = (
      'SELECT * FROM usuarios')
    Left = 456
    Top = 8
  end
  object dsUsuarios: TDataSource
    DataSet = qryUsuarios
    Left = 520
    Top = 16
  end
end

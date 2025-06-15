object fCadastroServicoView: TfCadastroServicoView
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastro de Servi'#231'os'
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
    object lblTituloServ: TLabel
      Left = 200
      Top = 8
      Width = 203
      Height = 30
      Caption = 'Cadastro de Servi'#231'os'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object gpbServ: TGroupBox
      Left = 16
      Top = 56
      Width = 321
      Height = 177
      TabOrder = 0
      object lblNome: TLabel
        Left = 16
        Top = 48
        Width = 94
        Height = 15
        Caption = 'Nome do Servi'#231'o:'
      end
      object lblPreco: TLabel
        Left = 77
        Top = 96
        Width = 33
        Height = 15
        Caption = 'Pre'#231'o:'
      end
      object edtNome: TEdit
        Left = 128
        Top = 45
        Width = 177
        Height = 23
        TabOrder = 0
      end
      object edtpreco: TEdit
        Left = 128
        Top = 93
        Width = 177
        Height = 23
        TabOrder = 1
      end
    end
    object btnNovo: TButton
      Left = 360
      Top = 56
      Width = 107
      Height = 36
      Caption = 'Novo'
      TabOrder = 1
      OnClick = btnNovoClick
    end
    object btnEditar: TButton
      Left = 488
      Top = 56
      Width = 107
      Height = 36
      Caption = 'Editar'
      TabOrder = 2
      OnClick = btnEditarClick
    end
    object btnLimpar: TButton
      Left = 360
      Top = 119
      Width = 107
      Height = 36
      Caption = 'Limpar'
      TabOrder = 3
      OnClick = btnLimparClick
    end
    object btnExcluir: TButton
      Left = 488
      Top = 119
      Width = 107
      Height = 36
      Caption = 'Excluir'
      TabOrder = 4
      OnClick = btnExcluirClick
    end
    object btnSalvar: TButton
      Left = 424
      Top = 172
      Width = 107
      Height = 36
      Caption = 'Salvar'
      TabOrder = 5
      OnClick = btnSalvarClick
    end
    object DBGrid1: TDBGrid
      Left = 16
      Top = 248
      Width = 601
      Height = 185
      DataSource = dsServicos
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
          Width = 490
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'preco'
          Visible = True
        end>
    end
  end
  object qryServicos: TFDQuery
    Active = True
    Connection = uDM.FDConnection
    SQL.Strings = (
      'SELECT * FROM servicos')
    Left = 520
    Top = 8
  end
  object dsServicos: TDataSource
    DataSet = qryServicos
    Left = 448
  end
end

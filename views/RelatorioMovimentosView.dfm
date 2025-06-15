object fRelatorioMovimentosView: TfRelatorioMovimentosView
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Relat'#243'rio de Movimentos'
  ClientHeight = 518
  ClientWidth = 763
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
    Width = 763
    Height = 518
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 264
      Top = 8
      Width = 248
      Height = 30
      Caption = 'Relat'#243'rio de Movimentos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object gppCabecalho: TGroupBox
      Left = 0
      Top = 36
      Width = 753
      Height = 181
      Caption = 'Filtros'
      TabOrder = 0
      object lblDataInicial: TLabel
        Left = 64
        Top = 18
        Width = 61
        Height = 15
        Caption = 'Data Inicial:'
      end
      object lbldataFinal: TLabel
        Left = 284
        Top = 18
        Width = 55
        Height = 15
        Caption = 'Data Final:'
      end
      object lblTurno: TLabel
        Left = 497
        Top = 18
        Width = 34
        Height = 15
        Caption = 'Turno:'
      end
      object lblHorarioInicial: TLabel
        Left = 57
        Top = 72
        Width = 77
        Height = 15
        Caption = 'Hor'#225'rio Inicial:'
      end
      object lblHorarioFinal: TLabel
        Left = 226
        Top = 72
        Width = 71
        Height = 15
        Caption = 'Horario Final:'
      end
      object lblUsuario: TLabel
        Left = 427
        Top = 72
        Width = 43
        Height = 15
        Caption = 'Usu'#225'rio:'
      end
      object lblPlaca: TLabel
        Left = 598
        Top = 72
        Width = 74
        Height = 15
        Caption = 'Placa/Veiculo:'
      end
      object lblSuite: TLabel
        Left = 668
        Top = 18
        Width = 29
        Height = 15
        Caption = 'Suite:'
      end
      object dtpInicio: TDateTimePicker
        Left = 3
        Top = 39
        Width = 175
        Height = 23
        Date = 45812.000000000000000000
        Time = 0.983320914354408200
        TabOrder = 0
      end
      object dtpFim: TDateTimePicker
        Left = 208
        Top = 39
        Width = 191
        Height = 23
        Date = 45812.000000000000000000
        Time = 0.985493009262427200
        TabOrder = 1
      end
      object medtHoraInicio: TMaskEdit
        Left = 32
        Top = 93
        Width = 121
        Height = 23
        TabOrder = 2
        Text = ''
      end
      object medtHoraFim: TMaskEdit
        Left = 199
        Top = 93
        Width = 121
        Height = 23
        TabOrder = 3
        Text = ''
      end
      object cbbTurno: TComboBox
        Left = 439
        Top = 39
        Width = 145
        Height = 23
        TabOrder = 4
      end
      object cbbUsuario: TComboBox
        Left = 359
        Top = 93
        Width = 172
        Height = 23
        TabOrder = 5
      end
      object cbbSuite: TComboBox
        Left = 605
        Top = 39
        Width = 145
        Height = 23
        TabOrder = 6
      end
      object edtPlaca: TEdit
        Left = 574
        Top = 93
        Width = 121
        Height = 23
        TabOrder = 7
      end
      object btnFiltrar: TButton
        Left = 183
        Top = 136
        Width = 161
        Height = 29
        Caption = 'Filtrar'
        TabOrder = 8
        OnClick = btnFiltrarClick
      end
      object btnImprimir: TButton
        Left = 407
        Top = 136
        Width = 161
        Height = 29
        Caption = 'Imprimir'
        TabOrder = 9
        OnClick = btnImprimirClick
      end
    end
    object DBGrid1: TDBGrid
      Left = 0
      Top = 231
      Width = 753
      Height = 290
      DataSource = dsMovimentos
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'entrada'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'saida'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'placa'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cliente'
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'suite'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'usuario'
          Width = 200
          Visible = True
        end>
    end
  end
  object dsMovimentos: TDataSource
    Left = 640
  end
  object qryMovimentos: TFDQuery
    Connection = uDM.FDConnection
    Left = 568
    Top = 8
  end
end

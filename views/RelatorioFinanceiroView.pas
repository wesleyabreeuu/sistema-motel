unit RelatorioFinanceiroView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TfRelatorioFinanceiroView = class(TForm)
    pnlFundo: TPanel;
    lblTitulo: TLabel;
    gppFiltros: TGroupBox;
    DBGrid1: TDBGrid;
    lblTipo: TLabel;
    lblStatus: TLabel;
    lblDescricao: TLabel;
    lblDataInicial: TLabel;
    lblDataFinal: TLabel;
    cbbTipo: TComboBox;
    cbbStatus: TComboBox;
    edtDescricao: TEdit;
    dtpDataInicial: TDateTimePicker;
    dtpDataFinal: TDateTimePicker;
    btnFiltrar: TButton;
    qryFinanceiro: TFDQuery;
    dsFinanceiro: TDataSource;
    btnImprimir: TButton;
    qryFinanceiroid: TFDAutoIncField;
    qryFinanceirotipo: TWideStringField;
    qryFinanceirodescricao: TWideStringField;
    qryFinanceirovalor: TBCDField;
    qryFinanceirodata: TDateField;
    qryFinanceirovencimento: TDateField;
    qryFinanceirodata_pagamento: TDateField;
    qryFinanceirostatus: TWideStringField;
    qryFinanceiroforma_pagamento: TWideStringField;
    qryFinanceiroobservacao: TWideMemoField;

    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);

  private
    procedure AplicarFiltros;
  public
  end;

var
  fRelatorioFinanceiroView: TfRelatorioFinanceiroView;

implementation

uses
  dmUDM, LoginView, Printers, System.StrUtils;

{$R *.dfm}

procedure TfRelatorioFinanceiroView.FormShow(Sender: TObject);
begin

    // Verificação de permissão
  if SameText(TipoUsuarioLogado, 'Usuário') then
  begin
    MessageDlg('Você não tem autorização para acessar esta tela.', mtWarning, [mbOK], 0);
    Close;
    Exit;
  end;

  // Preenche os combos
  cbbTipo.Items.Text := 'Receita' + sLineBreak + 'Despesa';
  cbbStatus.Items.Text := 'Pendente' + sLineBreak + 'Pago';

  dtpDataInicial.Date := Date - 30;
  dtpDataFinal.Date := Date;

  AplicarFiltros;
end;



procedure TfRelatorioFinanceiroView.btnImprimirClick(Sender: TObject);
var
  SL: TStringList;
  i, y: Integer;
begin
  if qryFinanceiro.IsEmpty then
  begin
    ShowMessage('Nenhum dado para imprimir. Faça um filtro primeiro.');
    Exit;
  end;

  SL := TStringList.Create;
  try
    SL.Add('============== RELATÓRIO FINANCEIRO ==============');
    SL.Add('Período: ' + FormatDateTime('dd/MM/yyyy', dtpDataInicial.Date) +
           ' a ' + FormatDateTime('dd/MM/yyyy', dtpDataFinal.Date));
    SL.Add('Tipo: ' + IfThen(cbbTipo.Text = '', 'Todos', cbbTipo.Text));
    SL.Add('Status: ' + IfThen(cbbStatus.Text = '', 'Todos', cbbStatus.Text));
    SL.Add('---------------------------------------------------');
    SL.Add('Data     | Tipo    | Descrição         | Valor  | Status');
    SL.Add('---------------------------------------------------');

    qryFinanceiro.First;
    while not qryFinanceiro.Eof do
    begin
      SL.Add(
        FormatDateTime('dd/MM', qryFinanceiro.FieldByName('data').AsDateTime) + ' | ' +
        Format('%-7s', [qryFinanceiro.FieldByName('tipo').AsString]) + ' | ' +
        Copy(qryFinanceiro.FieldByName('descricao').AsString, 1, 17) + ' | ' +
        Format('%6.2f', [qryFinanceiro.FieldByName('valor').AsFloat]) + ' | ' +
        qryFinanceiro.FieldByName('status').AsString
      );
      qryFinanceiro.Next;
    end;

    SL.Add('===================================================');
    SL.Add('Impresso em: ' + FormatDateTime('dd/MM/yyyy HH:nn', Now));
    SL.Add('===================================================');

    Printer.Title := 'Relatório Financeiro';
    Printer.BeginDoc;
    try
      Printer.Canvas.Font.Name := 'Courier New';
      Printer.Canvas.Font.Size := 10;
      y := 100;

      for i := 0 to SL.Count - 1 do
      begin
        Printer.Canvas.TextOut(100, y, SL[i]);
        y := y + 60; // espaçamento entre linhas
      end;
    finally
      Printer.EndDoc;
    end;

    ShowMessage('Relatório enviado para a impressora.');

  finally
    SL.Free;
  end;
end;

procedure TfRelatorioFinanceiroView.btnFiltrarClick(Sender: TObject);
begin
  AplicarFiltros;
end;

procedure TfRelatorioFinanceiroView.AplicarFiltros;
var
  SQLBase: string;
begin
  SQLBase := 'SELECT id, tipo, descricao, valor, data, vencimento, data_pagamento, status, forma_pagamento, observacao ' +
             'FROM financeiro WHERE 1=1 ';

  if cbbTipo.Text <> '' then
    SQLBase := SQLBase + ' AND tipo = :tipo';

  if cbbStatus.Text <> '' then
    SQLBase := SQLBase + ' AND status = :status';

  if Trim(edtDescricao.Text) <> '' then
    SQLBase := SQLBase + ' AND descricao LIKE :descricao';

  SQLBase := SQLBase + ' AND data BETWEEN :dataInicial AND :dataFinal';

  with qryFinanceiro do
  begin
    Close;
    SQL.Clear;
    SQL.Text := SQLBase;

    if cbbTipo.Text <> '' then
      ParamByName('tipo').AsString := LowerCase(cbbTipo.Text);

    if cbbStatus.Text <> '' then
      ParamByName('status').AsString := LowerCase(cbbStatus.Text);

    if Trim(edtDescricao.Text) <> '' then
      ParamByName('descricao').AsString := '%' + Trim(edtDescricao.Text) + '%';

    ParamByName('dataInicial').AsDate := dtpDataInicial.Date;
    ParamByName('dataFinal').AsDate := dtpDataFinal.Date;

    Open;
  end;
end;

end.


unit ContasAPagarView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls,
  Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Grids, Vcl.DBGrids;

type
  TfContasAPagarView = class(TForm)
    pnlFundo: TPanel;
    lblTitulo: TLabel;
    gpbFiltros: TGroupBox;
    lblTipoFiltro: TLabel;
    lblStatusFiltro: TLabel;
    lblDataInicial: TLabel;
    lblDataFinal: TLabel;
    lblDescricaoFiltro: TLabel;
    cbFiltroTipo: TComboBox;
    cbFiltroStatus: TComboBox;
    dtpFiltroInicio: TDateTimePicker;
    dtpFiltroFim: TDateTimePicker;
    edtFiltroDescricao: TEdit;
    btnFiltrar: TButton;
    gpContas: TGroupBox;
    lblTipo: TLabel;
    lblVencimento: TLabel;
    lblDescricao: TLabel;
    lblValor: TLabel;
    lblObservacao: TLabel;
    cbbTipo: TComboBox;
    DateTimePicker1: TDateTimePicker;
    edtDescicao: TEdit;
    edtValor: TEdit;
    edtObservacao: TEdit;
    btnSalvar: TButton;
    btnMarcarComo: TButton;
    DBGrid1: TDBGrid;
    qryFinanceiro: TFDQuery;
    dsFInanceiro: TDataSource;
    btnImprimir: TButton;

    procedure FormShow(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnMarcarComoClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);

  private
    procedure CarregarContas;
    procedure AjustarGrid;
  public
  end;

var
  fContasAPagarView: TfContasAPagarView;

implementation

uses dmUDM, Printers;

{$R *.dfm}

procedure TfContasAPagarView.FormShow(Sender: TObject);
begin
  cbFiltroTipo.Items.Text := 'Todos'#13'Receita'#13'Despesa';
  cbFiltroStatus.Items.Text := 'Todos'#13'Pendente'#13'Pago';
  cbbTipo.Items.Text := 'Receita'#13'Despesa';

  cbFiltroTipo.ItemIndex := 0;
  cbFiltroStatus.ItemIndex := 0;
  cbbTipo.ItemIndex := 0;

  dtpFiltroInicio.Date := Date - 30;
  dtpFiltroFim.Date := Date;

  CarregarContas;
end;

procedure TfContasAPagarView.AjustarGrid;
begin
  if DBGrid1.Columns.Count > 0 then
  begin
    DBGrid1.Columns[0].Visible := False; // oculta o campo "id"

    // trata campo observacao se desejar ocultar também
    if DBGrid1.Columns.Count >= 10 then
      DBGrid1.Columns[9].Visible := False; // observacao (campo 10 = index 9)
  end;
end;



procedure TfContasAPagarView.CarregarContas;
begin
  qryFinanceiro.Close;

  qryFinanceiro.SQL.Text :=
    'SELECT id, tipo, descricao, valor, data, vencimento, data_pagamento, status, forma_pagamento, observacao ' +
    'FROM financeiro ' +
    'WHERE ';

  if cbFiltroStatus.ItemIndex = 2 then // Pago
    qryFinanceiro.SQL.Add('data_pagamento BETWEEN :inicio AND :fim')
  else
    qryFinanceiro.SQL.Add('vencimento BETWEEN :inicio AND :fim');

  if cbFiltroTipo.ItemIndex > 0 then
    qryFinanceiro.SQL.Add('AND tipo = :tipo');

  if cbFiltroStatus.ItemIndex > 0 then
    qryFinanceiro.SQL.Add('AND status = :status');

  if Trim(edtFiltroDescricao.Text) <> '' then
    qryFinanceiro.SQL.Add('AND descricao LIKE :descricao');

  qryFinanceiro.ParamByName('inicio').AsDate := dtpFiltroInicio.Date;
  qryFinanceiro.ParamByName('fim').AsDate := dtpFiltroFim.Date;

  if cbFiltroTipo.ItemIndex > 0 then
    qryFinanceiro.ParamByName('tipo').AsString := LowerCase(cbFiltroTipo.Text);

  if cbFiltroStatus.ItemIndex > 0 then
    qryFinanceiro.ParamByName('status').AsString := LowerCase(cbFiltroStatus.Text);

  if Trim(edtFiltroDescricao.Text) <> '' then
    qryFinanceiro.ParamByName('descricao').AsString := '%' + edtFiltroDescricao.Text + '%';

  qryFinanceiro.Open;
  AjustarGrid;
end;


procedure TfContasAPagarView.btnSalvarClick(Sender: TObject);
begin
  if Trim(edtDescicao.Text) = '' then
  begin
    ShowMessage('Informe a descrição.');
    Exit;
  end;

  qryFinanceiro.Close;
  qryFinanceiro.SQL.Text :=
    'INSERT INTO financeiro (tipo, descricao, valor, data, vencimento, status, observacao) ' +
    'VALUES (:tipo, :descricao, :valor, CURDATE(), :vencimento, ''pendente'', :observacao)';

  qryFinanceiro.ParamByName('tipo').AsString := LowerCase(cbbTipo.Text);
  qryFinanceiro.ParamByName('descricao').AsString := edtDescicao.Text;
  qryFinanceiro.ParamByName('valor').AsFloat := StrToFloatDef(edtValor.Text, 0);
  qryFinanceiro.ParamByName('vencimento').AsDate := DateTimePicker1.Date;
  qryFinanceiro.ParamByName('observacao').AsString := edtObservacao.Text;

  qryFinanceiro.ExecSQL;

  ShowMessage('Conta cadastrada com sucesso.');
  CarregarContas;
end;

procedure TfContasAPagarView.btnMarcarComoClick(Sender: TObject);
var
  id: Integer;
begin
  if qryFinanceiro.IsEmpty then
  begin
    ShowMessage('Selecione uma conta para marcar como paga.');
    Exit;
  end;

  // Usa método seguro para capturar o valor do campo "id"
  if qryFinanceiro.FindField('id') = nil then
  begin
    ShowMessage('Erro: o campo "id" não foi encontrado na consulta atual.');
    Exit;
  end;

  id := qryFinanceiro.FieldByName('id').AsInteger;

  // Executa a atualização
  qryFinanceiro.Close;
  qryFinanceiro.SQL.Text :=
    'UPDATE financeiro SET status = ''pago'', data_pagamento = CURDATE() WHERE id = :id';
  qryFinanceiro.ParamByName('id').AsInteger := id;
  qryFinanceiro.ExecSQL;

  ShowMessage('Conta marcada como paga com sucesso.');

  CarregarContas;
end;

procedure TfContasAPagarView.btnFiltrarClick(Sender: TObject);
begin
  CarregarContas;
end;

procedure TfContasAPagarView.btnImprimirClick(Sender: TObject);
var
  y, LineHeight, LeftMargin: Integer;
begin
  if qryFinanceiro.IsEmpty then
  begin
    ShowMessage('Nenhuma conta encontrada para imprimir.');
    Exit;
  end;

  Printer.BeginDoc;
  try
    Printer.Canvas.Font.Name := 'Courier New';
    Printer.Canvas.Font.Size := 10;

    LeftMargin := 100;
    LineHeight := 64;
    y := 100;

    // Cabeçalho
    Printer.Canvas.TextOut(LeftMargin, y, 'Relatório de Contas a Pagar/Receber');
    Inc(y, LineHeight);
    Printer.Canvas.TextOut(LeftMargin, y, 'Período: ' +
      DateToStr(dtpFiltroInicio.Date) + ' a ' + DateToStr(dtpFiltroFim.Date));
    Inc(y, LineHeight);
    Printer.Canvas.TextOut(LeftMargin, y, '--------------------------------------------------------------');
    Inc(y, LineHeight);

    // Títulos da tabela
    Printer.Canvas.TextOut(LeftMargin, y, Format('%-10s %-30s %10s %15s %12s',
      ['Tipo', 'Descrição', 'Valor(R$)', 'Vencimento', 'Status']));
    Inc(y, LineHeight);
    Printer.Canvas.TextOut(LeftMargin, y, '--------------------------------------------------------------');
    Inc(y, LineHeight);

    // Dados
    qryFinanceiro.First;
    while not qryFinanceiro.Eof do
    begin
      Printer.Canvas.TextOut(LeftMargin, y, Format('%-10s %-30s %10s %15s %12s',
        [ qryFinanceiro.FieldByName('tipo').AsString,
          Copy(qryFinanceiro.FieldByName('descricao').AsString, 1, 30),
          FormatFloat('0.00', qryFinanceiro.FieldByName('valor').AsFloat),
          FormatDateTime('dd/mm/yyyy', qryFinanceiro.FieldByName('vencimento').AsDateTime),
          qryFinanceiro.FieldByName('status').AsString
        ]));
      Inc(y, LineHeight);
      qryFinanceiro.Next;
    end;

  finally
    Printer.EndDoc;
  end;

  ShowMessage('Relatório enviado para impressão.');
end;

end.


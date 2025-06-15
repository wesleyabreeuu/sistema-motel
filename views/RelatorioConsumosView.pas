unit RelatorioConsumosView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls,
  Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Grids, Vcl.DBGrids, Printers;

type
  TfRelatorioConsumosView = class(TForm)
    pnlFundo: TPanel;
    lblTitulo: TLabel;
    gppFiltros: TGroupBox;
    lblDataInicial: TLabel;
    lblDataFinal: TLabel;
    lblTipo: TLabel;
    lblProduto: TLabel;
    lblSuite: TLabel;
    dtpDataInicial: TDateTimePicker;
    dtpDataFinal: TDateTimePicker;
    cbTipoProduto: TComboBox;
    cbProduto: TComboBox;
    cbSuite: TComboBox;
    btnFiltrar: TButton;
    btnImprimir: TButton;
    dbgConsumos: TDBGrid;
    qryConsumos: TFDQuery;
    dsConsumos: TDataSource;
    qryProdutos: TFDQuery;
    qrySuites: TFDQuery;

    procedure FormShow(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);

  private
    procedure CarregarProdutos;
    procedure CarregarSuites;
    procedure BuscarConsumos;
  public
  end;

var
  fRelatorioConsumosView: TfRelatorioConsumosView;

implementation

uses dmUDM, LoginView;

{$R *.dfm}

procedure TfRelatorioConsumosView.FormShow(Sender: TObject);
begin
  if SameText(TipoUsuarioLogado, 'Usuário') then
  begin
    MessageDlg('Você não tem autorização para acessar esta tela.', mtWarning, [mbOK], 0);
    Close;
    Exit;
  end;

  cbTipoProduto.Items.Clear;
  cbTipoProduto.Items.Add('Todos');
  cbTipoProduto.Items.Add('Estoque');
  cbTipoProduto.Items.Add('Frigobar');
  cbTipoProduto.Items.Add('Serviço');
  cbTipoProduto.ItemIndex := 0;

  dtpDataInicial.Date := Now - 7;
  dtpDataFinal.Date := Now;

  CarregarProdutos;
  CarregarSuites;
end;

procedure TfRelatorioConsumosView.CarregarProdutos;
begin
  cbProduto.Items.Clear;
  cbProduto.Items.Add('Todos');

  qryProdutos.Close;
  qryProdutos.SQL.Text := 'SELECT nome FROM produtos ORDER BY nome';
  qryProdutos.Open;

  while not qryProdutos.Eof do
  begin
    cbProduto.Items.Add(qryProdutos.FieldByName('nome').AsString);
    qryProdutos.Next;
  end;

  cbProduto.ItemIndex := 0;
end;


procedure TfRelatorioConsumosView.CarregarSuites;
begin
  cbSuite.Items.Clear;
  cbSuite.Items.Add('Todas');

  qrySuites.Close;
  qrySuites.SQL.Text := 'SELECT nome FROM suites ORDER BY nome';
  qrySuites.Open;

  while not qrySuites.Eof do
  begin
    cbSuite.Items.Add(qrySuites.FieldByName('nome').AsString);
    qrySuites.Next;
  end;

  cbSuite.ItemIndex := 0;
end;


procedure TfRelatorioConsumosView.btnFiltrarClick(Sender: TObject);
begin
  BuscarConsumos;
end;

procedure TfRelatorioConsumosView.btnImprimirClick(Sender: TObject);
var
  SL: TStringList;
  i, y: Integer;
begin
  if qryConsumos.IsEmpty then
  begin
    ShowMessage('Nenhum dado para imprimir. Aplique um filtro primeiro.');
    Exit;
  end;

  SL := TStringList.Create;
  try
    SL.Add('================ RELATÓRIO DE CONSUMOS ================');
    SL.Add('Período: ' + FormatDateTime('dd/MM/yyyy', dtpDataInicial.Date) +
           ' a ' + FormatDateTime('dd/MM/yyyy', dtpDataFinal.Date));
    SL.Add('Tipo: ' + cbTipoProduto.Text);
    SL.Add('Produto/Serviço: ' + cbProduto.Text);
    SL.Add('Suíte: ' + cbSuite.Text);
    SL.Add('--------------------------------------------------------');
    SL.Add('Data     | Tipo     | Item          | Qtd | Vlr | Total | Suíte');
    SL.Add('--------------------------------------------------------');

    qryConsumos.First;
    while not qryConsumos.Eof do
    begin
      SL.Add(
        FormatDateTime('dd/MM', qryConsumos.FieldByName('data_consumo').AsDateTime) + ' | ' +
        Format('%-8s', [qryConsumos.FieldByName('tipo').AsString]) + ' | ' +
        Format('%-13s', [qryConsumos.FieldByName('nome_item').AsString]) + ' | ' +
        Format('%3d', [qryConsumos.FieldByName('quantidade').AsInteger]) + ' | ' +
        Format('%4.2f', [qryConsumos.FieldByName('valor').AsFloat]) + ' | ' +
        Format('%5.2f', [qryConsumos.FieldByName('total').AsFloat]) + ' | ' +
        qryConsumos.FieldByName('suite').AsString
      );
      qryConsumos.Next;
    end;

    SL.Add('========================================================');
    SL.Add('Gerado em: ' + FormatDateTime('dd/MM/yyyy HH:nn', Now));
    SL.Add('========================================================');

    Printer.Title := 'Relatório de Consumos';
    Printer.BeginDoc;
    try
      Printer.Canvas.Font.Name := 'Courier New';
      Printer.Canvas.Font.Size := 10;
      y := 100;

      for i := 0 to SL.Count - 1 do
      begin
        Printer.Canvas.TextOut(100, y, SL[i]);
        y := y + 60; // ESPAÇAMENTO AUMENTADO PARA +60 pixels
      end;
    finally
      Printer.EndDoc;
    end;

    ShowMessage('Relatório enviado para a impressora (ou PDF).');

  finally
    SL.Free;
  end;
end;

procedure TfRelatorioConsumosView.BuscarConsumos;
begin
  qryConsumos.Close;
  qryConsumos.SQL.Text :=
    'SELECT c.datahora AS data_consumo, c.tipo, p.nome AS nome_item, ' +
    'c.quantidade, c.valor, (c.quantidade * c.valor) AS total, s.nome AS suite ' +
    'FROM consumos c ' +
    'JOIN suites s ON c.suite_id = s.id ' +
    'LEFT JOIN produtos p ON (c.item_id = p.id AND c.tipo IN (''frigobar'', ''estoque'')) ' +
    'WHERE c.datahora BETWEEN :data_inicial AND :data_final ';

  if cbTipoProduto.ItemIndex > 0 then
    qryConsumos.SQL.Add('AND c.tipo = :tipo');

  if cbProduto.ItemIndex > 0 then
    qryConsumos.SQL.Add('AND p.nome = :produto');

  if cbSuite.ItemIndex > 0 then
    qryConsumos.SQL.Add('AND s.nome = :suite');

      // ⚠️ Definir tipos dos parâmetros
  qryConsumos.ParamByName('data_inicial').DataType := ftDate;
  qryConsumos.ParamByName('data_final').DataType := ftDate;

  qryConsumos.ParamByName('data_inicial').AsDateTime := dtpDataInicial.Date;
  qryConsumos.ParamByName('data_final').AsDateTime := dtpDataFinal.Date;

  if cbTipoProduto.ItemIndex > 0 then
    qryConsumos.ParamByName('tipo').AsString := LowerCase(cbTipoProduto.Text);

  if cbProduto.ItemIndex > 0 then
    qryConsumos.ParamByName('produto').AsString := cbProduto.Text;

  if cbSuite.ItemIndex > 0 then
    qryConsumos.ParamByName('suite').AsString := cbSuite.Text;

  qryConsumos.Open;
end;

end.


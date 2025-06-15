unit FinalizarHospedagemView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, System.DateUtils, FireDAC.Comp.Client,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, System.StrUtils;

type
  TfFinalizarHospedagemView = class(TForm)
    pnlFundo: TPanel;
    lblGestao: TLabel;
    gppDados: TGroupBox;
    lblSuite: TLabel;
    lblDadosEntrada: TLabel;
    lblHoraAtual: TLabel;
    lblVeiculo: TLabel;
    lblPlaca: TLabel;
    lblTempoTotal: TLabel;
    lblSuiteUsada: TLabel;
    lblVeiculoUsado: TLabel;
    lblPlacaUsada: TLabel;
    lblEntrada: TLabel;
    lblHoraAtualUsada: TLabel;
    lblTempoPermanencia: TLabel;
    dbgConsumo: TDBGrid;
    lblValorHospedagem: TLabel;
    lblValorConsumo: TLabel;
    lblValorTotal: TLabel;
    lblTotalHospedagem: TLabel;
    lblTotalConsumo: TLabel;
    lblTotal: TLabel;
    gppForma1: TGroupBox;
    gppForma2: TGroupBox;
    lblTipoPag1: TLabel;
    lblTipoPag2: TLabel;
    cbbFormaPag1: TComboBox;
    cbbFormaPag2: TComboBox;
    lblValorPago1: TLabel;
    lblValorPago2: TLabel;
    edtValorTotal1: TEdit;
    edtValorTotal2: TEdit;
    btnFinalizarHospedagem: TButton;
    btnCancelar: TButton;
    qryAuxiliar: TFDQuery;
    qryConsumos: TFDQuery;
    dsConsumos: TDataSource;

    procedure FormShow(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnFinalizarHospedagemClick(Sender: TObject);
  private
    SuiteIDSelecionada: Integer;
    VeiculoIDSelecionado: Integer;
    procedure AtualizarDadosHospedagem;
    function CarregarConsumos: Currency;
    function LimparValorEdit(Edit: TEdit): Currency;
  public
    procedure AbrirTelaFinalizacao(SuiteID, VeiculoID: Integer);
  end;

var
  fFinalizarHospedagemView: TfFinalizarHospedagemView;

implementation

uses dmUDM, Printers, Math;

{$R *.dfm}

procedure TfFinalizarHospedagemView.AbrirTelaFinalizacao(SuiteID, VeiculoID: Integer);
begin
  SuiteIDSelecionada := SuiteID;
  VeiculoIDSelecionado := VeiculoID;
  AtualizarDadosHospedagem;
end;

procedure TfFinalizarHospedagemView.FormShow(Sender: TObject);
begin
  cbbFormaPag1.Items.Clear;
  cbbFormaPag1.Items.Add('Dinheiro');
  cbbFormaPag1.Items.Add('Pix');
  cbbFormaPag1.Items.Add('Cartão de Débito');
  cbbFormaPag1.Items.Add('Cartão de Crédito');

  cbbFormaPag2.Items.Assign(cbbFormaPag1.Items);

  cbbFormaPag1.ItemIndex := -1;
  cbbFormaPag2.ItemIndex := -1;
end;

procedure TfFinalizarHospedagemView.AtualizarDadosHospedagem;
var
  DataEntrada, DataAtual: TDateTime;
  Horas: Integer;
  PrecoHora, TotalHospedagem, TotalConsumos, TotalGeral: Currency;
begin
  DataAtual := Now;
  lblHoraAtualUsada.Caption := FormatDateTime('dd/MM/yyyy hh:nn', DataAtual);
  DataEntrada := StrToDateTime(lblEntrada.Caption);

  Horas := HoursBetween(DataAtual, DataEntrada);
  lblTempoPermanencia.Caption := IntToStr(Horas) + ' horas';

  with qryAuxiliar do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT preco_hora FROM suites WHERE id = :id');
    ParamByName('id').AsInteger := SuiteIDSelecionada;
    Open;

    if not IsEmpty then
      PrecoHora := FieldByName('preco_hora').AsCurrency
    else
      PrecoHora := 0;
  end;

  TotalHospedagem := Horas * PrecoHora;
  lblTotalHospedagem.Caption := FormatFloat('R$ ,0.00', TotalHospedagem);

  TotalConsumos := CarregarConsumos;
  lblTotalConsumo.Caption := FormatFloat('R$ ,0.00', TotalConsumos);

  TotalGeral := TotalHospedagem + TotalConsumos;
  lblTotal.Caption := FormatFloat('R$ ,0.00', TotalGeral);
end;

function TfFinalizarHospedagemView.CarregarConsumos: Currency;
var
  Total: Currency;
begin
  Total := 0;
  with qryConsumos do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT c.quantidade, ' +
            'CASE WHEN c.tipo IN (''frigobar'', ''estoque'') THEN p.nome ' +
            '     WHEN c.tipo = ''servico'' THEN s.nome ' +
            '     ELSE ''Desconhecido'' END AS nome, ' +
            'c.valor ' +
            'FROM consumos c ' +
            'LEFT JOIN produtos p ON (c.tipo IN (''frigobar'', ''estoque'') AND c.item_id = p.id) ' +
            'LEFT JOIN servicos s ON (c.tipo = ''servico'' AND c.item_id = s.id) ' +
            'WHERE c.veiculo_id = :veiculo_id');
    ParamByName('veiculo_id').AsInteger := VeiculoIDSelecionado;
    Open;

    First;
    while not Eof do
    begin
      Total := Total + (FieldByName('quantidade').AsInteger * FieldByName('valor').AsFloat);
      Next;
    end;
  end;

  dbgConsumo.DataSource := dsConsumos;
  Result := Total;
end;

function TfFinalizarHospedagemView.LimparValorEdit(Edit: TEdit): Currency;
var
  valorStr: string;
begin
  valorStr := Trim(Edit.Text);
  valorStr := StringReplace(valorStr, 'R$', '', [rfReplaceAll]);
  valorStr := StringReplace(valorStr, '.', '', [rfReplaceAll]);
  valorStr := StringReplace(valorStr, ',', '.', [rfReplaceAll]);
  Result := StrToFloatDef(valorStr, 0);
end;

procedure TfFinalizarHospedagemView.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfFinalizarHospedagemView.btnFinalizarHospedagemClick(Sender: TObject);
var
  TotalHospedagem, TotalConsumos, TotalGeral, ValorPag1, ValorPag2: Currency;
  FormaPag1, FormaPag2: String;
  SL: TStringList;
  i, y: Integer;
begin
  TotalHospedagem := StrToCurrDef(StringReplace(lblTotalHospedagem.Caption, 'R$', '', [rfReplaceAll]), 0);
  TotalConsumos := StrToCurrDef(StringReplace(lblTotalConsumo.Caption, 'R$', '', [rfReplaceAll]), 0);
  TotalGeral := TotalHospedagem + TotalConsumos;

  ValorPag1 := LimparValorEdit(edtValorTotal1);
  ValorPag2 := LimparValorEdit(edtValorTotal2);

  FormaPag1 := cbbFormaPag1.Text;
  FormaPag2 := cbbFormaPag2.Text;

  if not SameValue(ValorPag1 + ValorPag2, TotalGeral, 0.01) then
  begin
    ShowMessage('A soma dos valores pagos não corresponde ao valor total da hospedagem!');
    Exit;
  end;

  with qryAuxiliar do
  begin
    Close;
    SQL.Text :=
      'UPDATE veiculos SET saida = NOW(), ' +
      'pagamento_forma1 = :forma1, pagamento_valor1 = :valor1, ' +
      'pagamento_forma2 = :forma2, pagamento_valor2 = :valor2 ' +
      'WHERE id = :veiculo_id';
    ParamByName('forma1').AsString := FormaPag1;
    ParamByName('valor1').AsCurrency := ValorPag1;
    ParamByName('forma2').AsString := FormaPag2;
    ParamByName('valor2').AsCurrency := ValorPag2;
    ParamByName('veiculo_id').AsInteger := VeiculoIDSelecionado;
    ExecSQL;

    Close;
    SQL.Text := 'UPDATE suites SET status = ''Disponível'' WHERE id = :id';
    ParamByName('id').AsInteger := SuiteIDSelecionada;
    ExecSQL;
  end;

  SL := TStringList.Create;
  try
    SL.Add('===============================');
    SL.Add('        COMPROVANTE FINAL      ');
    SL.Add('===============================');
    SL.Add('Suite: ' + lblSuiteUsada.Caption);
    SL.Add('Veículo: ' + lblVeiculoUsado.Caption);
    SL.Add('Placa: ' + lblPlacaUsada.Caption);
    SL.Add('Entrada: ' + lblEntrada.Caption);
    SL.Add('Hora Atual: ' + lblHoraAtualUsada.Caption);
    SL.Add('Tempo de Permanência: ' + lblTempoPermanencia.Caption);
    SL.Add('Valor da Hospedagem: ' + lblTotalHospedagem.Caption);
    SL.Add('Valor do Consumo: ' + lblTotalConsumo.Caption);
    SL.Add('Valor Total: ' + lblTotal.Caption);
    SL.Add('Forma de Pagamento 1: ' + FormaPag1);
    SL.Add('Valor Pago 1: R$ ' + FormatFloat('0.00', ValorPag1));
    if Trim(FormaPag2) <> '' then
    begin
      SL.Add('Forma de Pagamento 2: ' + FormaPag2);
      SL.Add('Valor Pago 2: R$ ' + FormatFloat('0.00', ValorPag2));
    end;
    SL.Add('-------------------------------');
    SL.Add('       ITENS CONSUMIDOS        ');
    SL.Add('-------------------------------');
    qryConsumos.First;
    while not qryConsumos.Eof do
    begin
      SL.Add(qryConsumos.FieldByName('nome').AsString +
        ' x' + qryConsumos.FieldByName('quantidade').AsString +
        ' - R$ ' + FormatFloat('0.00', qryConsumos.FieldByName('valor').AsFloat));
      qryConsumos.Next;
    end;
    SL.Add('===============================');
    SL.Add('  Obrigado por escolher o');
    SL.Add('        Love''s Motel');
    SL.Add('===============================');
    Printer.BeginDoc;
    try
      Printer.Canvas.Font.Name := 'Courier New';
      Printer.Canvas.Font.Size := 10;
      y := 100;
      for i := 0 to SL.Count - 1 do
      begin
        Printer.Canvas.TextOut(100, y, SL[i]);
        y := y + 60;
      end;
    finally
      Printer.EndDoc;
    end;
  finally
    SL.Free;
  end;

  ShowMessage('Hospedagem finalizada com sucesso!');
  Close;
end;

end.


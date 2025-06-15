unit GestaoView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FinalizarHospedagemView;

type
  TfGestao = class(TForm)
    pnlFundo: TPanel;
    lblTitulo: TLabel;
    lblSuiteUsada: TLabel;
    gppDadosSuite: TGroupBox;
    lblNome: TLabel;
    lblMarca: TLabel;
    lblPlaca: TLabel;
    Label1: TLabel;
    lblCor: TLabel;
    lblNomeUsado: TLabel;
    lblMarcaUsada: TLabel;
    lblCorUsada: TLabel;
    lblPlacaUsada: TLabel;
    lblDataUsada: TLabel;
    btnConsumoEstoque: TButton;
    btnServiço: TButton;
    pgcConsumos: TPageControl;
    tabFrigobar: TTabSheet;
    tabEstoque: TTabSheet;
    tabServicos: TTabSheet;
    dbgFrigobar: TDBGrid;
    dbgEstoque: TDBGrid;
    dbgServico: TDBGrid;
    btnConsumoFrigobar: TButton;
    btnFinalizar: TButton;
    btnFechar: TButton;
    qryVeiculo: TFDQuery;
    qryFrigobar: TFDQuery;
    dsFrigobar: TDataSource;
    qryEstoque: TFDQuery;
    dsEstoque: TDataSource;
    qryServico: TFDQuery;
    dsServico: TDataSource;
    qryConsumo: TFDQuery;
    qryEstoqueid: TFDAutoIncField;
    qryEstoquenome: TWideStringField;
    qryEstoquepreco_unitario: TBCDField;
    qryEstoquequantidade_estoque: TIntegerField;

    procedure btnFecharClick(Sender: TObject);
    procedure btnConsumoFrigobarClick(Sender: TObject);
    procedure btnConsumoEstoqueClick(Sender: TObject);
    procedure btnServicoClick(Sender: TObject);
    procedure btnFinalizarClick(Sender: TObject);
  private
    SuiteIDSelecionada: Integer;
    VeiculoIDSelecionado: Integer;
    procedure CarregarProdutosFrigobar;
    procedure CarregarProdutosEstoque;
    procedure CarregarServicos;
    procedure RegistrarConsumo(const Tipo: String; ItemID: Integer; ValorUnitario: Double);
  public
    procedure AbrirGestaoSuite(SuiteID: Integer);
  end;

var
  fGestao: TfGestao;

implementation

uses dmUDM;

{$R *.dfm}

procedure TfGestao.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfGestao.btnFinalizarClick(Sender: TObject);
begin
  Application.CreateForm(TfFinalizarHospedagemView, fFinalizarHospedagemView);
  try
    fFinalizarHospedagemView.lblSuiteUsada.Caption := lblSuiteUsada.Caption;
    fFinalizarHospedagemView.lblVeiculoUsado.Caption := lblNomeUsado.Caption;
    fFinalizarHospedagemView.lblPlacaUsada.Caption := lblPlacaUsada.Caption;
    fFinalizarHospedagemView.lblEntrada.Caption := lblDataUsada.Caption;

    fFinalizarHospedagemView.AbrirTelaFinalizacao(SuiteIDSelecionada, VeiculoIDSelecionado);

    fFinalizarHospedagemView.ShowModal;
  finally
    FreeAndNil(fFinalizarHospedagemView);
  end;
end;

procedure TfGestao.AbrirGestaoSuite(SuiteID: Integer);
var
  NumeroSuite: String;
begin
  SuiteIDSelecionada := SuiteID;

  with qryVeiculo do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT numero FROM suites WHERE id = :id');
    ParamByName('id').AsInteger := SuiteID;
    Open;

    if not IsEmpty then
      NumeroSuite := FieldByName('numero').AsString
    else
      NumeroSuite := 'Suíte não encontrada';
  end;

  lblSuiteUsada.Caption := NumeroSuite;

  with qryVeiculo do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT id, nome, marca, cor, placa, entrada ' +
            'FROM veiculos ' +
            'WHERE suite_id = :s AND saida IS NULL ' +
            'ORDER BY entrada DESC');
    ParamByName('s').AsInteger := SuiteID;
    Open;

    if not IsEmpty then
    begin
      VeiculoIDSelecionado := FieldByName('id').AsInteger;
      lblNomeUsado.Caption := FieldByName('nome').AsString;
      lblMarcaUsada.Caption := FieldByName('marca').AsString;
      lblCorUsada.Caption := FieldByName('cor').AsString;
      lblPlacaUsada.Caption := FieldByName('placa').AsString;
      lblDataUsada.Caption := FormatDateTime('dd/MM/yyyy hh:nn', FieldByName('entrada').AsDateTime);
    end
    else
    begin
      VeiculoIDSelecionado := 0;
      lblNomeUsado.Caption := '---';
      lblMarcaUsada.Caption := '---';
      lblCorUsada.Caption := '---';
      lblPlacaUsada.Caption := '---';
      lblDataUsada.Caption := '---';
    end;
  end;

  CarregarProdutosFrigobar;
  CarregarProdutosEstoque;
  CarregarServicos;
end;

procedure TfGestao.CarregarProdutosFrigobar;
begin
  with qryFrigobar do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT id, nome, preco_unitario, quantidade_estoque FROM produtos WHERE tipo = ''frigobar'' ORDER BY nome');
    Open;
  end;
end;

procedure TfGestao.CarregarProdutosEstoque;
begin
  with qryEstoque do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT id, nome, preco_unitario, quantidade_estoque FROM produtos WHERE tipo = ''estoque'' ORDER BY nome');
    Open;
  end;
end;

procedure TfGestao.CarregarServicos;
begin
  with qryServico do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT id, nome, preco FROM servicos ORDER BY nome');
    Open;
  end;
end;

procedure TfGestao.btnConsumoFrigobarClick(Sender: TObject);
begin
  if qryFrigobar.IsEmpty then
  begin
    ShowMessage('Nenhum produto selecionado.');
    Exit;
  end;

  if qryFrigobar.FieldByName('quantidade_estoque').AsInteger <= 0 then
  begin
    ShowMessage('Produto sem estoque disponível.');
    Exit;
  end;

  RegistrarConsumo('frigobar', qryFrigobar.FieldByName('id').AsInteger, qryFrigobar.FieldByName('preco_unitario').AsFloat);

  qryFrigobar.Edit;
  qryFrigobar.FieldByName('quantidade_estoque').AsInteger := qryFrigobar.FieldByName('quantidade_estoque').AsInteger - 1;
  qryFrigobar.Post;
end;

procedure TfGestao.btnConsumoEstoqueClick(Sender: TObject);
begin
  if qryEstoque.IsEmpty then
  begin
    ShowMessage('Nenhum produto selecionado.');
    Exit;
  end;

  if qryEstoque.FieldByName('quantidade_estoque').AsInteger <= 0 then
  begin
    ShowMessage('Produto sem estoque disponível.');
    Exit;
  end;

  RegistrarConsumo('estoque', qryEstoque.FieldByName('id').AsInteger, qryEstoque.FieldByName('preco_unitario').AsFloat);

  with qryConsumo do
  begin
    Close;
    SQL.Text := 'UPDATE produtos SET quantidade_estoque = quantidade_estoque - 1 WHERE id = :id';
    ParamByName('id').AsInteger := qryEstoque.FieldByName('id').AsInteger;
    ExecSQL;
  end;

  CarregarProdutosEstoque;
end;

procedure TfGestao.btnServicoClick(Sender: TObject);
begin
  if qryServico.IsEmpty then
  begin
    ShowMessage('Nenhum serviço selecionado.');
    Exit;
  end;

  RegistrarConsumo('servico', qryServico.FieldByName('id').AsInteger, qryServico.FieldByName('preco').AsFloat);
end;

procedure TfGestao.RegistrarConsumo(const Tipo: String; ItemID: Integer; ValorUnitario: Double);
begin
  with qryConsumo do
  begin
    Close;
    SQL.Clear;
    SQL.Add('INSERT INTO consumos (suite_id, veiculo_id, tipo, item_id, quantidade, valor, datahora) ' +
            'VALUES (:suite_id, :veiculo_id, :tipo, :item_id, :quantidade, :valor, NOW())');
    ParamByName('suite_id').AsInteger := SuiteIDSelecionada;
    ParamByName('veiculo_id').AsInteger := VeiculoIDSelecionado;
    ParamByName('tipo').AsString := Tipo;
    ParamByName('item_id').AsInteger := ItemID;
    ParamByName('quantidade').AsInteger := 1;
    ParamByName('valor').AsFloat := ValorUnitario;
    ExecSQL;
  end;

  ShowMessage('Item adicionado ao consumo.');
end;

end.


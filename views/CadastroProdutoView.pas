unit CadastroProdutoView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, dmUDM,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Grids, Vcl.DBGrids;

type
  TfCadastroProdutoView = class(TForm)
    pnlFundo: TPanel;
    gpbCadastroProdutos: TGroupBox;
    lblTitulo: TLabel;
    edtNomeProduto: TEdit;
    cbbTipo: TComboBox;
    edtQuantidade: TEdit;
    editPreco: TEdit;
    btnNovo: TButton;
    btnEditar: TButton;
    btnLimpar: TButton;
    btnExcluir: TButton;
    btnSalvar: TButton;
    dbgProdutos: TDBGrid;
    lblNomeProduto: TLabel;
    lblTipo: TLabel;
    lblQuantidade: TLabel;
    lblPreco: TLabel;
    queryProdutos: TFDQuery;
    dsProduto: TDataSource;
    queryProdutosid: TFDAutoIncField;
    queryProdutosnome: TWideStringField;
    queryProdutostipo: TWideStringField;
    queryProdutosquantidade_estoque: TIntegerField;
    queryProdutospreco_unitario: TBCDField;

    procedure FormShow(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbgProdutosCellClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
  private
    FModoEdicao: Boolean;
    procedure CarregarTipos;
    procedure AtualizarGrid;
    procedure LimparCampos;
    procedure HabilitarCampos(Habilitar: Boolean);
  public
  end;

var
  fCadastroProdutoView: TfCadastroProdutoView;

implementation

{$R *.dfm}


procedure TfCadastroProdutoView.FormCreate(Sender: TObject);
begin
  HabilitarCampos(False); // Desativa campos ao criar
end;




procedure TfCadastroProdutoView.FormShow(Sender: TObject);
begin
  CarregarTipos;
  AtualizarGrid;
  LimparCampos;
  HabilitarCampos(False);
end;

procedure TfCadastroProdutoView.CarregarTipos;
begin
  cbbTipo.Items.Clear;
  cbbTipo.Items.Add('frigobar');
  cbbTipo.Items.Add('estoque');
  cbbTipo.ItemIndex := -1;
end;

procedure TfCadastroProdutoView.AtualizarGrid;
begin
  queryProdutos.Close;
  queryProdutos.SQL.Text := 'SELECT * FROM produtos ORDER BY nome';
  queryProdutos.Open;
end;

procedure TfCadastroProdutoView.LimparCampos;
begin
  edtNomeProduto.Clear;
  cbbTipo.ItemIndex := -1;
  edtQuantidade.Clear;
  editPreco.Clear;
end;

procedure TfCadastroProdutoView.HabilitarCampos(Habilitar: Boolean);
begin
  edtNomeProduto.Enabled := Habilitar;
  cbbTipo.Enabled := Habilitar;
  edtQuantidade.Enabled := Habilitar;
  editPreco.Enabled := Habilitar;
end;

procedure TfCadastroProdutoView.btnNovoClick(Sender: TObject);
begin
  LimparCampos;
  HabilitarCampos(True);
  edtNomeProduto.SetFocus;
  FModoEdicao := False;
end;

procedure TfCadastroProdutoView.btnSalvarClick(Sender: TObject);
begin
  if Trim(edtNomeProduto.Text) = '' then
  begin
    ShowMessage('Informe o nome do produto.');
    Exit;
  end;

  if FModoEdicao then
    queryProdutos.Edit
  else
    queryProdutos.Append;

  queryProdutos.FieldByName('nome').AsString := edtNomeProduto.Text;
  queryProdutos.FieldByName('tipo').AsString := cbbTipo.Text;
  queryProdutos.FieldByName('quantidade_estoque').AsInteger := StrToIntDef(edtQuantidade.Text, 0);
  queryProdutos.FieldByName('preco_unitario').AsFloat := StrToFloatDef(editPreco.Text, 0);
  queryProdutos.Post;

  ShowMessage('Produto salvo com sucesso.');
  AtualizarGrid;
  LimparCampos;
  HabilitarCampos(False);
end;

procedure TfCadastroProdutoView.btnLimparClick(Sender: TObject);
begin
  LimparCampos;
end;

procedure TfCadastroProdutoView.btnEditarClick(Sender: TObject);
begin
  if not queryProdutos.IsEmpty then
  begin
    edtNomeProduto.Text := queryProdutos.FieldByName('nome').AsString;
    cbbTipo.ItemIndex := cbbTipo.Items.IndexOf(queryProdutos.FieldByName('tipo').AsString);
    edtQuantidade.Text := queryProdutos.FieldByName('quantidade_estoque').AsString;
    editPreco.Text := queryProdutos.FieldByName('preco_unitario').AsString;

    HabilitarCampos(True);
    edtNomeProduto.SetFocus;
    FModoEdicao := True;
  end
  else
    ShowMessage('Nenhum produto selecionado.');
end;

procedure TfCadastroProdutoView.btnExcluirClick(Sender: TObject);
begin
  if not queryProdutos.IsEmpty then
  begin
    if MessageDlg('Deseja realmente excluir este produto?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      queryProdutos.Delete;
      AtualizarGrid;
      LimparCampos;
      HabilitarCampos(False);
    end;
  end;
end;

procedure TfCadastroProdutoView.dbgProdutosCellClick(Column: TColumn);
begin
  edtNomeProduto.Text := queryProdutos.FieldByName('nome').AsString;
  cbbTipo.ItemIndex := cbbTipo.Items.IndexOf(queryProdutos.FieldByName('tipo').AsString);
  edtQuantidade.Text := queryProdutos.FieldByName('quantidade_estoque').AsString;
  editPreco.Text := queryProdutos.FieldByName('preco_unitario').AsString;
  HabilitarCampos(False);
end;

end.


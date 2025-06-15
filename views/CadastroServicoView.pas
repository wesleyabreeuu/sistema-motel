unit CadastroServicoView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.Client, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TfCadastroServicoView = class(TForm)
    pnlFundo: TPanel;
    lblTituloServ: TLabel;
    gpbServ: TGroupBox;
    lblNome: TLabel;
    lblPreco: TLabel;
    edtNome: TEdit;
    edtPreco: TEdit;
    btnNovo: TButton;
    btnEditar: TButton;
    btnLimpar: TButton;
    btnExcluir: TButton;
    btnSalvar: TButton;
    DBGrid1: TDBGrid;
    qryServicos: TFDQuery;
    dsServicos: TDataSource;

    procedure FormShow(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);

  private
    FIdServicoSelecionado: Integer;
    FModoEdicao: Boolean;
    procedure HabilitarCampos(Ativo: Boolean);
    procedure LimparCampos;
    procedure CarregarServicos;
  public
  end;

var
  fCadastroServicoView: TfCadastroServicoView;

implementation

{$R *.dfm}
uses
  dmUDM;

procedure TfCadastroServicoView.FormShow(Sender: TObject);
begin
  HabilitarCampos(False);
  LimparCampos;
  CarregarServicos;
end;

procedure TfCadastroServicoView.HabilitarCampos(Ativo: Boolean);
begin
  edtNome.Enabled := Ativo;
  edtPreco.Enabled := Ativo;
  btnSalvar.Enabled := Ativo;
end;

procedure TfCadastroServicoView.LimparCampos;
begin
  edtNome.Clear;
  edtPreco.Clear;
  FIdServicoSelecionado := 0;
end;

procedure TfCadastroServicoView.CarregarServicos;
begin
  qryServicos.Close;
  qryServicos.SQL.Text := 'SELECT * FROM servicos';
  qryServicos.Open;
  DBGrid1.DataSource := dsServicos;
end;

procedure TfCadastroServicoView.btnNovoClick(Sender: TObject);
begin
  HabilitarCampos(True);
  LimparCampos;
  FModoEdicao := False;
end;

procedure TfCadastroServicoView.btnLimparClick(Sender: TObject);
begin
  LimparCampos;
end;

procedure TfCadastroServicoView.btnEditarClick(Sender: TObject);
begin
  if FIdServicoSelecionado = 0 then
  begin
    ShowMessage('Selecione um serviço para editar.');
    Exit;
  end;

  HabilitarCampos(True);
  FModoEdicao := True;
end;

procedure TfCadastroServicoView.btnExcluirClick(Sender: TObject);
begin
  if FIdServicoSelecionado = 0 then
  begin
    ShowMessage('Selecione um serviço para excluir.');
    Exit;
  end;

  if MessageDlg('Deseja realmente excluir este serviço?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    qryServicos.SQL.Text := 'DELETE FROM servicos WHERE id = :id';
    qryServicos.ParamByName('id').AsInteger := FIdServicoSelecionado;
    qryServicos.ExecSQL;
    CarregarServicos;
    LimparCampos;
  end;
end;

procedure TfCadastroServicoView.btnSalvarClick(Sender: TObject);
begin
  if (edtNome.Text = '') or (edtPreco.Text = '') then
  begin
    ShowMessage('Preencha todos os campos.');
    Exit;
  end;

  if FModoEdicao then
  begin
    qryServicos.SQL.Text :=
      'UPDATE servicos SET nome = :nome, preco = :preco WHERE id = :id';
    qryServicos.ParamByName('id').AsInteger := FIdServicoSelecionado;
  end
  else
  begin
    qryServicos.SQL.Text :=
      'INSERT INTO servicos (nome, preco) VALUES (:nome, :preco)';
  end;

  qryServicos.ParamByName('nome').AsString := edtNome.Text;
  qryServicos.ParamByName('preco').AsFloat := StrToFloatDef(edtPreco.Text, 0);

  qryServicos.ExecSQL;

  ShowMessage('Serviço salvo com sucesso!');
  CarregarServicos;
  LimparCampos;
  HabilitarCampos(False);
end;

procedure TfCadastroServicoView.DBGrid1CellClick(Column: TColumn);
begin
  if not qryServicos.IsEmpty then
  begin
    FIdServicoSelecionado := qryServicos.FieldByName('id').AsInteger;
    edtNome.Text := qryServicos.FieldByName('nome').AsString;
    edtPreco.Text := qryServicos.FieldByName('preco').AsString;
  end;
end;

end.


unit CadastroUsuariosView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.Client, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TfCadastroUsuarioView = class(TForm)
    pnlFundo: TPanel;
    lblTituloUsuario: TLabel;
    gpbUsuarios: TGroupBox;
    lblNome: TLabel;
    lblLogin: TLabel;
    lblSenha: TLabel;
    lblTIpo: TLabel;
    edtNome: TEdit;
    edtLogin: TEdit;
    edtSenha: TEdit;
    cbbTipo: TComboBox;
    btnNovo: TButton;
    btnEditar: TButton;
    btnLimpar: TButton;
    btnExcluir: TButton;
    btnSalvar: TButton;
    DBGrid1: TDBGrid;
    qryUsuarios: TFDQuery;
    dsUsuarios: TDataSource;

    procedure FormShow(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);

  private
    FModoEdicao: Boolean;
    FIdUsuarioSelecionado: Integer;
    procedure HabilitarCampos(Ativo: Boolean);
    procedure LimparCampos;
    procedure CarregarUsuarios;
  public
  end;

var
  fCadastroUsuarioView: TfCadastroUsuarioView;

implementation

  uses LoginView;


{$R *.dfm}

procedure TfCadastroUsuarioView.FormShow(Sender: TObject);
begin
  // Verificação de permissão
  if SameText(TipoUsuarioLogado, 'Usuário') then
  begin
    MessageDlg('Você não tem autorização para acessar esta tela.', mtWarning, [mbOK], 0);
    Close;
    Exit;
  end;

  // Preencher o ComboBox de tipo se ainda não estiver preenchido
  if cbbTipo.Items.Count = 0 then
  begin
    cbbTipo.Items.Add('Administrador');
    cbbTipo.Items.Add('Usuário');
  end;

  HabilitarCampos(False);
  LimparCampos;
  CarregarUsuarios;
end;


procedure TfCadastroUsuarioView.HabilitarCampos(Ativo: Boolean);
begin
  edtNome.Enabled := Ativo;
  edtLogin.Enabled := Ativo;
  edtSenha.Enabled := Ativo;
  cbbTipo.Enabled := Ativo;
  btnSalvar.Enabled := Ativo;
end;

procedure TfCadastroUsuarioView.LimparCampos;
begin
  edtNome.Clear;
  edtLogin.Clear;
  edtSenha.Clear;
  cbbTipo.ItemIndex := -1;
  FIdUsuarioSelecionado := 0;
end;

procedure TfCadastroUsuarioView.CarregarUsuarios;
begin
  qryUsuarios.Close;
  qryUsuarios.SQL.Text := 'SELECT * FROM usuarios';
  qryUsuarios.Open;

 // Oculta a coluna 'senha'
  DBGrid1.DataSource := dsUsuarios;
end;

procedure TfCadastroUsuarioView.btnNovoClick(Sender: TObject);
begin
  HabilitarCampos(True);
  LimparCampos;
  FModoEdicao := False;
end;

procedure TfCadastroUsuarioView.btnEditarClick(Sender: TObject);
begin
  if FIdUsuarioSelecionado = 0 then
  begin
    ShowMessage('Selecione um usuário para editar.');
    Exit;
  end;

  HabilitarCampos(True);
  FModoEdicao := True;
end;

procedure TfCadastroUsuarioView.btnLimparClick(Sender: TObject);
begin
  LimparCampos;
end;

procedure TfCadastroUsuarioView.btnExcluirClick(Sender: TObject);
begin
  if FIdUsuarioSelecionado = 0 then
  begin
    ShowMessage('Selecione um usuário para excluir.');
    Exit;
  end;

  if MessageDlg('Deseja realmente excluir este usuário?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    qryUsuarios.SQL.Text := 'DELETE FROM usuarios WHERE id = :id';
    qryUsuarios.ParamByName('id').AsInteger := FIdUsuarioSelecionado;
    qryUsuarios.ExecSQL;
    CarregarUsuarios;
    LimparCampos;
  end;
end;

procedure TfCadastroUsuarioView.btnSalvarClick(Sender: TObject);
begin
  if (edtNome.Text = '') or (edtLogin.Text = '') or (edtSenha.Text = '') or (cbbTipo.ItemIndex = -1) then
  begin
    ShowMessage('Preencha todos os campos.');
    Exit;
  end;

  if FModoEdicao then
  begin
    // UPDATE
    qryUsuarios.SQL.Text :=
      'UPDATE usuarios SET nome = :nome, login = :login, senha = :senha, tipo = :tipo WHERE id = :id';
    qryUsuarios.ParamByName('id').AsInteger := FIdUsuarioSelecionado;
  end
  else
  begin
    // INSERT
    qryUsuarios.SQL.Text :=
      'INSERT INTO usuarios (nome, login, senha, tipo) VALUES (:nome, :login, :senha, :tipo)';
  end;

  qryUsuarios.ParamByName('nome').AsString := edtNome.Text;
  qryUsuarios.ParamByName('login').AsString := edtLogin.Text;
  qryUsuarios.ParamByName('senha').AsString := edtSenha.Text;
  qryUsuarios.ParamByName('tipo').AsString := cbbTipo.Text;

  qryUsuarios.ExecSQL;

  ShowMessage('Usuário salvo com sucesso!');
  CarregarUsuarios;
  LimparCampos;
  HabilitarCampos(False);
end;

procedure TfCadastroUsuarioView.DBGrid1CellClick(Column: TColumn);
begin
  if not qryUsuarios.IsEmpty then
  begin
    FIdUsuarioSelecionado := qryUsuarios.FieldByName('id').AsInteger;
    edtNome.Text := qryUsuarios.FieldByName('nome').AsString;
    edtLogin.Text := qryUsuarios.FieldByName('login').AsString;
    edtSenha.Text := qryUsuarios.FieldByName('senha').AsString;
    cbbTipo.ItemIndex := cbbTipo.Items.IndexOf(qryUsuarios.FieldByName('tipo').AsString);
  end;
end;


end.


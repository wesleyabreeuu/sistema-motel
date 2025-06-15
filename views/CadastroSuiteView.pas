unit CadastroSuiteView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.Generics.Collections, System.UITypes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB, FireDAC.Comp.Client,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TSuite = record
    Numero: string;
    Nome: string;
    Preco: Double;
    Status: string;
  end;

  TfCadastroSuiteView = class(TForm)
    pnlFundo: TPanel;
    lblTitulo: TLabel;
    gpbCadastroSuites: TGroupBox;
    lblNumeroSuite: TLabel;
    lblNomeSuite: TLabel;
    lblPreco: TLabel;
    lblStatus: TLabel;
    edtNumero: TEdit;
    edtNome: TEdit;
    ediPreco: TEdit;
    cbbStatus: TComboBox;
    btnNovo: TButton;
    btnEditar: TButton;
    btnLimpar: TButton;
    btnExcluir: TButton;
    btnSalvar: TButton;
    grdSuites: TDBGrid;
    qrySuites: TFDQuery;
    dsSuites: TDataSource;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure grdSuitesCellClick(Column: TColumn);
  private
    FSuites: TList<TSuite>;
    FSelecionado: Integer;
    procedure AtualizarGrid;
    procedure LimparCampos;
    procedure CarregarStatus;
    procedure HabilitarCampos;
    procedure DesabilitarCampos;
  public
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  end;

var
  fCadastroSuiteView: TfCadastroSuiteView;

implementation

{$R *.dfm}

uses
  dmUDM; // Certifique-se de que o DataModule esteja no uses da implementação

procedure TfCadastroSuiteView.CarregarStatus;
begin
  cbbStatus.Items.Clear;
  cbbStatus.Items.Add('Disponível');
  cbbStatus.Items.Add('Ocupada');
end;

procedure TfCadastroSuiteView.HabilitarCampos;
begin
  edtNumero.Enabled := True;
  edtNome.Enabled := True;
  ediPreco.Enabled := True;
  cbbStatus.Enabled := True;
end;

procedure TfCadastroSuiteView.DesabilitarCampos;
begin
  edtNumero.Enabled := False;
  edtNome.Enabled := False;
  ediPreco.Enabled := False;
  cbbStatus.Enabled := False;
end;

procedure TfCadastroSuiteView.FormCreate(Sender: TObject);
begin
    // Configura a conexão do componente aqui na criação
  qrySuites.Connection := uDM.FDConnection;

  FSuites := TList<TSuite>.Create;
  CarregarStatus;
  FSelecionado := -1;
  DesabilitarCampos;


end;

procedure TfCadastroSuiteView.AtualizarGrid;
begin
  if qrySuites.Active then
    qrySuites.Close;

  qrySuites.SQL.Text := 'SELECT * FROM suites';
  qrySuites.Open;
end;


procedure TfCadastroSuiteView.LimparCampos;
begin
  edtNumero.Clear;
  edtNome.Clear;
  ediPreco.Clear;
  cbbStatus.ItemIndex := -1;
  FSelecionado := -1;
end;

procedure TfCadastroSuiteView.btnNovoClick(Sender: TObject);
begin
  HabilitarCampos;
  LimparCampos;
  edtNumero.SetFocus;
end;

procedure TfCadastroSuiteView.btnLimparClick(Sender: TObject);
begin
  LimparCampos;
end;

procedure TfCadastroSuiteView.btnSalvarClick(Sender: TObject);
begin
  if not qrySuites.Active then
    qrySuites.Open;

  qrySuites.Append;
  qrySuites.FieldByName('numero').AsString := edtNumero.Text;
  qrySuites.FieldByName('nome').AsString := edtNome.Text;
  qrySuites.FieldByName('preco_hora').AsFloat := StrToFloatDef(ediPreco.Text, 0);
  qrySuites.FieldByName('status').AsString := cbbStatus.Text;
  qrySuites.Post;

  ShowMessage('Suíte salva com sucesso!');
  qrySuites.Refresh;

  LimparCampos;
  DesabilitarCampos;
end;

procedure TfCadastroSuiteView.grdSuitesCellClick(Column: TColumn);
begin
  edtNumero.Text := qrySuites.FieldByName('numero').AsString;
  edtNome.Text   := qrySuites.FieldByName('nome').AsString;
  ediPreco.Text  := qrySuites.FieldByName('preco_hora').AsString;
  cbbStatus.Text := qrySuites.FieldByName('status').AsString;
end;

procedure TfCadastroSuiteView.btnExcluirClick(Sender: TObject);
begin
  if not qrySuites.IsEmpty then
  begin
    if MessageDlg('Tem certeza que deseja excluir esta suíte?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      qrySuites.Delete;
      qrySuites.Refresh;
    end;
  end;
end;

procedure TfCadastroSuiteView.btnEditarClick(Sender: TObject);
begin
  if not qrySuites.IsEmpty then
  begin
    HabilitarCampos;
    edtNumero.Text := qrySuites.FieldByName('numero').AsString;
    edtNome.Text := qrySuites.FieldByName('nome').AsString;
    ediPreco.Text := qrySuites.FieldByName('preco_hora').AsString;
    cbbStatus.ItemIndex := cbbStatus.Items.IndexOf(qrySuites.FieldByName('status').AsString);
  end;
end;

procedure TfCadastroSuiteView.FormShow(Sender: TObject);
begin
  if not qrySuites.Active then
  begin
    qrySuites.SQL.Text := 'SELECT * FROM suites';
    qrySuites.Open;
  end;

  // Corrige: garante que os campos estejam sempre desabilitados ao abrir
  LimparCampos;
  DesabilitarCampos;
end;

procedure TfCadastroSuiteView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  LimparCampos;
  DesabilitarCampos;
end;



end.

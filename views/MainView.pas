unit MainView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls, CadastroSuiteView, dmUDM,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, EntradaView, RelatorioFinanceiroView , CadastroProdutoView, RelatorioConsumosView, ContasAPagarView, RelatorioMovimentosView, CadastroServicoView, CadastroUsuariosView, GestaoView;

type
  TfrmMainView = class(TForm)
    pnlBackground: TPanel;
    fMainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    Cadastros2: TMenuItem;
    Servios1: TMenuItem;
    Servios2: TMenuItem;
    Suites1: TMenuItem;
    Suites2: TMenuItem;
    Servios3: TMenuItem;
    Servios4: TMenuItem;
    Movimento1: TMenuItem;
    Movimento2: TMenuItem;
    Financeiro1: TMenuItem;
    Contasapagarareceber1: TMenuItem;
    Sobre1: TMenuItem;
    qrySuitesMain: TFDQuery;
    tmrInicial: TTimer;

    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Suites1Click(Sender: TObject);
    procedure tmrInicialTimer(Sender: TObject);
    procedure Suites2Click(Sender: TObject);
    procedure Servios3Click(Sender: TObject);
    procedure Servios4Click(Sender: TObject);
    procedure Movimento1Click(Sender: TObject);
    procedure Movimento2Click(Sender: TObject);
    procedure Contasapagarareceber1Click(Sender: TObject);
    procedure Financeiro1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Sobre1Click(Sender: TObject);
  public
    procedure CarregarSuites;
    procedure SuiteClick(Sender: TObject);
  private
    procedure AtualizarPainelSuítes(Sender: TObject);
  end;

var
  frmMainView: TfrmMainView;

implementation

uses LoginView;

{$R *.dfm}

procedure TfrmMainView.FormActivate(Sender: TObject);
begin
  pnlBackground.DestroyComponents;
  CarregarSuites;
end;

procedure TfrmMainView.FormCreate(Sender: TObject);
begin
  if not Assigned(uDM) then Exit;

  qrySuitesMain.Connection := uDM.FDConnection;

  if not uDM.FDConnection.Connected then
    uDM.FDConnection.Connected := True;
end;

procedure TfrmMainView.FormShow(Sender: TObject);
begin
  if not Assigned(uDM) then
  begin
    ShowMessage('DataModule não carregado.');
    Exit;
  end;

  if not uDM.FDConnection.Connected then
  begin
    try
      uDM.FDConnection.Connected := True;
    except
      on E: Exception do
      begin
        ShowMessage('Erro ao conectar ao banco de dados: ' + E.Message);
        Exit;
      end;
    end;
  end;

  tmrInicial.Enabled := True;
end;

procedure TfrmMainView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  Halt(0); // Encerra forçadamente o processo para evitar travamento do .exe
end;

procedure TfrmMainView.Suites1Click(Sender: TObject);
var
  form: TfCadastroSuiteView;
begin
  form := TfCadastroSuiteView.Create(nil);
  try
    form.ShowModal;
  finally
    form.Free;
  end;

  pnlBackground.DestroyComponents;
  CarregarSuites;
end;

procedure TfrmMainView.Suites2Click(Sender: TObject);
begin
  if not Assigned(fCadastroProdutoView) then
    Application.CreateForm(TfCadastroProdutoView, fCadastroProdutoView);

  fCadastroProdutoView.ShowModal;
end;

procedure TfrmMainView.Servios3Click(Sender: TObject);
begin
  if not Assigned(fCadastroServicoView) then
    Application.CreateForm(TfCadastroServicoView, fCadastroServicoView);

  fCadastroServicoView.ShowModal;
end;

procedure TfrmMainView.Servios4Click(Sender: TObject);
begin
  if SameText(TipoUsuarioLogado, 'Usuário') then
  begin
    MessageDlg('Você não tem autorização para acessar esta tela.', mtWarning, [mbOK], 0);
    Exit;
  end;

  if not Assigned(fCadastroUsuarioView) then
    Application.CreateForm(TfCadastroUsuarioView, fCadastroUsuarioView);

  fCadastroUsuarioView.ShowModal;
end;

procedure TfrmMainView.Sobre1Click(Sender: TObject);
begin
    ShowMessage(
    'Love''s Motel - Sistema de Gestão de Motel' + sLineBreak +
    'Versão: 1.0.0' + sLineBreak +
    'Desenvolvido por: Wesley Abreu Soluções Digitais' + sLineBreak +
    'Tecnologia: Delphi 12 + MySQL' + sLineBreak +
    'Contato: (35)99194-7159' + sLineBreak +
    sLineBreak +
    'Todos os direitos reservados © 2025'
  );
end;

procedure TfrmMainView.Movimento1Click(Sender: TObject);
begin
  if not Assigned(fRelatorioMovimentosView) then
    Application.CreateForm(TfRelatorioMovimentosView, fRelatorioMovimentosView);

  fRelatorioMovimentosView.ShowModal;
end;

procedure TfrmMainView.Movimento2Click(Sender: TObject);
begin
  if not Assigned(fRelatorioConsumosView) then
    Application.CreateForm(TfRelatorioConsumosView, fRelatorioConsumosView);

  fRelatorioConsumosView.ShowModal;
end;

procedure TfrmMainView.Contasapagarareceber1Click(Sender: TObject);
begin
  if not Assigned(fContasAPagarView) then
    Application.CreateForm(TfContasAPagarView, fContasAPagarView);

  fContasAPagarView.ShowModal;
end;

procedure TfrmMainView.Financeiro1Click(Sender: TObject);
begin
  if not Assigned(fRelatorioFinanceiroView) then
    Application.CreateForm(TfRelatorioFinanceiroView, fRelatorioFinanceiroView);

  fRelatorioFinanceiroView.ShowModal;
end;

procedure TfrmMainView.CarregarSuites;
var
  suitePanel: TPanel;
  x, y: Integer;
  col, row: Integer;
  panelWidth, panelHeight, spacing, totalCols: Integer;
begin
  if not Assigned(uDM) then Exit;

  if not uDM.FDConnection.Connected then
    uDM.FDConnection.Connected := True;

  qrySuitesMain.Close;
  qrySuitesMain.Connection := uDM.FDConnection;
  qrySuitesMain.SQL.Text := 'SELECT id, numero, status FROM suites ORDER BY numero';
  qrySuitesMain.Open;

  totalCols := 5;
  spacing := 15;
  panelHeight := 80;
  panelWidth := (pnlBackground.Width - (spacing * (totalCols + 1))) div totalCols;

  col := 0;
  row := 0;

  while not qrySuitesMain.Eof do
  begin
    suitePanel := TPanel.Create(Self);
    suitePanel.Parent := pnlBackground;
    suitePanel.Width := panelWidth;
    suitePanel.Height := panelHeight;
    suitePanel.Left := spacing + (col * (panelWidth + spacing));
    suitePanel.Top := spacing + (row * (panelHeight + spacing));
    suitePanel.Caption := 'Suíte ' + qrySuitesMain.FieldByName('numero').AsString;
    suitePanel.Tag := qrySuitesMain.FieldByName('id').AsInteger;
    suitePanel.Alignment := taCenter;
    suitePanel.Font.Size := 10;
    suitePanel.Font.Style := [fsBold];
    suitePanel.OnClick := SuiteClick;
    suitePanel.StyleElements := [];

    if SameText(qrySuitesMain.FieldByName('status').AsString, 'Ocupada') then
      suitePanel.Color := clRed
    else
      suitePanel.Color := clLime;

    Inc(col);
    if col >= totalCols then
    begin
      col := 0;
      Inc(row);
    end;

    qrySuitesMain.Next;
  end;
end;

procedure TfrmMainView.SuiteClick(Sender: TObject);
var
  suiteID: Integer;
begin
  suiteID := TPanel(Sender).Tag;

  if TPanel(Sender).Color = clLime then
  begin
    Application.CreateForm(TfrmEntradaView, frmEntradaView);
    frmEntradaView.SuiteNumero := suiteID;
    frmEntradaView.OnAfterEntradaSalva := AtualizarPainelSuítes;
    frmEntradaView.ShowModal;
    FreeAndNil(frmEntradaView);
  end
  else
  begin
    Application.CreateForm(TfGestao, fGestao);
    try
      fGestao.AbrirGestaoSuite(suiteID);
      fGestao.ShowModal;
    finally
      FreeAndNil(fGestao);
    end;
  end;

  pnlBackground.DestroyComponents;
  CarregarSuites;
end;

procedure TfrmMainView.tmrInicialTimer(Sender: TObject);
begin
  tmrInicial.Enabled := False;
  pnlBackground.DestroyComponents;
  CarregarSuites;
end;

procedure TfrmMainView.AtualizarPainelSuítes(Sender: TObject);
begin
  pnlBackground.DestroyComponents;
  CarregarSuites;
end;

end.


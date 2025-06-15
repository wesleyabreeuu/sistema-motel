unit LoginView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TfLoginView = class(TForm)
    pnlFundo: TPanel;
    gppLogin: TGroupBox;
    lblTitulo1: TLabel;
    lblTitulo2: TLabel;
    lblLogin: TLabel;
    lblSenha: TLabel;
    edtLogin: TEdit;
    edtSenha: TEdit;
    btnEntrar: TButton;
    qryLogin: TFDQuery;

    procedure btnEntrarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure RealizarLogin;
  public
  end;

var
  fLoginView: TfLoginView;
  UsuarioLogado: string;
  TipoUsuarioLogado: string;

implementation

uses MainView, dmUDM;

{$R *.dfm}

procedure TfLoginView.FormShow(Sender: TObject);
begin
  edtLogin.Clear;
  edtSenha.Clear;
  edtLogin.SetFocus;
end;

procedure TfLoginView.btnEntrarClick(Sender: TObject);
begin
  RealizarLogin;
end;

procedure TfLoginView.RealizarLogin;
begin
  with qryLogin do
  begin
    Close;
    SQL.Text := 'SELECT * FROM usuarios WHERE login = :login AND senha = :senha';
    ParamByName('login').AsString := Trim(edtLogin.Text);
    ParamByName('senha').AsString := Trim(edtSenha.Text);
    Open;

    if not IsEmpty then
    begin
      UsuarioLogado := FieldByName('nome').AsString;
      TipoUsuarioLogado := FieldByName('tipo').AsString;

      ShowMessage('Seja bem-vindo, ' + UsuarioLogado + '!');
      fLoginView.Hide;
      Application.CreateForm(TfrmMainView, frmMainView);
      frmMainView.Show;
    end
    else
    begin
      MessageDlg('Dados incorretos. Tente novamente.', mtError, [mbOK], 0);
    end;
  end;
end;

end.


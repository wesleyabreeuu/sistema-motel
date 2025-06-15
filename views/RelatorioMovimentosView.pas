unit RelatorioMovimentosView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.Mask, Vcl.ComCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Printers;

type
  TfRelatorioMovimentosView = class(TForm)
    pnlFundo: TPanel;
    Label1: TLabel;
    gppCabecalho: TGroupBox;
    lblDataInicial: TLabel;
    lbldataFinal: TLabel;
    lblTurno: TLabel;
    lblHorarioInicial: TLabel;
    lblHorarioFinal: TLabel;
    lblUsuario: TLabel;
    lblPlaca: TLabel;
    lblSuite: TLabel;
    dtpInicio: TDateTimePicker;
    dtpFim: TDateTimePicker;
    medtHoraInicio: TMaskEdit;
    medtHoraFim: TMaskEdit;
    cbbTurno: TComboBox;
    cbbUsuario: TComboBox;
    cbbSuite: TComboBox;
    edtPlaca: TEdit;
    btnFiltrar: TButton;
    DBGrid1: TDBGrid;
    dsMovimentos: TDataSource;
    btnImprimir: TButton;
    qryMovimentos: TFDQuery;


    procedure FormShow(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);

  private
    procedure AplicarFiltros;
    function HoraValida(HoraStr: string): Boolean;
  public
  end;

var
  fRelatorioMovimentosView: TfRelatorioMovimentosView;

implementation

{$R *.dfm}
uses dmUDM, LoginView;

procedure TfRelatorioMovimentosView.FormShow(Sender: TObject);
begin
  if SameText(TipoUsuarioLogado, 'Usuário') then
  begin
    MessageDlg('Você não tem autorização para acessar esta tela.', mtWarning, [mbOK], 0);
    Close;
    Exit;
  end;

  cbbTurno.Items.Clear;
  cbbTurno.Items.Add('Todos');
  cbbTurno.Items.Add('Manhã');
  cbbTurno.Items.Add('Tarde');
  cbbTurno.Items.Add('Noite');
  cbbTurno.Items.Add('Madrugada');
  cbbTurno.ItemIndex := 0;

  cbbUsuario.Items.Clear;
  qryMovimentos.Close;
  qryMovimentos.Connection := uDM.FDConnection;
  qryMovimentos.SQL.Text := 'SELECT id, nome FROM usuarios';
  qryMovimentos.Open;
  cbbUsuario.Items.AddObject('Todos', TObject(0));
  while not qryMovimentos.Eof do
  begin
    cbbUsuario.Items.AddObject(qryMovimentos.FieldByName('nome').AsString, TObject(qryMovimentos.FieldByName('id').AsInteger));
    qryMovimentos.Next;
  end;
  cbbUsuario.ItemIndex := 0;

  cbbSuite.Items.Clear;
  qryMovimentos.Close;
  qryMovimentos.SQL.Text := 'SELECT id, nome FROM suites';
  qryMovimentos.Open;
  cbbSuite.Items.AddObject('Todas', TObject(0));
  while not qryMovimentos.Eof do
  begin
    cbbSuite.Items.AddObject(qryMovimentos.FieldByName('nome').AsString, TObject(qryMovimentos.FieldByName('id').AsInteger));
    qryMovimentos.Next;
  end;
  cbbSuite.ItemIndex := 0;
end;

function TfRelatorioMovimentosView.HoraValida(HoraStr: string): Boolean;
var
  Dummy: TDateTime;
begin
  Result := TryStrToTime(HoraStr, Dummy);
end;

procedure TfRelatorioMovimentosView.btnFiltrarClick(Sender: TObject);
begin
  AplicarFiltros;
end;

procedure TfRelatorioMovimentosView.AplicarFiltros;
var
  SQL, turnoCond: string;
  dataIni, dataFim, horaIni, horaFim, placa: string;
  idUsuario, idSuite: Integer;
begin
  dataIni := FormatDateTime('yyyy-mm-dd', dtpInicio.Date);
  dataFim := FormatDateTime('yyyy-mm-dd', dtpFim.Date);
  horaIni := Trim(medtHoraInicio.Text);
  horaFim := Trim(medtHoraFim.Text);
  placa := Trim(edtPlaca.Text);
  idUsuario := Integer(cbbUsuario.Items.Objects[cbbUsuario.ItemIndex]);
  idSuite := Integer(cbbSuite.Items.Objects[cbbSuite.ItemIndex]);

  SQL := 'SELECT v.entrada, v.saida, v.placa, v.nome AS cliente, ' +
         's.nome AS suite, u.nome AS usuario ' +
         'FROM veiculos v ' +
         'LEFT JOIN suites s ON s.id = v.suite_id ' +
         'LEFT JOIN usuarios u ON u.id = v.usuario_id ' +
         'WHERE DATE(v.entrada) BETWEEN :dataIni AND :dataFim ';

  if idUsuario > 0 then
    SQL := SQL + 'AND v.usuario_id = :idUsuario ';

  if idSuite > 0 then
    SQL := SQL + 'AND v.suite_id = :idSuite ';

  if placa <> '' then
    SQL := SQL + 'AND v.placa LIKE :placa ';

  if cbbTurno.ItemIndex > 0 then
  begin
    case cbbTurno.ItemIndex of
      1: turnoCond := 'AND TIME(v.entrada) BETWEEN "06:00:00" AND "12:00:00" ';
      2: turnoCond := 'AND TIME(v.entrada) BETWEEN "12:00:01" AND "18:00:00" ';
      3: turnoCond := 'AND TIME(v.entrada) BETWEEN "18:00:01" AND "23:59:59" ';
      4: turnoCond := 'AND TIME(v.entrada) BETWEEN "00:00:00" AND "05:59:59" ';
    end;
    SQL := SQL + turnoCond;
  end;

  if HoraValida(horaIni) and HoraValida(horaFim) then
    SQL := SQL + 'AND TIME(v.entrada) BETWEEN :horaIni AND :horaFim ';

  qryMovimentos.Close;
  qryMovimentos.SQL.Text := SQL;
  qryMovimentos.ParamByName('dataIni').AsDate := dtpInicio.Date;
  qryMovimentos.ParamByName('dataFim').AsDate := dtpFim.Date;

  if idUsuario > 0 then
    qryMovimentos.ParamByName('idUsuario').AsInteger := idUsuario;

  if idSuite > 0 then
    qryMovimentos.ParamByName('idSuite').AsInteger := idSuite;

  if placa <> '' then
    qryMovimentos.ParamByName('placa').AsString := '%' + placa + '%';

  if HoraValida(horaIni) and HoraValida(horaFim) then
  begin
    qryMovimentos.ParamByName('horaIni').AsTime := StrToTime(horaIni);
    qryMovimentos.ParamByName('horaFim').AsTime := StrToTime(horaFim);
  end;

  qryMovimentos.Open;
end;

procedure TfRelatorioMovimentosView.btnImprimirClick(Sender: TObject);
var
  SL: TStringList;
  i, y: Integer;
begin
  if qryMovimentos.IsEmpty then
  begin
    ShowMessage('Nenhum dado para imprimir. Faça um filtro primeiro.');
    Exit;
  end;

  SL := TStringList.Create;
  try
    SL.Add('============== RELATÓRIO DE MOVIMENTOS =============');
    SL.Add('Período: ' + FormatDateTime('dd/MM/yyyy', dtpInicio.Date) + ' a ' + FormatDateTime('dd/MM/yyyy', dtpFim.Date));
    SL.Add('----------------------------------------------------');
    SL.Add('Entrada   | Saída     | Placa    | Cliente      | Suíte | Usuário');
    SL.Add('----------------------------------------------------');

    qryMovimentos.First;
    while not qryMovimentos.Eof do
    begin
      SL.Add(
        FormatDateTime('dd/MM HH:nn', qryMovimentos.FieldByName('entrada').AsDateTime) + ' | ' +
        FormatDateTime('dd/MM HH:nn', qryMovimentos.FieldByName('saida').AsDateTime) + ' | ' +
        qryMovimentos.FieldByName('placa').AsString + ' | ' +
        Copy(qryMovimentos.FieldByName('cliente').AsString, 1, 12) + ' | ' +
        qryMovimentos.FieldByName('suite').AsString + ' | ' +
        qryMovimentos.FieldByName('usuario').AsString
      );
      qryMovimentos.Next;
    end;

    SL.Add('====================================================');
    SL.Add('Impresso em: ' + FormatDateTime('dd/MM/yyyy HH:nn', Now));
    SL.Add('====================================================');

    Printer.Title := 'Relatório de Movimentos';
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

    ShowMessage('Relatório enviado para a impressora.');

  finally
    SL.Free;
  end;
end;

end.


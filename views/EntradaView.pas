unit EntradaView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB,
  FireDAC.Comp.Client, dmUDM, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TfrmEntradaView = class(TForm)
    pnlBackgroundEntrada: TPanel;
    lblTitulo: TLabel;
    lblSuite: TLabel;
    lblNomeVeiculo: TLabel;
    lblMarcaVeiculo: TLabel;
    lblCorVeiculo: TLabel;
    lblPlacaVeiculo: TLabel;
    cbMarca: TComboBox;
    cbNomeVeiculo: TComboBox;
    edtCorVeiculo: TEdit;
    edtPlaca: TEdit;
    lblHorarioEntrada: TLabel;
    lblHorarioValor: TLabel;
    btnSalvar: TButton;
    btnLimpar: TButton;
    qryEntrada: TFDQuery;

    procedure FormShow(Sender: TObject);
    procedure cbMarcaChange(Sender: TObject);
    procedure lblHorarioValorClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
  private
    { Private declarations }
  public
    SuiteNumero: Integer;
    OnAfterEntradaSalva: TNotifyEvent;
  end;

var
  frmEntradaView: TfrmEntradaView;

implementation

{$R *.dfm}

uses
  MainView, Printers; // <- Adicionado para chamar o OnActivate

procedure TfrmEntradaView.FormShow(Sender: TObject);
begin
  lblHorarioValor.Caption := FormatDateTime('dd/mm/yyyy hh:nn:ss', Now);
  cbMarca.ItemIndex := -1;
  cbNomeVeiculo.ItemIndex := -1;
  cbNomeVeiculo.Items.Clear;
  edtCorVeiculo.Clear;
  edtPlaca.Clear;

    // LIMPAR E CARREGAR AS MARCAS
  cbMarca.Items.Clear;
  cbMarca.Items.Add('Chevrolet');
  cbMarca.Items.Add('Fiat');
  cbMarca.Items.Add('Volkswagen');
  cbMarca.Items.Add('Hyundai');
  cbMarca.Items.Add('Honda');
  cbMarca.Items.Add('Renault');
  cbMarca.Items.Add('Ford');
  cbMarca.Items.Add('Nissan');
  cbMarca.Items.Add('Jeep');
  cbMarca.Items.Add('Peugeot');
  cbMarca.Items.Add('Citroen');
  cbMarca.Items.Add('Kia');
  cbMarca.Items.Add('Mitsubishi');
  cbMarca.Items.Add('BMW');
  cbMarca.Items.Add('Mercedes-Benz');
  cbMarca.Items.Add('Audi');
  cbMarca.Items.Add('Volvo');
  cbMarca.Items.Add('Land Rover');
  cbMarca.Items.Add('Chery');
  cbMarca.Items.Add('JAC Motors');
  cbMarca.Items.Add('BYD');
  cbMarca.Items.Add('GWM');
  cbMarca.Items.Add('Porsche');
  cbMarca.Items.Add('Lexus');
  cbMarca.Items.Add('Mini');
  cbMarca.Items.Add('RAM');
  cbMarca.Items.Add('Iveco');
  cbMarca.Items.Add('Subaru');
  cbMarca.Items.Add('Toyota');
end;

procedure TfrmEntradaView.lblHorarioValorClick(Sender: TObject);
begin
  lblHorarioValor.Caption := FormatDateTime('dd/mm/yyyy hh:nn:ss', Now);
end;

procedure TfrmEntradaView.btnLimparClick(Sender: TObject);
begin
  cbMarca.ItemIndex := -1;
  cbNomeVeiculo.Clear;
  cbNomeVeiculo.ItemIndex := -1;
  edtCorVeiculo.Clear;
  edtPlaca.Clear;
  lblHorarioValor.Caption := FormatDateTime('dd/mm/yyyy hh:nn:ss', Now);
end;

procedure TfrmEntradaView.btnSalvarClick(Sender: TObject);
var
  qry: TFDQuery;
  horarioAtual: TDateTime;
  SL: TStringList;
  i, y: Integer;
  numeroSuite: string;
begin
  if (cbMarca.ItemIndex = -1) or (cbNomeVeiculo.ItemIndex = -1) or
     (Trim(edtPlaca.Text) = '') then
  begin
    ShowMessage('Preencha os campos obrigatórios: Marca, Veículo e Placa.');
    Exit;
  end;

  horarioAtual := Now;
  lblHorarioValor.Caption := FormatDateTime('dd/mm/yyyy hh:nn:ss', horarioAtual);

  qry := TFDQuery.Create(nil);
  try
    qry.Connection := uDM.FDConnection;

    qry.SQL.Text :=
      'INSERT INTO veiculos (suite_id, nome, marca, cor, placa, entrada) ' +
      'VALUES (:suite_id, :nome, :marca, :cor, :placa, :entrada)';
    qry.ParamByName('suite_id').AsInteger := SuiteNumero;
    qry.ParamByName('nome').AsString := cbNomeVeiculo.Text;
    qry.ParamByName('marca').AsString := cbMarca.Text;
    qry.ParamByName('cor').AsString := edtCorVeiculo.Text;
    qry.ParamByName('placa').AsString := edtPlaca.Text;
    qry.ParamByName('entrada').AsDateTime := horarioAtual;
    qry.ExecSQL;

    qry.SQL.Text := 'UPDATE suites SET status = "Ocupada" WHERE id = :id';
    qry.ParamByName('id').AsInteger := SuiteNumero;
    qry.ExecSQL;

    ShowMessage('Entrada registrada com sucesso.');

    // Impressão térmica
    SL := TStringList.Create;
try
  // Buscar o número da suíte
      qry.SQL.Text := 'SELECT numero FROM suites WHERE id = :id';
      qry.ParamByName('id').AsInteger := SuiteNumero;
      qry.Open;
      numeroSuite := qry.FieldByName('numero').AsString;
      qry.Close;

      SL.Add('===============================');
      SL.Add('       ENTRADA DE VEÍCULO     ');
      SL.Add('===============================');
      SL.Add('Suíte: ' + numeroSuite);
      SL.Add('Nome: ' + cbNomeVeiculo.Text);
      SL.Add('Marca: ' + cbMarca.Text);
      SL.Add('Cor: ' + edtCorVeiculo.Text);
      SL.Add('Placa: ' + edtPlaca.Text);
      SL.Add('Data: ' + FormatDateTime('dd/mm/yyyy', horarioAtual));
      SL.Add('Hora: ' + FormatDateTime('hh:nn:ss', horarioAtual));
      SL.Add('===============================');
      SL.Add('   Obrigado por escolher o');
      SL.Add('         Love''s Motel');
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

    // Atualiza MainView
    if Assigned(OnAfterEntradaSalva) then
      OnAfterEntradaSalva(Self);

    if Assigned(frmMainView) then
    begin
      frmMainView.pnlBackground.DestroyComponents;
      frmMainView.CarregarSuites;
    end;

    Close;
  finally
    qry.Free;
  end;
end;


procedure TfrmEntradaView.cbMarcaChange(Sender: TObject);
begin
  cbNomeVeiculo.Items.Clear;

  if cbMarca.Text = 'Chevrolet' then
  begin
    cbNomeVeiculo.Items.Add('Onix');
    cbNomeVeiculo.Items.Add('Onix Plus');
    cbNomeVeiculo.Items.Add('Cruze');
    cbNomeVeiculo.Items.Add('Spin');
    cbNomeVeiculo.Items.Add('Tracker');
    cbNomeVeiculo.Items.Add('S10');
    cbNomeVeiculo.Items.Add('Montana');
    cbNomeVeiculo.Items.Add('Trailblazer');
    cbNomeVeiculo.Items.Add('Corsa');
    cbNomeVeiculo.Items.Add('Vectra');
    cbNomeVeiculo.Items.Add('Astra');
    cbNomeVeiculo.Items.Add('Kadett');
    cbNomeVeiculo.Items.Add('Opala');
    cbNomeVeiculo.Items.Add('Chevette');
    cbNomeVeiculo.Items.Add('Monza');
    cbNomeVeiculo.Items.Add('Blazer');
  end
  else if cbMarca.Text = 'Fiat' then
  begin
    cbNomeVeiculo.Items.Add('Argo');
    cbNomeVeiculo.Items.Add('Mobi');
    cbNomeVeiculo.Items.Add('Cronos');
    cbNomeVeiculo.Items.Add('Pulse');
    cbNomeVeiculo.Items.Add('Fastback');
    cbNomeVeiculo.Items.Add('Toro');
    cbNomeVeiculo.Items.Add('Strada');
    cbNomeVeiculo.Items.Add('Fiorino');
    cbNomeVeiculo.Items.Add('Uno');
    cbNomeVeiculo.Items.Add('Palio');
    cbNomeVeiculo.Items.Add('Siena');
    cbNomeVeiculo.Items.Add('147');
    cbNomeVeiculo.Items.Add('Idea');
    cbNomeVeiculo.Items.Add('Tempra');
    cbNomeVeiculo.Items.Add('Tipo');
  end
  else if cbMarca.Text = 'Volkswagen' then
  begin
    cbNomeVeiculo.Items.Add('Gol');
    cbNomeVeiculo.Items.Add('Voyage');
    cbNomeVeiculo.Items.Add('Virtus');
    cbNomeVeiculo.Items.Add('Polo');
    cbNomeVeiculo.Items.Add('T-Cross');
    cbNomeVeiculo.Items.Add('Nivus');
    cbNomeVeiculo.Items.Add('Taos');
    cbNomeVeiculo.Items.Add('Saveiro');
    cbNomeVeiculo.Items.Add('Amarok');
    cbNomeVeiculo.Items.Add('Fusca');
    cbNomeVeiculo.Items.Add('Brasília');
    cbNomeVeiculo.Items.Add('Kombi');
    cbNomeVeiculo.Items.Add('Passat');
    cbNomeVeiculo.Items.Add('Parati');
    cbNomeVeiculo.Items.Add('Santana');
    cbNomeVeiculo.Items.Add('Fox');
    cbNomeVeiculo.Items.Add('Golf');
    cbNomeVeiculo.Items.Add('Jetta');
  end
  else if cbMarca.Text = 'Hyundai' then
  begin
    cbNomeVeiculo.Items.Add('HB20');
    cbNomeVeiculo.Items.Add('HB20S');
    cbNomeVeiculo.Items.Add('HB20X');
    cbNomeVeiculo.Items.Add('Creta');
    cbNomeVeiculo.Items.Add('Tucson');
    cbNomeVeiculo.Items.Add('ix35');
    cbNomeVeiculo.Items.Add('Santa Fe');
    cbNomeVeiculo.Items.Add('Azera');
    cbNomeVeiculo.Items.Add('Elantra');
    cbNomeVeiculo.Items.Add('Veloster');
  end
  else if cbMarca.Text = 'Honda' then
  begin
    cbNomeVeiculo.Items.Add('Civic');
    cbNomeVeiculo.Items.Add('Fit');
    cbNomeVeiculo.Items.Add('City');
    cbNomeVeiculo.Items.Add('WR-V');
    cbNomeVeiculo.Items.Add('HR-V');
    cbNomeVeiculo.Items.Add('CR-V');
    cbNomeVeiculo.Items.Add('Accord');
    cbNomeVeiculo.Items.Add('Jazz');
    cbNomeVeiculo.Items.Add('Brio');
    cbNomeVeiculo.Items.Add('Prelude');
  end
  else if cbMarca.Text = 'Renault' then
  begin
    cbNomeVeiculo.Items.Add('Kwid');
    cbNomeVeiculo.Items.Add('Sandero');
    cbNomeVeiculo.Items.Add('Logan');
    cbNomeVeiculo.Items.Add('Duster');
    cbNomeVeiculo.Items.Add('Captur');
    cbNomeVeiculo.Items.Add('Stepway');
    cbNomeVeiculo.Items.Add('Oroch');
    cbNomeVeiculo.Items.Add('Megane');
    cbNomeVeiculo.Items.Add('Symbol');
    cbNomeVeiculo.Items.Add('Scenic');
  end
  else if cbMarca.Text = 'Ford' then
  begin
    cbNomeVeiculo.Items.Add('Ka');
    cbNomeVeiculo.Items.Add('Ka Sedan');
    cbNomeVeiculo.Items.Add('Fiesta');
    cbNomeVeiculo.Items.Add('Focus');
    cbNomeVeiculo.Items.Add('EcoSport');
    cbNomeVeiculo.Items.Add('Ranger');
    cbNomeVeiculo.Items.Add('Fusion');
    cbNomeVeiculo.Items.Add('Edge');
    cbNomeVeiculo.Items.Add('Maverick');
    cbNomeVeiculo.Items.Add('Territory');
  end
  else if cbMarca.Text = 'Nissan' then
  begin
    cbNomeVeiculo.Items.Add('March');
    cbNomeVeiculo.Items.Add('Versa');
    cbNomeVeiculo.Items.Add('Kicks');
    cbNomeVeiculo.Items.Add('Sentra');
    cbNomeVeiculo.Items.Add('Frontier');
    cbNomeVeiculo.Items.Add('X-Trail');
    cbNomeVeiculo.Items.Add('Tiida');
    cbNomeVeiculo.Items.Add('Altima');
    cbNomeVeiculo.Items.Add('Livina');
    cbNomeVeiculo.Items.Add('Murano');
  end
  else if cbMarca.Text = 'Jeep' then
  begin
    cbNomeVeiculo.Items.Add('Renegade');
    cbNomeVeiculo.Items.Add('Compass');
    cbNomeVeiculo.Items.Add('Commander');
    cbNomeVeiculo.Items.Add('Wrangler');
    cbNomeVeiculo.Items.Add('Cherokee');
    cbNomeVeiculo.Items.Add('Grand Cherokee');
    cbNomeVeiculo.Items.Add('Patriot');
    cbNomeVeiculo.Items.Add('Liberty');
    cbNomeVeiculo.Items.Add('Gladiator');
    cbNomeVeiculo.Items.Add('CJ-5');
  end
  else if cbMarca.Text = 'Peugeot' then
  begin
    cbNomeVeiculo.Items.Add('208');
    cbNomeVeiculo.Items.Add('2008');
    cbNomeVeiculo.Items.Add('3008');
    cbNomeVeiculo.Items.Add('308');
    cbNomeVeiculo.Items.Add('408');
    cbNomeVeiculo.Items.Add('Partner');
    cbNomeVeiculo.Items.Add('Expert');
    cbNomeVeiculo.Items.Add('RCZ');
    cbNomeVeiculo.Items.Add('607');
    cbNomeVeiculo.Items.Add('106');
  end
  else if cbMarca.Text = 'Citroen' then
  begin
    cbNomeVeiculo.Items.Add('C3');
    cbNomeVeiculo.Items.Add('C4 Cactus');
    cbNomeVeiculo.Items.Add('Aircross');
    cbNomeVeiculo.Items.Add('C4 Lounge');
    cbNomeVeiculo.Items.Add('Xsara');
    cbNomeVeiculo.Items.Add('Berlingo');
    cbNomeVeiculo.Items.Add('Jumpy');
    cbNomeVeiculo.Items.Add('C5');
    cbNomeVeiculo.Items.Add('C6');
    cbNomeVeiculo.Items.Add('DS3');
  end
  else if cbMarca.Text = 'Kia' then
  begin
    cbNomeVeiculo.Items.Add('Sportage');
    cbNomeVeiculo.Items.Add('Sorento');
    cbNomeVeiculo.Items.Add('Soul');
    cbNomeVeiculo.Items.Add('Cerato');
    cbNomeVeiculo.Items.Add('Rio');
    cbNomeVeiculo.Items.Add('Picanto');
    cbNomeVeiculo.Items.Add('Bongo');
    cbNomeVeiculo.Items.Add('Seltos');
    cbNomeVeiculo.Items.Add('Optima');
    cbNomeVeiculo.Items.Add('Mohave');
  end
  else if cbMarca.Text = 'Mitsubishi' then
  begin
    cbNomeVeiculo.Items.Add('ASX');
    cbNomeVeiculo.Items.Add('Outlander');
    cbNomeVeiculo.Items.Add('Eclipse Cross');
    cbNomeVeiculo.Items.Add('Lancer');
    cbNomeVeiculo.Items.Add('Pajero');
    cbNomeVeiculo.Items.Add('L200');
    cbNomeVeiculo.Items.Add('Galant');
    cbNomeVeiculo.Items.Add('Mirage');
    cbNomeVeiculo.Items.Add('3000GT');
    cbNomeVeiculo.Items.Add('Montero');
  end
  else if cbMarca.Text = 'BMW' then
  begin
    cbNomeVeiculo.Items.Add('320i');
    cbNomeVeiculo.Items.Add('330i');
    cbNomeVeiculo.Items.Add('X1');
    cbNomeVeiculo.Items.Add('X3');
    cbNomeVeiculo.Items.Add('X5');
    cbNomeVeiculo.Items.Add('X6');
    cbNomeVeiculo.Items.Add('M3');
    cbNomeVeiculo.Items.Add('M4');
    cbNomeVeiculo.Items.Add('Z4');
    cbNomeVeiculo.Items.Add('118i');
  end
  else if cbMarca.Text = 'Mercedes-Benz' then
  begin
    cbNomeVeiculo.Items.Add('Classe A');
    cbNomeVeiculo.Items.Add('Classe C');
    cbNomeVeiculo.Items.Add('Classe E');
    cbNomeVeiculo.Items.Add('GLA');
    cbNomeVeiculo.Items.Add('GLC');
    cbNomeVeiculo.Items.Add('GLE');
    cbNomeVeiculo.Items.Add('GLS');
    cbNomeVeiculo.Items.Add('CLA');
    cbNomeVeiculo.Items.Add('C63 AMG');
    cbNomeVeiculo.Items.Add('S500');
  end
  else if cbMarca.Text = 'Audi' then
  begin
    cbNomeVeiculo.Items.Add('A3');
    cbNomeVeiculo.Items.Add('A4');
    cbNomeVeiculo.Items.Add('A5');
    cbNomeVeiculo.Items.Add('A6');
    cbNomeVeiculo.Items.Add('Q3');
    cbNomeVeiculo.Items.Add('Q5');
    cbNomeVeiculo.Items.Add('Q7');
    cbNomeVeiculo.Items.Add('RS3');
    cbNomeVeiculo.Items.Add('TT');
    cbNomeVeiculo.Items.Add('e-tron');
  end
  else if cbMarca.Text = 'Volvo' then
  begin
    cbNomeVeiculo.Items.Add('XC40');
    cbNomeVeiculo.Items.Add('XC60');
    cbNomeVeiculo.Items.Add('XC90');
    cbNomeVeiculo.Items.Add('S60');
    cbNomeVeiculo.Items.Add('S90');
    cbNomeVeiculo.Items.Add('V40');
    cbNomeVeiculo.Items.Add('V60');
    cbNomeVeiculo.Items.Add('C30');
    cbNomeVeiculo.Items.Add('C70');
    cbNomeVeiculo.Items.Add('V90');
  end
  else if cbMarca.Text = 'Land Rover' then
  begin
    cbNomeVeiculo.Items.Add('Evoque');
    cbNomeVeiculo.Items.Add('Discovery Sport');
    cbNomeVeiculo.Items.Add('Defender');
    cbNomeVeiculo.Items.Add('Range Rover');
    cbNomeVeiculo.Items.Add('Velar');
    cbNomeVeiculo.Items.Add('Freelander');
    cbNomeVeiculo.Items.Add('Discovery');
    cbNomeVeiculo.Items.Add('Range Rover Sport');
    cbNomeVeiculo.Items.Add('Range Rover Classic');
    cbNomeVeiculo.Items.Add('Series III');
  end
  else if cbMarca.Text = 'Chery' then
  begin
    cbNomeVeiculo.Items.Add('Tiggo 2');
    cbNomeVeiculo.Items.Add('Tiggo 3X');
    cbNomeVeiculo.Items.Add('Tiggo 5X');
    cbNomeVeiculo.Items.Add('Tiggo 7');
    cbNomeVeiculo.Items.Add('Tiggo 8');
    cbNomeVeiculo.Items.Add('QQ');
    cbNomeVeiculo.Items.Add('Arrizo 5');
    cbNomeVeiculo.Items.Add('Arrizo 6');
    cbNomeVeiculo.Items.Add('Face');
    cbNomeVeiculo.Items.Add('Cielo');
  end
  else if cbMarca.Text = 'JAC Motors' then
  begin
    cbNomeVeiculo.Items.Add('T40');
    cbNomeVeiculo.Items.Add('T50');
    cbNomeVeiculo.Items.Add('T60');
    cbNomeVeiculo.Items.Add('T80');
    cbNomeVeiculo.Items.Add('J3');
    cbNomeVeiculo.Items.Add('J5');
    cbNomeVeiculo.Items.Add('iEV20');
    cbNomeVeiculo.Items.Add('iEV40');
    cbNomeVeiculo.Items.Add('J6');
    cbNomeVeiculo.Items.Add('J7');
  end
  else if cbMarca.Text = 'BYD' then
  begin
    cbNomeVeiculo.Items.Add('Dolphin');
    cbNomeVeiculo.Items.Add('Yuan Plus');
    cbNomeVeiculo.Items.Add('Han');
    cbNomeVeiculo.Items.Add('Song Plus');
    cbNomeVeiculo.Items.Add('Seal');
    cbNomeVeiculo.Items.Add('Tang');
    cbNomeVeiculo.Items.Add('Qin');
    cbNomeVeiculo.Items.Add('F3');
    cbNomeVeiculo.Items.Add('e5');
    cbNomeVeiculo.Items.Add('e6');
  end
  else if cbMarca.Text = 'GWM' then
  begin
    cbNomeVeiculo.Items.Add('Haval H6');
    cbNomeVeiculo.Items.Add('Jolion');
    cbNomeVeiculo.Items.Add('Tank 300');
    cbNomeVeiculo.Items.Add('Tank 500');
    cbNomeVeiculo.Items.Add('Poer');
    cbNomeVeiculo.Items.Add('Wingle 5');
    cbNomeVeiculo.Items.Add('Wingle 7');
    cbNomeVeiculo.Items.Add('Ora 03');
    cbNomeVeiculo.Items.Add('Ora 07');
    cbNomeVeiculo.Items.Add('Cannon');
  end
  else if cbMarca.Text = 'Porsche' then
  begin
    cbNomeVeiculo.Items.Add('Macan');
    cbNomeVeiculo.Items.Add('Cayenne');
    cbNomeVeiculo.Items.Add('Panamera');
    cbNomeVeiculo.Items.Add('911');
    cbNomeVeiculo.Items.Add('718 Boxster');
    cbNomeVeiculo.Items.Add('718 Cayman');
    cbNomeVeiculo.Items.Add('Taycan');
    cbNomeVeiculo.Items.Add('Carrera');
    cbNomeVeiculo.Items.Add('Targa');
    cbNomeVeiculo.Items.Add('Turbo S');
  end
  else if cbMarca.Text = 'Lexus' then
  begin
    cbNomeVeiculo.Items.Add('UX');
    cbNomeVeiculo.Items.Add('NX');
    cbNomeVeiculo.Items.Add('RX');
    cbNomeVeiculo.Items.Add('ES');
    cbNomeVeiculo.Items.Add('IS');
    cbNomeVeiculo.Items.Add('GS');
    cbNomeVeiculo.Items.Add('CT');
    cbNomeVeiculo.Items.Add('LS');
    cbNomeVeiculo.Items.Add('LC');
    cbNomeVeiculo.Items.Add('RC');
  end
  else if cbMarca.Text = 'Mini' then
  begin
    cbNomeVeiculo.Items.Add('Cooper');
    cbNomeVeiculo.Items.Add('Cooper S');
    cbNomeVeiculo.Items.Add('Countryman');
    cbNomeVeiculo.Items.Add('Paceman');
    cbNomeVeiculo.Items.Add('Clubman');
    cbNomeVeiculo.Items.Add('John Cooper Works');
    cbNomeVeiculo.Items.Add('One');
    cbNomeVeiculo.Items.Add('Convertible');
    cbNomeVeiculo.Items.Add('Electric');
    cbNomeVeiculo.Items.Add('Roadster');
  end
  else if cbMarca.Text = 'RAM' then
  begin
    cbNomeVeiculo.Items.Add('1500');
    cbNomeVeiculo.Items.Add('2500');
    cbNomeVeiculo.Items.Add('3500');
    cbNomeVeiculo.Items.Add('Classic');
    cbNomeVeiculo.Items.Add('Rebel');
    cbNomeVeiculo.Items.Add('Laramie');
    cbNomeVeiculo.Items.Add('Limited');
    cbNomeVeiculo.Items.Add('TRX');
    cbNomeVeiculo.Items.Add('Power Wagon');
    cbNomeVeiculo.Items.Add('Big Horn');
  end
  else if cbMarca.Text = 'Iveco' then
  begin
    cbNomeVeiculo.Items.Add('Daily');
    cbNomeVeiculo.Items.Add('Tector');
    cbNomeVeiculo.Items.Add('Hi-Way');
    cbNomeVeiculo.Items.Add('Stralis');
    cbNomeVeiculo.Items.Add('Eurocargo');
    cbNomeVeiculo.Items.Add('Cavallino');
    cbNomeVeiculo.Items.Add('Vertis');
    cbNomeVeiculo.Items.Add('Trakker');
    cbNomeVeiculo.Items.Add('TurboDaily');
    cbNomeVeiculo.Items.Add('Massif');
  end
  else if cbMarca.Text = 'Subaru' then
  begin
    cbNomeVeiculo.Items.Add('XV');
    cbNomeVeiculo.Items.Add('Forester');
    cbNomeVeiculo.Items.Add('Impreza');
    cbNomeVeiculo.Items.Add('Outback');
    cbNomeVeiculo.Items.Add('Legacy');
    cbNomeVeiculo.Items.Add('WRX');
    cbNomeVeiculo.Items.Add('BRZ');
    cbNomeVeiculo.Items.Add('Ascent');
    cbNomeVeiculo.Items.Add('Crosstrek');
    cbNomeVeiculo.Items.Add('Levorg');
  end
    else if cbMarca.Text = 'Citroen' then
  begin
    cbNomeVeiculo.Items.Add('C3');
    cbNomeVeiculo.Items.Add('C4 Cactus');
    cbNomeVeiculo.Items.Add('Aircross');
    cbNomeVeiculo.Items.Add('C4 Lounge');
    cbNomeVeiculo.Items.Add('Xsara');
    cbNomeVeiculo.Items.Add('Berlingo');
    cbNomeVeiculo.Items.Add('Jumpy');
    cbNomeVeiculo.Items.Add('C5');
    cbNomeVeiculo.Items.Add('C6');
    cbNomeVeiculo.Items.Add('DS3');
  end
  else if cbMarca.Text = 'Toyota' then
  begin
    cbNomeVeiculo.Items.Add('Corolla');
    cbNomeVeiculo.Items.Add('Corolla Cross');
    cbNomeVeiculo.Items.Add('Hilux');
    cbNomeVeiculo.Items.Add('Etios');
    cbNomeVeiculo.Items.Add('Yaris');
    cbNomeVeiculo.Items.Add('SW4');
    cbNomeVeiculo.Items.Add('Camry');
    cbNomeVeiculo.Items.Add('RAV4');
    cbNomeVeiculo.Items.Add('Prius');
    cbNomeVeiculo.Items.Add('Land Cruiser');
  end
  else if cbMarca.Text = 'GWM' then
  begin
    cbNomeVeiculo.Items.Add('Haval H6');
    cbNomeVeiculo.Items.Add('Jolion');
    cbNomeVeiculo.Items.Add('Tank 300');
    cbNomeVeiculo.Items.Add('Tank 500');
    cbNomeVeiculo.Items.Add('Poer');
    cbNomeVeiculo.Items.Add('Wingle 5');
    cbNomeVeiculo.Items.Add('Wingle 7');
    cbNomeVeiculo.Items.Add('Ora 03');
    cbNomeVeiculo.Items.Add('Ora 07');
    cbNomeVeiculo.Items.Add('Cannon');
  end
  else if cbMarca.Text = 'Chery' then
  begin
    cbNomeVeiculo.Items.Add('Tiggo 2');
    cbNomeVeiculo.Items.Add('Tiggo 3X');
    cbNomeVeiculo.Items.Add('Tiggo 5X');
    cbNomeVeiculo.Items.Add('Tiggo 7');
    cbNomeVeiculo.Items.Add('Tiggo 8');
    cbNomeVeiculo.Items.Add('QQ');
    cbNomeVeiculo.Items.Add('Arrizo 5');
    cbNomeVeiculo.Items.Add('Arrizo 6');
    cbNomeVeiculo.Items.Add('Face');
    cbNomeVeiculo.Items.Add('Cielo');
  end;


  cbNomeVeiculo.ItemIndex := -1;
end;


end.

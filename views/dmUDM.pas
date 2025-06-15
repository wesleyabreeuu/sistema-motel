unit dmUDM;

interface

uses
  System.SysUtils, System.Classes, Vcl.Forms, Vcl.Dialogs, // ? Adicionado Vcl.Dialogs
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL,
  Data.DB, FireDAC.Comp.Client, Winapi.Windows, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;



type
  TuDM = class(TDataModule)
    FDConnection: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  uDM: TuDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}



procedure TuDM.DataModuleCreate(Sender: TObject);
begin
  FDConnection.Params.Clear;
  FDConnection.Params.DriverID := 'MySQL';
  FDConnection.Params.Database := 'motel_manager';
  FDConnection.Params.UserName := 'dev';
  FDConnection.Params.Password := 'dev123';
  FDConnection.Params.Add('Server=127.0.0.1');
  FDConnection.Params.Add('Port=3308');
  FDConnection.Params.Add('CharacterSet=utf8mb4');
  FDConnection.Params.Add('VendorLib=libmariadb.dll');

  FDPhysMySQLDriverLink1.VendorLib := 'libmariadb.dll';  // esteja na mesma pasta do .exe
  FDPhysMySQLDriverLink1.VendorHome := ExtractFilePath(ParamStr(0));
  FDPhysMySQLDriverLink1.EmbeddedArgs.Clear;

  FDConnection.LoginPrompt := False;
  FDConnection.Connected := True;
end;


end.

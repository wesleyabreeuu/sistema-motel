program loves_motel;

uses
  Vcl.Forms,
  MainView in '..\forms\MainView.dfm' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

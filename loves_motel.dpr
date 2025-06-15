program loves_motel;

uses
  Vcl.Forms,
  MainView in 'views\MainView.pas' {frmMainView},
  EntradaView in 'views\EntradaView.pas' {frmEntradaView},
  CadastroSuiteView in 'views\CadastroSuiteView.pas' {fCadastroSuiteView},
  dmUDM in 'views\dmUDM.pas' {uDM: TDataModule},
  CadastroProdutoView in 'views\CadastroProdutoView.pas' {fCadastroProdutoView},
  CadastroServicoView in 'views\CadastroServicoView.pas' {fCadastroServicoView},
  CadastroUsuariosView in 'views\CadastroUsuariosView.pas' {fieCadastroUsuarioVw},
  GestaoView in 'views\GestaoView.pas' {fGestao},
  FinalizarHospedagemView in 'views\FinalizarHospedagemView.pas' {fFinalizarHospedagemView},
  RelatorioMovimentosView in 'views\RelatorioMovimentosView.pas' {fRelatorioMovimentosView},
  RelatorioConsumosView in 'views\RelatorioConsumosView.pas' {fRelatorioConsumosView},
  RelatorioFinanceiroView in 'views\RelatorioFinanceiroView.pas' {fRelatorioFinanceiroView},
  ContasAPagarView in 'views\ContasAPagarView.pas' {fContasAPagarView},
  LoginView in 'views\LoginView.pas' {fLoginView},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin

  Application.Initialize;
  TStyleManager.TrySetStyle('Smokey Quartz Kamri');
  Application.CreateForm(TuDM, uDM);
  Application.CreateForm(TfLoginView, fLoginView);
  Application.MainFormOnTaskbar := True;
     Application.CreateForm(TfrmMainView, frmMainView);

   // <-- DEVE VIR PRIMEIRO
  Application.CreateForm(TfCadastroServicoView, fCadastroServicoView);
  Application.CreateForm(TfCadastroUsuarioView, fCadastroUsuarioView);
  Application.CreateForm(TfCadastroProdutoView, fCadastroProdutoView);
  Application.CreateForm(TfCadastroServicoView, fCadastroServicoView);
  Application.CreateForm(TfCadastroUsuarioView, fCadastroUsuarioView);
  Application.CreateForm(TfGestao, fGestao);
  Application.CreateForm(TfFinalizarHospedagemView, fFinalizarHospedagemView);
  Application.CreateForm(TfCadastroSuiteView, fCadastroSuiteView);
  Application.CreateForm(TfRelatorioMovimentosView, fRelatorioMovimentosView);
  Application.CreateForm(TfRelatorioConsumosView, fRelatorioConsumosView);
    Application.CreateForm(TfRelatorioFinanceiroView, fRelatorioFinanceiroView);
  Application.CreateForm(TfContasAPagarView, fContasAPagarView);
  Application.Run;
end.


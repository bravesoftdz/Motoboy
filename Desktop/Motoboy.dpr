program Motoboy;

uses
  Vcl.Forms,
  UPrincipal in 'UPrincipal.pas' {Form1},
  ULib in '..\Lib\ULib.pas',
  UDM in 'UDM.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.

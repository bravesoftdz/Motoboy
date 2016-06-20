program Motoboy;

uses
  Vcl.Forms,
  UPrincipal in 'UPrincipal.pas' {Form1},
  ULib in '..\Lib\ULib.pas',
  UDM in 'UDM.pas' {DM: TDataModule},
  UClientClasses in '..\ClientDataSnap\UClientClasses.pas',
  UDMSnap in '..\ClientDataSnap\UDMSnap.pas' {DMSnap: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TDMSnap, DMSnap);
  Application.Run;
end.

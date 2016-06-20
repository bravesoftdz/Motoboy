program Motoboy;

uses
  Vcl.Forms,
  UPrincipal in 'UPrincipal.pas' {FPrincipal},
  ULib in '..\Lib\ULib.pas',
  UDM in 'UDM.pas' {DM: TDataModule},
  UClientClasses in '..\ClientDataSnap\UClientClasses.pas',
  UDMSnap in '..\ClientDataSnap\UDMSnap.pas' {DMSnap: TDataModule},
  ULogin in 'ULogin.pas' {FLogin};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TDMSnap, DMSnap);
  Application.Run;
end.

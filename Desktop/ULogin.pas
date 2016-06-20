unit ULogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TFLogin = class(TForm)
    EdtUsuario: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    EdtSenha: TEdit;
    BtnLogar: TBitBtn;
    BtnSair: TBitBtn;
    procedure BtnSairClick(Sender: TObject);
    procedure BtnLogarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    Function VerificaBranco: Boolean;
  public
    { Public declarations }
  end;

var
  FLogin: TFLogin;

implementation

{$R *.dfm}

uses UDM, UPrincipal;

procedure TFLogin.BtnLogarClick(Sender: TObject);
Var
  X : String;
begin
  if (not VerificaBranco) then
    Exit;

  X:='Select pkusuario from tbusuario where usuario = ' + QuotedStr(EdtUsuario.Text)
   + ' and senha = ' + QuotedStr(EdtSenha.Text);
  LibUtils.ExecutarSQL(X, DM.SQLGeral);

  if (DM.SQLGeral.FieldByName('PKUSUARIO').AsString <> '') then
  Begin
    FLogin.Close;
    if FPrincipal = nil then
      Application.CreateForm(TFPrincipal, FPrincipal);
    FPrincipal.ShowModal;
  End
  else
  begin
    Application.MessageBox('Usuário/Senha não encontrado', 'Usuário não encontrado', MB_OK + MB_ICONEXCLAMATION);
    Exit;
  end;
end;

procedure TFLogin.BtnSairClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFLogin.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key in ['''', '"', '#'] then
  begin
    Key:= #0;
  end;

  if key = #13 then
  begin
    if not (ActiveControl is TMemo) then
    begin
      Key:= #0;
      Perform(Wm_NextDlgCtl,0,0);
    end;
  end;

  if Key = #27 then
  begin
    Key:= #0;
    BtnSairClick(nil);
  end;
end;

function TFLogin.VerificaBranco: Boolean;
begin
  Result:= False;

  if not LibUtils.VerificaBranco(EdtUsuario, 'Usuário') then Exit;
  if not LibUtils.VerificaBranco(EdtSenha, 'Senha') then Exit;

  Result:= True;
end;

end.

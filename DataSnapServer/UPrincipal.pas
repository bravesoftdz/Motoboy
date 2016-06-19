unit UPrincipal;

interface

uses
  Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.AppEvnts, Vcl.StdCtrls, IdHTTPWebBrokerBridge, Web.HTTPApp, Vcl.Buttons,
  IniFiles, WinApi.Windows, Winapi.ShellApi, Datasnap.DSSession;

type
  TFPrincipal = class(TForm)
    ButtonStart: TButton;
    ButtonStop: TButton;
    EditPort: TEdit;
    Label1: TLabel;
    ApplicationEvents1: TApplicationEvents;
    ButtonOpenBrowser: TButton;
    Label2: TLabel;
    Label3: TLabel;
    BtnSalvar: TButton;
    EdtServidor: TEdit;
    EdtCaminhoBanco: TEdit;
    BtnLoc: TBitBtn;
    OpenDlg: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure ButtonStartClick(Sender: TObject);
    procedure ButtonStopClick(Sender: TObject);
    procedure ButtonOpenBrowserClick(Sender: TObject);
    procedure BtnLocClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
  private
    FServer: TIdHTTPWebBrokerBridge;
    procedure StartServer;
    procedure GravaINI(Texto: String; Tag: String);
    function LerIni(Tag: string): String;
  public
    { Public declarations }
  end;

var
  FPrincipal: TFPrincipal;

implementation

{$R *.dfm}

uses UDMServerMethods;

procedure TFPrincipal.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
begin
  ButtonStart.Enabled := not FServer.Active;
  ButtonStop.Enabled := FServer.Active;
  EditPort.Enabled := not FServer.Active;
end;

procedure TFPrincipal.BtnLocClick(Sender: TObject);
var
  Cam, NCam: String;
  I: Integer;
begin
  OpenDlg.Execute;
  if OpenDlg.FileName <> '' then
  begin
    Cam:= OpenDlg.FileName;
    if Copy(Cam, 1, 2) <> '\\' then
    begin
      EdtCaminhoBanco.Text:= Cam;
    end
    else
    begin
      NCam:= '';
      for I:= 3 to Length(Cam) do
        if Cam[I] = '\' then
        begin
          EdtServidor.Text:= Copy(Cam, 3, I-3);
          NCam:= Copy(Cam, I+1, Length(Cam)-I);
          EdtCaminhoBanco.Text:= Copy(NCam, 1, 1) + ':\' + Copy(NCam, 3, Length(Cam)-3);
          Break;
        end;
    end;

    if BtnSalvar.CanFocus then
      BtnSalvar.SetFocus;
  end;
end;

procedure TFPrincipal.BtnSalvarClick(Sender: TObject);
begin
  GravaINI(EditPort.Text, 'Porta');
  GravaINI(EdtServidor.Text, 'Servidor');
  GravaINI(EdtCaminhoBanco.Text, 'Caminho');
end;

procedure TFPrincipal.ButtonOpenBrowserClick(Sender: TObject);
var
  LURL: string;
begin
  StartServer;
  LURL := Format('http://localhost:%s', [EditPort.Text]);
  ShellExecute(0,
        nil,
        PChar(LURL), nil, nil, SW_SHOWNOACTIVATE);
end;

procedure TFPrincipal.ButtonStartClick(Sender: TObject);
begin
  StartServer;
end;

procedure TerminateThreads;
begin
  if TDSSessionManager.Instance <> nil then
    TDSSessionManager.Instance.TerminateAllSessions;
end;

procedure TFPrincipal.ButtonStopClick(Sender: TObject);
begin
  TerminateThreads;
  FServer.Active := False;
  FServer.Bindings.Clear;
end;

procedure TFPrincipal.FormCreate(Sender: TObject);
begin
  FServer := TIdHTTPWebBrokerBridge.Create(Self);
  EditPort.Text:= LerIni('Porta');
  EdtServidor.Text:= LerIni('Servidor');
  EdtCaminhoBanco.Text:= LerIni('Caminho');

  if (Trim(EditPort.Text) <> '') and (Trim(EdtServidor.Text) <> '') and (Trim(EdtCaminhoBanco.Text) <> '')then
    ButtonStartClick(nil);
end;

procedure TFPrincipal.GravaINI(Texto, Tag: String);
var
  ArqIni: TIniFile;
  Arquivo: String;
begin
  Arquivo:= ExtractFilePath(Application.ExeName) + 'ConfDataSnapServer.ini';
  ArqIni := TIniFile.Create(Arquivo);
  try
    ArqIni.WriteString('Configuracao', Tag, Texto);
  finally
    ArqIni.Free;
  end;

end;

function TFPrincipal.LerIni(Tag: string): String;
var
  ArqIni: TIniFile;
  Arquivo: String;
begin
  Arquivo:= ExtractFilePath(Application.ExeName) + 'ConfDataSnapServer.ini';
  ArqIni := TIniFile.Create(Arquivo);
  try
    LerIni := ArqIni.ReadString('Configuracao', Tag, '');
  finally
    ArqIni.Free;
  end;
end;

procedure TFPrincipal.StartServer;
begin
  try
    DMServerMethods.FDConexao.Connected:= False;
    DMServerMethods.FDConexao.Connected := True;
  except on E: Exception do
    begin
      raise Exception.Create(E.Message);
      Exit;
    end;
  end;

  if not FServer.Active then
  begin
    FServer.Bindings.Clear;
    FServer.DefaultPort := StrToInt(EditPort.Text);
    FServer.Active := True;
  end;

  ShowMessage(DMServerMethods.FDConexao.Params.Values['Database']);
end;

end.

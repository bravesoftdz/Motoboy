unit UDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase,
  FireDAC.Phys.FB, MidasLib, Winapi.Windows, Vcl.Forms, System.IniFiles,
  ULib, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TDM = class(TDataModule)
    FDConexao: TFDConnection;
    FDPhysFBDriverLink: TFDPhysFBDriverLink;
    FDTransaction: TFDTransaction;
    SQLGeral: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;
  DataCorrente: TDateTime;
  LibUtils: TLibUtils;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
var
  X: String;
  ArqIni: TIniFile;
  Msg, ArquivoConf, ProtocoloTxt, Banco, Servidor, CaminhoDB: String;
  Protocolo: Integer;
begin
  ArquivoConf:= ExtractFilePath(ParamStr(0)) + 'Configuracao.ini';
  if not FileExists(ArquivoConf) then
  begin
    Application.MessageBox('Não foi encontrado o arquivo de configuração do sistema. Configure-o antes de iniciar o sistema.', 'Configuração de Sistema', MB_ICONINFORMATION);
    Application.Terminate;
    Exit;
  end;

  ArqIni:= TIniFile.Create(ArquivoConf);
  try
    Protocolo:= ArqIni.ReadInteger('Acesso', 'Protocolo', 0);
    Servidor:= ArqIni.ReadString('Acesso', 'Servidor', '');
    Banco:= ArqIni.ReadString('Acesso', 'BancoDeDados', '');
    case Protocolo of
      0 : ProtocoloTxt:= 'ipTCPIP';
      1 : ProtocoloTxt:= 'ipNetBEUI';
    end;
  finally
    ArqIni.Free;
  end;

  //************************************************************************************************

  try
    FDConexao.Connected:= False;
    FDConexao.LoginPrompt:= False;
    FDConexao.Params.Clear;
    FDConexao.Params.DriverID:= 'FB';
    FDConexao.Params.UserName:= 'SYSDBA';
    FDConexao.Params.Password:= 'masterkey';
    FDConexao.Params.Add('Port=3050');
    FDConexao.Params.Add('CharacterSet=WIN1252');
    FDConexao.Params.Add('Protocol='+ProtocoloTxt);
    FDConexao.Params.Add('Server='+Servidor);
    FDConexao.Params.Add('DataBase='+Banco);
    FDConexao.Connected:= True;
    CaminhoDB:= Servidor + ':' + Banco;
  except on E: Exception do
    begin
      Msg:= 'Ocorreu um erro ao tentar conectar no Banco de Dados';
      Application.MessageBox(PChar(Msg), 'Configuração de Sistema', MB_ICONERROR);
      raise Exception.Create(E.Message);
      Application.Terminate;
      Exit;
    end;
  end;

  X:= 'select current_date as data from RDB$DATABASE';
  LibUtils.ExecutarSQL(X, SQLGeral);
  DataCorrente:= SQLGeral.FieldByName('data').AsDateTime;

  Application.CreateForm(TFLogin, FLogin);
  FLogin.ShowModal;
end;

end.

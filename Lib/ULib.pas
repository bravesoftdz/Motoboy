unit ULib;

interface

Uses
  Winapi.WinInet, System.Win.Registry, IdGlobal, IdHash, IdHashMessageDigest,
  Winapi.Windows, System.SysUtils, FireDAC.Comp.Client;

const
  C1 = 58693;
  C2 = 56852;
  _Key = 18562;

  //*** formatos de data e hora ***********
  fmtSalvarData = 'dd.mm.yyyy';
  fmtSalvarHora = 'hh:mm';
  fmtSalvarDataHora = 'dd.mm.yyyy hh:mm';
  fmtMostrarData = 'dd/mm/yyyy';
  fmtMostrarHora = 'hh:mm';
  fmtMostrarDataHora = 'dd/mm/yyyy hh:mm';

Type
  TLibUtils = Class
    private
      function RetornarTipoSQL(sSQL: String): Integer;
    public
      //*** CRIPTOGRAFIA *****************************************************************************
      function EncryptStr(const S: String): String;
      function DecryptStr(const S: String): String;
      function GetMD5(AValor: String): String;
      function GetNomeComputador: String;
      function IsConnectedToInternet: Boolean;
      function WindowsVersion: string;

      function SalvarValor(Valor: Real; CasasDecimais: Integer = 2; SeparadorDecimal: String = '.'): String; overload;
      function SalvarValor(Valor: String; CasasDecimais: Integer = 2; SeparadorDecimal: String = '.'): String; overload;
      function LimparValor(Valor: String): String;
      function FormataCasaDecimal5(valor: String) : String;

      function SalvarChave(Chave: String): String;
      procedure ExecutarSQL(sSQL: String; Query: TFDQuery);
      function ExibirValor(Valor: Real; CasasDecimais: Integer = 2): String;
end;

implementation

{ TLibUtils }

function TLibUtils.DecryptStr(const S: String): String;
var
  I: Integer;
  Key: Word;
begin
  Key:= _Key;
  Result := S;
  for I := 1 to Length(S) do
  begin
   Result[I] := char(byte(S[I]) xor (Key shr 8));
   Key := (byte(S[I]) + Key) * C1 + C2;
  end;

end;

function TLibUtils.EncryptStr(const S: String): String;
var
  I: Integer;
  Key: Word;
begin
  Key:= _Key;
  Result := S;
  for I := 1 to Length(S) do
  begin
    Result[I] := char(byte(S[I]) xor (Key shr 8));
    Key := (byte(Result[I]) + Key) * C1 + C2;
  end;

end;

procedure TLibUtils.ExecutarSQL(sSQL: String; Query: TFDQuery);
begin
  with Query do
  begin
    Close;
    SQL.Clear;
    SQL.Add(sSQL);

    if RetornarTipoSQL(sSQL) = 0 then
      ExecSQL
    else
      Open;
  end;

end;

function TLibUtils.ExibirValor(Valor: Real; CasasDecimais: Integer): String;
begin
  if (CasasDecimais < 3) then
    Valor:= StrToFloat(FormataCasaDecimal5(FloatToStr(Valor)));

  Result:= FormatFloat('#,##0.'+StringOfChar('0', CasasDecimais), Valor);
end;

function TLibUtils.FormataCasaDecimal5(valor: String): String;
Var
  resultado: Real;
  fracao: Real;
  terceiraCasa : integer;
  eNegativo: Boolean;
begin
  resultado:= trunc(StrToFloatDef(LimparValor(valor), 0));
  fracao:= frac(StrToFloatDef(LimparValor(valor), 0));
  eNegativo:=False;
  if (resultado < 0) then
  begin
    eNegativo:=True;
    resultado:= resultado * -1;
    fracao:= fracao * -1;
  end;

  terceiraCasa:= StrtoIntDef(Copy(FloatToStr(fracao), 5, 1), 0);
  resultado:= resultado + StrToFloat('0,' + (Copy(FloatToStr(fracao), 3, 2)));

  if (terceiraCasa > 5) then
    resultado:= resultado + 0.01;

  if (eNegativo) then
    Resultado:=Resultado * -1;

  Result:= FormatFloat('#0.00', Resultado);

end;

function TLibUtils.GetMD5(AValor: String): String;
var
  hashMessageDigest5: TIdHashMessageDigest5;
begin
  hashMessageDigest5:= nil;
  try
    hashMessageDigest5:= TIdHashMessageDigest5.Create;
    Result:= IdGlobal.IndyLowerCase(hashMessageDigest5.HashStringAsHex(AValor));
  finally
    hashMessageDigest5.Free;
  end;

end;

function TLibUtils.GetNomeComputador: String;
var
  I: DWord;
begin
  I:= MAX_COMPUTERNAME_LENGTH + 1;
  SetLength(Result, I);
  Winapi.Windows.GetComputerName(PChar(Result), I);
  Result:= String(PChar(Result));
end;

function TLibUtils.IsConnectedToInternet: Boolean;
var
  dwConnectionTypes: DWORD;
begin
  dwConnectionTypes:= INTERNET_CONNECTION_MODEM + INTERNET_CONNECTION_LAN + INTERNET_CONNECTION_PROXY;
  Result:= InternetGetConnectedState(@dwConnectionTypes, 0);

end;

function TLibUtils.LimparValor(Valor: String): String;
var
  y: String;
  I: Integer;
begin
  if Valor = '' then
    Valor:= '0';

  Y:= '';
  for I:= 1 to length(Valor) do
    if Valor[I] <> '.' then
      y:= y + Valor[i];
  Result:= Y;

end;

function TLibUtils.RetornarTipoSQL(sSQL: String): Integer;
var
  I: Integer;
begin
  Result:= 0;

  for I:= 1 to Length(sSQL) do
  begin
    if (UpperCase(Copy(sSQL, I, 14)) = 'CREATE TRIGGER') then
    begin Result:= 0; Exit; end;
    if (UpperCase(Copy(sSQL, I, 13)) = 'ALTER TRIGGER') then
    begin Result:= 0; Exit; end;
    if (UpperCase(Copy(sSQL, I, 23)) = 'CREATE OR ALTER TRIGGER') then
    begin Result:= 0; Exit; end;
    if (UpperCase(Copy(sSQL, I, 6)) = 'SELECT') then
    begin Result:= 1; Exit; end;
    if (UpperCase(Copy(sSQL, I, 6)) = 'UPDATE') then
    begin Result:= 0; Exit; end;
    if (UpperCase(Copy(sSQL, I, 6)) = 'INSERT') then
    begin Result:= 0; Exit; end;
    if (UpperCase(Copy(sSQL, I, 6)) = 'DELETE') then
    begin Result:= 0; Exit; end;
    if (UpperCase(Copy(sSQL, I, 5)) = 'ALTER') then
    begin Result:= 0; Exit; end;
  end;

end;

function TLibUtils.SalvarValor(Valor: Real; CasasDecimais: Integer;
  SeparadorDecimal: String): String;
var
  X, Y: String;
  I, II: Integer;
begin
  If (CasasDecimais < 3) then
    Valor:= StrToFloat(FormataCasaDecimal5(FloatToStr(Valor)));

  X:= FormatFloat('#0.'+StringOfChar('0',CasasDecimais), Valor);

  II:= 0;
  for I:= 1 to Length(X) do
  begin
    if (X[I] in ['-', ',', '0'..'9']) then
    begin
      if X[I] = ',' then
      begin
        II:= II + 1;
        if II <= 1 then
          Y:= Y + SeparadorDecimal;
      end
      else
        Y:= Y + X[I];
    end;
  end;

  if Y = '' then
    Y:= '0';
  Result:= Y;

end;

function TLibUtils.SalvarChave(Chave: String): String;
begin
  if Trim(Chave) = '' then
    Result:= 'null'
  else
    Result:= Chave;
end;

function TLibUtils.SalvarValor(Valor: String; CasasDecimais: Integer;
  SeparadorDecimal: String): String;
var
  X, Y: String;
  I, II: Integer;
begin
  If (CasasDecimais < 3) then
    Valor:= FormataCasaDecimal5(Valor);

  X:= FormatFloat('#0.'+StringOfChar('0',CasasDecimais), StrToFloat(LimparValor(Valor)));

  II:= 0;
  for I:= 1 to Length(X) do
  begin
    if (X[I] in ['-', ',', '0'..'9']) then
    begin
      if X[I] = ',' then
      begin
        II:= II + 1;
        if II <= 1 then
          Y:= Y + SeparadorDecimal;
      end
      else
        Y:= Y + X[I];
    end;
  end;

  if Y = '' then
    Y:= '0';
  Result:= Y;

end;

function TLibUtils.WindowsVersion: string;
var
  vNome,
  vVersao,
  vCurrentBuild: String;
  Reg: TRegistry;
begin
  Reg         := TRegistry.Create;
  Reg.Access  := KEY_READ;
  Reg.RootKey := HKEY_LOCAL_MACHINE;

  Reg.OpenKey('\SOFTWARE\Microsoft\Windows NT\CurrentVersion\', true);

  vNome         := Reg.ReadString('ProductName');
  vVersao       := Reg.ReadString('CurrentVersion');
  vCurrentBuild := Reg.ReadString('CurrentBuild');

  Result := vNome + ' - ' + vVersao + ' - ' + vCurrentBuild;
end;

end.

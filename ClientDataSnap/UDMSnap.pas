unit UDMSnap;

interface

uses
  System.SysUtils, System.Classes, UClientClasses, Datasnap.DSClientRest;

type
  TDMSnap = class(TDataModule)
    DSRestConnection1: TDSRestConnection;
  private
    FInstanceOwner: Boolean;
    FDMServerMethodsClient: TDMServerMethodsClient;
    function GetDMServerMethodsClient: TDMServerMethodsClient;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property InstanceOwner: Boolean read FInstanceOwner write FInstanceOwner;
    property DMServerMethodsClient: TDMServerMethodsClient read GetDMServerMethodsClient write FDMServerMethodsClient;

end;

var
  DMSnap: TDMSnap;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

constructor TDMSnap.Create(AOwner: TComponent);
begin
  inherited;
  FInstanceOwner := True;
end;

destructor TDMSnap.Destroy;
begin
  FDMServerMethodsClient.Free;
  inherited;
end;

function TDMSnap.GetDMServerMethodsClient: TDMServerMethodsClient;
begin
  if FDMServerMethodsClient = nil then
    FDMServerMethodsClient:= TDMServerMethodsClient.Create(DSRestConnection1, FInstanceOwner);
  Result := FDMServerMethodsClient;
end;

end.

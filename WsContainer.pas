unit WsContainer;

interface

uses System.SysUtils, System.Classes,
  Vcl.SvcMgr,
  Datasnap.DSTCPServerTransport,
  Datasnap.DSHTTPCommon, Datasnap.DSHTTP,
  Datasnap.DSServer, Datasnap.DSCommonServer,
  Datasnap.DSClientMetadata, Datasnap.DSHTTPServiceProxyDispatcher,
  Datasnap.DSProxyJavaAndroid, Datasnap.DSProxyJavaBlackBerry,
  Datasnap.DSProxyObjectiveCiOS, Datasnap.DSProxyCsharpSilverlight,
  Datasnap.DSProxyFreePascal_iOS,
  Datasnap.DSAuth, IPPeerServer, Datasnap.DSProxyJavaScript,
  Datasnap.DSMetadata, Datasnap.DSServerMetadata, System.JSON, Data.DBXCommon;

type
  TWebsContainer = class(TService)
    DSServer1: TDSServer;
    DSTCPServerTransport1: TDSTCPServerTransport;
    DSHTTPService1: TDSHTTPService;
    DSAuthenticationManager1: TDSAuthenticationManager;
    DSHTTPServiceProxyDispatcher1: TDSHTTPServiceProxyDispatcher;
    DSProxyGenerator1: TDSProxyGenerator;
    DSServerMetaDataProvider1: TDSServerMetaDataProvider;
    DSHTTPServiceFileDispatcher1: TDSHTTPServiceFileDispatcher;
    DSServerClass1: TDSServerClass;
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DSAuthenticationManager1UserAuthorize(Sender: TObject;
      EventObject: TDSAuthorizeEventObject; var valid: Boolean);
    procedure DSAuthenticationManager1UserAuthenticate(Sender: TObject;
      const Protocol, Context, User, Password: string; var valid: Boolean;
      UserRoles: TStrings);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure DataModuleCreate(Sender: TObject);
    procedure DSHTTPService1FormatResult(Sender: TObject;
      var ResultVal: TJSONValue; const Command: TDBXCommand;
      var Handled: Boolean);
  private
    { Private declarations }
  protected
    function DoStop: Boolean; override;
    function DoPause: Boolean; override;
    function DoContinue: Boolean; override;
    procedure DoInterrogate; override;
  public
    function GetServiceController: TServiceController; override;
  end;

var
  WebsContainer: TWebsContainer;

implementation

{$R *.dfm}

uses Winapi.Windows, WsMetodos;

procedure TWebsContainer.DataModuleCreate(Sender: TObject);
begin
  // --
end;

procedure TWebsContainer.DSServerClass1GetClass(DSServerClass
  : TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := WsMetodos.TWebsMetodos;
end;

procedure TWebsContainer.DSAuthenticationManager1UserAuthenticate
  (Sender: TObject; const Protocol, Context, User, Password: string;
  var valid: Boolean; UserRoles: TStrings);
begin
  valid := True;
end;

procedure TWebsContainer.DSAuthenticationManager1UserAuthorize
  (Sender: TObject; EventObject: TDSAuthorizeEventObject; var valid: Boolean);
begin
  valid := True;
end;

procedure TWebsContainer.DSHTTPService1FormatResult(Sender: TObject;
  var ResultVal: TJSONValue; const Command: TDBXCommand; var Handled: Boolean);
begin
  Handled := True;
end;

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  WebsContainer.Controller(CtrlCode);
end;

function TWebsContainer.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

function TWebsContainer.DoContinue: Boolean;
begin
  Result := inherited;
  DSServer1.Start;
end;

procedure TWebsContainer.DoInterrogate;
begin
  inherited;
end;

function TWebsContainer.DoPause: Boolean;
begin
  DSServer1.Stop;
  Result := inherited;
end;

function TWebsContainer.DoStop: Boolean;
begin
  DSServer1.Stop;
  Result := inherited;
end;

procedure TWebsContainer.ServiceStart(Sender: TService;
  var Started: Boolean);
begin
  DSServer1.Start;
end;

end.

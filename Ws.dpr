program Ws;

uses
  Vcl.SvcMgr,
  WsMetodos in 'WsMetodos.pas' {WebsMetodos: TDSServerModule},
  WsContainer in 'WsContainer.pas' {WebsContainer: TService},
  Clases in 'Clases.pas';

{$R *.RES}

begin
  if not Application.DelayInitialize or Application.Installing then
    Application.Initialize;
  Application.CreateForm(TWebsContainer, WebsContainer);
  Application.Run;
end.

unit RemoteHost;

interface
uses Classes, HTTPApp, IdHTTP, RDPCOMAPILib_TLB, System.SysUtils;

type
  TGeneratedEvent = procedure(Sender: TObject; const APassword: String; const AConnectionString: String) of object;

  TRemoteHost = class
  private
    FRDPSession: RDPSession;
    Fpass: string;
    Fconnstring: string;
    FServerAddress: string;
    FSupporterID: string;
    FOnGenerated: TGeneratedEvent;
    FOnDisconnect: TNotifyEvent;
    procedure Setpass(const Value: string);
    procedure Setconnstring(const Value: string);
    procedure Incoming( ASender: TObject;const a: IDispatch);
    procedure SetServerAddress(const Value: string);
    procedure SetSupporterID(const Value: string);
  protected
    property RDPSession: RDPSession read FRDPSession;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Generate;
    procedure Disconnect;
    property Password: string read Fpass write Setpass;
    property ConnString: string read Fconnstring write Setconnstring;
    property ServerAddress: string read FServerAddress write SetServerAddress;
    property SupporterID: string read FSupporterID write SetSupporterID;
    property OnGenerated: TGeneratedEvent read FOnGenerated write FOnGenerated;
    property OnDisconnect: TNotifyEvent read FOnDisconnect write FOnDisconnect;
  end;

implementation

constructor TRemoteHost.Create;
begin
  FRDPSession := RDPSession;
  ServerAddress := 'http://remote.jointdots.com';
  SupporterID := '1';
end;

destructor TRemoteHost.Destroy;
begin
  FRDPSession.Free;
  inherited;
end;

procedure TRemoteHost.Generate;
var
  Invitation: IRDPSRAPIInvitation;
  pasi: String;
  pin: Integer;
  HTTP: TIdHTTP;
  Query: String;
begin
  FRDPSession.OnAttendeeConnected := Incoming;
  pin := 999 + Random(1000) + Random(100);
  RDPSession.Open;
  Password := IntToStr(pin);
  Invitation := FRDPSession.Invitations.CreateInvitation('WinPresenter', 'PresentationGroup', Password, 5);
  ConnString := Invitation.ConnectionString;
  HTTP := TIdHTTP.Create;
  try
    Query := ServerAddress + '/invitation.php?invitation=' + String(HTTPEncode(Invitation.ConnectionString)) +'&' + 'password=' + pasi + '&id=' + SupporterID;
    HTTP.Get(Query);
    if Assigned(OnGenerated) then
      OnGenerated(self, Password, connstring);
  finally
    HTTP.Free;
  end;
end;


procedure TRemoteHost.Incoming(ASender: TObject; const a: IDispatch);
var
  MyGuest: IRDPSRAPIAttendee;
begin
  MyGuest := IRDPSRAPIAttendee(a);
  MyGuest.ControlLevel := CTRL_LEVEL(CTRL_lEVEL_INTERACTIVE);
end;

procedure TRemoteHost.Disconnect;
var
  HTTP: TIdHTTP;
  Query: String;
begin
  HTTP := TIdHTTP.Create;
  try
    RDPSession.Close;
    Query := ServerAddress + '/invitation.php?invitation=' + '&' + 'password='  + '&id=' + SupporterID;
    HTTP.Get(Query);
    if Assigned(OnDisconnect) then
      OnDisconnect(self);
  finally
    HTTP.Free;
  end;
end;

procedure TRemoteHost.Setconnstring(const Value: string);
begin
  Fconnstring := Value;
end;

procedure TRemoteHost.Setpass(const Value: string);
begin
  Fpass := Value;
end;

procedure TRemoteHost.SetServerAddress(const Value: string);
begin
  FServerAddress := Value;
end;

procedure TRemoteHost.SetSupporterID(const Value: string);
begin
  FSupporterID := Value;
end;

end.
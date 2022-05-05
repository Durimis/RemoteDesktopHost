program RemoteHostController;

uses
  Vcl.Forms,
  RemoteHostMainForm in 'RemoteHostMainForm.pas' {frmRemoteHost},
  RemoteHost in 'RemoteHost.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmRemoteHost, frmRemoteHost);
  Application.Run;
end.

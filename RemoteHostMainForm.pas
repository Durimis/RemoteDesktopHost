unit RemoteHostMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RDPCOMAPILib_TLB, Vcl.StdCtrls,
  Vcl.OleServer, HTTPApp, IdHTTP, Vcl.Menus, RemoteHost;

type
  TfrmRemoteHost = class(TForm)
    btnGenerate: TButton;
    btnDisConnect: TButton;
    edtPassword: TEdit;
    Label1: TLabel;
    edtInvitation: TEdit;
    Label3: TLabel;
    edtSupporterID: TEdit;
    Label2: TLabel;
    edtServerAddress: TEdit;
    Label4: TLabel;
    procedure btnGenerateClick(Sender: TObject);
    procedure btnDisConnectClick(Sender: TObject);
  private
    FRemoteHost: TRemoteHost;
    procedure DoOnGenerated(Sender: TObject; const APassword: String; const AConnectionString: String);
  public
    { Public declarations }
  end;

var
  frmRemoteHost: TfrmRemoteHost;

implementation

{$R *.dfm}

procedure TfrmRemoteHost.btnGenerateClick(Sender: TObject);
begin
  if not Assigned(FRemoteHost) then begin
    FRemoteHost := TRemoteHost.Create;
    if (edtSupporterID.Text = '') then begin
        ShowMessage('No ID or server typed going with Default');
        edtSupporterID.Text := FRemoteHost.SupporterID;
        edtServerAddress.Text :=  FRemoteHost.ServerAddress;
      end
    else
      if edtServerAddress.Text = '' then
        begin
        ShowMessage('No ID or server typed going with Default');
        edtSupporterID.Text := FRemoteHost.SupporterID;
        edtServerAddress.Text := FRemoteHost.ServerAddress;
        end
      else
        begin
        FRemoteHost.SupporterID := edtSupporterID.Text;
        FRemoteHost.ServerAddress := edtServerAddress.Text;
        end;
    FRemoteHost.OnGenerated := DoOnGenerated;
    FRemoteHost.Generate;
  end;
end;

procedure TfrmRemoteHost.DoOnGenerated(Sender: TObject; const APassword, AConnectionString: String);
begin
  edtPassword.Text := APassword; //FRemoteHost.Password;
  edtInvitation.Text := AConnectionString; //FRemoteHost.connstring;
end;

procedure TfrmRemoteHost.btnDisConnectClick(Sender: TObject);
begin
  FRemoteHost.Disconnect;
  FRemoteHost.Free;
  FRemoteHost := nil;
end;

end.

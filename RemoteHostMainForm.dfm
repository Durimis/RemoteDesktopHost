object frmRemoteHost: TfrmRemoteHost
  Left = 0
  Top = 0
  Caption = 'RemoteHost'
  ClientHeight = 221
  ClientWidth = 495
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 18
    Top = 101
    Width = 49
    Height = 13
    Caption = 'Pin Code :'
  end
  object Label3: TLabel
    Left = 176
    Top = 101
    Width = 53
    Height = 13
    Caption = 'Invitation :'
  end
  object Label2: TLabel
    Left = 18
    Top = 29
    Width = 21
    Height = 13
    Caption = 'ID : '
  end
  object Label4: TLabel
    Left = 155
    Top = 29
    Width = 74
    Height = 13
    Caption = 'Server Address'
  end
  object btnGenerate: TButton
    Left = 176
    Top = 169
    Width = 161
    Height = 25
    Caption = 'Generate and Send Ivitation'
    TabOrder = 0
    OnClick = btnGenerateClick
  end
  object btnDisConnect: TButton
    Left = 8
    Top = 169
    Width = 75
    Height = 25
    Caption = 'Disconnect'
    TabOrder = 1
    OnClick = btnDisConnectClick
  end
  object edtPassword: TEdit
    Left = 8
    Top = 126
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object edtInvitation: TEdit
    Left = 176
    Top = 126
    Width = 241
    Height = 21
    TabOrder = 3
  end
  object edtSupporterID: TEdit
    Left = 56
    Top = 26
    Width = 73
    Height = 21
    TabOrder = 4
  end
  object edtServerAddress: TEdit
    Left = 248
    Top = 26
    Width = 153
    Height = 21
    TabOrder = 5
  end
end

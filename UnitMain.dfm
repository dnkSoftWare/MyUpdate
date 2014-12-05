object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 258
  ClientWidth = 544
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 56
    Top = 144
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Label2: TLabel
    Left = 48
    Top = 16
    Width = 224
    Height = 13
    Caption = #1055#1091#1090#1100' '#1076#1083#1103' '#1074#1099#1075#1088#1091#1079#1082#1080'  '#1080' '#1087#1088#1086#1074#1077#1088#1082#1080' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1081
  end
  object Edit1: TEdit
    Left = 48
    Top = 40
    Width = 433
    Height = 21
    TabOrder = 0
    Text = 'o:\_RMSAuto_RELEASE\TestMyUpdate\'
  end
  object Button1: TButton
    Left = 48
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Check'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 360
    Top = 80
    Width = 121
    Height = 25
    Caption = 'Upload update'
    TabOrder = 4
  end
  object Button3: TButton
    Left = 144
    Top = 80
    Width = 75
    Height = 25
    Caption = 'CheckNew'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 48
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Button4'
    TabOrder = 5
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 225
    Top = 80
    Width = 96
    Height = 25
    Caption = 'UpdateInThread'
    TabOrder = 3
  end
  object Button6: TButton
    Left = 168
    Top = 184
    Width = 75
    Height = 25
    Caption = 'ChDir'
    TabOrder = 6
    OnClick = Button6Click
  end
  object MyUpdate1: TMyUpdate
    AutoStart = True
    CheckFolder = 'O:\_RMSAuto_RELEASE\TestMyUpdate\'
    CheckIntervalInSec = 5
    OnHaveUpdate = MyUpdate1HaveUpdate
    Left = 304
    Top = 168
  end
end

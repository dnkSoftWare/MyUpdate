object FormUpdateEditor: TFormUpdateEditor
  Left = 0
  Top = 0
  Anchors = [akTop, akRight]
  Caption = 'Updater editor'
  ClientHeight = 273
  ClientWidth = 603
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    603
    273)
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 8
    Top = 58
    Width = 188
    Height = 13
    Caption = 'This files will included to update archive'
  end
  object Label3: TLabel
    Left = 8
    Top = 8
    Width = 134
    Height = 13
    Caption = 'Choice file fo add to archive'
  end
  object btInsert: TButton
    Left = 512
    Top = 82
    Width = 83
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Insert'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = btInsertClick
  end
  object btDelete: TButton
    Left = 512
    Top = 113
    Width = 83
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Delete'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = btDeleteClick
  end
  object btOk: TButton
    Left = 512
    Top = 240
    Width = 83
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 5
  end
  object EditFileName: TEdit
    Left = 8
    Top = 27
    Width = 495
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
    ExplicitWidth = 501
  end
  object btOpenFileForArch: TButton
    Left = 512
    Top = 25
    Width = 83
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Open'
    TabOrder = 0
    OnClick = btOpenFileForArchClick
  end
  object ValueListEditor1: TValueListEditor
    AlignWithMargins = True
    Left = 8
    Top = 77
    Width = 495
    Height = 188
    Margins.Left = 8
    Margins.Right = 100
    Margins.Bottom = 8
    Align = alBottom
    Anchors = [akRight, akBottom]
    DisplayOptions = [doColumnTitles, doAutoColResize]
    KeyOptions = [keyEdit, keyAdd, keyDelete, keyUnique]
    TabOrder = 2
    TitleCaptions.Strings = (
      'FileName'
      'Description')
    ExplicitWidth = 501
    ColWidths = (
      244
      245)
  end
end

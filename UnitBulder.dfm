object FormUpdateBuilder: TFormUpdateBuilder
  Left = 0
  Top = 0
  Caption = 'My update builder'
  ClientHeight = 546
  ClientWidth = 864
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    864
    546)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 18
    Top = 54
    Width = 80
    Height = 13
    Caption = 'Main application:'
  end
  object Label2: TLabel
    Left = 18
    Top = 123
    Width = 70
    Height = 13
    Caption = 'About update:'
  end
  object Label3: TLabel
    Left = 18
    Top = 180
    Width = 81
    Height = 13
    Caption = 'Do after update:'
  end
  object Label4: TLabel
    Left = 18
    Top = 227
    Width = 88
    Height = 13
    Caption = 'Info after update:'
  end
  object Label5: TLabel
    Left = 18
    Top = 272
    Width = 36
    Height = 13
    Caption = 'File list:'
  end
  object Label6: TLabel
    Left = 18
    Top = 448
    Width = 202
    Height = 13
    Caption = 'Destination folder for update project files:'
  end
  object lbMainArch: TLabel
    Left = 18
    Top = 88
    Width = 55
    Height = 13
    Caption = 'Main Archiv'
  end
  object edMainAppFile: TcxButtonEdit
    Left = 104
    Top = 50
    Anchors = [akLeft, akTop, akRight]
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end
      item
        Caption = 'Get version'
        Kind = bkText
        Width = 100
      end>
    TabOrder = 2
    Width = 744
  end
  object edAboutUpdate: TcxTextEdit
    Left = 104
    Top = 120
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 4
    Width = 744
  end
  object rgAfterUpdate: TcxRadioGroup
    Left = 104
    Top = 160
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Ater update'
    Properties.Columns = 3
    Properties.Items = <
      item
        Caption = 'showinfo'
        Value = 'showinfo'
      end
      item
        Caption = 'restart'
        Value = 'restart'
      end
      item
        Caption = 'forcerestart'
        Value = 'forcerestart'
      end>
    TabOrder = 5
    Height = 41
    Width = 744
  end
  object edInfoAfterUpdate: TcxTextEdit
    Left = 112
    Top = 224
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 6
    Text = 
      #1055#1086#1083#1091#1095#1077#1085#1086' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077'. '#1055#1077#1088#1077#1079#1072#1087#1091#1089#1090#1080#1090#1077' '#1087#1088#1086#1075#1088#1072#1084#1084#1091' '#1076#1083#1103' '#1077#1075#1086' '#1072#1082#1090#1080#1074#1080#1079#1072#1094#1080#1080 +
      '.'
    Width = 736
  end
  object cxGrid1: TcxGrid
    Left = 104
    Top = 272
    Width = 744
    Height = 153
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 7
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = DataSource1
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1FileName: TcxGridDBColumn
        DataBinding.FieldName = 'FileName'
        Width = 515
      end
      object cxGrid1DBTableView1ArchName: TcxGridDBColumn
        DataBinding.FieldName = 'ArchName'
        Width = 85
      end
      object cxGrid1DBTableView1UpdateIfNotExist: TcxGridDBColumn
        DataBinding.FieldName = 'UpdateIfNotExist'
        Width = 72
      end
      object cxGrid1DBTableView1SkipThisFile: TcxGridDBColumn
        DataBinding.FieldName = 'SkipThisFile'
        Width = 70
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object btAddOtherFiles: TcxButton
    Left = 16
    Top = 304
    Width = 75
    Height = 25
    Caption = 'Add files'
    TabOrder = 8
    OnClick = btAddOtherFilesClick
  end
  object btDeploy: TcxButton
    Left = 104
    Top = 504
    Width = 177
    Height = 25
    Caption = 'Deploy update files'
    OptionsImage.Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000000000000000
      000000000000000000000000000000020412020F224E03142F6B03152F6D0210
      255401050B190000000000000000000000000000000000000000000000000000
      000000000000010409280D48A1B51669E7FF186BE9FF196CEAFF196CEAFF186B
      E9FF1769E7FF0E4DACC101040A2F000000000000000000000000000000000000
      0000010409291766DEF51C6EEBFF1B6EEBFF196CE9FF1768E4FC1667E2FA186B
      E8FF1B6EEBFF1C6EEBFF1667E1F80104092A0000000000000000000000000000
      00000D3C84911E70ECFF1D6FEBFF0B3472A90208132A00000000000000000106
      0D1E092E64951C6FEBFF1E70ECFF082A5B860000000000000000000000000000
      00000A2B5D892373EEFF1659C1D3000000000001020A1860CDE11861CFE30001
      030D000000001455B4C62273EEFF08234C700000000000000000000000000000
      000000020411195CC3D4206FE6F9030E1D4002070F202374EEFF2374EDFF0207
      0F220618334A2070E8FB1553B0C0000001040000000000000000000000000000
      0000000000000001010509254E711859BCCB0E35707A2777F0FF2777EFFF0E35
      70791652ACBA05142A5B00000000000000000000000000000000000000000000
      000000000000010408100000000000000000020810222B7AF1FF2B7AF1FF0208
      1125000000000000000001040810000000000000000000000000000000000000
      00001A50A3AC2D7CF3FF0B264C6C00000000030811252F7DF4FF2F7DF4FF0309
      1227000000000C254B6A2D7CF3FF1B51A4AE0000000000000000000000000000
      0000205EBDC53884F6FF3481F5FF0C254C6A030913273481F6FF3381F6FF030A
      142A0C254A683481F5FF3884F6FF2160BDC60000000000000000000000000000
      000001030516286BCFD73C87F8FF3884F7FF1743878D3784F8FF3784F8FF1744
      888E3884F7FF3C87F8FF286BCFD7010305160000000000000000000000000000
      000000000000010306192C6FD3DA4089FAFF3C87F9FF3F88FAFF3F88FAFF3C87
      F9FF4089FAFF2C70D5DB0103061A000000000000000000000000000000000000
      000000000000000000000104071D3074DBDF438CFBFF428CFBFF428CFBFF438C
      FBFF3075DCE00104071E00000000000000000000000000000000000000000000
      0000000000000000000000000000020408223378DFE2478EFCFF478EFCFF3478
      E0E3020409230000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000002050925387CE4E6387CE5E70205
      0926000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000002050A2802050A290000
      0000000000000000000000000000000000000000000000000000}
    TabOrder = 11
  end
  object edDestinationFolder: TcxTextEdit
    Left = 104
    Top = 467
    TabOrder = 10
    Width = 665
  end
  object btLoadProject: TcxButton
    Left = 16
    Top = 14
    Width = 183
    Height = 25
    Caption = 'Open project'
    TabOrder = 0
  end
  object edMainArch: TcxTextEdit
    Left = 104
    Top = 83
    Properties.ReadOnly = True
    TabOrder = 3
    Width = 225
  end
  object btSaveProject: TcxButton
    Left = 232
    Top = 14
    Width = 209
    Height = 25
    Caption = 'SaveProject'
    TabOrder = 1
  end
  object cxButton1: TcxButton
    Left = 784
    Top = 464
    Width = 64
    Height = 25
    Caption = 'cxButton1'
    TabOrder = 9
    OnClick = cxButton1Click
  end
  object mdFiles: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 176
    Top = 304
    object mdFilesFileName: TStringField
      FieldName = 'FileName'
      Size = 250
    end
    object mdFilesIncludeInArch: TStringField
      FieldName = 'IncludeInArch'
      Size = 50
    end
    object mdFilesUpdateIfNotExist: TBooleanField
      FieldName = 'UpdateIfNotExist'
    end
  end
  object DataSource1: TDataSource
    DataSet = FileList
    Left = 456
    Top = 408
  end
  object OpenDialog1: TOpenDialog
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Title = 'Choise files'
    Left = 40
    Top = 352
  end
  object FileList: TVirtualTable
    Options = [voPersistentData, voStored, voSkipUnSupportedFieldTypes]
    Active = True
    FieldDefs = <
      item
        Name = 'FileName'
        Attributes = [faRequired]
        DataType = ftString
        Size = 255
      end
      item
        Name = 'ArchName'
        DataType = ftString
        Size = 250
      end
      item
        Name = 'UpdateIfNotExist'
        DataType = ftBoolean
      end
      item
        Name = 'SkipThisFile'
        DataType = ftBoolean
      end>
    Left = 528
    Top = 408
    Data = {
      03000400080046696C654E616D650100FF00000000000800417263684E616D65
      0100FA0000000000100055706461746549664E6F744578697374050000000000
      00000C00536B69705468697346696C650500000000000000000000000000}
  end
end

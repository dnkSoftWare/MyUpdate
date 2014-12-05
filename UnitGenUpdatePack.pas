unit UnitGenUpdatePack;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dnkUpdater, System.Actions, Vcl.ActnList, Vcl.StdActns,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ImgList, Vcl.ComCtrls;

type
  TFormGenUpdatePack = class(TForm)
    ActionList1: TActionList;
    FileSaveAs1: TFileSaveAs;
    FileOpen1: TFileOpen;
    btLoadInfo: TButton;
    GroupBox1: TGroupBox;
    btAddToPAck: TButton;
    InPackFileList: TLabel;
    ClearList: TButton;
    btDelete: TButton;
    cbMainFile: TCheckBox;
    FileNameEdit: TButtonedEdit;
    ImageList1: TImageList;
    InfoFileNameEdit: TButtonedEdit;
    btSaveInfo: TButton;
    ListFiles: TListBox;
    procedure btLoadInfoClick(Sender: TObject);
    procedure InfoFileNameEditRightButtonClick(Sender: TObject);
    procedure ListFilesClick(Sender: TObject);
  private

    FUpdateInfo:TUpdateInfo;

  public
    { Public declarations }

  end;

var
  FormGenUpdatePack: TFormGenUpdatePack;

implementation

{$R *.dfm}

procedure TFormGenUpdatePack.btLoadInfoClick(Sender: TObject);
 var F:TFileUpType;
begin
 if not Assigned(FUpdateInfo) then
   FUpdateInfo:=TUpdateInfo.Create(InfoFileNameEdit.Text,'7zip.exe');

  FUpdateInfo.ReadUpdateInfo;

  ListFiles.Clear;
  ListFiles.Items.AddObject(FUpdateInfo.GetInfoText, FUpdateInfo);
  if FUpdateInfo.ListFiles.Count>0 then
  for F in FUpdateInfo.ListFiles do
   ListFiles.Items.AddObject(F.GetInfoText, F);

end;

procedure TFormGenUpdatePack.InfoFileNameEditRightButtonClick(Sender: TObject);
begin
 if FileOpen1.Execute then
  TEdit(Sender).Text:=FileOpen1.Dialog.FileName;
end;

procedure TFormGenUpdatePack.ListFilesClick(Sender: TObject);
 var SelObj:TObject; UI:TUpdateInfo;
begin
 if TListBox(Sender).ItemIndex >= 0 then
 begin
  cbMainFile.Checked:=false;
  SelObj:=  TListBox(Sender).Items.Objects[ TListBox(Sender).ItemIndex ];
 if SelObj is TFileUpType then
   FileNameEdit.Text:=(SelObj as TFileUpType).GetFileName;

 if SelObj is TUpdateInfo then
  begin
   FileNameEdit.Text:=(SelObj as TUpdateInfo).AppSourceFolder + (SelObj as TUpdateInfo).AppFileName;
   cbMainFile.Checked:=true;
  end;

 end;
end;

end.

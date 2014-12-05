unit dnkUpdaterEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, dnkUpdater, Vcl.ValEdit,
  Vcl.ExtCtrls;

type
  TFormUpdateEditor = class(TForm)
    Label2: TLabel;
    btInsert: TButton;
    btDelete: TButton;
    btOk: TButton;
    EditFileName: TEdit;
    Label3: TLabel;
    btOpenFileForArch: TButton;
    ValueListEditor1: TValueListEditor;
    procedure btDeleteClick(Sender: TObject);
    procedure btInsertClick(Sender: TObject);
    procedure btOpenClick(Sender: TObject);
    procedure btOpenFileForArchClick(Sender: TObject);
  private
    FUpdater: TUpdate;
    { Private declarations }
  public
    InfoFileNameValue: string;
    constructor Create(AOwnerForm: TComponent; AUpdater: TUpdate); overload;
    { Public declarations }
  end;

//var
//  FormUpdateEditor: TFormUpdateEditor;

implementation

{$R *.dfm}

constructor TFormUpdateEditor.Create(AOwnerForm: TComponent; AUpdater: TUpdate);
begin
  inherited Create(AOwnerForm);
  FUpdater:=AUpdater;
  InfoFileNameValue:=FUpdater.UpdateInfo.UpdateInfoFile;
end;

procedure TFormUpdateEditor.btDeleteClick(Sender: TObject);
begin
 if ValueListEditor1.RowCount>2 then
  ValueListEditor1.DeleteRow(ValueListEditor1.Row);
end;

procedure TFormUpdateEditor.btInsertClick(Sender: TObject);
begin
 if EditFileName.Text>'' then
 begin
  ValueListEditor1.InsertRow(EditFileName.Text,'Description for file...',True);
  EditFileName.Text:='';
 end;
end;

procedure TFormUpdateEditor.btOpenClick(Sender: TObject);
begin
  With TOpenDialog.Create(Self) do
  begin
   Filter:= 'All files (*.*)|*.*|INFO Files (*.inf)|*.inf';
   if Execute then
      InfoFileNameValue:=FileName;
   Free;
  end;
end;

procedure TFormUpdateEditor.btOpenFileForArchClick(Sender: TObject);
begin
   With TOpenDialog.Create(Self) do
  begin
   Filter:= 'All files (*.*)|*.*';
   InitialDir:=ExtractFileDir(ParamStr(0));
   if Execute then
      EditFileName.Text:=FileName;
   Free;
  end;
end;

end.

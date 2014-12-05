unit UnitBulder;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxNavigator, Data.DB, cxDBData, Vcl.StdCtrls, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, dxmdaset,
  cxGroupBox, cxRadioGroup, cxTextEdit, cxMaskEdit, cxButtonEdit, Vcl.Menus, cxButtons, MemDS,
  VirtualTable, dnkOptions;

type
  TUpdateBuilder = class(TOptions)
    Const	cArchiveBuilder: string = '7za.exe';
    const cRestartBat: String = 'restart.bat';
	private
		FMainApp: String;
		FMainAppVersion: string;
	published
		property MainApp: String read FMainApp write FMainApp;
		property MainAppVersion: string read FMainAppVersion write FMainAppVersion;
  end;


  TFormUpdateBuilder = class(TForm)
    edMainAppFile: TcxButtonEdit;
    edAboutUpdate: TcxTextEdit;
    rgAfterUpdate: TcxRadioGroup;
    edInfoAfterUpdate: TcxTextEdit;
    mdFiles: TdxMemData;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    DataSource1: TDataSource;
    mdFilesFileName: TStringField;
    mdFilesUpdateIfNotExist: TBooleanField;
    mdFilesIncludeInArch: TStringField;
    btAddOtherFiles: TcxButton;
    OpenDialog1: TOpenDialog;
    btDeploy: TcxButton;
    Label6: TLabel;
    edDestinationFolder: TcxTextEdit;
    btLoadProject: TcxButton;
    FileList: TVirtualTable;
    cxGrid1DBTableView1FileName: TcxGridDBColumn;
    cxGrid1DBTableView1ArchName: TcxGridDBColumn;
    cxGrid1DBTableView1UpdateIfNotExist: TcxGridDBColumn;
    cxGrid1DBTableView1SkipThisFile: TcxGridDBColumn;
    lbMainArch: TLabel;
    edMainArch: TcxTextEdit;
    btSaveProject: TcxButton;
    cxButton1: TcxButton;
    procedure btAddOtherFilesClick(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormUpdateBuilder: TFormUpdateBuilder;

implementation
     Uses FileCtrl;
{$R *.dfm}

procedure TFormUpdateBuilder.btAddOtherFilesClick(Sender: TObject);
var
	FileName: string;
begin
 if OpenDialog1.Execute(Self.Handle) then
  begin
   if not FileList.Active then FileList.Open;
   for FileName in OpenDialog1.Files do
    begin
      FileList.DisableControls;
      FileList.Insert;
      FileList.FieldByName('FileName').Value:=FileName;
      FileList.Post;
      FileList.EnableControls;
    end;
  end;
end;

procedure TFormUpdateBuilder.cxButton1Click(Sender: TObject);
var
	chosenDirectory: string;
begin
  if SelectDirectory('Выберите каталог', '', chosenDirectory) then Value:=IncludeTrailingBackslash(chosenDirectory);
end;

end.

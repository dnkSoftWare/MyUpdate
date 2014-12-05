unit dnkUpdater;

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections, Vcl.Forms,
  WinApi.Windows, Dialogs, System.IOUtils, Vcl.ExtCtrls, IniFiles;

const
  constArchiveDefaultExtension = '.zip';
  constArchivatorName = '7za.exe';
  constTmpFolder = 'UpdateFolder';

type
  TAppName = type string;
  TUpdateInfo = class;
  TUpdateEvent = procedure (Sender: TObject; UpdateInfo: TUpdateInfo) of object;
  {{
  Класс с информацией об обновляемом файле
  }
  TFileUpType = class(TObject)
  private
    FOwner:TUpdateInfo;
    //1 Текстовая информация о файле
    FFileInfo: string;
    FFileFolder:String;
    //1 Имя файла
    FFileName: string;
    //1 Размер файла
    FFileSize: LongInt;
    function GetFileSize: LongInt;
  public
    constructor Create(AOwner: TObject; Afileinfo, AFullFileName: string);
    procedure SetFile(Afileinfo, AFileName: string);
    destructor Destroy; override;
    function GetFileName: string;
    function GetInfoText: string;

  end;

  //1 Информационный файл обновления приложения
  TUpdateInfo = class(TObject)
  private
    //1 Название Информационного файла
    FUpdateInfoFile: string;
    //1 Имя файла приложения
    FAppFileName: string;
    //1 Исходное расположение главного файла
    FAppSourceFolder: string;

    //1 Имя файла архива
    FArchFileName: string;
    //1 Список файлов входящих в обновление
    FListFiles: TObjectList<TFileUpType>;
    //1 Информация о номере новой версии
    FNewVersion: string;


    function FileListReady: Boolean;
    function GetFileList: string;
    procedure SetAppFileName(const Value: string);
    procedure SetAppSourceFolder(const Value: string);
    procedure SetArchFileName(const Value: string);
    procedure SetListFiles(const Value: TObjectList<TFileUpType>);
    procedure SetNewVersion(const Value: string);
  public
    constructor Create(AInfoFileName, AArchFileName: String; const AAppFileName:
        string = '');
    destructor Destroy; override;
    //1 Добавляет файл в архив с обновлениями
    procedure AddFileInUpdate(AValue: TFileUpType);
    function GetInfoText: string;
    function NewFileInUpdate(const AFileName: string; const ANote: string =
        ''): TFileUpType;
    //1 Получить информацию из информационного файла
    procedure ReadUpdateInfo;
    //1 Записать информацию в информационный файл
    procedure WriteUpdateInfo;

  published
    property AppFileName: string read FAppFileName write SetAppFileName;
    property AppSourceFolder: string read FAppSourceFolder write SetAppSourceFolder;
    property ArchFileName: string read FArchFileName write SetArchFileName;
    property ListFiles: TObjectList<TFileUpType> read FListFiles write SetListFiles;
    //1 Новая версия (из информационного файла)
    property NewVersion: string read FNewVersion write SetNewVersion;
    property UpdateInfoFile: string read FUpdateInfoFile write FUpdateInfoFile;
  end;

  //1 Класс реализующий механизм обновления приложения
  TUpdate = class(TComponent)
  private
    FAppFileName: TAppName;
    FArchivatorFileName: TAppName;
    FBatFile: string;
    FCheckUpdate: TTimer;
    FDelBATFileAfterUpdate: Boolean;
    FFirstCheckAfterSecond: Integer;
    FInfoFileName: TAppName;
    FInfoPath: string;
    FNeedAutoReboot: Boolean;
    FNextCheckAfterSecond: Integer;
    FOnNewVersion: TUpdateEvent;
    FTmpFolder: string;
    //1 Поле содержащее информационную часть
    FUpdateInfo: TUpdateInfo;
    procedure CreateBAT;
    function InfoFileExists: Boolean;
    procedure SetAppFileName(const Value: TAppName);
    procedure SetInfoFileName(const Value: TAppName);
    procedure SetInfoPath(const Value: string);
    procedure SetTPath(const Value: TDirectory);
    procedure SetUpdateInfo(const Value: TUpdateInfo);
  protected
    procedure DoNewVersionEvent; dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    //1 Проверяем доступность новой версии
    function CheckNewVersion: Boolean;
    procedure CheckUpdateOnTimer(Sender: TObject);
    procedure DoUpdate;
    function GetUpdate: Boolean;
    procedure Loaded; override;
    procedure SetFirstCheckAfterSecond(const Value: Integer);
    procedure SetNextCheckAfterSecond(const Value: Integer);
    procedure SetUpdateData;
    procedure StartBat;
    property UpdateInfo: TUpdateInfo read FUpdateInfo write SetUpdateInfo;
  published
    //1 Название файла приложения
    property AppFileName: TAppName read FAppFileName write SetAppFileName;
    //1 Название файла архиватора (обычно 7z.exe)
    property ArchivatorFileName: TAppName read FArchivatorFileName write
        FArchivatorFileName;
    property DelBATFileAfterUpdate: Boolean read FDelBATFileAfterUpdate write
        FDelBATFileAfterUpdate default False;
    //1 После какой задержки проверять наличие обновления 1-й раз после запуска
    property FirstCheckAfterSecond: Integer read FFirstCheckAfterSecond write
        SetFirstCheckAfterSecond default 3;
    property InfoFileName: TAppName read FInfoFileName write SetInfoFileName;
    //1 Путь к папке с информационным файлом и остальными файлами
    property InfoPath: string read FInfoPath write SetInfoPath;
    //1 Необходима автоперезагрузка
    property NeedAutoReboot: Boolean read FNeedAutoReboot write FNeedAutoReboot
        default False;
    //1 После первой проверки можно запустить в цикле повторные проверки с указанным интервалом
    property NextCheckAfterSecond: Integer read FNextCheckAfterSecond write
        SetNextCheckAfterSecond default 300;
    //1 Папка для разворачивания обновления
    property TmpFolder: string read FTmpFolder write FTmpFolder;
    property OnNewVersion: TUpdateEvent read FOnNewVersion write FOnNewVersion;
  end;

  //1 Класс реализующий генерацию и выгрузку пакета с обновлением в установленное место
  TDeployUpdate = class(TPersistent)
  private
    FAppFileName: TAppName;
    FArchivatorFileName: TAppName;
    FInfoFileName: TAppName;
    FInfoPath: string;
    FNeedParamForMakeDeploy: string;
    FStartAfterTime: Integer;
    //1 Поле содержащее информационную часть
    FUpdateInfo: TUpdateInfo;
    //1 Копируем архиватор в свою папку
    procedure CopyArchivator;
    procedure CopyArchiveFile;
    procedure CreateUpdateInfoFile;
    function InfoFileExists: Boolean;
    procedure ReCreateArchive;
    procedure SetAppFileName(const Value: TAppName);
    procedure SetInfoFileName(const Value: TAppName);
    procedure SetInfoPath(const Value: string);
    procedure SetUpdateInfo(const Value: TUpdateInfo);
  public
    procedure Deploy;
    property StartAfterTime: Integer read FStartAfterTime write FStartAfterTime
        default 2000;
    property UpdateInfo: TUpdateInfo read FUpdateInfo write SetUpdateInfo;
  published
    property AppFileName: TAppName read FAppFileName write SetAppFileName;
    property ArchivatorFileName: TAppName read FArchivatorFileName write
        FArchivatorFileName;
    property InfoFileName: TAppName read FInfoFileName write SetInfoFileName;
    property InfoPath: string read FInfoPath write SetInfoPath;
    property NeedParamForMakeDeploy: string read FNeedParamForMakeDeploy write
        FNeedParamForMakeDeploy;
  end;

function  FileExec( const CmdLine: String; bHide, bWait: Boolean): Boolean;
function GetVersionApp(AFileName: string): string;

implementation

const
  SFileList = 'FileList';
  SMainInfoSection = 'MainInfo';
  SSourceappdir = 'sourceappdir';
  SArchive = 'archive';
  SApplication = 'application';
  SVersion = 'version';

function GetVersionApp(AFileName: string): string;
var
  VerInfoSize: DWORD;
  VerInfo: Pointer;
  VerValueSize: DWORD;
  VerValue: PVSFixedFileInfo;
  Dummy: DWORD;
begin
try
  VerInfoSize := GetFileVersionInfoSize(PChar(AFileName), Dummy);
  GetMem(VerInfo, VerInfoSize);
  GetFileVersionInfo(PChar(AFileName), 0, VerInfoSize, VerInfo);
  VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
  with VerValue^ do
  begin
    Result := IntToStr(dwFileVersionMS shr 16);
    Result := Result + '.' + IntToStr(dwFileVersionMS and $FFFF);
    Result := Result + '.' + IntToStr(dwFileVersionLS shr 16);
    Result := Result + '.' + IntToStr(dwFileVersionLS and $FFFF);
  end;
  FreeMem(VerInfo, VerInfoSize);
except
  raise Exception.Create('Application version is not available!');
end;
end;

function  FileExec( const CmdLine: String; bHide, bWait: Boolean): Boolean;
var
  StartupInfo : TStartupInfo;
  ProcessInfo : TProcessInformation;
begin
  FillChar(StartupInfo, SizeOf(TStartupInfo), 0);
  with StartupInfo do
  begin
    cb := SizeOf(TStartupInfo);
    dwFlags := STARTF_USESHOWWINDOW or STARTF_FORCEONFEEDBACK;
    if bHide then
       wShowWindow := SW_HIDE
    else
       wShowWindow := SW_SHOWNORMAL;
  end;

  Result := CreateProcess(nil, PChar(CmdLine), nil, nil, False,
               NORMAL_PRIORITY_CLASS, nil, nil, StartupInfo, ProcessInfo);
  if Result then
     CloseHandle(ProcessInfo.hThread);

  if bWait then
     if Result then
     begin
       WaitForInputIdle(ProcessInfo.hProcess, INFINITE);
       WaitForSingleObject(ProcessInfo.hProcess, INFINITE);
     end;
  if Result then
     CloseHandle(ProcessInfo.hProcess);
end;

constructor TFileUpType.Create(AOwner: TObject; Afileinfo, AFullFileName:
    string);
begin
 FOwner:=TUpdateInfo(AOwner);
 FFileInfo:=Afileinfo;
 FFileName:=ExtractFileName(AFullFileName);
 FFileFolder:=ExtractFilePath(AFullFileName);
 if FileExists(AFullFileName) then
  FFileSize:=GetFileSize;
end;

{
********************************* TFileUpType **********************************
}
procedure TFileUpType.SetFile(Afileinfo, AFileName: string);
begin
 FFileInfo:=Afileinfo;
 FFileName:=AFileName;
 FFileSize:=GetFileSize;
end;

destructor TFileUpType.Destroy;
begin
  inherited;
end;

function TFileUpType.GetFileName: string;
begin
  Result := FFileFolder+FFileName ;
end;

function TFileUpType.GetFileSize: LongInt;
var
  A: TWin32FileAttributeData;
  AA: PWin32FileAttributeData;
  B: Int64Rec;
  C: Cardinal;
begin
  AA := @A;
  if not GetFileAttributesEx (PChar (FFileFolder + FFileName), GetFileExInfoStandard, AA) then begin
    C := GetLastError;
   raise Exception.CreateFMT ('Ошибка определения размера файла %s. Код ошибки = %d', [FFileName, C]);
  end;
  B.Hi := A.nFileSizeHigh;
  B.Lo := A.nFileSizeLow;
  Result:= Int64 (B);
end;

function TFileUpType.GetInfoText: string;
begin
  Result := FFileInfo+' = '+FFileFolder+FFileName;
end;

{
********************************* TUpdateInfo **********************************
}
constructor TUpdateInfo.Create(AInfoFileName, AArchFileName: String; const
    AAppFileName: string = '');
 var FI:TFileUpType;
begin
if FileExists(AInfoFileName) then
 begin
 FAppFileName:=AAppFileName;
 FArchFileName:=AArchFileName;
 FUpdateInfoFile:=AInfoFileName;
 FAppSourceFolder:='.\';
 FNewVersion:='';
 FListFiles:=TObjectList<TFileUpType>.Create;
 end
  else
 raise Exception.Create('Update file not found!');
end;

destructor TUpdateInfo.Destroy;
begin
  FListFiles.Free;
  Inherited;
end;

procedure TUpdateInfo.AddFileInUpdate(AValue: TFileUpType);
begin
 if Assigned(FListFiles) then FListFiles.Add(AValue);
end;

function TUpdateInfo.FileListReady: Boolean;
begin
  Result := (FListFiles.Count>0);
end;

function TUpdateInfo.GetFileList: string;
var
  I: TFileUpType;
begin
 Result:='';
  for I in FListFiles do
   if Result>'' then
      Result := Result+' '+I.FFileName
    else
      Result := I.FFileName;
end;

function TUpdateInfo.GetInfoText: string;
begin
  Result := 'MainApp = '+FAppSourceFolder+FAppFileName + ' v.'+FNewVersion;
end;

function TUpdateInfo.NewFileInUpdate(const AFileName: string; const ANote:string = ''): TFileUpType;
  var FU:TFileUpType;
begin
  FU:= TFileUpType.Create(Self, ANote, AFileName);
  Result := FU;
end;

procedure TUpdateInfo.ReadUpdateInfo;
 var FI:TIniFile; SL:TStringList;
  I: Integer;
begin
 FI:=TIniFile.Create(FUpdateInfoFile);
 SL:=TStringList.Create;
 FI.ReadSectionValues(SMainInfoSection,SL);

 SetNewVersion(SL.Values[SVersion]);
 SetAppFileName(SL.Values[SApplication]);
 SetArchFileName(SL.Values[SArchive]);
 SetAppSourceFolder(SL.Values[SSourceappdir]);
  { TODO : Читать ещё список файлов если они есть... }
 SL.Clear;
 FI.ReadSectionValues(SFileList,SL);
  for I := 0 to SL.Count-1 do
   AddFileInUpdate( NewFileInUpdate(SL.ValueFromIndex[I], Copy(SL.Strings[I],1,Pos('=',SL.Strings[I])-1)) );
 FI.Free;  SL.Free;
end;

procedure TUpdateInfo.SetAppFileName(const Value: string);
begin
 if Pos('\',Value)>0 then
  begin
   FAppSourceFolder:= ExtractFileDir(Value);
   FAppFileName:=ExtractFileName(Value);
  end
   else
   FAppFileName := Value;
end;

procedure TUpdateInfo.SetAppSourceFolder(const Value: string);
begin
  FAppSourceFolder := Value;
end;

procedure TUpdateInfo.SetArchFileName(const Value: string);
begin
  FArchFileName := Value;
end;

procedure TUpdateInfo.SetListFiles(const Value: TObjectList<TFileUpType>);
begin
  FListFiles := Value;
end;

procedure TUpdateInfo.SetNewVersion(const Value: string);
begin
  FNewVersion := Value;
end;

procedure TUpdateInfo.WriteUpdateInfo;
 var Ini:TIniFile;
begin
 Ini:=TIniFile.Create(FUpdateInfoFile);
  Ini.WriteString(SMainInfoSection,SVersion,FNewVersion);
  Ini.WriteString(SMainInfoSection,SApplication,FAppFileName);
  Ini.WriteString(SMainInfoSection,SArchive,FArchFileName);
  Ini.WriteString(SMainInfoSection,SSourceappdir,FAppSourceFolder);


 Ini.Free;
 ShowMessage('Файл:'+FUpdateInfoFile+' создан!');
end;



{
*********************************** TUpdate ************************************
}
constructor TUpdate.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FArchivatorFileName:=constArchivatorName;
  FTmpFolder:=constTmpFolder;
  FCheckUpdate:=TTimer.Create(Self);
  FCheckUpdate.Interval:=1000 * FFirstCheckAfterSecond;
  FCheckUpdate.OnTimer:=CheckUpdateOnTimer;
  FCheckUpdate.Enabled:=True;
//
//  FInfoFileName:=String( ExtractFileName(AInfoFileName) );
//  FInfoPath:=ExtractFilePath(AInfoFileName);
 (*TODO: extracted code

  If (csDesigning in ComponentState) or (csLoading in ComponentState) then
  AN:='ApplicationName.exe'
 else
  AN:=ExtractFileName(ParamStr(0));
  AA:=ChangeFileExt(AN,constArchiveDefaultExtension);
  FUpdateInfo:=TUpdateInfo.Create(AN,AA);
 *)
// SetUpdateData(AAppFileName, AInfoFileName);
//  FUpdateInfo.FInfoFileName:= FInfoPath + FInfoFileName;
end;

destructor TUpdate.Destroy;
begin
 If Assigned(FUpdateInfo) then FUpdateInfo.Free;
 If Assigned(FCheckUpdate) then
  FCheckUpdate.Free;

 inherited;
end;

function TUpdate.CheckNewVersion: Boolean;
begin
 if not InfoFileExists then
   raise Exception.Create('INFO File not found.')
 else
 begin
  FUpdateInfo.ReadUpdateInfo;
  Result:= (GetVersionApp(ParamStr(0)) < FUpdateInfo.FNewVersion);
  if Result then DoNewVersionEvent; // генерируем событие
 end;
end;

procedure TUpdate.CheckUpdateOnTimer(Sender: TObject);
begin
 FCheckUpdate.Enabled:=False; // Отключаем повторный запуск
 if CheckNewVersion then GetUpdate;
end;

procedure TUpdate.CreateBAT;
var
 F: Textfile;
 CurDir, CurFile: String;
begin
 CurFile:=ExtractFileName(ParamStr(0));
 CurDir:=ExtractFilePath(ParamStr(0));
 FBatFile:=Changefileext(Paramstr (0),'.bat');
AssignFile(F,FBatFile);
Rewrite(F);
Writeln(F, 'If Exist ',FArchivatorFileName,' Goto 0');
Writeln(F, 'xcopy /Y "', FInfoPath+FArchivatorFileName,'" "', CurDir,'"');
Writeln(F, ':0');
Writeln(F, 'If not Exist ', FUpdateInfo.FArchFileName,' Goto 2');
Writeln(F, ':1');
writeln(F, 'del ',FUpdateInfo.FAppFileName);
Writeln(F, 'If Exist ', FUpdateInfo.FAppFileName,' Goto 1');
writeln(F, FArchivatorFileName,' e -y ',FUpdateInfo.FArchFileName);
writeln(F, 'del ',FUpdateInfo.FArchFileName);
Writeln(F, 'Start ',FUpdateInfo.FAppFileName);
Writeln(F, ':2');
if FDelBATFileAfterUpdate then Writeln(F,'del %0');// удалить батник
CloseFile(F);
end;

procedure TUpdate.DoNewVersionEvent;
begin
  if Assigned(FOnNewVersion) then FOnNewVersion(Self,Self.FUpdateInfo);
end;

procedure TUpdate.DoUpdate;
begin
   if MessageBox(0, PChar('Обновление получено!' + #13#10 +
     'Установить немедленно ?'+#13#10+'Программа будет автоматически перезапущена...'), PChar('Внимание'), MB_YESNO +
     MB_ICONINFORMATION) = IDYES then
   begin
    StartBat;
    Application.Terminate;
   end;
end;

function TUpdate.GetUpdate: Boolean;
begin
 Result:=False;
 if CheckNewVersion then
   if MessageBox(0, PChar('Найдено обновление v.'+FUpdateInfo.FNewVersion+' !' + #13#10 + 'Установить ?'),
     PChar('Внимание'), MB_YESNO + MB_ICONQUESTION) = IDYES then
   begin
    if CopyFile(PWideChar(FInfoPath + FUpdateInfo.FArchFileName),PWideChar(FUpdateInfo.FArchFileName),False) then
     begin
      CreateBAT;

      Result:=True;
     end
      else
      MessageBox(0, PChar('Не удалость скопировать файл архива!'+ #13#10 +FInfoPath + FUpdateInfo.FArchFileName),
        PChar('Внимание'), MB_OK + MB_ICONWARNING);
   end;

end;

function TUpdate.InfoFileExists: Boolean;
begin
  Result := FileExists(FInfoPath + FInfoFileName);
end;

procedure TUpdate.Loaded;
begin
//  inherited;
  if not ( InfoFileName > '' ) then
   ShowMessage('Необходимо ввести имя и расположение информационного файла!');
end;

procedure TUpdate.SetAppFileName(const Value: TAppName);
begin
  FAppFileName := Value;
end;

procedure TUpdate.SetFirstCheckAfterSecond(const Value: Integer);
begin
  FFirstCheckAfterSecond := Value;
end;

procedure TUpdate.SetInfoFileName(const Value: TAppName);
begin
  FInfoFileName:=Value;
end;

procedure TUpdate.SetInfoPath(const Value: string);
begin
  FInfoPath := Value;
end;

procedure TUpdate.SetNextCheckAfterSecond(const Value: Integer);
begin
  FNextCheckAfterSecond := Value;
end;

procedure TUpdate.SetTPath(const Value: TDirectory);
begin
if Value.Exists(Value.GetCurrentDirectory) then

  FInfoPath := Value.GetCurrentDirectory;
end;

procedure TUpdate.SetUpdateData;
var
  AA: String;
begin
 if FAppFileName <> ParamStr(0) then
  if MessageBox(0,
    PChar('Имя текущего приложения отличается от введеного вами!' + #13#10 +
    'Заменить на '+ParamStr(0)+' ?'), PChar('Внимание'), MB_YESNO + MB_ICONWARNING) = IDYES
    then
  begin
    FAppFileName:= ParamStr(0);
  end;

   AA:=ChangeFileExt(FAppFileName,constArchiveDefaultExtension);  // названеи архива

  If not Assigned(FUpdateInfo) then  FUpdateInfo:=TUpdateInfo.Create(FAppFileName,AA) else
  begin
   FUpdateInfo.SetAppFileName(FAppFileName);
   FUpdateInfo.SetArchFileName(AA);
  end;

end;

procedure TUpdate.SetUpdateInfo(const Value: TUpdateInfo);
begin
  FUpdateInfo := Value;
end;

procedure TUpdate.StartBat;
begin
  if FileExists(FBatFile) then
  begin
    FileExec(FBatFile,True,False);
    FNeedAutoReboot:=True;
  end
  else
  begin
    FNeedAutoReboot:=False;
   raise Exception.Create('Командный файл' + FBatFile +#13#10 + 'не найден !');
  end;
end;


{
******************************** TDeployUpdate *********************************
}
procedure TDeployUpdate.CopyArchivator;
begin
if not FileExists(FInfoPath + FArchivatorFileName,False) then
 if not CopyFile(PWideChar(FInfoPath + FArchivatorFileName),PWideChar(ExtractFilePath(FAppFileName) + FArchivatorFileName),False) then
  raise Exception.Create('Невозможно скопировать файл архиватора '+FArchivatorFileName+'!')
end;

procedure TDeployUpdate.CopyArchiveFile;
begin
 if not CopyFile(PWideChar(FUpdateInfo.FArchFileName),PWideChar(FInfoPath + FUpdateInfo.FArchFileName),False) then
  raise Exception.Create('Невозможно скопировать файл архива '+FUpdateInfo.FArchFileName+'!')
 Else
  DeleteFile(PWideChar(FUpdateInfo.FArchFileName));
end;

procedure TDeployUpdate.CreateUpdateInfoFile;
begin
 if FInfoFileName>'' then
   FUpdateInfo.WriteUpdateInfo
  else
   raise Exception.Create('Имя и расположение информационного файла не определено!');
end;

procedure TDeployUpdate.Deploy;
begin
 if not InfoFileExists then
   raise Exception.Create('UPDATEINFO File not found.')
 else
 begin
  ReCreateArchive;
  CopyArchivator;
  CopyArchiveFile;
  CreateUpdateInfoFile;
 end;
end;

function TDeployUpdate.InfoFileExists: Boolean;
begin
  Result := FileExists(FInfoPath + FInfoFileName);
end;

procedure TDeployUpdate.ReCreateArchive;
var
  SLine: string;
begin
 if FileExists(FUpdateInfo.FArchFileName) then
  DeleteFile(PWideChar(FUpdateInfo.FArchFileName)) ;
 Sline:=FArchivatorFileName+' a -y '+FUpdateInfo.FArchFileName+' '+FUpdateInfo.GetFileList;
 if FUpdateInfo.FileListReady then
  if not FileExec(SLine,True,True) then
  begin
   raise Exception.Create('Не удалось создать архив с файлами!');
   Exit;
  end;
end;

procedure TDeployUpdate.SetAppFileName(const Value: TAppName);
begin
  FAppFileName := Value;
end;

procedure TDeployUpdate.SetInfoFileName(const Value: TAppName);
begin
  FInfoFileName:=Value;
end;

procedure TDeployUpdate.SetInfoPath(const Value: string);
begin
  FInfoPath := Value;
end;

procedure TDeployUpdate.SetUpdateInfo(const Value: TUpdateInfo);
begin
  FUpdateInfo := Value;
end;



end.


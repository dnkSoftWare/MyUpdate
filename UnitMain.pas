unit UnitMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uMyUpdate, Vcl.ExtCtrls, Vcl.FileCtrl;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Label1: TLabel;
    Button2: TButton;
    Label2: TLabel;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    MyUpdate1: TMyUpdate;
		procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
		procedure Button3Click(Sender: TObject);
		procedure Button4Click(Sender: TObject);
		procedure Button6Click(Sender: TObject);
		procedure MyUpdate1HaveUpdate(Sender: TObject);
  private
		{ Private declarations }
		myGlobalUpdate: TMyUpdate;
		procedure HaveUpdate(Sender: TObject);
  public
    { Public declarations }
  end;

function GetVersionApp: string;

procedure StopAppAndStartBat;

var
  Form1: TForm1;

implementation
 uses MyThreadingUnit;
{$R *.dfm}

function GetVersionApp: string;
var
  VerInfoSize: DWORD;
  VerInfo: Pointer;
  VerValueSize: DWORD;
  VerValue: PVSFixedFileInfo;
  Dummy: DWORD;
begin
  VerInfoSize := GetFileVersionInfoSize(PChar(ParamStr(0)), Dummy);
  GetMem(VerInfo, VerInfoSize);
  GetFileVersionInfo(PChar(ParamStr(0)), 0, VerInfoSize, VerInfo);
  VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
  with VerValue^ do
  begin
    Result := IntToStr(dwFileVersionMS shr 16);
    Result := Result + '.' + IntToStr(dwFileVersionMS and $FFFF);
    Result := Result + '.' + IntToStr(dwFileVersionLS shr 16);
    Result := Result + '.' + IntToStr(dwFileVersionLS and $FFFF);
  end;
  FreeMem(VerInfo, VerInfoSize);
end;

procedure CreateBatFile(AFromPath, AFromFile: string);
var
F: Textfile;
CurDir, CurFile: String;
begin
CurFile:=ExtractFileName(Application.ExeName);
CurDir:=ExtractFilePath(Application.ExeName);

AssignFile(F,Changefileext(Paramstr (0),'.bat'));
Rewrite(F);
Writeln(F, 'xcopy /Y "', AFromPath+AFromFile, '" "', CurDir, '"');
Writeln(F, 'xcopy /Y "', AFromPath,'rar.exe" "', CurDir,'"');

// Writeln(F,':1');  //создаём метку 1:
Writeln(F, 'If not Exist ', AFromFile,' Goto 2');
WriteLn(F, 'ren ',CurFile,' ',CurFile,'.bak'); //переименовать ехе
// Writeln(F, 'If exist ', CurFile, ' Goto 1');// если файл не удалён перейти на 1:
writeln(F, 'rar e -y ',AFromFile);
writeln(F, 'del ',AFromFile,' rar.exe');
writeln(F, 'If not exist ',CurFile,' Goto 2');
Writeln(F, 'Start ',CurFile);
Writeln(F, ':2');
Writeln(F,'rem del %0');// удалить батник
CloseFile(F);
end;

procedure StopAppAndStartBat;
 var S:String;
begin
S:='"'+ChangeFileExt(Paramstr(0),'.bat')+'"';
//WinExec(PAnsiChar(S),SW_HIDE); // запускаем батник
FileExec(S,True,False);
Application.Terminate;
end;


procedure TForm1.FormDestroy(Sender: TObject);
begin
 // ShowMessage('123');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 Form1.Caption:='version:'+GetVersionApp;
// myGlobalUpdate:=TMyUpdate.Create(Self);
// myGlobalUpdate.CheckFolder:= Edit1.Text;
// myGlobalUpdate.CheckIntervalInSec:= 3 ;
// myGlobalUpdate.OnHaveUpdate:=HaveUpdate;
// myGlobalUpdate.StartCheckUpdate;
// MyUpdate1.StartCheckUpdate;
end;

procedure TForm1.Button1Click(Sender: TObject);
 var SL:TStringList;
     P,F:String;
begin
  SL:=TStringList.Create; SL.LoadFromFile(Edit1.Text);
  If SL.Values['ver'] > GetVersionApp then
   begin
   P:=ExtractFilePath(Edit1.Text);
   Label1.Caption:='Найдено обновление '+SL.Values['ver'] ;
   F:= SL.Values['mod'];
    CreateBatFile(P,F);
    StopAppAndStartBat;
   end;
  SL.Free;
end;

procedure TForm1.Button3Click(Sender: TObject);
 var mUpd:TMyUpdate;
begin
   mUpd:=TMyUpdate.Create(Self, Edit1.Text);
  try
   if mUpd.HaveUpdate then
     if MessageBox(0, PChar('Обновление найдено!' + #13#10 + 'NewVersion:' + mUpd.NewVersion+
       #13#10 + 'About:' + mUpd.AboutNewVersion + #13#10#13#10 + 'Установить обновление?'),
       PChar(Caption), MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) = IDYES then
     begin
       mUpd.DoUpdate;
     end;
  finally
    FreeAndNil(mUpd);
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
Var
 ME:TMyThread1;
 I:Integer;
begin
  I:=0;
  ME:=TMyThread1.Create(3000, procedure begin Inc(I); ME.Synchronize(procedure  begin Label1.Caption:=IntToStr(I); end ) end  );
  ME.FreeOnTerminate:=True;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  chosenDirectory : string;
begin
  // Просим пользователя выбрать требуемый каталог, стартовый каталог C:
  if SelectDirectory('Выберите каталог', '', chosenDirectory)
  then ShowMessage('Выбранный каталог = '+chosenDirectory)
  else ShowMessage('Выбор каталога прервался');
end;

procedure TForm1.HaveUpdate(Sender: TObject);
begin
     with myGlobalUpdate do
     begin
//     Label1.Caption:=myGlobalUpdate.NewVersion;
       if MessageBox(0, PChar('Найдено обновление !' + #13#10 + 'NewVersion:' + NewVersion+
         #13#10 + 'About:' + AboutNewVersion + #13#10#13#10 + 'Установить обновление?'),
         PChar(Caption), MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) = IDYES then
       begin
         DoUpdateInThread;
       end
       else
       if MessageBox(0, PChar('Прекратить проверку  ?'),
         PChar(Application.Title), MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) =
         IDYES then
       begin
         StopCheckThread;
       end;

     end;
end;

procedure TForm1.MyUpdate1HaveUpdate(Sender: TObject);
begin
    with MyUpdate1 do
     begin
//     Label1.Caption:=myGlobalUpdate.NewVersion;
       if MessageBox(0, PChar('Найдено обновление !' + #13#10 + 'NewVersion:' + NewVersion+
         #13#10 + 'About:' + AboutNewVersion + #13#10#13#10 + 'Установить обновление?'),
         PChar(Caption), MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) = IDYES then
       begin
         DoUpdateInThread;
       end
       else
       if MessageBox(0, PChar('Прекратить проверку  ?'),
         PChar(Application.Title), MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) =
         IDYES then
       begin
         StopCheckThread;
       end;
     end;
end;

end.

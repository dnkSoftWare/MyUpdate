unit dnkUpdaterReg;

interface
   Uses System.SysUtils, System.Classes, System.UITypes, Vcl.Forms, Dialogs,
   dnkUpdater, dnkUpdaterEdit , DesignEditors, DesignIntF;



type
  TUpdateCompEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TUpdateInfoFileProperty = class(TPropertyEditor)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure SetValue(const AValue: string); override;
  end;

 procedure Register;

implementation

 procedure Register;
 begin
   RegisterComponents('dnkUpdater', [TUpdate]);
   RegisterPropertyEditor(TypeInfo(TUpdate),NIL,'',TUpdateInfoFileProperty);
 //  RegisterComponentEditor(TUpdate, TUpdateCompEditor);
 end;

procedure TUpdateCompEditor.ExecuteVerb(Index: Integer);
begin
 With TFormUpdateEditor.Create(nil,TUpdate(Component)) do
  begin
    if ispositiveresult (ShowModal) then
      TUpdate(Component).SetInfoFile(InfoFileNameValue);
  end;
end;

function TUpdateCompEditor.GetVerb(Index: Integer): string;
begin
  Result := 'Edit updater...';
  // TODO -cMM: TUpdateCompEditor.GetVerb default body inserted
end;

function TUpdateCompEditor.GetVerbCount: Integer;
begin
  Result := 1;
  // TODO -cMM: TUpdateCompEditor.GetVerbCount default body inserted
end;

procedure TUpdateInfoFileProperty.Edit;
begin
  With TOpenDialog.Create(Nil) do
  begin
   Filter:= 'All files (*.*)|*.*|INFO Files (*.inf)|*.inf';
   FileName:=Value;
   if Execute then
      Value:=FileName;
   Free;
  end;
end;

function TUpdateInfoFileProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

function TUpdateInfoFileProperty.GetValue: string;
begin
  Result := GetStrValue;
end;

procedure TUpdateInfoFileProperty.SetValue(const AValue: string);
begin
  SetStrValue(AValue);
end;

end.

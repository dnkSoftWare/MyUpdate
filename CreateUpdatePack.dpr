program CreateUpdatePack;

uses
  Vcl.Forms,
  UnitGenUpdatePack in 'UnitGenUpdatePack.pas' {FormGenUpdatePack};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormGenUpdatePack, FormGenUpdatePack);
  Application.Run;
end.

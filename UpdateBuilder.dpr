program UpdateBuilder;

uses
  Vcl.Forms,
  UnitBulder in 'UnitBulder.pas' {FormUpdateBuilder};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormUpdateBuilder, FormUpdateBuilder);
  Application.Run;
end.

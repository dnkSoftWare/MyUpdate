program tmupdate;

uses
  Vcl.Forms,
  UnitMain in 'UnitMain.pas' {Form1},
  uMyUpdate in '..\dnkLib\uMyUpdate.pas',
  MyThreadingUnit in '..\dnkLib\MyThreadingUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

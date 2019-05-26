program Simple;

uses
  System.StartUpCopy,
  FMX.Forms,
  Simple.Main in 'Simple.Main.pas' {Form9},
  FMX.Swipe in '..\..\Src\FMX.Swipe.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm9, Form9);
  Application.CreateForm(TForm9, Form9);
  Application.Run;
end.

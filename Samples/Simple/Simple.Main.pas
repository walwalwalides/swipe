unit Simple.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FrameStand, FMX.Layouts, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.MultiView, FMX.Objects, FMX.Effects, FMX.Swipe;

type
  TForm9 = class(TForm)
    MultiView1: TMultiView;
    Swipe1: TSwipe;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form9: TForm9;

implementation

{$R *.fmx}

end.

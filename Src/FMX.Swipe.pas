unit FMX.Swipe;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls, FMX.Layouts, FMX.Objects, FMX.StdCtrls, System.UITypes,
  FMX.Graphics, FMX.MultiView;

type

  TSwipe = class(TLayout)
  private
    FRectangle: TRectangle;
    FTitle: TLabel;
    FButton: TButton;
    FFontColor: TAlphaColor;
    FMultiView: TMultiView;
    function GetFill: TBrush;
    function GetTitle: string;
    procedure SetFill(const Value: TBrush);
    procedure SetFontColor(const Value: TAlphaColor);
    procedure SetTitle(const Value: string);
    procedure DoOnMultiViewShow(Sender: TObject);
    procedure DoOnMultiViewHidden(Sender: TObject);
    procedure DoOnClickSwipe(Sender: TObject);
    procedure SetMultiView(const Value: TMultiView);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    function HasMultiView: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Fill: TBrush read GetFill write SetFill;
    property Title: string read GetTitle write SetTitle;
    property MultiView: TMultiView read FMultiView write SetMultiView;
    property FontColor: TAlphaColor read FFontColor write SetFontColor default TAlphaColorRec.Black;
  end;

implementation

uses
  FMX.MultiView.Types;

{ TSwipe }

constructor TSwipe.Create(AOwner: TComponent);
begin
  inherited;

  Align := TAlignLayout.Bottom;
  Height := 56;

  FRectangle := TRectangle.Create(Self);
  FRectangle.SetSubComponent(True);
  FRectangle.Stored := False;
  FRectangle.Stroke.Kind := TBrushKind.None;
  FRectangle.Align := TAlignLayout.Client;
  FRectangle.Parent := Self;

  FButton := TButton.Create(FRectangle);
  FButton.SetSubComponent(True);
  FButton.Stored := False;
  FButton.StyleLookup := 'arrowuptoolbutton';
  FButton.Align := TAlignLayout.Left;
  FButton.Parent := FRectangle;
  FButton.Align := TAlignLayout.None;
  FButton.OnClick := DoOnClickSwipe;

  FTitle := TLabel.Create(FRectangle);
  FTitle.SetSubComponent(True);
  FTitle.Stored := False;
  FTitle.Align := TAlignLayout.Client;
  FTitle.TextSettings.Font.Size := 20;
  FTitle.TextSettings.HorzAlign := TTextAlign.Center;
  FTitle.Parent := FRectangle;

  Fill.Color := TAlphaColorRec.White;
end;

destructor TSwipe.Destroy;
begin
  if HasMultiView then
    FMultiView.RemoveFreeNotify(Self);

  inherited;
end;

procedure TSwipe.DoOnClickSwipe(Sender: TObject);
begin
  if HasMultiView then
  begin
    if FMultiView.IsShowed then
      FMultiView.HideMaster
    else
      FMultiView.ShowMaster;
  end;
end;

procedure TSwipe.DoOnMultiViewHidden(Sender: TObject);
begin
  FButton.StyleLookup := 'arrowuptoolbutton';
  FRectangle.Parent := Self;
  FRectangle.Align := TAlignLayout.Client;
end;

procedure TSwipe.DoOnMultiViewShow(Sender: TObject);
begin
  FButton.StyleLookup := 'arrowdowntoolbutton';
  FRectangle.Align := TAlignLayout.None;
  FRectangle.Parent := FMultiView;
end;

function TSwipe.GetFill: TBrush;
begin
  Result := FRectangle.Fill;
end;

function TSwipe.GetTitle: string;
begin
  Result := FTitle.Text;
end;

function TSwipe.HasMultiView: Boolean;
begin
  Result := FMultiView <> nil;
end;

procedure TSwipe.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;

  if (AComponent = FMultiView) and (Operation = opRemove) then
    FMultiView := nil;
end;

procedure TSwipe.SetFill(const Value: TBrush);
begin
  FRectangle.Fill := Value;
end;

procedure TSwipe.SetFontColor(const Value: TAlphaColor);
begin
  if FFontColor <> Value then
  begin
    FFontColor := Value;
    FTitle.TextSettings.FontColor := Value;
    FButton.IconTintColor := Value;
  end;
end;

procedure TSwipe.SetMultiView(const Value: TMultiView);
begin
if FMultiView <> Value then
  begin
    FMultiView := Value;

    if HasMultiView then
    begin
      FMultiView.AddFreeNotify(Self);
      FMultiView.Mode := TMultiViewMode.Drawer;
      FMultiView.DrawerOptions.Placement := TPanelPlacement.Bottom;
      FMultiView.OnShown := DoOnMultiViewShow;
      FMultiView.OnHidden := DoOnMultiViewHidden;
    end;
  end;
end;

procedure TSwipe.SetTitle(const Value: string);
begin
  if FTitle.Text <> Value then
    FTitle.Text := Value;
end;

end.

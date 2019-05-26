unit FMX.Swipe.Register;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls, FMX.Layouts, FMX.Objects, FMX.StdCtrls, System.UITypes,
  FMX.Graphics, FMX.MultiView, DesignEditors, DesignMenus, DesignIntf, FMX.Swipe;

type

  TSwipeEditor = class(TComponentEditor)
  private const
    EditorShowHide = 0;
    EditorMode = 1;
    SMultiViewShow = 'Show';
    SMultiViewHide = 'Hide';
  private
    FSwipe: TSwipe;
  public
    constructor Create(AComponent: TComponent; ADesigner: IDesigner); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure PrepareItem(Index: Integer; const AItem: IMenuItem); override;
    procedure ExecuteVerb(Index: Integer); override;
    property Swipe: TSwipe read FSwipe;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('HashLoad', [TSwipe]);
  RegisterComponentEditor(TSwipe, TSwipeEditor);
end;

{ TSwipeEditor }

constructor TSwipeEditor.Create(AComponent: TComponent; ADesigner: IDesigner);
begin
  inherited;
  FSwipe := AComponent as TSwipe;
end;

procedure TSwipeEditor.ExecuteVerb(Index: Integer);
begin
  inherited;
  if (Index = EditorShowHide) and Swipe.HasMultiView then
  begin
    if Swipe.MultiView.IsShowed then
      Swipe.MultiView.HideMaster
    else
      Swipe.MultiView.ShowMaster;
    Designer.Modified;
  end;
end;

function TSwipeEditor.GetVerb(Index: Integer): string;
begin
  Result := string.Empty;

  if Swipe.HasMultiView then
  case Index of
    EditorShowHide:
      if Swipe.MultiView.IsShowed then
        Result := SMultiViewHide
      else
        Result := SMultiViewShow;
  end;
end;

function TSwipeEditor.GetVerbCount: Integer;
begin
  Result := 0;

  if Swipe.HasMultiView then
    Result := 1;
end;

procedure TSwipeEditor.PrepareItem(Index: Integer; const AItem: IMenuItem);
begin
  inherited PrepareItem(Index, AItem);

  if Swipe.HasMultiView then
  begin
    case Index of
      EditorShowHide:
        AItem.Enabled := Swipe.MultiView.HasPresenter and Swipe.MultiView.Presenter.CanShowHideInDesignTime;
    end;
  end;
end;

end.

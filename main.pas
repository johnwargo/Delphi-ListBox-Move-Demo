unit main;

interface

uses
  System.SysUtils, System.Variants, System.Classes, System.Net.URLClient,
  System.Net.HttpClient, System.Net.HttpClientComponent,

  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.ToolWin, Vcl.ComCtrls, Vcl.ImgList,

  Winapi.Windows, Winapi.Messages, Winapi.ShellAPI;

type
  TMoveDirection = (mdUp, mdDown);

  TfrmMain = class(TForm)
    PanelMain: TPanel;
    ListItems: TListBox;
    PanelToolbar: TPanel;
    ToolBar: TToolBar;
    ButtonTop: TButton;
    ButtonBottom: TButton;
    ButtonDown: TButton;
    ButtonUp: TButton;
    StatusBar: TStatusBar;
    procedure StatusBarClick(Sender: TObject);
    procedure ButtonTopClick(Sender: TObject);
    procedure ButtonUpClick(Sender: TObject);
    procedure ButtonDownClick(Sender: TObject);
    procedure ButtonBottomClick(Sender: TObject);
    procedure ListItemsClick(Sender: TObject);
  private
    procedure UpdateFormState;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

function CanMoveItem(List: TListBox; Direction: TMoveDirection): Boolean;
// determines whether there is any space above (mdUp) or below (mdDown)
// from the currently selected item(s)
var
  i, Limit: Integer;
begin
  Result := false;
  // Leave (False) when nothing's selected
  if List.SelCount < 1 then
    exit;
  // one or more selected
  Limit := List.Count - 1;
  if Direction = mdUp then begin
    for i := 0 to Limit do begin
      if List.Selected[i] then begin
        if i > 0 then begin
          Result := true;
          break;
        end;
        break;
      end;
    end;
  end else begin
    for i := Limit downto 0 do begin
      if List.Selected[i] then begin
        if i < Limit then begin
          Result := true;
          break;
        end;
        break;
      end;
    end;
  end;
end;

procedure TfrmMain.UpdateFormState();
var
  canMoveDown, canMoveUp: Boolean;
begin
  // determine whether we can move up and/or down with the
  // selected items
  canMoveDown := CanMoveItem(ListItems, mdDown);
  canMoveUp := CanMoveItem(ListItems, mdUp);
  // set the button status based on it
  ButtonTop.Enabled := canMoveUp;
  ButtonUp.Enabled := canMoveUp;
  ButtonDown.Enabled := canMoveDown;
  ButtonBottom.Enabled := canMoveDown;
end;

procedure DisableButton(Sender: TObject);
// Disables the button using the Sender object
// Keps me from having to manually disable a specific button
var
  btn: TButton;
begin
  btn := Sender as TButton;
  btn.Enabled := false;
end;

procedure SwapListItem(List: TListBox; SrcIdx: Integer; md: TMoveDirection;
  keepSelection: Boolean = true);
// for a single selected item, swaps it with another item in the list
var
  DestStr: String;
  DestIdx: Integer;
begin
  DestIdx := SrcIdx - 1; // Assume up
  if md = TMoveDirection.mdDown then // check and assign down
    DestIdx := SrcIdx + 1;
  DestStr := List.Items[DestIdx];
  List.Items[DestIdx] := List.Items[SrcIdx];
  List.Selected[DestIdx] := true;
  List.Items[SrcIdx] := DestStr;
  List.Selected[SrcIdx] := false;
end;

procedure TfrmMain.ButtonTopClick(Sender: TObject);
// Move all the selected items to the top of the list
var
  SelList: TStringList;
  i: Integer;
begin
  // Disable the button just clicked so the user can't click it twice
  // before we're done
  DisableButton(Sender);
  // create a temporary string list to hold the selected items
  SelList := TStringList.Create;
  // populate the temporary string list
  for i := ListItems.Count - 1 downto 0 do begin
    if ListItems.Selected[i] then begin
      SelList.Add(ListItems.Items[i])
    end;
  end;
  // delete all of the selected items (all have been copied to the
  // temporary sring list
  ListItems.DeleteSelected;
  // Insert all of the selected items at the top of the list
  for i := 0 to SelList.Count - 1 do begin
    ListItems.Items.Insert(0, SelList.Strings[i]);
    ListItems.Selected[0] := true;
  end;
  SelList.Free;
  UpdateFormState;
end;

procedure TfrmMain.ButtonUpClick(Sender: TObject);
var
  SelList: TStringList;
  i, Limit, StartIdx, TempIdx: Integer;
  HasIdx: Boolean;
begin
  // Disable the button just clicked so the user can't click it twice
  // before we're done
  DisableButton(Sender);
  // is there only one selected?
  if ListItems.SelCount < 2 then begin
    SwapListItem(ListItems, ListItems.ItemIndex, TMoveDirection.mdUp);
  end else begin
    // Move all the selected ones
    StartIdx := -1;
    SelList := TStringList.Create;
    HasIdx := false;
    Limit := ListItems.Count - 1;
    for i := 0 to Limit do begin
      if ListItems.Selected[i] then begin
        SelList.Add(ListItems.Items[i]);
        if not HasIdx then begin
          StartIdx := i;
          HasIdx := true;
        end;
      end;
    end;
    ListItems.DeleteSelected;
    // decrement the start idx (this handles the move)
    Dec(StartIdx);
    // insert all the items at the index
    for i := 0 to SelList.Count - 1 do begin
      TempIdx := StartIdx + i;
      ListItems.Items.Insert(TempIdx, SelList.Strings[i]);
      ListItems.Selected[TempIdx] := true;
    end;
    SelList.Free;
  end;
  UpdateFormState;
end;

procedure TfrmMain.ButtonDownClick(Sender: TObject);
var
  SelList: TStringList;
  i, Limit, StartIdx: Integer;
  HasIdx: Boolean;
begin
  // Disable the button just clicked so the user can't click it twice
  // before we're done
  DisableButton(Sender);
  if ListItems.SelCount < 2 then begin
    SwapListItem(ListItems, ListItems.ItemIndex, TMoveDirection.mdDown);
  end else begin
    StartIdx := -1;
    SelList := TStringList.Create;
    HasIdx := false;
    Limit := ListItems.Count - 1;
    for i := Limit downto 0 do begin
      if ListItems.Selected[i] then begin
        SelList.Add(ListItems.Items[i]);
        if not HasIdx then begin
          StartIdx := i;
          HasIdx := true;
        end;
      end;
    end;
    ListItems.DeleteSelected;
    // increment the start idx (this handles the move)
    StartIdx := StartIdx - SelList.Count + 2;
    // insert all the items at the index
    for i := 0 to SelList.Count - 1 do begin
      ListItems.Items.Insert(StartIdx, SelList.Strings[i]);
      ListItems.Selected[StartIdx] := true;
    end;
    SelList.Free;
  end;
  UpdateFormState;
end;

procedure TfrmMain.ButtonBottomClick(Sender: TObject);
// Move all the selected items to the bottom of the list
var
  SelList: TStringList;
  i: Integer;
begin
  // Disable the button just clicked so the user can't click it twice
  // before we're done
  DisableButton(Sender);
  SelList := TStringList.Create;
  for i := 0 to ListItems.Count - 1 do begin
    if ListItems.Selected[i] then begin
      SelList.Add(ListItems.Items[i])
    end;
  end;
  ListItems.DeleteSelected;
  for i := 0 to SelList.Count - 1 do begin
    ListItems.Items.AddStrings(SelList.Strings[i]); // append to the bottom
    ListItems.Selected[ListItems.Count - 1] := true; // set its selected state
  end;
  SelList.Free;
  UpdateFormState;
end;

procedure TfrmMain.ListItemsClick(Sender: TObject);
begin
  UpdateFormState;
end;

procedure TfrmMain.StatusBarClick(Sender: TObject);
begin
  // open the web site
  ShellExecute(self.WindowHandle, 'open', 'https://johnwargo.com', nil, nil,
    SW_SHOWNORMAL);
end;

end.

# Delphi ListBox Multiselect Item(s) Move Demo

A simple Delphi application that shows how to move one or more selected items around in a ListBox component.

## Background

I was working on a Windows application project in Delphi that required moving items around within a Delphi standard [ListBox](https://docwiki.embarcadero.com/Libraries/Alexandria/en/Vcl.StdCtrls.TListBox). It's pretty easy to swap list item position when only a single item is selected, but once you enable `multiselect` on the component, things become more difficult. As I poked around on the Internet for solutions, I couldn't find a complete example, so I decided to create and publish one. Here it is.

## About The Code

As I started writing the code that responded to the different buttons, I realized that in order for this to work, the app needed to detect whether the item(s) **could** move before actually trying to move the item(s). Rather than build the logic into the buttons themselves, I made a simple procedure called `UpdateFormState` that did the checking for me; here's the code:

```pascal
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
```

With that in place, everywhere the app could affect selected items, I made a call to the `UpdateFormState` procedure. Each of the buttons will enable or disable depending on whether the button can act on the selected item positions.

Rather than hard-coding disabling buttons so users can't click them again while the application is moving ListBox items, I did something I've never done before. Every time you trigger an event on a Delphi component, Delphi passes the resulting procedure call a `Sender` object which is the component that fired the event. To simplify things, created a procedure that used the `Sender` object to get a handle to the clicked button, then set the `Enabled` property on that object to `False` to disable the button. This made the code much cleaner.

```pascal
procedure DisableButton(Sender: TObject);
// Disables the button using the Sender object
// Keps me from having to manually disable a specific button
var
  btn: TButton;
begin
  btn := Sender as TButton;
  btn.Enabled := false;
end;
```

Take a look at the code for each button to see how I moved multiple selected items around in the app.

## Runtime

When you run the app, it opens with a list of random words paired into 2, 3 or 4 word phrases in the list box. Select one or more items in the list, then click the buttons to move the selected items to the Top or Bottom of the list or to move them up or down.

![Application Main Screen](images/image-01.png)

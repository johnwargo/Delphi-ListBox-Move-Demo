unit main;

interface

uses
  Winapi.Windows, Winapi.Messages,

  System.SysUtils, System.Variants, System.Classes, System.Net.URLClient,
  System.Net.HttpClient, System.Net.HttpClientComponent,

  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.ToolWin, Vcl.ComCtrls, System.ImageList, Vcl.ImgList;

type
  TfrmMain = class(TForm)
    PanelMain: TPanel;
    ListItems: TListBox;
    PanelToolbar: TPanel;
    ToolBar: TToolBar;
    ButtonTop: TButton;
    ButtonBottom: TButton;
    ButtonDown: TButton;
    ButtonUp: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

end.

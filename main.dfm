object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'ListBox Move Demo'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object PanelMain: TPanel
    Left = 0
    Top = 30
    Width = 624
    Height = 386
    Align = alClient
    BevelOuter = bvNone
    Padding.Left = 10
    Padding.Top = 5
    Padding.Right = 10
    Padding.Bottom = 10
    TabOrder = 0
    ExplicitWidth = 622
    ExplicitHeight = 403
    object ListItems: TListBox
      Left = 10
      Top = 5
      Width = 604
      Height = 371
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ItemHeight = 17
      Items.Strings = (
        'saluted renews greaseproofs'
        'mortally bezzant shmaltzes unveiled'
        'platoon conservancy'
        'zareeba paupiettes ripsaw'
        'anechoic conepatl sonovox acetonitriles'
        'inertness haranguing siddurs'
        'tovariches knobbier parsnips'
        'memorability phenytoins'
        'dullsvilles gullible veridicalities'
        'dominie furthered woolsack fleahopper'
        'forklifting phagocytose'
        'choicenesses babooneries utopians'
        'beshadowed puparia'
        'man fabulist fashions sylvas'
        'dhooras calos disaccustomed'
        'geosynclinal relending'
        'reminded reasserts'
        'draw bluetongues fucoses'
        'obtests reseeing libelees febrifuge'
        'effervesce nannyish mornings'
        'overheats nialamide'
        'vetivert sabs swobbers anergias'
        'sagest shekels nebulousness'
        'frameable conceptuses'
        'redigested holm'
        'serries slivering sacklike'
        'frogged murthering bureaus epiphyses'
        'crampoon frostline'
        'jackfruits bifidly'
        'tubeworm disfavoured gavots'
        'dilatorily acquiescences'
        'mammocking ashiness cashaw celebration'
        'kats effronteries misspoken'
        'saponated flingers birthname helminthology')
      MultiSelect = True
      ParentFont = False
      TabOrder = 0
      OnClick = ListItemsClick
      ExplicitWidth = 602
      ExplicitHeight = 388
    end
  end
  object PanelToolbar: TPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 30
    Align = alTop
    AutoSize = True
    BevelOuter = bvNone
    Padding.Left = 5
    Padding.Top = 5
    Padding.Right = 5
    TabOrder = 1
    ExplicitWidth = 622
    object ToolBar: TToolBar
      Left = 5
      Top = 5
      Width = 614
      Height = 25
      Align = alClient
      ButtonHeight = 25
      ButtonWidth = 43
      EdgeInner = esNone
      EdgeOuter = esNone
      Indent = 10
      List = True
      ParentShowHint = False
      ShowCaptions = True
      AllowTextButtons = True
      ShowHint = True
      TabOrder = 0
      ExplicitWidth = 612
      object ButtonTop: TButton
        Left = 10
        Top = 0
        Width = 75
        Height = 25
        Hint = 'Move the selected item(s) to the top of the list'
        Caption = '&Top'
        TabOrder = 0
        OnClick = ButtonTopClick
      end
      object ButtonUp: TButton
        Left = 85
        Top = 0
        Width = 75
        Height = 25
        Hint = 'Move the selected item(s) up one position in the list'
        Caption = 'Up'
        TabOrder = 3
        OnClick = ButtonUpClick
      end
      object ButtonDown: TButton
        Left = 160
        Top = 0
        Width = 75
        Height = 25
        Hint = 'Move the selected item(s) down one position in the list'
        Caption = 'Down'
        TabOrder = 2
        OnClick = ButtonDownClick
      end
      object ButtonBottom: TButton
        Left = 235
        Top = 0
        Width = 75
        Height = 25
        Hint = 'Move the selected item(s) to the bottom of the list'
        Caption = 'Bottom'
        TabOrder = 1
        OnClick = ButtonBottomClick
      end
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 416
    Width = 624
    Height = 25
    Panels = <
      item
        Bevel = pbNone
        Text = 'By John M. Wargo (https://johnwargo.com)'
        Width = 50
      end>
    OnClick = StatusBarClick
    ExplicitTop = 411
  end
end

object MainFrm: TMainFrm
  Left = 794
  Top = 357
  Caption = 'MesoScan V1.6.9 64 bit 20/1/20'
  ClientHeight = 1122
  ClientWidth = 828
  Color = clBlack
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  OnShow = FormShow
  TextHeight = 13
  object ControlGrp: TGroupBox
    Left = 8
    Top = 0
    Width = 297
    Height = 97
    Caption = ' Scan Control '
    Color = clGray
    ParentBackground = False
    ParentColor = False
    TabOrder = 0
    object bScanImage: TButton
      Left = 58
      Top = 40
      Width = 110
      Height = 20
      Hint = 'Scan new image'
      Caption = 'Scan Image'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = bScanImageClick
    end
    object bStopScan: TButton
      Left = 58
      Top = 63
      Width = 110
      Height = 20
      Hint = 'Stop scanning'
      Caption = 'Stop'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = bStopScanClick
    end
    object ckRepeat: TCheckBox
      Left = 220
      Top = 28
      Width = 65
      Height = 17
      Hint = 'Repeated image scanning'
      Caption = 'Repeat'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object rbFastScan: TRadioButton
      Left = 220
      Top = 10
      Width = 100
      Height = 17
      Hint = 'High speed image'
      Caption = 'Fast '
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      TabStop = True
      OnClick = rbFastScanClick
    end
    object rbHRScan: TRadioButton
      Left = 220
      Top = 55
      Width = 100
      Height = 17
      Hint = 'High resolution image'
      Caption = 'Hi Res.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = rbHRScanClick
    end
    object bScanZoomOut: TButton
      Left = 15
      Top = 40
      Width = 35
      Height = 20
      Hint = 'Zoom Out: Scan Image using previous ROI '
      Caption = '-'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = bScanZoomOutClick
    end
    object bScanZoomIn: TButton
      Left = 175
      Top = 40
      Width = 35
      Height = 20
      Hint = 'Zoom In: Scan image within user selected region of interest.'
      Caption = '+'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      OnClick = bScanZoomInClick
    end
    object bScanFull: TButton
      Left = 58
      Top = 16
      Width = 110
      Height = 20
      Hint = 'Scan full field of view'
      Caption = 'Scan Full Field'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      OnClick = bScanFullClick
    end
  end
  object ImageGrp: TGroupBox
    Left = 311
    Top = 4
    Width = 474
    Height = 353
    Color = clBlack
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentBackground = False
    ParentColor = False
    ParentFont = False
    TabOrder = 1
    object lbReadout: TLabel
      Left = 267
      Top = 315
      Width = 65
      Height = 16
      Caption = 'lbReadout'
      Color = clBlack
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Image0: TImage
      Left = 9
      Top = 37
      Width = 281
      Height = 178
      ParentShowHint = False
      ShowHint = False
      Stretch = True
      OnDblClick = Image0DblClick
      OnMouseDown = Image0MouseDown
      OnMouseMove = Image0MouseMove
      OnMouseUp = Image0MouseUp
    end
    object ZSectionPanel: TPanel
      Left = 159
      Top = 233
      Width = 170
      Height = 25
      BevelOuter = bvNone
      TabOrder = 0
      object lbZSection: TLabel
        Left = 119
        Top = 0
        Width = 32
        Height = 16
        Caption = 'xxxx'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object scZSection: TScrollBar
        Left = 0
        Top = 0
        Width = 113
        Height = 20
        PageSize = 0
        TabOrder = 0
        OnChange = scZSectionChange
      end
    end
    object Panel1: TPanel
      Left = 3
      Top = 8
      Width = 86
      Height = 20
      BevelOuter = bvNone
      TabOrder = 1
    end
    object ZoomPanel: TPanel
      Left = 9
      Top = 317
      Width = 105
      Height = 25
      BevelOuter = bvNone
      TabOrder = 2
      object lbZoom: TLabel
        Left = 0
        Top = 0
        Width = 63
        Height = 16
        Caption = 'Zoom (X1)'
        Color = clRed
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object bZoomIn: TButton
        Left = 63
        Top = 0
        Width = 17
        Height = 17
        Hint = 'Magnify displayed imaged'
        Caption = '+'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = bZoomInClick
      end
      object bZoomOut: TButton
        Left = 82
        Top = 0
        Width = 17
        Height = 17
        Hint = 'Reduce image magnification'
        Caption = '-'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = bZoomOutClick
      end
    end
    object ImagePage: TPageControl
      Left = 5
      Top = 9
      Width = 294
      Height = 22
      ActivePage = TabImage2
      TabOrder = 3
      OnChange = ImagePageChange
      object TabImage0: TTabSheet
        Caption = 'PMT0'
      end
      object TabImage1: TTabSheet
        Caption = 'TabImage1'
        ImageIndex = 1
      end
      object TabImage2: TTabSheet
        Caption = 'TabImage2'
        ImageIndex = 2
      end
      object TabImage3: TTabSheet
        Caption = 'TabImage3'
        ImageIndex = 3
      end
    end
  end
  object ImageSizeGrp: TGroupBox
    Left = 8
    Top = 102
    Width = 297
    Height = 222
    Caption = ' Image '
    Color = clGray
    ParentBackground = False
    ParentColor = False
    TabOrder = 2
    object Label4: TLabel
      Left = 95
      Top = 46
      Width = 146
      Height = 16
      Alignment = taRightJustify
      Caption = 'No. images per average'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object edNumRepeats: TValidatedEdit
      Left = 247
      Top = 46
      Width = 33
      Height = 24
      Hint = 'No. of images to be averaged'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ShowHint = True
      Text = ' 1 '
      Value = 1.000000000000000000
      Scale = 1.000000000000000000
      NumberFormat = '%.0f'
      LoLimit = 1.000000000000000000
      HiLimit = 20000.000000000000000000
    end
    object ZStackGrp: TGroupBox
      Left = 12
      Top = 105
      Width = 190
      Height = 104
      TabOrder = 1
      object Label5: TLabel
        Left = 56
        Top = 16
        Width = 59
        Height = 13
        Alignment = taRightJustify
        Caption = 'No. sections'
      end
      object Label6: TLabel
        Left = 4
        Top = 43
        Width = 111
        Height = 13
        Alignment = taRightJustify
        Caption = 'Section spacing (pixels)'
      end
      object Label1: TLabel
        Left = 16
        Top = 70
        Width = 99
        Height = 13
        Alignment = taRightJustify
        Caption = 'Section spacing (um)'
      end
      object edNumZsteps: TValidatedEdit
        Left = 121
        Top = 16
        Width = 57
        Height = 21
        Hint = 'No. of sections to be acquired'
        ShowHint = True
        Text = ' 1 '
        Value = 1.000000000000000000
        Scale = 1.000000000000000000
        NumberFormat = '%.0f'
        LoLimit = 1.000000000000000000
        HiLimit = 20000.000000000000000000
      end
      object edNumPixelsPerZStep: TValidatedEdit
        Left = 121
        Top = 43
        Width = 57
        Height = 21
        Hint = 'Z increment between sections (pixels)'
        OnKeyPress = edNumPixelsPerZStepKeyPress
        ShowHint = True
        Text = ' 1.000 '
        Value = 1.000000000000000000
        Scale = 1.000000000000000000
        NumberFormat = '%.3f'
        LoLimit = -100.000000000000000000
        HiLimit = 100.000000000000000000
      end
      object edMicronsPerZStep: TValidatedEdit
        Left = 121
        Top = 70
        Width = 57
        Height = 21
        Hint = 'Z increment between sections (microns)'
        OnKeyPress = edMicronsPerZStepKeyPress
        ShowHint = True
        Text = ' 0.000 um'
        Scale = 1.000000000000000000
        Units = 'um'
        NumberFormat = '%.3f'
        LoLimit = -100.000000000000000000
        HiLimit = 100.000000000000000000
      end
    end
    object cbImageMode: TComboBox
      Left = 12
      Top = 19
      Width = 268
      Height = 21
      Hint = 'Image acquisition mode'
      Style = csDropDownList
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnChange = cbImageModeChange
    end
    object LineScanGrp: TGroupBox
      Left = 12
      Top = 105
      Width = 190
      Height = 104
      TabOrder = 3
      object Label2: TLabel
        Left = 63
        Top = 16
        Width = 52
        Height = 16
        Alignment = taRightJustify
        Caption = 'No. lines'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object edLineScanFrameHeight: TValidatedEdit
        Left = 121
        Top = 16
        Width = 57
        Height = 24
        Hint = 'No. lines in line scan image'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ShowHint = True
        Text = ' 1000 '
        Value = 1000.000000000000000000
        Scale = 1.000000000000000000
        NumberFormat = '%.0f'
        LoLimit = 10.000000000000000000
        HiLimit = 30000.000000000000000000
      end
    end
    object ckKeepRepeats: TCheckBox
      Left = 68
      Top = 74
      Width = 212
      Height = 25
      Hint = 'Tick to save sections in file for later off-line averaging'
      Alignment = taLeftJustify
      Caption = 'Keep images for later averaging'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
  end
  object ZStageGrp: TGroupBox
    Left = 8
    Top = 328
    Width = 297
    Height = 93
    Caption = 'Z Position '
    Color = clGray
    ParentBackground = False
    ParentColor = False
    TabOrder = 3
    object edZTop: TValidatedEdit
      Left = 12
      Top = 16
      Width = 115
      Height = 28
      Hint = 'Stage position on Z axis'
      Color = clYellow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ShowHint = True
      Text = ' 0.00 um'
      Scale = 1.000000000000000000
      Units = 'um'
      NumberFormat = '%.2f'
      LoLimit = -10.000000000000000000
      HiLimit = 10.000000000000000000
    end
    object edGotoZPosition: TValidatedEdit
      Left = 192
      Top = 16
      Width = 100
      Height = 24
      Hint = 'Z axis position to move to'
      OnKeyPress = edGotoZPositionKeyPress
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ShowHint = True
      Text = ' 0.00 um'
      Scale = 1.000000000000000000
      Units = 'um'
      NumberFormat = '%.2f'
      LoLimit = -1000000.000000000000000000
      HiLimit = 1000000.000000000000000000
    end
    object bGotoZPosition: TButton
      Left = 133
      Top = 16
      Width = 57
      Height = 28
      Hint = 'Move stage to specified Z axis position'
      Caption = 'Go To'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = bGotoZPositionClick
    end
    object tbZPosition: TTrackBar
      Left = 12
      Top = 48
      Width = 282
      Height = 25
      Max = 10000
      Min = -1000
      Position = 5820
      TabOrder = 3
      ThumbLength = 14
      TickStyle = tsManual
      OnChange = tbZPositionChange
    end
    object rbZDialCoarse: TRadioButton
      Left = 75
      Top = 65
      Width = 73
      Height = 17
      Caption = 'Coarse'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      TabStop = True
    end
    object rbZDialFine: TRadioButton
      Left = 16
      Top = 65
      Width = 60
      Height = 17
      Caption = 'Fine'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
    end
  end
  object PMTGrp: TGroupBox
    Left = 8
    Top = 430
    Width = 295
    Height = 180
    Caption = ' PMT Channels  '
    Color = clGray
    ParentBackground = False
    ParentColor = False
    TabOrder = 4
    object Label15: TLabel
      Left = 56
      Top = 16
      Width = 22
      Height = 13
      Caption = 'Gain'
    end
    object Label3: TLabel
      Left = 114
      Top = 16
      Width = 23
      Height = 13
      Caption = 'Volts'
    end
    object PanelPMT0: TPanel
      Left = 3
      Top = 35
      Width = 238
      Height = 30
      BevelOuter = bvNone
      TabOrder = 0
      object cbPMTGain0: TComboBox
        Left = 53
        Top = 2
        Width = 49
        Height = 24
        Hint = 'PMT amplifier gain'
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ItemIndex = 0
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        Text = 'X1'
        Items.Strings = (
          'X1'
          'X2'
          'X5')
      end
      object edPMTVolts0: TValidatedEdit
        Left = 108
        Top = 2
        Width = 65
        Height = 24
        Hint = 'PMT voltage (% of maximum)'
        OnKeyPress = edPMTVolts0KeyPress
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ShowHint = True
        Text = ' 100 %'
        Value = 100.000000000000000000
        Scale = 1.000000000000000000
        Units = '%'
        NumberFormat = '%.0f'
        LoLimit = -1.000000015047466E30
        HiLimit = 100.000000000000000000
      end
      object ckEnablePMT0: TCheckBox
        Left = 0
        Top = 0
        Width = 47
        Height = 17
        Caption = 'Ch.0'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = ckEnablePMT0Click
      end
      object udPMTVolts0: TUpDown
        Left = 173
        Top = 2
        Width = 30
        Height = 24
        Min = -30000
        Max = 30000
        TabOrder = 3
        OnChangingEx = udPMTVolts0ChangingEx
      end
      object gpPMTColor0: TGroupBox
        Left = 210
        Top = 3
        Width = 20
        Height = 20
        Color = clGreen
        ParentBackground = False
        ParentColor = False
        TabOrder = 4
        OnClick = gpPMTColor0Click
      end
    end
    object PanelPMT1: TPanel
      Left = 3
      Top = 67
      Width = 238
      Height = 30
      BevelOuter = bvNone
      TabOrder = 1
      object cbPMTGain1: TComboBox
        Left = 53
        Top = 2
        Width = 49
        Height = 24
        Hint = 'PMT amplifier gain'
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ItemIndex = 0
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        Text = 'X1'
        Items.Strings = (
          'X1'
          'X2'
          'X5')
      end
      object edPMTVolts1: TValidatedEdit
        Left = 108
        Top = 2
        Width = 65
        Height = 24
        Hint = 'PMT voltage (% of maximum)'
        OnKeyPress = edPMTVolts0KeyPress
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ShowHint = True
        Text = ' 1 %'
        Value = 1.000000000000000000
        Scale = 1.000000000000000000
        Units = '%'
        NumberFormat = '%.0f'
        LoLimit = -1.000000015047466E30
        HiLimit = 100.000000000000000000
      end
      object ckEnablePMT1: TCheckBox
        Left = 0
        Top = 0
        Width = 47
        Height = 17
        Caption = 'Ch.1'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = ckEnablePMT0Click
      end
      object udPMTVolts1: TUpDown
        Left = 173
        Top = 2
        Width = 30
        Height = 24
        TabOrder = 3
        OnChangingEx = udPMTVolts1ChangingEx
      end
      object gpPMTColor1: TGroupBox
        Left = 210
        Top = 3
        Width = 20
        Height = 20
        Color = clGreen
        ParentBackground = False
        ParentColor = False
        TabOrder = 4
        OnClick = gpPMTColor0Click
      end
    end
    object PanelPMT2: TPanel
      Left = 3
      Top = 99
      Width = 238
      Height = 30
      BevelOuter = bvNone
      TabOrder = 2
      object cbPMTGain2: TComboBox
        Left = 53
        Top = 2
        Width = 49
        Height = 24
        Hint = 'PMT amplifier gain'
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ItemIndex = 0
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        Text = 'X1'
        Items.Strings = (
          'X1'
          'X2'
          'X5')
      end
      object edPMTVolts2: TValidatedEdit
        Left = 108
        Top = 2
        Width = 65
        Height = 24
        Hint = 'PMT voltage (% of maximum)'
        OnKeyPress = edPMTVolts0KeyPress
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ShowHint = True
        Text = ' 1 %'
        Value = 1.000000000000000000
        Scale = 1.000000000000000000
        Units = '%'
        NumberFormat = '%.0f'
        LoLimit = -1.000000015047466E30
        HiLimit = 100.000000000000000000
      end
      object ckEnablePMT2: TCheckBox
        Left = 0
        Top = 0
        Width = 47
        Height = 17
        Caption = 'Ch.2'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = ckEnablePMT0Click
      end
      object udPMTVolts2: TUpDown
        Left = 173
        Top = 2
        Width = 30
        Height = 24
        TabOrder = 3
        OnChangingEx = udPMTVolts2ChangingEx
      end
      object gpPMTColor2: TGroupBox
        Left = 210
        Top = 3
        Width = 20
        Height = 20
        Color = clGreen
        ParentBackground = False
        ParentColor = False
        TabOrder = 4
        OnClick = gpPMTColor0Click
      end
    end
    object PanelPMT3: TPanel
      Left = 3
      Top = 130
      Width = 238
      Height = 30
      BevelOuter = bvNone
      TabOrder = 3
      object cbPMTGain3: TComboBox
        Left = 53
        Top = 2
        Width = 49
        Height = 24
        Hint = 'PMT amplifier gain'
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ItemIndex = 0
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        Text = 'X1'
        Items.Strings = (
          'X1'
          'X2'
          'X5')
      end
      object edPMTVolts3: TValidatedEdit
        Left = 108
        Top = 2
        Width = 65
        Height = 24
        Hint = 'PMT voltage (% of maximum)'
        ParentCustomHint = False
        OnKeyPress = edPMTVolts0KeyPress
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Text = ' 1 %'
        Value = 1.000000000000000000
        Scale = 1.000000000000000000
        Units = '%'
        NumberFormat = '%.0f'
        LoLimit = -1.000000015047466E30
        HiLimit = 100.000000000000000000
      end
      object ckEnablePMT3: TCheckBox
        Left = 0
        Top = 0
        Width = 47
        Height = 17
        Caption = 'Ch.3'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = ckEnablePMT0Click
      end
      object udPMTVolts3: TUpDown
        Left = 173
        Top = 2
        Width = 30
        Height = 24
        TabOrder = 3
        OnChangingEx = udPMTVolts3ChangingEx
      end
      object gpPMTColor3: TGroupBox
        Left = 210
        Top = 5
        Width = 20
        Height = 20
        Color = clGreen
        ParentBackground = False
        ParentColor = False
        TabOrder = 4
        OnClick = gpPMTColor0Click
      end
    end
  end
  object LaserGrp: TGroupBox
    Left = 8
    Top = 616
    Width = 297
    Height = 56
    Caption = ' Laser '
    Color = clGray
    ParentBackground = False
    ParentColor = False
    TabOrder = 5
    object edLaserIntensity: TValidatedEdit
      Left = 231
      Top = 16
      Width = 44
      Height = 24
      OnKeyPress = edLaserIntensityKeyPress
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Text = ' 2 %'
      Value = 2.000000000000000000
      Scale = 1.000000000000000000
      Units = '%'
      NumberFormat = '%.0f'
      LoLimit = 0.000000999999997475
      HiLimit = 100.000000000000000000
    end
    object tbLaserIntensity: TTrackBar
      Left = 48
      Top = 16
      Width = 177
      Height = 25
      Max = 1000
      Position = 100
      TabOrder = 1
      ThumbLength = 14
      TickStyle = tsManual
      OnChange = tbLaserIntensityChange
    end
    object rbLaserOn: TRadioButton
      Left = 12
      Top = 15
      Width = 40
      Height = 17
      Caption = 'On'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial Narrow'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
    object rbLaserOff: TRadioButton
      Left = 12
      Top = 31
      Width = 40
      Height = 17
      Caption = 'Off'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial Narrow'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      TabStop = True
    end
  end
  object DisplayGrp: TGroupBox
    Left = 8
    Top = 678
    Width = 297
    Height = 371
    Caption = ' Display '
    Color = clGray
    ParentBackground = False
    ParentColor = False
    TabOrder = 6
    object Splitter1: TSplitter
      Left = 2
      Top = 15
      Height = 354
      ExplicitLeft = 3
      ExplicitTop = 17
      ExplicitHeight = 341
    end
    object plHistogram: TXYPlotDisplay
      Left = 11
      Top = 45
      Width = 275
      Height = 171
      MaxPointsPerLine = 4096
      XAxisMax = 1.000000000000000000
      XAxisTick = 0.200000002980232200
      XAxisLaw = axLinear
      XAxisLabel = 'X Axis'
      XAxisAutoRange = False
      YAxisMax = 1.000000000000000000
      YAxisTick = 0.200000002980232200
      YAxisLaw = axLog
      YAxisLabel = 'Y Axis'
      YAxisAutoRange = False
      YAxisLabelAtTop = False
      ScreenFontName = 'Arial'
      ScreenFontSize = 10
      LineWidth = 1
      MarkerSize = 6
      ShowLines = True
      ShowMarkers = False
      HistogramFullBorders = False
      HistogramFillColor = clWhite
      HistogramFillStyle = bsClear
      HistogramCumulative = False
      HistogramPercentage = False
      PrinterFontSize = 10
      PrinterFontName = 'Arial'
      PrinterLineWidth = 1
      PrinterMarkerSize = 5
      PrinterLeftMargin = 0
      PrinterRightMargin = 0
      PrinterTopMargin = 0
      PrinterBottomMargin = 0
      PrinterDisableColor = False
      MetafileWidth = 500
      MetafileHeight = 400
    end
    object cbPalette: TComboBox
      Left = 11
      Top = 15
      Width = 275
      Height = 24
      Hint = 'Display colour palette'
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnChange = cbPaletteChange
    end
    object gpYAxis: TGroupBox
      Left = 11
      Top = 220
      Width = 130
      Height = 45
      Caption = ' Y Axis '
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Arial Narrow'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object rbYAxisLinear: TRadioButton
        Left = 8
        Top = 16
        Width = 64
        Height = 20
        Caption = 'Linear'
        Color = clRed
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        TabOrder = 0
      end
      object rbYAxisLog: TRadioButton
        Left = 78
        Top = 16
        Width = 64
        Height = 20
        Caption = 'Log'
        Checked = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        TabStop = True
      end
    end
    object gpHistogramType: TGroupBox
      Left = 147
      Top = 222
      Width = 138
      Height = 44
      Caption = ' Histogram'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Arial Narrow'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object rbLineHistogram: TRadioButton
        Left = 3
        Top = 16
        Width = 56
        Height = 25
        Caption = 'Line'
        Checked = True
        Color = clRed
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        TabOrder = 0
        TabStop = True
      end
      object rbImageHistogram: TRadioButton
        Left = 60
        Top = 16
        Width = 64
        Height = 25
        Caption = 'Image'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = rbImageHistogramClick
      end
    end
    object gpContrast: TGroupBox
      Left = 11
      Top = 269
      Width = 275
      Height = 98
      Caption = ' Contrast '
      TabOrder = 3
      object bFullScale: TButton
        Left = 8
        Top = 16
        Width = 86
        Height = 20
        Hint = 'Set display intensity range to cover full camera range'
        Caption = 'Full Range'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = bFullScaleClick
      end
      object edDisplayIntensityRange: TRangeEdit
        Left = 105
        Top = 42
        Width = 152
        Height = 20
        Hint = 'Range of intensities displayed within image'
        OnKeyPress = edDisplayIntensityRangeKeyPress
        AutoSize = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial Narrow'
        Font.Style = []
        ShowHint = True
        Text = ' 4096 - 4096 '
        LoValue = 4096.000000000000000000
        HiValue = 4096.000000000000000000
        HiLimit = 1.000000015047466E30
        Scale = 1.000000000000000000
        NumberFormat = '%.0f - %.0f'
      end
      object bMaxContrast: TButton
        Left = 100
        Top = 16
        Width = 61
        Height = 20
        Hint = 'Set display range to min. - max.  intensities within image'
        Caption = 'Best'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnClick = bMaxContrastClick
      end
      object ckAutoOptimise: TCheckBox
        Left = 41
        Top = 68
        Width = 97
        Height = 17
        Caption = 'Auto adjust'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
      end
      object ckContrast6SDOnly: TCheckBox
        Left = 144
        Top = 68
        Width = 105
        Height = 17
        Hint = 
          'Set maximum contrast range to 6 standard deviations rather than ' +
          'min-max range'
        Caption = '6 x s.d. only'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
      end
      object bRange: TButton
        Left = 8
        Top = 42
        Width = 91
        Height = 20
        Hint = 'Set display range to min. - max.  intensities within image'
        Caption = 'Range'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
        OnClick = bRangeClick
      end
      object bCursors: TButton
        Left = 167
        Top = 16
        Width = 91
        Height = 20
        Hint = 'Set display range to min. - max.  intensities within image'
        Caption = 'Cursors'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 6
        OnClick = bCursorsClick
      end
    end
  end
  object StatusGrp: TGroupBox
    Left = 8
    Top = 1051
    Width = 297
    Height = 81
    TabOrder = 7
    object meStatus: TMemo
      Left = 8
      Top = 8
      Width = 280
      Height = 70
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Lines.Strings = (
        'meStatus')
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
  end
  object Timer: TTimer
    Enabled = False
    Interval = 100
    OnTimer = TimerTimer
    Left = 336
    Top = 720
  end
  object ImageFile: TImageFile
    XResolution = 1.000000000000000000
    YResolution = 1.000000000000000000
    ZResolution = 1.000000000000000000
    TResolution = 1.000000000000000000
    Left = 392
    Top = 720
  end
  object SaveDialog: TSaveDialog
    Left = 432
    Top = 744
  end
  object MainMenu1: TMainMenu
    Left = 416
    Top = 720
    object File1: TMenuItem
      Caption = 'File'
      object mnSaveImage: TMenuItem
        Caption = '&Save Image To File'
        OnClick = mnSaveImageClick
      end
      object SavetoImageJ1: TMenuItem
        Caption = 'Save to Image-&J'
        OnClick = SavetoImageJ1Click
      end
      object mnExit: TMenuItem
        Caption = '&Exit'
        OnClick = mnExitClick
      end
    end
    object mnSetup: TMenuItem
      Caption = 'Setup'
      object mnScanSettings: TMenuItem
        Caption = '&Scan Settings'
        OnClick = mnScanSettingsClick
      end
    end
  end
  object ColorDialog: TColorDialog
    Left = 251
    Top = 478
  end
end

object MainFrm: TMainFrm
  Left = 794
  Top = 357
  Caption = 'MesoScan V1.5.3 64 bit 19/01/15'
  ClientHeight = 850
  ClientWidth = 790
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ControlGrp: TGroupBox
    Left = 4
    Top = 4
    Width = 217
    Height = 118
    Caption = ' Scan Control '
    TabOrder = 0
    object bScanImage: TButton
      Left = 58
      Top = 40
      Width = 101
      Height = 20
      Hint = 'Scan new image'
      Caption = 'Scan Image'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
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
      Width = 101
      Height = 20
      Hint = 'Stop scanning'
      Caption = 'Stop'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = bStopScanClick
    end
    object ckRepeat: TCheckBox
      Left = 125
      Top = 89
      Width = 60
      Height = 17
      Hint = 'Repeated image scanning'
      Caption = 'Repeat'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object rbFastScan: TRadioButton
      Left = 16
      Top = 89
      Width = 41
      Height = 17
      Hint = 'High speed image'
      Caption = 'Fast '
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
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
      Left = 63
      Top = 89
      Width = 56
      Height = 17
      Hint = 'High resolution image'
      Caption = 'Hi Res.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = rbHRScanClick
    end
    object bScanZoomOut: TButton
      Left = 11
      Top = 40
      Width = 41
      Height = 20
      Hint = 'Zoom Out: Scan Image using previous ROI '
      Caption = '-'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = bScanZoomOutClick
    end
    object bScanZoomIn: TButton
      Left = 165
      Top = 40
      Width = 41
      Height = 20
      Hint = 'Zoom In: Scan image within user selected region of interest.'
      Caption = '+'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
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
      Width = 101
      Height = 20
      Hint = 'Scan full field of view'
      Caption = 'Scan Full Field'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
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
    Left = 231
    Top = 8
    Width = 500
    Height = 288
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object lbReadout: TLabel
      Left = 8
      Top = 217
      Width = 55
      Height = 14
      Caption = 'lbReadout'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ZSectionPanel: TPanel
      Left = 159
      Top = 243
      Width = 154
      Height = 22
      BevelOuter = bvNone
      TabOrder = 0
      object lbZSection: TLabel
        Left = 81
        Top = 0
        Width = 24
        Height = 14
        Caption = 'xxxx'
      end
      object scZSection: TScrollBar
        Left = 0
        Top = 0
        Width = 75
        Height = 15
        PageSize = 0
        TabOrder = 0
        OnChange = scZSectionChange
      end
    end
    object Panel1: TPanel
      Left = 3
      Top = 3
      Width = 86
      Height = 20
      BevelOuter = bvNone
      TabOrder = 1
    end
    object ZoomPanel: TPanel
      Left = 16
      Top = 237
      Width = 105
      Height = 20
      BevelOuter = bvNone
      TabOrder = 2
      object lbZoom: TLabel
        Left = 1
        Top = 0
        Width = 56
        Height = 14
        Caption = 'Zoom (X1)'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
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
      Left = 3
      Top = 3
      Width = 294
      Height = 217
      ActivePage = TabImage1
      TabOrder = 3
      object TabImage0: TTabSheet
        Caption = 'PMT0'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Image0: TImage
          Left = 2
          Top = 1
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
      end
      object TabImage1: TTabSheet
        Caption = 'TabImage1'
        ImageIndex = 1
        object Image1: TImage
          Left = 0
          Top = 0
          Width = 281
          Height = 185
          ParentShowHint = False
          ShowHint = False
          Stretch = True
          OnDblClick = Image0DblClick
          OnMouseDown = Image0MouseDown
          OnMouseMove = Image0MouseMove
          OnMouseUp = Image0MouseUp
        end
      end
      object TabImage2: TTabSheet
        Caption = 'TabImage2'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Image2: TImage
          Left = 0
          Top = 0
          Width = 281
          Height = 185
          ParentShowHint = False
          ShowHint = False
          Stretch = True
          OnDblClick = Image0DblClick
          OnMouseDown = Image0MouseDown
          OnMouseMove = Image0MouseMove
          OnMouseUp = Image0MouseUp
        end
      end
      object TabImage3: TTabSheet
        Caption = 'TabImage3'
        ImageIndex = 3
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Image3: TImage
          Left = 0
          Top = 0
          Width = 281
          Height = 185
          Stretch = True
          OnDblClick = Image0DblClick
          OnMouseDown = Image0MouseDown
          OnMouseMove = Image0MouseMove
          OnMouseUp = Image0MouseUp
        end
      end
    end
  end
  object ImageSizeGrp: TGroupBox
    Left = 8
    Top = 128
    Width = 217
    Height = 181
    Caption = ' Image '
    TabOrder = 2
    object Label4: TLabel
      Left = 60
      Top = 46
      Width = 103
      Height = 13
      Alignment = taRightJustify
      Caption = 'No. averages / image'
    end
    object edNumAverages: TValidatedEdit
      Left = 169
      Top = 47
      Width = 33
      Height = 21
      Hint = 'No. of images to be averaged'
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
      Top = 74
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
      object edNumZSections: TValidatedEdit
        Left = 121
        Top = 16
        Width = 57
        Height = 21
        Hint = 'No. of sections in Z stage'
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
        Hint = 'Z increment between sections'
        OnKeyPress = edNumPixelsPerZStepKeyPress
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
        Hint = 'Z increment between sections'
        OnKeyPress = edMicronsPerZStepKeyPress
        Text = ' 0.000 um'
        Scale = 1.000000000000000000
        Units = 'um'
        NumberFormat = '%.3f'
        LoLimit = -100.000000000000000000
        HiLimit = 100.000000000000000000
      end
    end
    object cbImageMode: TComboBox
      Left = 11
      Top = 20
      Width = 191
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
      Top = 74
      Width = 190
      Height = 104
      TabOrder = 3
      object Label2: TLabel
        Left = 74
        Top = 16
        Width = 41
        Height = 13
        Alignment = taRightJustify
        Caption = 'No. lines'
      end
      object edLineScanFrameHeight: TValidatedEdit
        Left = 121
        Top = 16
        Width = 57
        Height = 21
        Hint = 'No. lines in line scan image'
        ShowHint = True
        Text = ' 1000 '
        Value = 1000.000000000000000000
        Scale = 1.000000000000000000
        NumberFormat = '%.0f'
        LoLimit = 10.000000000000000000
        HiLimit = 30000.000000000000000000
      end
    end
  end
  object ZStageGrp: TGroupBox
    Left = 8
    Top = 304
    Width = 217
    Height = 75
    Caption = 'Z Position '
    TabOrder = 3
    object edZTop: TValidatedEdit
      Left = 12
      Top = 17
      Width = 192
      Height = 21
      Hint = 'Stage position on Z axis'
      ShowHint = True
      Text = ' 0.00 um'
      Scale = 1.000000000000000000
      Units = 'um'
      NumberFormat = '%.2f'
      LoLimit = -10.000000000000000000
      HiLimit = 10.000000000000000000
    end
    object edGotoZPosition: TValidatedEdit
      Left = 103
      Top = 42
      Width = 102
      Height = 21
      Hint = 'Z axis position to move to'
      OnKeyPress = edGotoZPositionKeyPress
      ShowHint = True
      Text = ' 0.00 um'
      Scale = 1.000000000000000000
      Units = 'um'
      NumberFormat = '%.2f'
      LoLimit = -1000000.000000000000000000
      HiLimit = 1000000.000000000000000000
    end
    object bGotoZPosition: TButton
      Left = 16
      Top = 44
      Width = 81
      Height = 17
      Hint = 'Move stage to specified Z axis position'
      Caption = 'Go To'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = bGotoZPositionClick
    end
  end
  object PMTGrp: TGroupBox
    Left = 8
    Top = 385
    Width = 217
    Height = 149
    Caption = ' PMT Channels  '
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
      Top = 30
      Width = 186
      Height = 28
      BevelOuter = bvNone
      TabOrder = 0
      object cbPMTGain0: TComboBox
        Left = 53
        Top = 0
        Width = 49
        Height = 23
        Hint = 'PMT amplifier gain'
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial Narrow'
        Font.Style = []
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
        Width = 51
        Height = 21
        Hint = 'PMT voltage (% of maximum)'
        ShowHint = True
        Text = ' 1 %'
        Value = 1.000000000000000000
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
        Left = 158
        Top = 0
        Width = 17
        Height = 23
        Min = -30000
        Max = 30000
        TabOrder = 3
        OnChangingEx = udPMTVolts0ChangingEx
      end
    end
    object PanelPMT1: TPanel
      Left = 3
      Top = 59
      Width = 186
      Height = 28
      BevelOuter = bvNone
      TabOrder = 1
      object cbPMTGain1: TComboBox
        Left = 53
        Top = 0
        Width = 49
        Height = 23
        Hint = 'PMT amplifier gain'
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial Narrow'
        Font.Style = []
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
        Top = 0
        Width = 51
        Height = 21
        Hint = 'PMT voltage (% of maximum)'
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
        Left = 158
        Top = 0
        Width = 17
        Height = 23
        TabOrder = 3
        OnChangingEx = udPMTVolts1ChangingEx
      end
    end
    object PanelPMT2: TPanel
      Left = 3
      Top = 86
      Width = 186
      Height = 28
      BevelOuter = bvNone
      TabOrder = 2
      object cbPMTGain2: TComboBox
        Left = 53
        Top = 0
        Width = 49
        Height = 23
        Hint = 'PMT amplifier gain'
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial Narrow'
        Font.Style = []
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
        Top = 0
        Width = 51
        Height = 21
        Hint = 'PMT voltage (% of maximum)'
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
        Left = 158
        Top = 0
        Width = 17
        Height = 23
        TabOrder = 3
        OnChangingEx = udPMTVolts2ChangingEx
      end
    end
    object PanelPMT3: TPanel
      Left = 3
      Top = 113
      Width = 186
      Height = 28
      BevelOuter = bvNone
      TabOrder = 3
      object cbPMTGain3: TComboBox
        Left = 53
        Top = 0
        Width = 49
        Height = 23
        Hint = 'PMT amplifier gain'
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial Narrow'
        Font.Style = []
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
        Top = 0
        Width = 51
        Height = 21
        Hint = 'PMT voltage (% of maximum)'
        ParentCustomHint = False
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
        Left = 158
        Top = 0
        Width = 17
        Height = 23
        TabOrder = 3
        OnChangingEx = udPMTVolts3ChangingEx
      end
    end
  end
  object LaserGrp: TGroupBox
    Left = 8
    Top = 538
    Width = 217
    Height = 56
    Caption = ' Laser '
    TabOrder = 5
    object edLaserIntensity: TValidatedEdit
      Left = 168
      Top = 16
      Width = 44
      Height = 21
      OnKeyPress = edLaserIntensityKeyPress
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
      Width = 114
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
    Top = 600
    Width = 217
    Height = 165
    Caption = ' Display '
    TabOrder = 6
    object Splitter1: TSplitter
      Left = 2
      Top = 15
      Height = 148
      ExplicitHeight = 176
    end
    object cbPalette: TComboBox
      Left = 11
      Top = 15
      Width = 193
      Height = 21
      Hint = 'Display colour palette'
      Style = csDropDownList
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnChange = cbPaletteChange
    end
    object ContrastPage: TPageControl
      Left = 10
      Top = 42
      Width = 196
      Height = 117
      ActivePage = RangeTab
      MultiLine = True
      TabOrder = 1
      object RangeTab: TTabSheet
        Caption = 'Display Contrast'
        object bFullScale: TButton
          Left = 2
          Top = 4
          Width = 70
          Height = 17
          Hint = 'Set display intensity range to cover full camera range'
          Caption = 'Full Range'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnClick = bFullScaleClick
        end
        object bMaxContrast: TButton
          Left = 3
          Top = 23
          Width = 70
          Height = 17
          Hint = 'Set display range to min. - max.  intensities within image'
          Caption = 'Best'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnClick = bMaxContrastClick
        end
        object edDisplayIntensityRange: TRangeEdit
          Left = 78
          Top = 4
          Width = 104
          Height = 20
          Hint = 'Range of intensities displayed within image'
          OnKeyPress = edDisplayIntensityRangeKeyPress
          AutoSize = False
          ShowHint = True
          Text = ' 4096 - 4096 '
          LoValue = 4096.000000000000000000
          HiValue = 4096.000000000000000000
          HiLimit = 1.000000015047466E30
          Scale = 1.000000000000000000
          NumberFormat = '%.0f - %.0f'
        end
        object ckContrast6SDOnly: TCheckBox
          Left = 2
          Top = 63
          Width = 105
          Height = 17
          Hint = 
            'Set maximum contrast range to 6 standard deviations rather than ' +
            'min-max range'
          Caption = '6 x s.d. only'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
        end
        object ckAutoOptimise: TCheckBox
          Left = 2
          Top = 46
          Width = 119
          Height = 17
          Caption = 'Auto adjust'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
        end
      end
      object SlidersTab: TTabSheet
        Caption = 'Sliders'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label9: TLabel
          Left = 14
          Top = 0
          Width = 49
          Height = 15
          Caption = 'Contrast'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label10: TLabel
          Left = 14
          Top = 40
          Width = 62
          Height = 15
          Caption = 'Brightness'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label11: TLabel
          Left = 2
          Top = 15
          Width = 5
          Height = 19
          Caption = '-'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label13: TLabel
          Left = 2
          Top = 58
          Width = 5
          Height = 19
          Caption = '-'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label12: TLabel
          Left = 177
          Top = 16
          Width = 11
          Height = 19
          Caption = '+'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Bodoni MT Black'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label14: TLabel
          Left = 175
          Top = 56
          Width = 11
          Height = 19
          Caption = '+'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Bodoni MT Black'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object sbContrast: TScrollBar
          Left = 17
          Top = 17
          Width = 155
          Height = 17
          Hint = 'Display contrast control slider'
          LargeChange = 10
          PageSize = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnChange = sbContrastChange
        end
        object sbBrightness: TScrollBar
          Left = 17
          Top = 61
          Width = 155
          Height = 17
          Hint = 'Display brightness control slider'
          LargeChange = 10
          PageSize = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnChange = sbContrastChange
        end
      end
    end
  end
  object StatusGrp: TGroupBox
    Left = 8
    Top = 770
    Width = 217
    Height = 81
    TabOrder = 7
    object meStatus: TMemo
      Left = 8
      Top = 10
      Width = 200
      Height = 61
      Lines.Strings = (
        'meStatus')
      ReadOnly = True
      TabOrder = 0
    end
  end
  object Timer: TTimer
    Enabled = False
    Interval = 100
    OnTimer = TimerTimer
    Left = 232
    Top = 608
  end
  object ImageFile: TImageFile
    XResolution = 1.000000000000000000
    YResolution = 1.000000000000000000
    ZResolution = 1.000000000000000000
    TResolution = 1.000000000000000000
    Left = 264
    Top = 608
  end
  object SaveDialog: TSaveDialog
    Left = 336
    Top = 608
  end
  object MainMenu1: TMainMenu
    Left = 296
    Top = 608
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
end

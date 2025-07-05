object SettingsFrm: TSettingsFrm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = ' Scan Settings '
  ClientHeight = 456
  ClientWidth = 779
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poMainFormCenter
  OnShow = FormShow
  TextHeight = 13
  object bOK: TButton
    Left = 8
    Top = 423
    Width = 65
    Height = 25
    Caption = 'OK'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ModalResult = 1
    ParentFont = False
    TabOrder = 0
    OnClick = bOKClick
  end
  object bCancel: TButton
    Left = 79
    Top = 423
    Width = 72
    Height = 20
    Caption = 'Cancel'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ModalResult = 2
    ParentFont = False
    TabOrder = 1
    OnClick = bCancelClick
  end
  object StageTab: TPageControl
    Left = 8
    Top = 8
    Width = 761
    Height = 409
    ActivePage = PMTTab
    TabOrder = 2
    object ScanTab: TTabSheet
      Caption = 'Scanning'
      object ImageHRGrp: TGroupBox
        Left = 3
        Top = 3
        Width = 235
        Height = 134
        Caption = ' Image (hi. res. scan)'
        TabOrder = 0
        object Label1: TLabel
          Left = 33
          Top = 18
          Width = 105
          Height = 16
          Alignment = taRightJustify
          Caption = 'Hi. Res. Pixels/line'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 21
          Top = 42
          Width = 117
          Height = 16
          Alignment = taRightJustify
          Caption = 'Fast Scan Pixels/line'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label12: TLabel
          Left = 9
          Top = 72
          Width = 129
          Height = 16
          Alignment = taRightJustify
          Caption = 'Fast Scan Lines/image'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object edHRFrameWidth: TValidatedEdit
          Left = 144
          Top = 18
          Width = 80
          Height = 24
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Text = ' 1000 '
          Value = 1000.000000000000000000
          Scale = 1.000000000000000000
          NumberFormat = '%.0f'
          LoLimit = 10.000000000000000000
          HiLimit = 30000.000000000000000000
        end
        object edFastFrameWidth: TValidatedEdit
          Left = 144
          Top = 45
          Width = 80
          Height = 24
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Text = ' 500 '
          Value = 500.000000000000000000
          Scale = 1.000000000000000000
          NumberFormat = '%.0f'
          LoLimit = 10.000000000000000000
          HiLimit = 30000.000000000000000000
        end
        object edFastFrameHeight: TValidatedEdit
          Left = 144
          Top = 72
          Width = 80
          Height = 24
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Text = ' 50 '
          Value = 50.000000000000000000
          Scale = 1.000000000000000000
          NumberFormat = '%.0f'
          LoLimit = 10.000000000000000000
          HiLimit = 30000.000000000000000000
        end
        object ckFastBidirectionalScan: TCheckBox
          Left = 25
          Top = 102
          Width = 201
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Fast bi-directional scan'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
      end
      object ScanGrp: TGroupBox
        Left = 244
        Top = 3
        Width = 267
        Height = 278
        Caption = ' Scan Settings'
        TabOrder = 1
        object Label3: TLabel
          Left = 97
          Top = 76
          Width = 68
          Height = 16
          Alignment = taRightJustify
          Caption = 'Phase delay'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object xscalelab: TLabel
          Left = 87
          Top = 106
          Width = 78
          Height = 16
          Alignment = taRightJustify
          Caption = 'X scale factor'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label5: TLabel
          Left = 88
          Top = 136
          Width = 77
          Height = 16
          Alignment = taRightJustify
          Caption = 'Y scale factor'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label6: TLabel
          Left = 81
          Top = 166
          Width = 84
          Height = 16
          Alignment = taRightJustify
          Caption = 'Max. scan rate'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label9: TLabel
          Left = 48
          Top = 196
          Width = 117
          Height = 16
          Alignment = taRightJustify
          Caption = 'Min. pixel dwell time'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label11: TLabel
          Left = 101
          Top = 16
          Width = 64
          Height = 16
          Alignment = taRightJustify
          Caption = 'Field Width'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label24: TLabel
          Left = 104
          Top = 46
          Width = 59
          Height = 16
          Alignment = taRightJustify
          Caption = 'Field Edge'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object ckCorrectSineWaveDistortion: TCheckBox
          Left = 55
          Top = 226
          Width = 201
          Height = 15
          Alignment = taLeftJustify
          Caption = 'Correct Sine Wave Distortion'
          Checked = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          State = cbChecked
          TabOrder = 0
        end
        object edPhaseShift: TValidatedEdit
          Left = 169
          Top = 76
          Width = 90
          Height = 24
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Text = ' 0 ms'
          Scale = 1000.000000000000000000
          Units = 'ms'
          NumberFormat = '%.4g'
          LoLimit = -1.000000015047466E30
          HiLimit = 20000.000000000000000000
        end
        object edXVoltsPerMicron: TValidatedEdit
          Left = 169
          Top = 106
          Width = 90
          Height = 24
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Text = ' 1 V/um'
          Value = 1.000000000000000000
          Scale = 1.000000000000000000
          Units = 'V/um'
          NumberFormat = '%.4g'
          LoLimit = 0.000009999999747379
          HiLimit = 1.000000000000000000
        end
        object edYVoltsPerMicron: TValidatedEdit
          Left = 169
          Top = 136
          Width = 90
          Height = 24
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Text = ' 1 V/um'
          Value = 1.000000000000000000
          Scale = 1.000000000000000000
          Units = 'V/um'
          NumberFormat = '%.4g'
          LoLimit = 0.000009999999747379
          HiLimit = 10.000000000000000000
        end
        object edMaxScanRate: TValidatedEdit
          Left = 169
          Top = 166
          Width = 90
          Height = 24
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Text = ' 100.0 Hz'
          Value = 100.000000000000000000
          Scale = 1.000000000000000000
          Units = 'Hz'
          NumberFormat = '%.1f'
          LoLimit = 1.000000000000000000
          HiLimit = 500.000000000000000000
        end
        object edMinPixelDwellTime: TValidatedEdit
          Left = 169
          Top = 196
          Width = 90
          Height = 24
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Text = ' 0.5 us'
          Value = 0.000000499999998738
          Scale = 1000000.000000000000000000
          Units = 'us'
          NumberFormat = '%.4g'
          LoLimit = -1.000000015047466E30
          HiLimit = 1.000000000000000000
        end
        object edFullFieldWidthMicrons: TValidatedEdit
          Left = 169
          Top = 16
          Width = 90
          Height = 24
          Hint = 'Maximum width of scanning field (um)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ShowHint = True
          Text = ' 5000 um'
          Value = 5000.000000000000000000
          Scale = 1.000000000000000000
          Units = 'um'
          NumberFormat = '%.0f'
          LoLimit = 100.000000000000000000
          HiLimit = 10000.000000000000000000
        end
        object edFieldEdge: TValidatedEdit
          Left = 169
          Top = 46
          Width = 90
          Height = 24
          Hint = 
            'Additional non-imaging region at edge of field (% of field width' +
            ')'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ShowHint = True
          Text = ' 5 %'
          Value = 0.050000000745058060
          Scale = 100.000000000000000000
          Units = '%'
          NumberFormat = '%.0f'
          LoLimit = -1.000000015047466E30
          HiLimit = 0.200000002980232200
        end
      end
      object gpDevices: TGroupBox
        Left = 244
        Top = 287
        Width = 267
        Height = 83
        Caption = ' Devices Detected '
        TabOrder = 2
        object meDeviceList: TMemo
          Left = 8
          Top = 16
          Width = 249
          Height = 57
          Hint = 'List of National Instruments devices detected'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Lines.Strings = (
            'meDeviceList')
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
        end
      end
      object gpXYGalvos: TGroupBox
        Left = 3
        Top = 252
        Width = 235
        Height = 113
        Caption = ' Scanning Galvanometer Control'
        TabOrder = 3
        object Label42: TLabel
          Left = 19
          Top = 44
          Width = 83
          Height = 14
          Alignment = taRightJustify
          Caption = 'X Galvo Control'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label43: TLabel
          Left = 18
          Top = 74
          Width = 84
          Height = 14
          Alignment = taRightJustify
          Caption = 'Y Galvo Control'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label44: TLabel
          Left = 181
          Top = 24
          Width = 38
          Height = 14
          Alignment = taRightJustify
          Caption = 'Invert'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object cbXGalvoControl: TComboBox
          Left = 108
          Top = 44
          Width = 90
          Height = 24
          Hint = 'Analogue output (AO) port controlling X galvanometer'
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
        end
        object cbYGalvoControl: TComboBox
          Left = 108
          Top = 74
          Width = 90
          Height = 24
          Hint = 'Analogue output (AO) port controlling Y galvanometer'
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
        end
        object ckXGalvoInvert: TCheckBox
          Left = 204
          Top = 44
          Width = 25
          Height = 17
          Hint = 'Invert X axis galvo control signal'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
        end
        object ckYGalvoInvert: TCheckBox
          Left = 204
          Top = 74
          Width = 25
          Height = 17
          Hint = 'Invert Y axis galvo control signal'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
        end
      end
      object gpFocusMode: TGroupBox
        Left = 3
        Top = 143
        Width = 235
        Height = 103
        Caption = ' Focus Mode '
        TabOrder = 4
        object Label45: TLabel
          Left = 73
          Top = 18
          Width = 65
          Height = 16
          Alignment = taRightJustify
          Caption = 'Pixels / line'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label46: TLabel
          Left = 61
          Top = 42
          Width = 77
          Height = 16
          Alignment = taRightJustify
          Caption = 'Lines / image'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label47: TLabel
          Left = 45
          Top = 72
          Width = 93
          Height = 16
          Alignment = taRightJustify
          Caption = 'Scanned region '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object edFocusModeFrameWidth: TValidatedEdit
          Left = 144
          Top = 18
          Width = 80
          Height = 24
          Hint = 'Focus Mode: No. of Pixels per scan line'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ShowHint = True
          Text = ' 1000 '
          Value = 1000.000000000000000000
          Scale = 1.000000000000000000
          NumberFormat = '%.0f'
          LoLimit = 10.000000000000000000
          HiLimit = 30000.000000000000000000
        end
        object edFocusModeFrameHeight: TValidatedEdit
          Left = 144
          Top = 45
          Width = 80
          Height = 24
          Hint = 'Focus Mode: No. of scan lines per image'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ShowHint = True
          Text = ' 500 '
          Value = 500.000000000000000000
          Scale = 1.000000000000000000
          NumberFormat = '%.0f'
          LoLimit = 10.000000000000000000
          HiLimit = 30000.000000000000000000
        end
        object edFocusModeRegion: TValidatedEdit
          Left = 144
          Top = 72
          Width = 80
          Height = 24
          Hint = 'Percentage of imaging area scanned while focussing'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ShowHint = True
          Text = ' 10 %'
          Value = 0.100000001490116100
          Scale = 100.000000000000000000
          Units = '%'
          NumberFormat = '%.0f'
          LoLimit = 0.009999999776482582
          HiLimit = 1.000000000000000000
        end
      end
    end
    object PMTTab: TTabSheet
      Caption = 'PM Tubes'
      ImageIndex = 1
      object PMTgrp: TGroupBox
        Left = 3
        Top = 3
        Width = 326
        Height = 286
        DefaultHeaderFont = False
        HeaderFont.Charset = DEFAULT_CHARSET
        HeaderFont.Color = clWindowText
        HeaderFont.Height = -13
        HeaderFont.Name = 'Tahoma'
        HeaderFont.Style = []
        TabOrder = 0
        object Label2: TLabel
          Left = 24
          Top = 17
          Width = 123
          Height = 16
          Alignment = taRightJustify
          Caption = 'No. of PMTs available'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label18: TLabel
          Left = 88
          Top = 225
          Width = 59
          Height = 16
          Alignment = taRightJustify
          Caption = 'Black level'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label19: TLabel
          Left = 24
          Top = 60
          Width = 124
          Height = 16
          Alignment = taRightJustify
          Caption = 'PMT0 Voltage Control'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label20: TLabel
          Left = 23
          Top = 87
          Width = 124
          Height = 16
          Alignment = taRightJustify
          Caption = 'PMT1 Voltage Control'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label21: TLabel
          Left = 23
          Top = 114
          Width = 124
          Height = 16
          Alignment = taRightJustify
          Caption = 'PMT2 Voltage Control'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label22: TLabel
          Left = 23
          Top = 141
          Width = 124
          Height = 16
          Alignment = taRightJustify
          Caption = 'PMT3 Voltage Control'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label23: TLabel
          Left = 25
          Top = 168
          Width = 122
          Height = 16
          Alignment = taRightJustify
          Caption = 'PMT voltage at 100%'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label48: TLabel
          Left = 250
          Top = 44
          Width = 58
          Height = 16
          Caption = 'Invert O/P'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object edNumPMTs: TValidatedEdit
          Left = 154
          Top = 17
          Width = 90
          Height = 24
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Text = ' 1 '
          Value = 1.000000000000000000
          Scale = 1.000000000000000000
          NumberFormat = '%.0f'
          LoLimit = 1.000000000000000000
          HiLimit = 4.000000000000000000
        end
        object ckInvertPMTsignal: TCheckBox
          Left = 112
          Top = 196
          Width = 131
          Height = 15
          Alignment = taLeftJustify
          Caption = 'Invert PMT signal'
          Checked = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          State = cbChecked
          TabOrder = 1
        end
        object edBlackLevel: TValidatedEdit
          Left = 154
          Top = 225
          Width = 90
          Height = 24
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Text = ' 10 '
          Value = 10.000000000000000000
          Scale = 1.000000000000000000
          NumberFormat = '%.0f'
          LoLimit = -32768.000000000000000000
          HiLimit = 32767.000000000000000000
        end
        object cbPMTControl0: TComboBox
          Left = 154
          Top = 60
          Width = 90
          Height = 24
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object cbPMTControl1: TComboBox
          Left = 154
          Top = 87
          Width = 90
          Height = 24
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object cbPMTControl2: TComboBox
          Left = 154
          Top = 114
          Width = 90
          Height = 24
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object cbPMTControl3: TComboBox
          Left = 154
          Top = 141
          Width = 90
          Height = 24
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
        end
        object edPMTMaxVolts: TValidatedEdit
          Left = 154
          Top = 168
          Width = 90
          Height = 24
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Text = ' 5 V'
          Value = 5.000000000000000000
          Scale = 1.000000000000000000
          Units = 'V'
          NumberFormat = '%.4g'
          LoLimit = -1.000000015047466E30
          HiLimit = 10.000000000000000000
        end
        object ckPMT0InvertSignal: TCheckBox
          Left = 248
          Top = 65
          Width = 23
          Height = 15
          Hint = 'Invert PMT0 output signal'
          Alignment = taLeftJustify
          Checked = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          State = cbChecked
          TabOrder = 8
        end
        object ckPMT1InvertSignal: TCheckBox
          Left = 248
          Top = 90
          Width = 23
          Height = 15
          Hint = 'Invert PMT1 output signal'
          Alignment = taLeftJustify
          Checked = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          State = cbChecked
          TabOrder = 9
        end
        object ckPMT2InvertSignal: TCheckBox
          Left = 248
          Top = 118
          Width = 23
          Height = 15
          Hint = 'Invert PMT2 output signal'
          Alignment = taLeftJustify
          Checked = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          State = cbChecked
          TabOrder = 10
        end
        object ckPMT3InvertSignal: TCheckBox
          Left = 248
          Top = 144
          Width = 23
          Height = 15
          Hint = 'Invert PMT3 output signal'
          Alignment = taLeftJustify
          Checked = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          State = cbChecked
          TabOrder = 11
        end
      end
    end
    object LasersTab: TTabSheet
      Caption = 'Lasers '
      ImageIndex = 2
      object cbLaserType: TComboBox
        Left = 11
        Top = 32
        Width = 209
        Height = 21
        TabOrder = 0
        Text = 'cbZStageType'
        OnChange = cbZStageTypeChange
      end
      object GroupBox4: TGroupBox
        Left = 3
        Top = 59
        Width = 382
        Height = 294
        Caption = 'GroupBox4'
        TabOrder = 1
        object Label28: TLabel
          Left = 24
          Top = 20
          Width = 27
          Height = 13
          Caption = 'Name'
        end
        object lbLaser0: TLabel
          Left = 3
          Top = 38
          Width = 12
          Height = 14
          Caption = '0.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label29: TLabel
          Left = 3
          Top = 65
          Width = 12
          Height = 14
          Caption = '1.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label30: TLabel
          Left = 3
          Top = 92
          Width = 12
          Height = 14
          Caption = '2.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label31: TLabel
          Left = 3
          Top = 119
          Width = 12
          Height = 14
          Caption = '3.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label32: TLabel
          Left = 3
          Top = 146
          Width = 12
          Height = 14
          Caption = '4.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label33: TLabel
          Left = 3
          Top = 173
          Width = 12
          Height = 14
          Caption = '5.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label34: TLabel
          Left = 3
          Top = 198
          Width = 12
          Height = 14
          Caption = '6.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label35: TLabel
          Left = 1
          Top = 225
          Width = 12
          Height = 14
          Caption = '7.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label15: TLabel
          Left = 22
          Top = 259
          Width = 101
          Height = 13
          Alignment = taRightJustify
          Caption = 'Shutter Change Time'
        end
        object edLaserName0: TEdit
          Left = 24
          Top = 38
          Width = 99
          Height = 21
          TabOrder = 0
          Text = 'edLaserName0'
        end
        object edLaserName1: TEdit
          Left = 24
          Top = 65
          Width = 99
          Height = 21
          TabOrder = 1
          Text = 'edLaserName0'
        end
        object edLaserName2: TEdit
          Left = 24
          Top = 92
          Width = 99
          Height = 21
          TabOrder = 2
          Text = 'edLaserName0'
        end
        object edLaserName3: TEdit
          Left = 24
          Top = 119
          Width = 99
          Height = 21
          TabOrder = 3
          Text = 'edLaserName0'
        end
        object edLaserName4: TEdit
          Left = 24
          Top = 146
          Width = 99
          Height = 21
          TabOrder = 4
          Text = 'edLaserName0'
        end
        object edLaserName5: TEdit
          Left = 24
          Top = 173
          Width = 99
          Height = 21
          TabOrder = 5
          Text = 'edLaserName0'
        end
        object edLaserName6: TEdit
          Left = 24
          Top = 198
          Width = 99
          Height = 21
          TabOrder = 6
          Text = 'edLaserName0'
        end
        object edLaserName7: TEdit
          Left = 22
          Top = 225
          Width = 99
          Height = 21
          TabOrder = 7
          Text = 'edLaserName0'
        end
        object LaserExternalControlPanel: TPanel
          Left = 129
          Top = 16
          Width = 249
          Height = 241
          BevelOuter = bvNone
          TabOrder = 8
          object Label27: TLabel
            Left = 0
            Top = 3
            Width = 72
            Height = 13
            Hint = 'Laser on/off TTL digital output'
            Caption = 'On/Off Control'
            Color = clBtnFace
            ParentColor = False
          end
          object Label26: TLabel
            Left = 96
            Top = 4
            Width = 81
            Height = 13
            Hint = 'Laser intensity analogue output'
            Caption = 'Intensity Control'
            ParentShowHint = False
            ShowHint = True
          end
          object Label36: TLabel
            Left = 192
            Top = 2
            Width = 46
            Height = 13
            Hint = 'Control voltage at maximum intensity'
            Caption = 'V (100%)'
            ParentShowHint = False
            ShowHint = True
          end
          object cbLaserActiveControl0: TComboBox
            Left = 0
            Top = 22
            Width = 90
            Height = 21
            Style = csDropDownList
            TabOrder = 0
          end
          object cbLaserActiveControl1: TComboBox
            Left = 0
            Top = 49
            Width = 90
            Height = 21
            Style = csDropDownList
            TabOrder = 1
          end
          object cbLaserActiveControl2: TComboBox
            Left = 0
            Top = 76
            Width = 90
            Height = 21
            Style = csDropDownList
            TabOrder = 2
          end
          object cbLaserActiveControl3: TComboBox
            Left = 0
            Top = 103
            Width = 90
            Height = 21
            Style = csDropDownList
            TabOrder = 3
          end
          object cbLaserActiveControl4: TComboBox
            Left = 0
            Top = 130
            Width = 90
            Height = 21
            Style = csDropDownList
            TabOrder = 4
          end
          object cbLaserActiveControl5: TComboBox
            Left = 0
            Top = 157
            Width = 90
            Height = 21
            Style = csDropDownList
            TabOrder = 5
          end
          object cbLaserActiveControl6: TComboBox
            Left = 0
            Top = 182
            Width = 90
            Height = 21
            Style = csDropDownList
            TabOrder = 6
          end
          object cbLaserActiveControl7: TComboBox
            Left = 0
            Top = 209
            Width = 90
            Height = 21
            Style = csDropDownList
            TabOrder = 7
          end
          object cbLaserIntensityControl0: TComboBox
            Left = 96
            Top = 22
            Width = 90
            Height = 21
            Style = csDropDownList
            TabOrder = 8
          end
          object cbLaserIntensityControl1: TComboBox
            Left = 96
            Top = 49
            Width = 90
            Height = 21
            Style = csDropDownList
            TabOrder = 9
          end
          object cbLaserIntensityControl2: TComboBox
            Left = 96
            Top = 76
            Width = 90
            Height = 21
            Style = csDropDownList
            TabOrder = 10
          end
          object cbLaserIntensityControl3: TComboBox
            Left = 96
            Top = 103
            Width = 90
            Height = 21
            Style = csDropDownList
            TabOrder = 11
          end
          object cbLaserIntensityControl4: TComboBox
            Left = 96
            Top = 130
            Width = 90
            Height = 21
            Style = csDropDownList
            TabOrder = 12
          end
          object cbLaserIntensityControl5: TComboBox
            Left = 96
            Top = 157
            Width = 90
            Height = 21
            Style = csDropDownList
            TabOrder = 13
          end
          object cbLaserIntensityControl6: TComboBox
            Left = 96
            Top = 182
            Width = 90
            Height = 21
            Style = csDropDownList
            TabOrder = 14
          end
          object cbLaserIntensityControl7: TComboBox
            Left = 96
            Top = 209
            Width = 90
            Height = 21
            Style = csDropDownList
            TabOrder = 15
          end
          object edLaserVMax0: TValidatedEdit
            Left = 192
            Top = 21
            Width = 50
            Height = 21
            Text = ' 5 V'
            Value = 5.000000000000000000
            Scale = 1.000000000000000000
            Units = 'V'
            NumberFormat = '%.4g'
            LoLimit = -1.000000015047466E30
            HiLimit = 10.000000000000000000
          end
          object edLaserVMax1: TValidatedEdit
            Left = 192
            Top = 49
            Width = 50
            Height = 21
            Text = ' 5 V'
            Value = 5.000000000000000000
            Scale = 1.000000000000000000
            Units = 'V'
            NumberFormat = '%.4g'
            LoLimit = -1.000000015047466E30
            HiLimit = 10.000000000000000000
          end
          object edLaserVMax2: TValidatedEdit
            Left = 192
            Top = 76
            Width = 50
            Height = 21
            Text = ' 5 V'
            Value = 5.000000000000000000
            Scale = 1.000000000000000000
            Units = 'V'
            NumberFormat = '%.4g'
            LoLimit = -1.000000015047466E30
            HiLimit = 10.000000000000000000
          end
          object edLaserVMax3: TValidatedEdit
            Left = 192
            Top = 103
            Width = 50
            Height = 21
            Text = ' 5 V'
            Value = 5.000000000000000000
            Scale = 1.000000000000000000
            Units = 'V'
            NumberFormat = '%.4g'
            LoLimit = -1.000000015047466E30
            HiLimit = 10.000000000000000000
          end
          object edLaserVMax4: TValidatedEdit
            Left = 192
            Top = 130
            Width = 50
            Height = 21
            Text = ' 5 V'
            Value = 5.000000000000000000
            Scale = 1.000000000000000000
            Units = 'V'
            NumberFormat = '%.4g'
            LoLimit = -1.000000015047466E30
            HiLimit = 10.000000000000000000
          end
          object edLaserVMax5: TValidatedEdit
            Left = 192
            Top = 157
            Width = 50
            Height = 21
            Text = ' 5 V'
            Value = 5.000000000000000000
            Scale = 1.000000000000000000
            Units = 'V'
            NumberFormat = '%.4g'
            LoLimit = -1.000000015047466E30
            HiLimit = 10.000000000000000000
          end
          object edLaserVMax6: TValidatedEdit
            Left = 192
            Top = 184
            Width = 50
            Height = 21
            Text = ' 5 V'
            Value = 5.000000000000000000
            Scale = 1.000000000000000000
            Units = 'V'
            NumberFormat = '%.4g'
            LoLimit = -1.000000015047466E30
            HiLimit = 10.000000000000000000
          end
          object edLaserVMax7: TValidatedEdit
            Left = 192
            Top = 211
            Width = 50
            Height = 21
            Text = ' 5 V'
            Value = 5.000000000000000000
            Scale = 1.000000000000000000
            Units = 'V'
            NumberFormat = '%.4g'
            LoLimit = -1.000000015047466E30
            HiLimit = 10.000000000000000000
          end
        end
        object edLaserShutterChangeTime: TValidatedEdit
          Left = 129
          Top = 259
          Width = 81
          Height = 21
          Text = ' 500 ms'
          Value = 0.500000000000000000
          Scale = 1000.000000000000000000
          Units = 'ms'
          NumberFormat = '%.4g'
          LoLimit = -1.000000015047466E30
          HiLimit = 1000000.000000000000000000
        end
        object ckLaserControlEnabled: TCheckBox
          Left = 216
          Top = 263
          Width = 65
          Height = 15
          Alignment = taLeftJustify
          Caption = 'Enabled'
          Checked = True
          State = cbChecked
          TabOrder = 10
        end
      end
      object Panel1: TPanel
        Left = 403
        Top = 63
        Width = 297
        Height = 137
        Caption = 'Panel1'
        TabOrder = 2
        object Label7: TLabel
          Left = 24
          Top = 11
          Width = 58
          Height = 13
          Alignment = taRightJustify
          Caption = 'Control Port'
        end
        object cbLaserControlComPort: TComboBox
          Left = 88
          Top = 11
          Width = 97
          Height = 21
          Style = csDropDownList
          TabOrder = 0
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'XYZ Stage Control'
      ImageIndex = 3
      object GroupBox2: TGroupBox
        Left = 8
        Top = 10
        Width = 230
        Height = 191
        TabOrder = 0
        object Label8: TLabel
          Left = 56
          Top = 43
          Width = 58
          Height = 13
          Alignment = taRightJustify
          Caption = 'Control Port'
        end
        object Label10: TLabel
          Left = 49
          Top = 68
          Width = 65
          Height = 13
          Alignment = taRightJustify
          Caption = 'Z scale factor'
        end
        object Label13: TLabel
          Left = 61
          Top = 95
          Width = 53
          Height = 13
          Alignment = taRightJustify
          Caption = 'Z step time'
        end
        object Label14: TLabel
          Left = 12
          Top = 122
          Width = 102
          Height = 13
          Alignment = taRightJustify
          Caption = 'Z Position Lower Limit'
        end
        object Label16: TLabel
          Left = 12
          Top = 149
          Width = 102
          Height = 13
          Alignment = taRightJustify
          Caption = 'Z Position Upper Limit'
        end
        object cbZStagePort: TComboBox
          Left = 120
          Top = 41
          Width = 97
          Height = 21
          Style = csDropDownList
          TabOrder = 0
          OnChange = cbZStagePortChange
        end
        object edZScaleFactor: TValidatedEdit
          Left = 120
          Top = 68
          Width = 97
          Height = 21
          Text = ' 1 steps/um'
          Value = 1.000000000000000000
          Scale = 1.000000000000000000
          Units = 'steps/um'
          NumberFormat = '%.4g'
          LoLimit = -1.000000015047466E30
          HiLimit = 1000000.000000000000000000
        end
        object cbZStageType: TComboBox
          Left = 8
          Top = 16
          Width = 209
          Height = 21
          TabOrder = 2
          Text = 'cbZStageType'
          OnChange = cbZStageTypeChange
        end
        object edZStepTime: TValidatedEdit
          Left = 120
          Top = 95
          Width = 97
          Height = 21
          Text = ' 100 ms'
          Value = 0.100000001490116100
          Scale = 1000.000000000000000000
          Units = 'ms'
          NumberFormat = '%.4g'
          LoLimit = -1.000000015047466E30
          HiLimit = 1000000.000000000000000000
        end
        object edZpositionMin: TValidatedEdit
          Left = 120
          Top = 122
          Width = 97
          Height = 21
          Text = ' -10000 um'
          Value = -10000.000000000000000000
          Scale = 1.000000000000000000
          Units = 'um'
          NumberFormat = '%.0f'
          LoLimit = -1.000000015047466E30
          HiLimit = 1000000.000000000000000000
        end
        object edZPositionMax: TValidatedEdit
          Left = 120
          Top = 149
          Width = 97
          Height = 21
          Text = ' 10000 um'
          Value = 10000.000000000000000000
          Scale = 1.000000000000000000
          Units = 'um'
          NumberFormat = '%.0f'
          LoLimit = -1.000000015047466E30
          HiLimit = 1000000.000000000000000000
        end
      end
      object gpStageProtection: TGroupBox
        Left = 3
        Top = 207
        Width = 233
        Height = 146
        Caption = ' Stage Protection '
        TabOrder = 1
        object Label37: TLabel
          Left = 27
          Top = 20
          Width = 143
          Height = 39
          Alignment = taRightJustify
          Caption = 'Stage Protection TTL  Trigger Pulse (0=High-Low, 1=Low-High)'
          WordWrap = True
        end
        object edStageProtectionTTLTrigger: TValidatedEdit
          Left = 180
          Top = 20
          Width = 41
          Height = 21
          Hint = '1= Trigger  on High-Low, 0= Trigger on Low-High'
          ShowHint = True
          Text = ' 0 '
          Scale = 1.000000000000000000
          NumberFormat = '%.0f'
          LoLimit = -1.000000015047466E30
          HiLimit = 1.000000000000000000
        end
      end
      object gpZPositionDial: TGroupBox
        Left = 244
        Top = 10
        Width = 233
        Height = 191
        Caption = 'Z Position Dial '
        TabOrder = 2
        object Label38: TLabel
          Left = 31
          Top = 44
          Width = 110
          Height = 13
          Alignment = taRightJustify
          Caption = 'Microns / step (coarse)'
          WordWrap = True
        end
        object Label39: TLabel
          Left = 20
          Top = 19
          Width = 94
          Height = 13
          Alignment = taRightJustify
          Caption = 'Encoder A/D Inputs'
        end
        object Label41: TLabel
          Left = 45
          Top = 71
          Width = 96
          Height = 13
          Alignment = taRightJustify
          Caption = 'Microns / step (fine)'
          WordWrap = True
        end
        object edZDialMicronsPerStepCoarse: TValidatedEdit
          Left = 160
          Top = 43
          Width = 57
          Height = 21
          Hint = 'Microns per step of Z dial rotational encoder'
          ShowHint = True
          Text = ' 10.0 um'
          Value = 10.000000000000000000
          Scale = 1.000000000000000000
          Units = 'um'
          NumberFormat = '%.1f'
          LoLimit = 10.000000000000000000
          HiLimit = 250.000000000000000000
        end
        object cbZDialADCInputs: TComboBox
          Left = 120
          Top = 16
          Width = 97
          Height = 21
          Style = csDropDownList
          TabOrder = 1
        end
        object edZDialMicronsPerStepFine: TValidatedEdit
          Left = 160
          Top = 70
          Width = 57
          Height = 21
          Hint = 'Microns per step of Z dial rotational encoder'
          ShowHint = True
          Text = ' 0.1 um'
          Value = 0.100000001490116100
          Scale = 1.000000000000000000
          Units = 'um'
          NumberFormat = '%.1f'
          LoLimit = 0.100000001490116100
          HiLimit = 250.000000000000000000
        end
      end
      object gpPriorCommands: TGroupBox
        Left = 242
        Top = 207
        Width = 233
        Height = 146
        Caption = ' Prior Command Terminal'
        TabOrder = 3
        object Label40: TLabel
          Left = 8
          Top = 20
          Width = 51
          Height = 13
          Alignment = taRightJustify
          Caption = 'Command:'
          WordWrap = True
        end
        object lbReply: TLabel
          Left = 28
          Top = 43
          Width = 31
          Height = 13
          Alignment = taRightJustify
          Caption = 'Reply:'
          WordWrap = True
        end
        object edPriorCommand: TEdit
          Left = 65
          Top = 16
          Width = 100
          Height = 21
          TabOrder = 0
        end
        object bPriorSend: TButton
          Left = 171
          Top = 16
          Width = 50
          Height = 20
          Caption = 'Send'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnClick = bPriorSendClick
        end
        object mePriorReply: TMemo
          Left = 65
          Top = 40
          Width = 155
          Height = 97
          Lines.Strings = (
            '')
          TabOrder = 2
        end
      end
    end
    object MiscTab: TTabSheet
      Caption = 'Miscellaneous'
      ImageIndex = 4
      object GroupBox3: TGroupBox
        Left = 8
        Top = 10
        Width = 401
        Height = 89
        TabOrder = 0
        object Label25: TLabel
          Left = 8
          Top = 8
          Width = 107
          Height = 13
          Caption = 'Image-J Program Path'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object edImageJPath: TEdit
          Left = 8
          Top = 26
          Width = 377
          Height = 21
          TabOrder = 0
          Text = 'edImageJPath'
        end
        object ckSaveAsMultipageTIFF: TCheckBox
          Left = 224
          Top = 53
          Width = 161
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Save stacks as multipage TIFF'
          TabOrder = 1
        end
      end
      object GroupBox1: TGroupBox
        Left = 8
        Top = 105
        Width = 401
        Height = 72
        TabOrder = 1
        object Label17: TLabel
          Left = 8
          Top = 7
          Width = 140
          Height = 13
          Caption = 'Raw image file storage folder'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object edRawImagesDirectory: TEdit
          Left = 8
          Top = 26
          Width = 377
          Height = 21
          Hint = 'Folder holding mesoscan.raw raw data capture file'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Text = 'edRawImagesDirectory'
        end
      end
    end
  end
end

object SettingsFrm: TSettingsFrm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = ' Scan Settings '
  ClientHeight = 437
  ClientWidth = 773
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
    Top = 407
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
    Top = 410
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
    Top = 6
    Width = 761
    Height = 395
    ActivePage = TabSheet1
    TabOrder = 2
    object ScanTab: TTabSheet
      Caption = 'Scanning'
      object ImageHRGrp: TGroupBox
        Left = 8
        Top = 10
        Width = 235
        Height = 103
        Caption = ' Image (hi. res. scan)'
        TabOrder = 0
        object Label1: TLabel
          Left = 43
          Top = 18
          Width = 88
          Height = 13
          Alignment = taRightJustify
          Caption = 'Hi. Res. Pixels/line'
        end
        object Label4: TLabel
          Left = 26
          Top = 42
          Width = 97
          Height = 13
          Alignment = taRightJustify
          Caption = 'Fast Scan Pixels/line'
        end
        object Label12: TLabel
          Left = 17
          Top = 72
          Width = 106
          Height = 13
          Alignment = taRightJustify
          Caption = 'Fast Scan Lines/image'
        end
        object edHRFrameWidth: TValidatedEdit
          Left = 140
          Top = 18
          Width = 90
          Height = 21
          Text = ' 1000 '
          Value = 1000.000000000000000000
          Scale = 1.000000000000000000
          NumberFormat = '%.0f'
          LoLimit = 10.000000000000000000
          HiLimit = 30000.000000000000000000
        end
        object edFastFrameWidth: TValidatedEdit
          Left = 140
          Top = 45
          Width = 90
          Height = 21
          Text = ' 500 '
          Value = 500.000000000000000000
          Scale = 1.000000000000000000
          NumberFormat = '%.0f'
          LoLimit = 10.000000000000000000
          HiLimit = 30000.000000000000000000
        end
        object edFastFrameHeight: TValidatedEdit
          Left = 140
          Top = 72
          Width = 90
          Height = 21
          Text = ' 50 '
          Value = 50.000000000000000000
          Scale = 1.000000000000000000
          NumberFormat = '%.0f'
          LoLimit = 10.000000000000000000
          HiLimit = 30000.000000000000000000
        end
      end
      object ScanGrp: TGroupBox
        Left = 256
        Top = 10
        Width = 235
        Height = 241
        Caption = ' Scan Settings'
        TabOrder = 1
        object Label3: TLabel
          Left = 73
          Top = 110
          Width = 58
          Height = 13
          Alignment = taRightJustify
          Caption = 'Phase delay'
        end
        object xscalelab: TLabel
          Left = 66
          Top = 136
          Width = 65
          Height = 13
          Alignment = taRightJustify
          Caption = 'X scale factor'
        end
        object Label5: TLabel
          Left = 66
          Top = 160
          Width = 65
          Height = 13
          Alignment = taRightJustify
          Caption = 'Y scale factor'
        end
        object Label6: TLabel
          Left = 59
          Top = 184
          Width = 72
          Height = 13
          Alignment = taRightJustify
          Caption = 'Max. scan rate'
        end
        object Label9: TLabel
          Left = 36
          Top = 208
          Width = 95
          Height = 13
          Alignment = taRightJustify
          Caption = 'Min. pixel dwell time'
        end
        object Label11: TLabel
          Left = 78
          Top = 18
          Width = 53
          Height = 13
          Alignment = taRightJustify
          Caption = 'Field Width'
        end
        object Label24: TLabel
          Left = 82
          Top = 44
          Width = 49
          Height = 13
          Alignment = taRightJustify
          Caption = 'Field Edge'
        end
        object ckCorrectSineWaveDistortion: TCheckBox
          Left = 26
          Top = 88
          Width = 201
          Height = 15
          Alignment = taLeftJustify
          Caption = 'Correct Sine Wave Distortion'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object edPhaseShift: TValidatedEdit
          Left = 137
          Top = 110
          Width = 90
          Height = 21
          Text = ' 0 ms'
          Scale = 1000.000000000000000000
          Units = 'ms'
          NumberFormat = '%.4g'
          LoLimit = -1.000000015047466E30
          HiLimit = 20000.000000000000000000
        end
        object edXVoltsPerMicron: TValidatedEdit
          Left = 137
          Top = 136
          Width = 90
          Height = 21
          Text = ' 1 V/um'
          Value = 1.000000000000000000
          Scale = 1.000000000000000000
          Units = 'V/um'
          NumberFormat = '%.4g'
          LoLimit = 0.000009999999747379
          HiLimit = 1.000000000000000000
        end
        object edYVoltsPerMicron: TValidatedEdit
          Left = 137
          Top = 160
          Width = 90
          Height = 21
          Text = ' 1 V/um'
          Value = 1.000000000000000000
          Scale = 1.000000000000000000
          Units = 'V/um'
          NumberFormat = '%.4g'
          LoLimit = 0.000009999999747379
          HiLimit = 10.000000000000000000
        end
        object edMaxScanRate: TValidatedEdit
          Left = 137
          Top = 184
          Width = 90
          Height = 21
          Text = ' 100.0 Hz'
          Value = 100.000000000000000000
          Scale = 1.000000000000000000
          Units = 'Hz'
          NumberFormat = '%.1f'
          LoLimit = 1.000000000000000000
          HiLimit = 500.000000000000000000
        end
        object ckBidirectionalScan: TCheckBox
          Left = 26
          Top = 65
          Width = 201
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Bi-directional scan'
          TabOrder = 5
        end
        object edMinPixelDwellTime: TValidatedEdit
          Left = 137
          Top = 205
          Width = 90
          Height = 21
          Text = ' 0.5 us'
          Value = 0.000000499999998738
          Scale = 1000000.000000000000000000
          Units = 'us'
          NumberFormat = '%.4g'
          LoLimit = -1.000000015047466E30
          HiLimit = 1.000000000000000000
        end
        object edFullFieldWidthMicrons: TValidatedEdit
          Left = 137
          Top = 18
          Width = 90
          Height = 21
          Hint = 'Maximum width of scanning field (um)'
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
          Left = 137
          Top = 43
          Width = 90
          Height = 21
          Hint = 
            'Additional non-imaging region at edge of field (% of field width' +
            ')'
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
    end
    object PMTTab: TTabSheet
      Caption = 'PM Tubes'
      ImageIndex = 1
      object PMTgrp: TGroupBox
        Left = 8
        Top = 10
        Width = 230
        Height = 235
        TabOrder = 0
        object Label2: TLabel
          Left = 20
          Top = 17
          Width = 103
          Height = 13
          Alignment = taRightJustify
          Caption = 'No. of PMTs available'
        end
        object Label18: TLabel
          Left = 74
          Top = 201
          Width = 49
          Height = 13
          Alignment = taRightJustify
          Caption = 'Black level'
        end
        object Label19: TLabel
          Left = 20
          Top = 44
          Width = 103
          Height = 13
          Alignment = taRightJustify
          Caption = 'PMT0 Voltage Control'
        end
        object Label20: TLabel
          Left = 20
          Top = 71
          Width = 103
          Height = 13
          Alignment = taRightJustify
          Caption = 'PMT1 Voltage Control'
        end
        object Label21: TLabel
          Left = 20
          Top = 98
          Width = 103
          Height = 13
          Alignment = taRightJustify
          Caption = 'PMT2 Voltage Control'
        end
        object Label22: TLabel
          Left = 20
          Top = 125
          Width = 103
          Height = 13
          Alignment = taRightJustify
          Caption = 'PMT3 Voltage Control'
        end
        object Label23: TLabel
          Left = 19
          Top = 152
          Width = 104
          Height = 13
          Alignment = taRightJustify
          Caption = 'PMT voltage at 100%'
        end
        object edNumPMTs: TValidatedEdit
          Left = 130
          Top = 17
          Width = 90
          Height = 21
          Text = ' 1 '
          Value = 1.000000000000000000
          Scale = 1.000000000000000000
          NumberFormat = '%.0f'
          LoLimit = 1.000000000000000000
          HiLimit = 4.000000000000000000
        end
        object ckInvertPMTsignal: TCheckBox
          Left = 111
          Top = 180
          Width = 108
          Height = 15
          Alignment = taLeftJustify
          Caption = 'Invert PMT signal'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
        object edBlackLevel: TValidatedEdit
          Left = 130
          Top = 201
          Width = 90
          Height = 21
          Text = ' 10 '
          Value = 10.000000000000000000
          Scale = 1.000000000000000000
          NumberFormat = '%.0f'
          LoLimit = -32768.000000000000000000
          HiLimit = 32767.000000000000000000
        end
        object cbPMTControl0: TComboBox
          Left = 130
          Top = 44
          Width = 90
          Height = 21
          Style = csDropDownList
          TabOrder = 3
        end
        object cbPMTControl1: TComboBox
          Left = 130
          Top = 71
          Width = 90
          Height = 21
          Style = csDropDownList
          TabOrder = 4
        end
        object cbPMTControl2: TComboBox
          Left = 130
          Top = 98
          Width = 90
          Height = 21
          Style = csDropDownList
          TabOrder = 5
        end
        object cbPMTControl3: TComboBox
          Left = 130
          Top = 125
          Width = 90
          Height = 21
          Style = csDropDownList
          TabOrder = 6
        end
        object edPMTMaxVolts: TValidatedEdit
          Left = 130
          Top = 152
          Width = 90
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
        Caption = ' Z position Control'
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
          Top = 43
          Width = 97
          Height = 21
          Style = csDropDownList
          TabOrder = 0
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
        Height = 98
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

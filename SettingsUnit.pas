unit SettingsUnit;
// ------------------------------------
// MesoScan - Scan Settings dialog box
// ------------------------------------
// 1-6-12 MinPixelDwellTimeAdded
// 17.03.15 Scan now only set to full field when full field with changed.
// 27.06.16 Enabled property removed
// 26.10.16 Frame height/widths limited to 10-30K
// 10.05.17 ZPositionMin, ZPositionMax limits added
// 14.05.18 edRawImagesDirectory added setting raw images folder to be changed by user
// 22.05.24 ZStage.StageProtectionTTLTrigger added to settings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ValidatedEdit, math,
  Vcl.ComCtrls, Vcl.ExtCtrls ;

type
  TSettingsFrm = class(TForm)
    bOK: TButton;
    bCancel: TButton;
    StageTab: TPageControl;
    ScanTab: TTabSheet;
    PMTTab: TTabSheet;
    LasersTab: TTabSheet;
    TabSheet1: TTabSheet;
    MiscTab: TTabSheet;
    ImageHRGrp: TGroupBox;
    Label1: TLabel;
    edHRFrameWidth: TValidatedEdit;
    ScanGrp: TGroupBox;
    Label3: TLabel;
    xscalelab: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label24: TLabel;
    ckCorrectSineWaveDistortion: TCheckBox;
    edPhaseShift: TValidatedEdit;
    edXVoltsPerMicron: TValidatedEdit;
    edYVoltsPerMicron: TValidatedEdit;
    edMaxScanRate: TValidatedEdit;
    ckBidirectionalScan: TCheckBox;
    edMinPixelDwellTime: TValidatedEdit;
    edFullFieldWidthMicrons: TValidatedEdit;
    edFieldEdge: TValidatedEdit;
    Label4: TLabel;
    edFastFrameWidth: TValidatedEdit;
    Label12: TLabel;
    edFastFrameHeight: TValidatedEdit;
    PMTgrp: TGroupBox;
    Label2: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    edNumPMTs: TValidatedEdit;
    ckInvertPMTsignal: TCheckBox;
    edBlackLevel: TValidatedEdit;
    cbPMTControl0: TComboBox;
    cbPMTControl1: TComboBox;
    cbPMTControl2: TComboBox;
    cbPMTControl3: TComboBox;
    edPMTMaxVolts: TValidatedEdit;
    GroupBox2: TGroupBox;
    Label8: TLabel;
    Label10: TLabel;
    Label13: TLabel;
    cbZStagePort: TComboBox;
    edZScaleFactor: TValidatedEdit;
    cbZStageType: TComboBox;
    edZStepTime: TValidatedEdit;
    GroupBox3: TGroupBox;
    Label25: TLabel;
    edImageJPath: TEdit;
    ckSaveAsMultipageTIFF: TCheckBox;
    cbLaserType: TComboBox;
    GroupBox4: TGroupBox;
    edLaserName0: TEdit;
    Label28: TLabel;
    lbLaser0: TLabel;
    Label29: TLabel;
    edLaserName1: TEdit;
    Label30: TLabel;
    edLaserName2: TEdit;
    Label31: TLabel;
    edLaserName3: TEdit;
    Label32: TLabel;
    edLaserName4: TEdit;
    Label33: TLabel;
    edLaserName5: TEdit;
    Label34: TLabel;
    edLaserName6: TEdit;
    Label35: TLabel;
    edLaserName7: TEdit;
    LaserExternalControlPanel: TPanel;
    Label27: TLabel;
    Label26: TLabel;
    Label36: TLabel;
    cbLaserActiveControl0: TComboBox;
    cbLaserActiveControl1: TComboBox;
    cbLaserActiveControl2: TComboBox;
    cbLaserActiveControl3: TComboBox;
    cbLaserActiveControl4: TComboBox;
    cbLaserActiveControl5: TComboBox;
    cbLaserActiveControl6: TComboBox;
    cbLaserActiveControl7: TComboBox;
    cbLaserIntensityControl0: TComboBox;
    cbLaserIntensityControl1: TComboBox;
    cbLaserIntensityControl2: TComboBox;
    cbLaserIntensityControl3: TComboBox;
    cbLaserIntensityControl4: TComboBox;
    cbLaserIntensityControl5: TComboBox;
    cbLaserIntensityControl6: TComboBox;
    cbLaserIntensityControl7: TComboBox;
    edLaserVMax0: TValidatedEdit;
    edLaserVMax1: TValidatedEdit;
    edLaserVMax2: TValidatedEdit;
    edLaserVMax3: TValidatedEdit;
    edLaserVMax4: TValidatedEdit;
    edLaserVMax5: TValidatedEdit;
    edLaserVMax6: TValidatedEdit;
    edLaserVMax7: TValidatedEdit;
    Label15: TLabel;
    edLaserShutterChangeTime: TValidatedEdit;
    ckLaserControlEnabled: TCheckBox;
    Panel1: TPanel;
    Label7: TLabel;
    cbLaserControlComPort: TComboBox;
    Label14: TLabel;
    edZpositionMin: TValidatedEdit;
    Label16: TLabel;
    edZPositionMax: TValidatedEdit;
    GroupBox1: TGroupBox;
    Label17: TLabel;
    edRawImagesDirectory: TEdit;
    gpStageProtection: TGroupBox;
    edStageProtectionTTLTrigger: TValidatedEdit;
    Label37: TLabel;
    gpZPositionDial: TGroupBox;
    Label38: TLabel;
    edZDialMicronsPerStepCoarse: TValidatedEdit;
    Label39: TLabel;
    cbZDialADCInputs: TComboBox;
    edZDialMicronsPerStepFine: TValidatedEdit;
    Label41: TLabel;
    gpPriorCommands: TGroupBox;
    Label40: TLabel;
    edPriorCommand: TEdit;
    bPriorSend: TButton;
    mePriorReply: TMemo;
    lbReply: TLabel;
    procedure FormShow(Sender: TObject);
    procedure bOKClick(Sender: TObject);
    procedure bCancelClick(Sender: TObject);
    procedure cbZStageTypeChange(Sender: TObject);
    procedure bPriorSendClick(Sender: TObject);
    procedure cbZStagePortChange(Sender: TObject);
  private
    { Private declarations }
    procedure SetLaser(
          iLaser : Integer ;                  // Laser #
          edName : TEdit ;                 // Laser name
          cbLaserActive :TComboBox ;     // Laser on/off control line menu
          cbLaserIntensity :TComboBox ;  // Laser intensity control line menu
          edVMax : TValidatedEdit ) ;        // Voltage at 100%

    procedure GetLaser(
          iLaser : Integer ;                  // Laser #
          edName : TEdit ;                   // Laser name
          cbLaserActive : TComboBox ;        // Laser on/off control line menu
          cbLaserIntensity : TComboBox ;     // Laser intensity control line menu
          edVMax : TValidatedEdit ) ;        // Voltage at 100%


  public
    { Public declarations }
  end;

var
  SettingsFrm: TSettingsFrm;

implementation

{$R *.dfm}

uses MainUnit, ZStageUnit, LaserUnit, LabIOUnit;

procedure TSettingsFrm.bCancelClick(Sender: TObject);
// ---------------------
// Cancel and close form
// ---------------------
begin
     Close
     end;


procedure TSettingsFrm.FormShow(Sender: TObject);
// --------------------------
// Initialise form on display
// --------------------------
var
    i,iDev : Integer ;
begin

    edHRFrameWidth.Value := MainFrm.HRFrameWidth ;
    edFastFrameWidth.Value := MainFrm.FastFrameWidth ;
    edFastFrameHeight.Value := MainFrm.FastFrameHeight ;

    edNumPMTs.Value := MainFrm.NumPMTs ;
    edPhaseShift.Value := MainFrm.PhaseShift ;
    ckBidirectionalScan.Checked :=  MainFrm.BidirectionalScan ;
    edMaxScanRate.Value := MainFrm.MaxScanRate ;
    edMinPixelDwellTime.Value := MainFrm.MinPixelDwellTime ;
    edXVoltsPerMicron.Value := MainFrm.XVoltsPerMicron ;
    edYVoltsPerMicron.Value := MainFrm.YVoltsPerMicron ;
    ckCorrectSineWaveDistortion.Checked := MainFrm.CorrectSineWaveDistortion ;
    edBlackLevel.Value := MainFrm.BlackLevel ;
    edFullFieldWidthMicrons.Value := MainFrm.FullFieldWidthMicrons ;
    edFieldEdge.Value := MainFrm.FieldEdge ;
    ckInvertPMTSignal.Checked := MainFrm.InvertPMTSignal ;

    // PMT control lines
    cbPMTControl0.Clear ;
    cbPMTControl0.Items.Add('None') ;
    for iDev := 1 to LabIO.NumDevices do
        for i := 0 to LabIO.NumDACs[iDev]-1 do
        begin
        cbPMTControl0.Items.Add(Format('Dev%d:AO%d',[iDev,i])) ;
        end;
    cbPMTControl1.Items.Assign(cbPMTControl0.Items);
    cbPMTControl2.Items.Assign(cbPMTControl0.Items);
    cbPMTControl3.Items.Assign(cbPMTControl0.Items);
    cbPMTControl0.ItemIndex := MainFrm.PMTControls[0] + 1 ;
    cbPMTControl1.ItemIndex := MainFrm.PMTControls[1] + 1 ;
    cbPMTControl2.ItemIndex := MainFrm.PMTControls[2] + 1 ;
    cbPMTControl3.ItemIndex := MainFrm.PMTControls[3] + 1 ;

    edPMTMaxVolts.Value := MainFrm.PMTMaxVolts ;

    // Laser control
    Laser.GetLaserTypes(cbLaserType.Items);
    Laser.GetCOMPorts( cbLaserControlComPort.Items ) ;

    // Set laser control line menus (for external control)
    SetLaser( 0, edLaserName0, cbLaserActiveControl0, cbLaserIntensityControl0, edLaserVMax0 ) ;
    SetLaser( 1, edLaserName1, cbLaserActiveControl1, cbLaserIntensityControl1, edLaserVMax1 ) ;
    SetLaser( 2, edLaserName2, cbLaserActiveControl2, cbLaserIntensityControl2, edLaserVMax2 ) ;
    SetLaser( 3, edLaserName3, cbLaserActiveControl3, cbLaserIntensityControl3, edLaserVMax3 ) ;
    SetLaser( 4, edLaserName4, cbLaserActiveControl4, cbLaserIntensityControl4, edLaserVMax4 ) ;
    SetLaser( 5, edLaserName5, cbLaserActiveControl5, cbLaserIntensityControl5, edLaserVMax5 ) ;
    SetLaser( 6, edLaserName6, cbLaserActiveControl6, cbLaserIntensityControl6, edLaserVMax6 ) ;
    SetLaser( 7, edLaserName7, cbLaserActiveControl7, cbLaserIntensityControl7, edLaserVMax7 ) ;

    // Z stage control
    ZStage.GetZStageTypes(cbZStageType.Items);
    cbZStageType.ItemIndex := Min(Max(ZStage.StageType,0),cbZStageType.Items.Count-1) ;

    ZStage.GetControlPorts( cbZStagePort.Items );
    cbZStagePort.ItemIndex := cbZStagePort.Items.IndexOfObject(TObject(ZStage.ControlPort)) ;

    edZScaleFactor.Units := ZStage.ScaleFactorUnits ;
    edZScaleFactor.Value := ZStage.ZScaleFactor ;
    edZStepTime.Value := ZStage.ZStepTime ;
    edZPositionMin.Value := ZStage.ZPositionMin ;
    edZPositionMax.Value := ZStage.ZPositionMax ;
    edStageProtectionTTLTrigger.Value := ZStage.StageProtectionTTLTrigger ;

    // Z rotational encoder dial
    ZStage.GetZDialADCInputs( cbZDialADCInputs.Items ) ;
    cbZDialADCInputs.ItemIndex := cbZDialADCInputs.Items.IndexOfObject(Tobject(ZStage.ZDialADCInputs)) ;
    edZDialMicronsPerStepCoarse.Value := ZStage.ZDialMicronsPerStepCoarse ;
    edZDialMicronsPerStepFine.Value := ZStage.ZDialMicronsPerStepFine ;

    edImageJPath.Text := MainFrm.ImageJPath ;
    ckSaveAsMultipageTIFF.Checked := MainFrm.SaveAsMultipageTIFF ;
    edRawImagesDirectory.Text := MainFrm.RawImagesDirectory ;

    end;



procedure TSettingsFrm.bOKClick(Sender: TObject);
// --------------------------
// Update program settings
// --------------------------
begin
    MainFrm.HRFRameWidth := Round(edHRFRameWidth.Value) ;
    MainFrm.FastFRameWidth := Round(edFastFRameWidth.Value) ;
    MainFrm.FastFRameHeight := Round(edFastFRameHeight.Value) ;
    MainFrm.BidirectionalScan := ckBidirectionalScan.Checked ;
    MainFrm.MaxScanRate := edMaxScanRate.Value ;
    MainFrm.MinPixelDwellTime := edMinPixelDwellTime.Value ;
    MainFrm.XVoltsPerMicron := edXVoltsPerMicron.Value ;
    MainFrm.YVoltsPerMicron := edYVoltsPerMicron.Value ;
    MainFrm.PhaseShift := edPhaseShift.Value ;
    MainFrm.CorrectSineWaveDistortion := ckCorrectSineWaveDistortion.Checked ;
    MainFrm.BlackLevel := Round(edBlackLevel.Value) ;

    MainFrm.NumPMTs := Round(edNumPMTs.Value) ;
    MainFrm.PMTControls[0] := cbPMTControl0.ItemIndex - 1 ;
    MainFrm.PMTControls[1] := cbPMTControl1.ItemIndex - 1 ;
    MainFrm.PMTControls[2] := cbPMTControl2.ItemIndex - 1 ;
    MainFrm.PMTControls[3] := cbPMTControl3.ItemIndex - 1 ;
    MainFrm.PMTMaxVolts := edPMTMaxVolts.Value ;
    MainFrm.UpdatePMTSettings ;

    if (MainFrm.FullFieldWidthMicrons <> edFullFieldWidthMicrons.Value) or
       (MainFrm.FieldEdge <> edFieldEdge.Value)then
       begin
       MainFrm.FullFieldWidthMicrons := edFullFieldWidthMicrons.Value ;
       MainFrm.FieldEdge := edFieldEdge.Value ;
       MainFrm.SetScanZoomToFullField ;
       end;

    MainFrm.InvertPMTSignal := ckInvertPMTSignal.Checked ;

    // Set laser control line menus (for external control)
    GetLaser( 0, edLaserName0, cbLaserActiveControl0, cbLaserIntensityControl0, edLaserVMax0 ) ;
    GetLaser( 1, edLaserName1, cbLaserActiveControl1, cbLaserIntensityControl1, edLaserVMax1 ) ;
    GetLaser( 2, edLaserName2, cbLaserActiveControl2, cbLaserIntensityControl2, edLaserVMax2 ) ;
    GetLaser( 3, edLaserName3, cbLaserActiveControl3, cbLaserIntensityControl3, edLaserVMax3 ) ;
    GetLaser( 4, edLaserName4, cbLaserActiveControl4, cbLaserIntensityControl4, edLaserVMax4 ) ;
    GetLaser( 5, edLaserName5, cbLaserActiveControl5, cbLaserIntensityControl5, edLaserVMax5 ) ;
    GetLaser( 6, edLaserName6, cbLaserActiveControl6, cbLaserIntensityControl6, edLaserVMax6 ) ;
    GetLaser( 7, edLaserName7, cbLaserActiveControl7, cbLaserIntensityControl7, edLaserVMax7 ) ;

    Laser.ShutterChangeTime := edLaserShutterChangeTime.Value ;

    ZStage.ControlPort := Integer( cbZStagePort.Items.Objects[cbZStagePort.ItemIndex] ) ;
    ZStage.ZScaleFactor := edZScaleFactor.Value ;
    ZStage.ZStepTime := edZStepTime.Value ;
    ZStage.ZPositionMin := edZPositionMin.Value ;
    ZStage.ZPositionMax := edZPositionMax.Value ;
    ZStage.StageProtectionTTLTrigger := Round(edStageProtectionTTLTrigger.Value) ;

    // Z rotational encoder dial
    ZStage.StopZDialADC ;
    ZStage.ZDialADCInputs := Integer(cbZDialADCInputs.Items.Objects[Max(cbZDialADCInputs.ItemIndex,0)]) ;
    ZStage.ZDialMicronsPerStepCoarse := edZDialMicronsPerStepCoarse.Value ;
    ZStage.ZDialMicronsPerStepFine := edZDialMicronsPerStepFine.Value ;
    ZStage.StartZDialADC ;

    MainFrm.ImageJPath := edImageJPath.Text ;
    MainFrm.SaveAsMultipageTIFF := ckSaveAsMultipageTIFF.Checked ;

    // Raw images storage folder
    MainFrm.RawImagesDirectory := edRawImagesDirectory.Text ;
    MainFrm.RawImagesFileName := MainFrm.RawImagesDirectory + 'mesoscan.raw' ;

    Close ;
    end;


procedure TSettingsFrm.bPriorSendClick(Sender: TObject);
// ----------------------------------------------
// Send command to Prior stage and wait for reply
// ----------------------------------------------
var
    TimedOut : Boolean ;
    s : string ;
begin
    ZStage.PriorSendCommand( edPriorCommand.Text ) ;
    s := ZStage.PriorReadReply ;
    if s = '' then s := 'No Reply' ;
    mePriorReply.Lines.Add( s ) ;
end;


procedure TSettingsFrm.cbZStagePortChange(Sender: TObject);
// ----------------
// COM port changed
// ----------------
begin
    ZStage.ControlPort := Integer( cbZStagePort.Items.Objects[cbZStagePort.ItemIndex] ) ;
end;


procedure TSettingsFrm.cbZStageTypeChange(Sender: TObject);
//
// Zstage type changed
//
begin
    ZStage.StageType := cbZStageType.ItemIndex ;
    ZStage.GetControlPorts(cbZStagePort.Items);
    cbZStagePort.ItemIndex := Min(Max(ZStage.ControlPort,0),cbZStagePort.Items.Count-1) ;

    edZScaleFactor.Units := ZStage.ScaleFactorUnits ;
    edZScaleFactor.Value := ZStage.ZScaleFactor ;

    end;

procedure TSettingsFrm.SetLaser(
          iLaser : Integer ;                  // Laser #
          edName : TEdit ;                   // Laser name
          cbLaserActive : TComboBox ;        // Laser on/off control line menu
          cbLaserIntensity : TComboBox ;     // Laser intensity control line menu
          edVMax : TValidatedEdit ) ;        // Voltage at 100%
// ----------------------------------
// Update laser control line settings
// ----------------------------------
begin
     edName.Text := Laser.LaserName[iLaser] ;
     Laser.GetActiveControlLines(cbLaserActive.Items);
     cbLaserActive.ItemIndex := cbLaserActive.items.IndexOfObject(TObject(Laser.ActiveControlPort[iLaser]));
     Laser.GetIntensityControlLines(cbLaserIntensity.Items);
     cbLaserIntensity.ItemIndex := cbLaserIntensity.items.IndexOfObject(TObject(Laser.IntensityControlPort[iLaser]));
     edVMax.Value := Laser.VMaxIntensity[iLaser] ;
     end ;

procedure TSettingsFrm.GetLaser(
          iLaser : Integer ;                  // Laser #
          edName : TEdit ;                   // Laser name
          cbLaserActive : TComboBox ;        // Laser on/off control line menu
          cbLaserIntensity : TComboBox ;     // Laser intensity control line menu
          edVMax : TValidatedEdit ) ;        // Voltage at 100%
// ----------------------------------
// Get laser control line settings
// ----------------------------------
begin
     Laser.LaserName[iLaser] := edName.Text ;
//     Laser.ActiveControlPort[iLaser] := Integer(cbLaserActive.Items.Objects[cbLaserActive.ItemIndex]);
//     Laser.IntensityControlPort[iLaser] := Integer(cbLaserIntensity.Items.Objects[cbLaserIntensity.ItemIndex]);
     Laser.VMaxIntensity[iLaser] := edVMax.Value ;
     end ;


end.

unit MainUnit;
// =======================================================================
// Mesoscan: Mesolens confocal LSM software                                                        e                                                                           ast
// =======================================================================
// (c) John Dempster, University of Strathclyde 2011-12
// V1.0 1-5-12
// V1.3 19-6-12 Z stage and 3D images now supported
// V1.5 20-03-13
// V1.5 08-08-13 Scan area now correctly updated when fullfieldwidth changed
//               Fixes offsets observed in scans
//               Incorrect offset on Y axis scan fixed
// V1.5.1 15.5.14 XZ imaging mode now works
//                Voltage controlled lens positioner now supported
//                Region of interest can now be set by double-clicking and dragging
// V1.5.2 15.07.14 Laser shutter control added
// V1.5.3 19.01.15 Y scan now working correctly again (after V1.5.x)
//                 XZ imaging checked Y position now matches horizontal cursor
// V1.5.4 10.03.15 Now supports up to 4 PMT channels
//                 PMT voltage control added
// V1.5.5 10.03.15 Access violations on startup with no settings file fixed
// V1.5.6 17.03.15 Scan now only set to full field when full field with changed in setup
//                 FrameHeight now forced to be greater than 1.
//                 PMT gain menus now forced to valid settings
// V1.5.7 14.05.15 Z position is now incremented one step at end of stack
//                 rather than being returned to top of stack to allow stack to be extended                                                                                 k
//                 Scan Full Field now correctly zooms out to full field (rather than
//                 to next wider zoom setting)
// V1.5.8 08.03.16 Beam now parked at 0,0 by last line of scan and unparked in first line
// V1.5.9 27.05.16 27.0.16 Z stage pressure switch protection implemented
// V1.6.0 26.06.16 XZ mode being fixed
// V1.6.1 27.06.16 XZ mode revised and now working
// V1.6.2 26.10.16 Frame sizes now limited to 10,10 ... 20K,20K
//                 PMT controls disabled when scanning
//                 Exit query when user stops program
// V1.6.3 13.02.17 Z steps no longer forced to be multiples of XY pixel size
// V1.6.4 10.05.17 ZPositionMin, ZPositionMax limits added
// V1.6.5 27.10.17 ZStageUnit: Stage protection interrupt now interrupts Z movement commands before move to zero.
// V1.6.6 91.11.17 ZStageUnit: OptiScan II now operated in standard (COMP 0) mode
// V1.6.7 14.05.18 RawImagesDirectory added allowing user to change folder holding raw images file (mesoscan.raw)
// V1.6.8 05.11.19 Now automatical determines max. sampling rate
//                 Display contrast buttons now only use acquired part of image during scanning.
//                 Brightness and contrast slider now work correctly
//                 PMT gain and voltage controls no longer disabled when scanning
//                 Image cleared to black at start of new scan
// V1.6.9 21.01.20 Averaging image repeats can now be saved
//        22.01.20 Tested in MesoScope 2
//                 Now adjusts A/D input mode when device only support pseudo diff.
// V1.7.0 14.09.20 Prior stage protection interrupt now triggered by a TTL high-low transition
//                 produced by Mesoscope V3 stage protection circuit when microswitches closed
// V1.7.1 19.04.21 Prior stage protection interrupt now triggered by a TTL low-high transition
//                 to be compatible with Strathclyde prototype mesolens system
// V1.7.3 22.05.24 Image intensity histogram added
//                 Form background now black
//                 Prior stage protection interrupt TTL transition now defined in settings
//                 MUTEX Dempster.MesoScan now prevents multiple instances
// V1.7.4 27.05.24 Plot colours of histogram can now be associated with PMT
//                 Repeat option turned off if scanning in high resolution mode
//                 Multiple copies of images no longer incorrectly saved after imaging in repeat mode
//                 Size of mouse grab areas on ROI box increaseed
// V1.7.5 26.06.24 Beam parking in first & last half scan cycles updated to linearly decrement sine amplitde to zero
//                 and Y position exponentially to zero. To fix audible galvo 'click' at start/end of scan.
//                 Display pixel readout cursor readout now updated when page changed.
// V1.7.6 05.08.24 PMT electron gain control now remains active during scan
// V1.7.7 10.08.24 Track bar added allowing mouse control of Z position
// V1.7.8 28.01.25 Rotational encoder added to provide coarse/fine control of Z stage movement
// V1.7.9 04.02.35 Z dial step now only moves stage after previous movement finishes
// V1.8.0 05.02.25 Z position updates after Z dial rotations now resticted to no more than 1 / sec
// V1.8.1 17.02.25 Z dial encoder sampling rate increased to 3.3 kHz to ensure detection of pulses
//                 when dial rotated quickly. Delay between Z stage updates reduced to 0.5s
//                 Upper limit of Z dial steps set to 250 um.
// V1.8.2 03.03.25 User entered commands can now be sent directly to Prior stages
//                 Only COM that exist are now listed
// V1.8.3 05.07.25 XGalvOAO XGalvoInvert YGalvOAO YGalvoInvert added to settings
//                 Each PMT signal channel can now be inverted individually
//                 Focus Mode option added showing fast scan of centre of image
// V1.8.4 09.07.25 LabIO updated to fix PMT gains beings stuck on X1
//

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ValidatedEdit, LabIOUnit, RangeEdit, math,
  ExtCtrls, ImageFile, xmldoc, xmlintf, ActiveX, Vcl.Menus, system.types, strutils, UITypes, shellapi, shlobj,
  XYPlotDisplay ;
const
    VMax = 10.0 ;
    NumGalvoDACs = 2 ;
    MaxFrameWidth = 30000 ;
    MaxFrameHeight = 30000 ;
    MinFrameWidth = 10 ;
    MinFrameHeight = 10 ;
    MaxFrameType = 2 ;
    MinPaletteColor = 11 ;
    MaxPaletteColor = 255 ;
    GreyScalePalette = 0 ;
    LUTSize = $10000 ;
    GreyLevelLimit = $FFFF ;
    FalseColourPalette = 1 ;
    MaxScanSpeed = 100. ;
    MinPixelDwellTime = 2E-6 ;
    MaxZoomFactors = 100 ;
    XYMode = 0 ;
    XYZMode = 1 ;
    XTMode = 2 ;
    XZMode = 3 ;
    MaxPMT = 3 ;
    HistogramNumBins = 200 ;

    zmFocusMode = 2 ;
    zmZoomIn = 1 ;
    zmZoomOut = -1 ;
    zmFullField = -2 ;
type
 TPaletteType = (palGrey,palGreen,palRed,palBlue,palFalseColor) ;
 TDoubleRect = record
    Left : Double ;
    Right : Double ;
    Top : Double ;
    Bottom : Double ;
    Width : Double ;
    Height : Double ;
    end ;

  TMainFrm = class(TForm)
    ControlGrp: TGroupBox;
    bScanImage: TButton;
    ImageGrp: TGroupBox;
    ZSectionPanel: TPanel;
    Timer: TTimer;
    bStopScan: TButton;
    ImageFile: TImageFile;
    SaveDialog: TSaveDialog;
    ckRepeat: TCheckBox;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    mnExit: TMenuItem;
    mnSetup: TMenuItem;
    mnScanSettings: TMenuItem;
    Panel1: TPanel;
    scZSection: TScrollBar;
    lbZSection: TLabel;
    lbReadout: TLabel;
    rbFastScan: TRadioButton;
    rbHRScan: TRadioButton;
    bScanZoomOut: TButton;
    bScanZoomIn: TButton;
    ImageSizeGrp: TGroupBox;
    Label4: TLabel;
    edNumRepeats: TValidatedEdit;
    ZStackGrp: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    edNumZsteps: TValidatedEdit;
    edNumPixelsPerZStep: TValidatedEdit;
    cbImageMode: TComboBox;
    Label1: TLabel;
    edMicronsPerZStep: TValidatedEdit;
    LineScanGrp: TGroupBox;
    Label2: TLabel;
    edLineScanFrameHeight: TValidatedEdit;
    ZStageGrp: TGroupBox;
    edZTop: TValidatedEdit;
    edGotoZPosition: TValidatedEdit;
    bGotoZPosition: TButton;
    PMTGrp: TGroupBox;
    LaserGrp: TGroupBox;
    edLaserIntensity: TValidatedEdit;
    tbLaserIntensity: TTrackBar;
    rbLaserOn: TRadioButton;
    rbLaserOff: TRadioButton;
    DisplayGrp: TGroupBox;
    Splitter1: TSplitter;
    cbPalette: TComboBox;
    StatusGrp: TGroupBox;
    meStatus: TMemo;
    bScanFull: TButton;
    mnSaveImage: TMenuItem;
    ZoomPanel: TPanel;
    lbZoom: TLabel;
    bZoomIn: TButton;
    bZoomOut: TButton;
    PanelPMT0: TPanel;
    cbPMTGain0: TComboBox;
    edPMTVolts0: TValidatedEdit;
    Label15: TLabel;
    Label3: TLabel;
    ckEnablePMT0: TCheckBox;
    udPMTVolts0: TUpDown;
    PanelPMT1: TPanel;
    cbPMTGain1: TComboBox;
    edPMTVolts1: TValidatedEdit;
    ckEnablePMT1: TCheckBox;
    udPMTVolts1: TUpDown;
    PanelPMT2: TPanel;
    cbPMTGain2: TComboBox;
    edPMTVolts2: TValidatedEdit;
    ckEnablePMT2: TCheckBox;
    udPMTVolts2: TUpDown;
    PanelPMT3: TPanel;
    cbPMTGain3: TComboBox;
    edPMTVolts3: TValidatedEdit;
    ckEnablePMT3: TCheckBox;
    udPMTVolts3: TUpDown;
    ImagePage: TPageControl;
    TabImage0: TTabSheet;
    TabImage1: TTabSheet;
    TabImage2: TTabSheet;
    TabImage3: TTabSheet;
    SavetoImageJ1: TMenuItem;
    ckKeepRepeats: TCheckBox;
    plHistogram: TXYPlotDisplay;
    Image0: TImage;
    gpYAxis: TGroupBox;
    rbYAxisLinear: TRadioButton;
    rbYAxisLog: TRadioButton;
    gpHistogramType: TGroupBox;
    rbLineHistogram: TRadioButton;
    rbImageHistogram: TRadioButton;
    gpContrast: TGroupBox;
    bFullScale: TButton;
    edDisplayIntensityRange: TRangeEdit;
    bMaxContrast: TButton;
    ckAutoOptimise: TCheckBox;
    ckContrast6SDOnly: TCheckBox;
    bRange: TButton;
    bCursors: TButton;
    ColorDialog: TColorDialog;
    gpPMTColor0: TGroupBox;
    gpPMTColor1: TGroupBox;
    gpPMTColor2: TGroupBox;
    gpPMTColor3: TGroupBox;
    tbZPosition: TTrackBar;
    rbZDialCoarse: TRadioButton;
    rbZDialFine: TRadioButton;
    bFocusScan: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure bScanImageClick(Sender: TObject);
    procedure bFullScaleClick(Sender: TObject);
    procedure edDisplayIntensityRangeKeyPress(Sender: TObject;
      var Key: Char);
    procedure bMaxContrastClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure bStopScanClick(Sender: TObject);
    procedure cbPaletteChange(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure mnExitClick(Sender: TObject);
    procedure edXPixelsKeyPress(Sender: TObject; var Key: Char);
    procedure edYPixelsKeyPress(Sender: TObject; var Key: Char);
    procedure mnScanSettingsClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tbLaserIntensityChange(Sender: TObject);
    procedure Image0MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ckLineScanClick(Sender: TObject);
    procedure bGotoZPositionClick(Sender: TObject);
    procedure bZoomInClick(Sender: TObject);
    procedure bZoomOutClick(Sender: TObject);
    procedure Image0MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image0MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure scZSectionChange(Sender: TObject);
    procedure rbFastScanClick(Sender: TObject);
    procedure rbHRScanClick(Sender: TObject);
    procedure bScanZoomInClick(Sender: TObject);
    procedure bScanZoomOutClick(Sender: TObject);
    procedure cbImageModeChange(Sender: TObject);
    procedure edNumPixelsPerZStepKeyPress(Sender: TObject; var Key: Char);
    procedure edMicronsPerZStepKeyPress(Sender: TObject; var Key: Char);
    procedure edGotoZPositionKeyPress(Sender: TObject; var Key: Char);
    procedure Image0DblClick(Sender: TObject);
    procedure bScanFullClick(Sender: TObject);
    procedure mnSaveImageClick(Sender: TObject);
    procedure edLaserIntensityKeyPress(Sender: TObject; var Key: Char);
    procedure ckEnablePMT0Click(Sender: TObject);
    procedure edPMTVolts0KeyPress(Sender: TObject; var Key: Char);
    procedure udPMTVolts0ChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Integer; Direction: TUpDownDirection);
    procedure udPMTVolts1ChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Integer; Direction: TUpDownDirection);
    procedure udPMTVolts2ChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Integer; Direction: TUpDownDirection);
    procedure udPMTVolts3ChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Integer; Direction: TUpDownDirection);
    procedure SavetoImageJ1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure bRangeClick(Sender: TObject);
    procedure rbImageHistogramClick(Sender: TObject);
    procedure bCursorsClick(Sender: TObject);
    procedure ImagePageChange(Sender: TObject);
    procedure gpPMTColor0Click(Sender: TObject);
    procedure tbZPositionChange(Sender: TObject);
    procedure bFocusScanClick(Sender: TObject);
  private
    { Private declarations }
        BitMap : Array[0..MaxPMT] of TBitMap ;  // Image internal bitmaps
//        Image : Array[0..MaxPMT] of TImage ;  // Image internal bitmaps
        procedure DisplayROI( BitMap : TBitmap ) ;
        procedure DisplaySquare(
                  BitMap : TBitMap ;
                  X : Integer ;
                  Y : Integer ) ;
        procedure FixRectangle( var Rect : TRect ) ;
        procedure SetImageSize(
                  Image : TImage ) ;
        function GetSpecialFolder(const ASpecialFolderID: Integer): string;
        procedure EnablePMTControls( Enabled : Boolean ) ;
  public
    { Public declarations }
    DeviceNum : Integer ;
    //ADCVoltageRange : Double ;
    ADCMaxValue : Integer ;
    DACMaxValue : Integer ;
    TempBuf : PBig16bitArray ;
    DACBuf : PBig16bitArray ;
    ADCBuf : PBig16bitArray ;
    AvgBuf : PBig32bitArray ;
    ADCMap : PBig32bitArray ;
//    XZLineAverage : PBig32bitArray ;
    ADCNumNewSamples : Integer ;
    ADCInput : Integer ;             // Selected analog input
    NumXPixels : Cardinal ;
    NumYPixels : Integer ;
    NumBeamParkLines : Integer ;        // No. of lines at start/end of scan used for beam parking/unparking
    NumPixels : Integer ;
    NumPixelsInDACBuf : Cardinal ;
//    BufSize : Integer ;
    XCentre : Double ;
    XWidth : Double ;
    YCentre : Double ;
    YHeight : Double ;
    ScanArea : Array[0..99] of TDoubleRect ;   // Selected scanning areas
    iScanZoom : Integer ;                      // Selected area in ScanArea
    PixelsToMicronsX : Double ;                // Image pixel X# to micron scaling factor
    PixelsToMicronsY : Double ;                // Image pixel Y# to micron scaling factor
    LineScanTime : Double ;                    // Time taken to scan a single line (s)
    LinesAvailableForDisplay : Integer ;       // Image lines available for display
    SelectedRect : TRect ;                     // Selected sub-area within displayed image (image pixels)
    SelectedRectBM : TRect ;                   // Selected sub-area (bitmap pixels)
    SelectedEdge : TRect ;                     // Selection rectangle edges selected
    MouseDown : Boolean ;                      // TRUE = image cursor mouse is depressed
    CursorPos : TPoint ;                       // Position of cursor within image
    TopLeftDown : TPoint ;
    MouseDownAt : TPoint ;                     // Mouse position when button depressed
    MouseUpCursor : Integer ;                  // Cursor icon when button released
    ZTop : Double ;
    //Zoom : Double ;
    FullFieldWidthMicrons : Double ;      // Actual width of full imaging field (um)
    FieldEdge : Double ;                  // Non-imaging edge of scan width (% of field width)
    BidirectionalScan : Boolean ;         // TRUE = bidirectional scan enabled
    CorrectSineWaveDistortion : Boolean ; // TRUE = sine wave image distortion correction
    InvertPMTSignal : Boolean ;           // TRUE = PMT signal inverted
    BlackLevel : Integer ;                // Black level of PMT signal
    MaxScanRate : Double ;                // Highest permitted scan rate
    MinPixelDwellTime : Double ;          // Smallest permitted pixel dwell time

    XGalvoAO : Integer ;                 // Resource # of AO port controlling X galvo
    YGalvoAO : Integer ;                 // Resource # of AO port controlling Y galvo
    XVoltsPerMicron : Double ;            // X galvo volts per micron displacement scall factor
    YVoltsPerMicron : Double ;            // Y galvo volts per micron displacement scall factor
    XGalvoInvert : Boolean ;              // TRUE = Invert X galvo voltage signal
    YGalvoInvert : Boolean ;              // TRUE = Invert Y galvo voltage signal

    PhaseShift : Double ;                 // Phase delay between galvo command & galvo displacement

    FrameWidth : Integer ;                // Width of image on display
    FrameHeight : Integer ;               // Height of image of display
    FullFieldWidth : Integer ;            // Width of full field image
    HRFrameWidth : Integer ;       // Width of high res. image
    HRFrameHeight : Integer ;      // Height of image of display

    FocusModeFrameWidth : Integer ;   // Focus mode: frame width (pixels)
    FocusModeFrameHeight : Integer ;  // Focus mode: frame height (lines)
    FocusModeRegion : Double ;        // Focus mode: imaging region (centred %)

    FastFrameWidth : Integer ;     // Fast imaging: frame width (pixels)
    FastFrameHeight : Integer ;    // Fast imaging: frame height (pixels)
    FastBiDirectionalScan : Boolean ; // TRUE = fast bidirectional scan
    FrameHeightScale : Double ;    // Fast imaging: Frame height scaling factor
    ScanInfo : String ;
    // PMT setting
    NumPMTs : Integer ;
    PMTGain : Array[0..MaxPMT] of Double ;
    PMTVolts : Array[0..MaxPMT] of Double ;
    PMTControls : Array[0..MaxPMT] of Integer ;      // PMT control voltage channel
    PMTInvertSignal : Array[0..MaxPMT] of Boolean ;  // TRUE = Invert output signal of PMT
    InvertADCValue : Array[0..MaxPMT] of Integer ;   // Inversion scale factor for AI channal associated with PMT
    PMTMaxVolts : double ;
    PMTList : Array[0..MaxPMT] of Integer ;
    NumPMTChannels : Integer ;
    ImageNames : Array[0..MaxPMT] of string ;
    ImageColors : Array[0..MaxPMT] of TColor ;
    //NumPixelsPerFrame : Integer ;
    NumADCChannels : Integer ;
    PixelDwellTime : Double ;
    // Laser control
    LaserIntensity : Double ;
    LaserControlEnabled : Boolean ;
    LaserControlComPort : Integer ;
    LaserControlComHandle : THandle ;
    LaserControlOpen : Boolean ;
    // Z axis control
    iZStep : Integer ;                  // Z Step counter
    ZSection : Integer ;                // Current Z Section being acquired
    ZStepSize : Double ;                  // Spacing between Z Sections (microns)
    NumZSectionsAvailable : Integer ;   // No. of Sections in Z stack
    NumLinesPerZStep : Integer ;      // No. lines per Z step in XZ mode
    XZLine : Integer ;                // XZ mode line counter
    ZStartingPosition : Double ;      // Z position at start of scanning
    ZStepsPending : Double ;          // Z dial steps (um) waiting to be executed
    ZDialWaitCount : Integer ;        // Z dial wait counter (restricts rate of Z stage updates)
    ADCPointer : Integer ;
    EmptyFlag : Integer ;
    UpdateDisplay : Boolean ;
    NewZStageTrackbarPosition : Boolean ;  // Z stage track bar changed
    //ZoomFactors : Array[0..MaxZoomFactors-1] of Double ;
    DisplayMaxWidth : Integer ;
    DisplayMaxHeight : Integer ;
    NumFrameTypes : Integer ;
    XScale : Single ;
    YScale : Single ;
    XLeft : Integer ;
    YTop : Integer ;
    XDown : Integer ;
    YDown : Integer ;
    XScaleToBM : Double ;
    ROIMode : Boolean ;
    YLineSpacingMicrons : Single ;
    YStartMicrons : Single ;
    YEndMicrons : Single ;
    YScaleToBM : Double ;
    Magnification : Integer ;
        // Display look-up tables
    YMax : Single ;                        // Histogram max bin value
    GreyLo : Array[0..MaxPMT] of Integer ; // Lower limit of display grey scale
    GreyHi : Array[0..MaxPMT] of Integer ; // Upper limit of display grey scale
    LUT : Array[0..MaxPMT,0..LUTSize-1] of Word ;    // Display look-up tables
    PaletteType : TPaletteType ;  // Display colour palette
    pImageBuf : Array[0..MaxPMT] of PSmallIntArray ; // Pointer to image buffers
    //PAverageBuf : PIntArray ; // Pointer to displayed image buffers
    NumAverages : Integer ;     // No. of images in average
    NumRepeats : Integer ;      // No. of image repeats acquired
    ClearAverage : Boolean ;    // TRUE = Clear averaging buffer
    SnapNum : Integer ;
    ScanRequested : Integer ;
    ScanningInProgress : Boolean ;
    // Display intensity histograms
     Histogram : Array[0..MaxPMT,0..HistogramNumBins*2-1] of Single ;
     LastLineAddedToHistogram : Integer ;
     HistogramCursorLo : Integer ;
     HistogramCursorHi : Integer ;
     BinWidth : Integer ;                      // Histogram bin width (grey level units)
    INIFileName : String ;
    ProgDirectory : String ;
    SaveDirectory : String ;
    SettingsDirectory : String ;     // XML Settings file folder
    RawImagesDirectory : String ;    // Folder where raw images stored during acquisition
    RawImagesFileName : String ;
    ImageJPath : String ;            // Path to Image-J program
    SaveAsMultipageTIFF : Boolean ;  // TRUE = save stacks as multi-page TIFF files
                                     // FALSE = save stacks as individual files
    UnsavedRawImage : Boolean ;    // TRUE indicates raw images file contains an unsaved hi res. image
    MemUsed : Integer ;

    procedure InitialiseImage ;
    procedure SetImagePanels ;
    procedure CreateScanWaveform ;
    procedure StartNewScan( iZoom : Integer ) ;
    procedure StartScan ;
    procedure GetImageFromPMT ;
    procedure SetDisplayIntensityRange(
          LoValue : Integer ;
          HiValue : Integer
          ) ;
    procedure UpdateLUT(
              ch : Integer ;
              GreyMax : Integer ) ;
    procedure SetPalette( BitMap : TBitMap ; PaletteType : TPaletteType ) ;
    procedure UpdateImage ;
    procedure UpdatePMTSettings ;
    procedure SetPMTVoltage(
              PMTNum : Integer ;
              PercentMax : Double ) ;
    procedure SetAllPMTVoltages ;
    procedure CalculateMaxContrast ;
    procedure SetScanZoomToFullField ;
    procedure PercentDone(
          var PCDone : Double ;
          var n : Integer ;
          var NumPixels : Integer ) ;
   procedure PlotHistogram ;
   procedure CreateHistogramPlot ;
   procedure ClearHistogram ;

    procedure SaveRawImage(
          FileName : String ;    // File to save to
          iSection : Integer     // Image Section number
          ) ;
    function SectionFileName(
         FileName : string ; // Base file name
         iChannel : Integer ;    // PMT #
         iSection : Integer  // Z section #
         ) : string ;
    procedure LoadRawImage(
          FileName : String ;    // File to save to
          iSection : Integer     // Image Section number
          ) ;
    procedure SaveImage( OpenImageJ: boolean ) ;
    procedure SaveSettingsToXMLFile1(
              FileName : String
              ) ;
    procedure SaveSettingsToXMLFile(
              FileName : String
              ) ;
    procedure LoadSettingsFromXMLFile1(
              FileName : String
              ) ;
    procedure LoadSettingsFromXMLFile(
              FileName : String
              ) ;

    procedure AddElementDouble(
              ParentNode : IXMLNode ;
              NodeName : String ;
              Value : Double
              ) ;
    function GetElementDouble(
              ParentNode : IXMLNode ;
              NodeName : String ;
              Value : Double
              ) : Double ;
    procedure AddElementInt(
              ParentNode : IXMLNode ;
              NodeName : String ;
              Value : Integer
              ) ;
    function GetElementInt(
              ParentNode : IXMLNode ;
              NodeName : String ;
              Value : Integer
              ) : Integer ;
    procedure AddElementBool(
              ParentNode : IXMLNode ;
              NodeName : String ;
              Value : Boolean
              ) ;
    function GetElementBool(
              ParentNode : IXMLNode ;
              NodeName : String ;
              Value : Boolean
              ) : Boolean ;
    procedure AddElementText(
              ParentNode : IXMLNode ;
              NodeName : String ;
              Value : String
              ) ;
    function GetElementText(
              ParentNode : IXMLNode ;
              NodeName : String ;
              Value : String
              ) : String ;
    function FindXMLNode(
         const ParentNode : IXMLNode ;  // Node to be searched
         NodeName : String ;            // Element name to be found
         var ChildNode : IXMLNode ;     // Child Node of found element
         var NodeIndex : Integer        // ParentNode.ChildNodes Index #
                          // Starting index on entry, found index on exit
         ) : Boolean ;
  end;

// Corrected system function call template
function GetSystemPaletteEntries(
         DC : HDC ;
         StartIndex : Cardinal ;
         NumEntries : Cardinal ;
         PaletteEntries : Pointer ) : Cardinal ; stdcall ;

var
  MainFrm: TMainFrm;
implementation
//uses LogUnit;

uses SettingsUnit, ZStageUnit, LaserUnit;
{$R *.dfm}
function GetSystemPaletteEntries ; external gdi32 name 'GetSystemPaletteEntries' ;

procedure TMainFrm.FormCreate(Sender: TObject);
// --------------------------------------
// Initalisations when program is created
// --------------------------------------
var
   ch : Integer ;
begin
     ADCMap := Nil ;
     ADCBuf := Nil ;
     AvgBuf := Nil ;
     DACBuf := Nil ;
//     XZLineAverage := Nil ;
     for ch := 0 to High(BitMap) do BitMap[ch] := Nil ;
     // Create array of image controls
     Image0.Tag := 0 ;
{     Image1.Tag := 1 ;
     Image2.Tag := 2 ;
     Image3.Tag := 3 ;}
{     Image[0] := Image0 ;
     Image[1] := Image0 ;
     Image[2] := Image0 ;
     Image[3] := Image0 ;}
     NewZStageTrackbarPosition := False ;
     ZDialWaitCount := 0 ;
     ZStepsPending := 0 ;
     end;

procedure TMainFrm.FormShow(Sender: TObject);
// --------------------------------------
// Initialisations when form is displayed
// --------------------------------------
var
    i,ch : Integer ;
    NumPix : Cardinal ;
    Gain : Double ;
begin
     Caption := 'MesoScan V1.8.4 ';
     {$IFDEF WIN32}
     Caption := Caption + '(32 bit)';
    {$ELSE}
     Caption := Caption + '(64 bit)';
    {$IFEND}
    Caption := Caption + ' 09/07/25';
     TempBuf := Nil ;
     DeviceNum := 1 ;
     LabIO.NIDAQAPI := NIDAQMX ;
     LabIO.Open ;
     meStatus.Clear ;
     for i := 1 to LabIO.NumDevices do
         meStatus.Lines.Add(LabIO.DeviceName[i] + ': ' + LabIO.DeviceBoardName[i] ) ;
     LabIO.ADCInputMode := imDifferential ;
     EmptyFlag := -32766 ;
     ADCMaxValue := LabIO.ADCMaxValue[DeviceNum] ;
     DACMaxValue := LabIO.DACMaxValue[DeviceNum] ;
     LabIO.WriteDACs( 1,[0.0,0.0],2);
     ADCPointer := 0 ;
     NumLinesPerZStep := 1 ;
     XZLine := 0 ;
//     XZAverageLine := 0 ;
     NumBeamParkLines := 10 ;            // Default # of beam parking lines
     DeviceNum := 1 ;
     for ch  := 0 to High(GreyLo) do GreyLo[ch] := 0 ;
     for ch  := 0 to High(GreyLo) do GreyHi[ch] := LabIO.ADCMaxValue[DeviceNum] ;
     LabIO.WriteDACs( 1,[0.0,0.0],2);
     SnapNum := 0 ;
     //StatusBar.SimpleText := LabIO.DeviceName[1] ;
     // Imaging mode
     cbImageMode.Clear ;
     cbImageMode.Items.Add('XY Image');
     cbImageMode.Items.Add('XYZ Image Stack');
     cbImageMode.Items.Add('XT Line Scan');
     cbImageMode.Items.Add('XZ Image');
     cbImageMode.ItemIndex := XYMode ;
     LineScanGrp.Visible := False ;
     ZStackGrp.Visible := False ;
     // Intensity display palette
     cbPalette.Clear ;
     cbPalette.Items.AddObject(' Grey scale', TObject(palGrey)) ;
     cbPalette.Items.AddObject(' False colour', TObject(palFalseColor)) ;
     cbPalette.Items.AddObject(' Red scale', TObject(palRed)) ;
     cbPalette.Items.AddObject(' Green scale', TObject(palGreen)) ;
     cbPalette.Items.AddObject(' Blue scale', TObject(palBlue)) ;
     cbPalette.ItemIndex := cbPalette.Items.IndexOfObject(TObject(MainFrm.PaletteType)) ;
     // PMT controls
     cbPMTGain0.Clear ;
     for i := 0 to LabIO.NumADCVoltageRanges[DeviceNum]-1 do begin
         Gain := LabIO.ADCVoltageRanges[DeviceNum,0] /
                 LabIO.ADCVoltageRanges[DeviceNum,i] ;
         cbPMTGain0.Items.Add(format('X%.4g',[Gain]));
         end ;
     if cbPMTGain0.Items.Count <= 0 then begin
        cbPMTGain0.Items.Add('n/a');
        end;
     cbPMTGain1.Items.Assign(cbPMTGain0.Items);
     cbPMTGain2.Items.Assign(cbPMTGain0.Items);
     cbPMTGain3.Items.Assign(cbPMTGain0.Items);
     cbPMTGain0.ItemIndex := 0 ;
     cbPMTGain1.ItemIndex := 0 ;
     cbPMTGain2.ItemIndex := 0 ;
     cbPMTGain3.ItemIndex := 0 ;
     for i := 0 to High(PMTControls) do PMTControls[i] := -1 ;
     edPMTVolts0.Value := 1.0 ;
     edPMTVolts1.Value := 1.0 ;
     edPMTVolts2.Value := 1.0 ;
     edPMTVolts3.Value := 1.0 ;
     PMTMaxVolts := 5.0 ;
     for i := 0 to High(PMTINvertSignal) do PMTINvertSignal[i] := False ;


     edDisplayIntensityRange.LoLimit := 0 ;
     edDisplayIntensityRange.HiLimit := ADCMaxValue ;
     bFullScale.Click ;
     // Save image file dialog
     SaveDialog.InitialDir := '' ;
     SaveDialog.Title := 'Save Image ' ;
     SaveDialog.options := [ofHideReadOnly,ofPathMustExist] ;
     SaveDialog.DefaultExt := '.tif' ;
     SaveDialog.Filter := ' TIFF (*.tif)|*.tif' ;
     SaveDialog.FilterIndex := 3 ;
     SaveDirectory := '' ;
     SnapNum := 1 ;
     FullFieldWidth := 500 ;
     FullFieldWidthMicrons := 2000.0 ;
     FieldEdge := 0.0 ;
     FrameWidth := FullFieldWidth ;
     FrameHeight := FullFieldWidth ;
     Magnification := 1;
     for ch := 0 to High(BitMap) do begin
         if BitMap[ch] <> Nil then BitMap[ch].Free ;
         BitMap[ch] := TBitMap.Create ;
         BitMap[ch].Width := FullFieldWidth ;
         BitMap[ch].Height := FullFieldWidth ;
         end;
     LinesAvailableForDisplay := 0 ;
     // Default normal scan settings
     NumAverages := 5 ;
     BiDirectionalScan := True ;
     MaxScanRate := 100.0 ;
     MinPixelDwellTime := 5E-7 ;
     // Default galvo AO settings
     XGalvoAO := 0 ;          // X galvo on Dev1:AO0
     YGalvoAO := 1 ;          // Y galvo on Dev1:AO`
     XGalvoInvert := False ;  // Do not invert X galvo voltage signal
     YGalvoInvert := False ;  // Do not invert Y galvo voltage signal
     XVoltsPerMicron := 1E-3 ;
     YVoltsPerMicron := 1E-3 ;
     //ADCVoltageRange := 0 ;
     PhaseShift := 0 ;
     CorrectSineWaveDistortion := True ;
     BlackLevel := 10 ;
     InvertPMTSignal := True ;
     HRFrameWidth := 1000 ;
     FastFrameWidth := 500 ;
     FastFrameHeight := 100 ;
     FrameHeightScale := 1.0 ;
     FastBiDirectionalScan := True ;
     edNumPixelsPerZStep.Value := 1.0 ;
     edNumZSteps.Value := 10.0 ;
     // Image-J program path
     ImageJPath := 'C:\ImageJ\imagej.exe';
     SaveAsMultipageTIFF := True ;
     // Load last used settings
     ProgDirectory := ExtractFilePath(ParamStr(0)) ;
     // Create settings directory path
     SettingsDirectory := GetSpecialFolder(CSIDL_COMMON_DOCUMENTS) + '\MesoScan\';
     if not SysUtils.DirectoryExists(SettingsDirectory) then begin
        if not SysUtils.ForceDirectories(SettingsDirectory) then
           ShowMessage( 'Unable to create settings folder' + SettingsDirectory) ;
        end ;
     // Raw data file folder initial setting
     RawImagesDirectory := SettingsDirectory ;
     // Load last used settings
     INIFileName := SettingsDirectory + 'mesoscan settings.xml' ;
     LoadSettingsFromXMLFile( INIFileName ) ;
     // Create raw image file name
     RawImagesFileName := RawImagesDirectory + 'mesoscan.raw' ;
     // Open Z stage
     ZStage.Open ;
     // Load normal scan
     if FullFieldWidthMicrons <= 0.0 then FullFieldWidthMicrons := 1E4 ;
     // Open laser control
     if LaserControlEnabled then begin
        //LaserControlOpen := OpenComPort( LaserControlCOMHandle, LaserControlCOMPort, CBR_9600 ) ;
        end
     else LaserControlOpen := False ;
     // Ensure laser shutter is closed
     for i := 0 to MaxLasers-1 do Laser.LaserActive[i] := False ;
     UpdateDisplay := False ;
     ScanRequested := 0 ;
     ScanningInProgress := False ;
     // Initialise full field image
     iScanZoom := 0 ;
     FrameWidth := FastFrameWidth ;
     FrameHeight := FastFrameWidth ;
    // (re)allocate image buffer
    NumPix := FrameWidth*FrameHeight*NumLinesPerZStep ;
    UpdatePMTSettings ;
    for ch := 0 to High(PImageBuf) do begin
        if PImageBuf[ch] <> Nil then FreeMem(PImageBuf[ch]) ;
        PImageBuf[ch] := Nil ;
        if ch < NumPMTChannels then begin
           PImageBuf[ch] := AllocMem( Int64(NumPix)*SizeOf(SmallInt)) ;
           for i := 0 to NumPix-1 do pImageBuf[ch]^[i] := 0 ;
           end;
        end;
    SetImagePanels ;
    InitialiseImage ;
    MouseUpCursor := crCross ;
    SetScanZoomToFullField ;
     Timer.Enabled := True ;
     UpdateDisplay := True ;
     bStopScan.Enabled := False ;
     image0.ControlStyle := image0.ControlStyle + [csOpaque] ;
     imagegrp.ControlStyle := imagegrp.ControlStyle + [csOpaque] ;
     lbreadout.ControlStyle := lbreadout.ControlStyle + [csOpaque] ;
     Left := 10 ;
     Top := 10 ;
     Height := Screen.Height - 50 - Top ;
     Width := Height + 50 ;
     // Set up image intensity histogram plot
     CreateHistogramPlot ;
  //   LoadRawImage( RawImagesFileName, 0 ) ;
     end;

procedure TMainFrm.SetScanZoomToFullField ;
// ---------------------------
// Set scan zoom to full field
// ---------------------------
begin
     iScanZoom := 0 ;
     ScanArea[iScanZoom].Left := 0.0 ;
     ScanArea[iScanZoom].Top := 0.0 ;
     ScanArea[iScanZoom].Right := FullFieldWidthMicrons ;
     ScanArea[iScanZoom].Bottom := FullFieldWidthMicrons ;
     ScanArea[iScanZoom].Width := FullFieldWidthMicrons ;
     ScanArea[iScanZoom].Height := FullFieldWidthMicrons ;
     SelectedRect.Left := 0 ;
     SelectedRect.Top := 0 ;
     SelectedRect.Right := FrameWidth-1 ;
     SelectedRect.Bottom := FrameHeight-1 ;
     edMicronsPerZStep.Value := edNumPixelsPerZStep.Value*(ScanArea[iScanZoom].Width/HRFrameWidth) ;
     end ;

procedure TMainFrm.Image0DblClick(Sender: TObject);
// -----------------------------
// Mouse double clicked on image
// -----------------------------
begin
    ROIMode := True ;
      // Set top-left of ROI box to current cursor position
      SelectedRectBM.Left := MouseDownAt.X ;
      SelectedRect.Left := Round(SelectedRectBM.Left/XScaleToBM) + XLeft ;
      SelectedRectBM.Top := MouseDownAt.Y ;
      SelectedRect.Top := Round(SelectedRectBM.Top/YScaleToBM) + YTop ;
      UpdateDisplay := True ;
    end;

procedure TMainFrm.Image0MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
// -------------------
// Mouse down on image
// -------------------
begin
     // Save mouse position when button pressed
     CursorPos.X := X ;
     CursorPos.Y := Y ;
     // Set mouse down flag
     MouseDown := True ;
     XDown := X ;
     YDown := Y ;
     MouseDownAt.X := X ;
     MouseDownAt.Y := Y ;
     TopLeftDown.X := XLeft ;
     TopLeftDown.Y := YTop ;
     MouseUpCursor := Image0.Cursor ;
     if (Image0.Cursor = crCross) and (not ROIMode) then Screen.Cursor := crHandPoint ;
     end;

procedure TMainFrm.Image0MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
// ----------------------
// Mouse moved over image
// ----------------------
const
    EdgeSize = 5 ;
var
    i,ch : Integer ;
    XRight,YBottom,XShift,YShift : Integer ;
    XImage,YImage : Integer ;
begin
     if pImageBuf[TImage(Sender).tag] = Nil then Exit ;
     XImage := Round(X/XScaleToBM) + XLeft ;
     YImage := Round(Y/YScaleToBM) + YTop ;
     i := YImage*FrameWidth + XImage ;
     PixelsToMicronsX := ScanArea[iScanZoom].Width/FrameWidth ;
     PixelsToMicronsY := FrameHeightScale*PixelsToMicronsX ;
     if (i > 0) and (i < FrameWidth*FrameHeight) then
        begin
        lbReadout.Caption := format('X=%.2f um, Y=%.2f um, I=%d',
                           [XImage*PixelsToMicronsX + ScanArea[iScanZoom].Left,
                            YImage*PixelsToMicronsY + ScanArea[iScanZoom].Top,
                            pImageBuf[TImage(Sender).tag][i]]) ;
         end ;
     if not MouseDown then
        begin
        // Indicate if cursor is over edge of zoom selection rectangle
        SelectedEdge.Left := 0 ;
        SelectedEdge.Right := 0 ;
        SelectedEdge.Top := 0 ;
        SelectedEdge.Bottom := 0 ;
        if (Abs(X - SelectedRectBM.Left) < EdgeSize) and
           (Y >= SelectedRectBM.Top) and
           (Y <= SelectedRectBM.Bottom) then SelectedEdge.Left := 1 ;
        if (Abs(X - SelectedRectBM.Right) < EdgeSize) and
           (Y >= SelectedRectBM.Top) and
           (Y <= SelectedRectBM.Bottom) then SelectedEdge.Right := 1 ;
        if (Abs(Y - SelectedRectBM.Top) < EdgeSize) and
           (X >= SelectedRectBM.Left) and
           (X <= SelectedRectBM.Right) then SelectedEdge.Top := 1 ;
        if (Abs(Y - SelectedRectBM.Bottom) < EdgeSize) and
           (X >= SelectedRectBM.Left) and
           (X <= SelectedRectBM.Right) then SelectedEdge.Bottom := 1 ;
        if (SelectedEdge.Left = 1) and (SelectedEdge.Top = 1) then Image0.Cursor := crSizeNWSE
        else if (SelectedEdge.Left = 1) and (SelectedEdge.Bottom = 1) then Image0.Cursor := crSizeNESW
        else if (SelectedEdge.Right = 1) and (SelectedEdge.Top = 1) then Image0.Cursor := crSizeNESW
        else if (SelectedEdge.Right = 1) and (SelectedEdge.Bottom = 1) then Image0.Cursor := crSizeNWSE
        else if SelectedEdge.Left = 1 then Image0.Cursor := crSizeWE
        else if SelectedEdge.Right = 1 then Image0.Cursor := crSizeWE
        else if SelectedEdge.Top = 1 then Image0.Cursor := crSizeNS
        else if SelectedEdge.Bottom = 1 then Image0.Cursor := crSizeNS
        else Image0.Cursor := crCross ;
        CursorPos.X := X ;
        CursorPos.Y := Y ;
        end
     else
        begin
        if Image0.Cursor = crCRoss then Image0.Cursor := crHandPoint ;
        XShift := X - CursorPos.X ;
        CursorPos.X := X ;
        YShift := Y - CursorPos.Y ;
        CursorPos.Y := Y ;
        if SelectedEdge.Left = 1 then
           begin
           // Move left edge
           SelectedRectBM.Left := Max(SelectedRectBM.Left + XShift,0);
           SelectedRectBM.Left := Min(SelectedRectBM.Left,Min(BitMap[0].Width-1,SelectedRectBM.Right-1)) ;
           SelectedRect.Left := Round(SelectedRectBM.Left/XScaleToBM) + XLeft ;
           end ;
        if SelectedEdge.Right = 1 then
           begin
           // Move right edge
           SelectedRectBM.Right := Max(SelectedRectBM.Right + XShift,Max(0,SelectedRectBM.Left));
           SelectedRectBM.Right := Min(SelectedRectBM.Right,BitMap[0].Width-1) ;
           SelectedRect.Right := Round(SelectedRectBM.Right/XScaleToBM) + XLeft ;
           end;
        if SelectedEdge.Top = 1 then
           begin
           // Move top edge
           SelectedRectBM.Top := Max(SelectedRectBM.Top + YShift,0);
           SelectedRectBM.Top := Min(SelectedRectBM.Top,Min(BitMap[0].Height-1,SelectedRectBM.Bottom-1)) ;
           SelectedRect.Top := Round(SelectedRectBM.Top/YScaleToBM) + YTop ;
           end;
        if SelectedEdge.Bottom = 1 then
           begin
           // Move bottom edge
           SelectedRectBM.Bottom := Max(SelectedRectBM.Bottom + YShift,SelectedRectBM.Top+1);
           SelectedRectBM.Bottom := Min(SelectedRectBM.Bottom,BitMap[0].Height-1) ;
           SelectedRect.Bottom := Round(SelectedRectBM.Bottom/YScaleToBM) + YTop ;
           end;
        if ROIMode then
           begin
           // If in ROI mode, set bottom,right edge of ROI to current cursor position
           SelectedRectBM.Right := X ;
           SelectedRectBM.Bottom := Y ;
           SelectedRect.Right := Round(SelectedRectBM.Right/XScaleToBM) + XLeft ;
           SelectedRect.Bottom := Round(SelectedRectBM.Bottom/YScaleToBM) + YTop ;
           end
        else if (SelectedEdge.Left or SelectedEdge.Right or
             SelectedEdge.Top or SelectedEdge.Bottom) = 0 then
            begin
            // Move display window
            XLeft := TopLeftDown.X - Round((X - MouseDownAt.X)/XScaleToBM) ;
            XRight := Min(XLeft + Round(Bitmap[0].Width/XScaleToBM),FrameWidth) ;
            XLeft := Max( XRight - Round(Bitmap[0].Width/XScaleToBM), 0 ) ;
            YTop := TopLeftDown.Y - Round((Y - MouseDownAt.Y)/YScaleToBM) ;
            YBottom := Min(YTop + Round(Bitmap[0].Height/YScaleToBM),FrameHeight) ;
            YTop := Max( YBottom - Round(Bitmap[0].Height/YScaleToBM),0) ;
            end;
         end ;
     for ch := 0 to NumPMTChannels-1 do Image0.Cursor := Image0.Cursor ;
     UpdateDisplay := True ;
     end ;

procedure TMainFrm.FixRectangle( var Rect : TRect ) ;
// -----------------------------------------------------
// Ensure top/left is above/to the right of bottom/right
// -----------------------------------------------------
var
    RTemp : TRect ;
begin
    RTemp := Rect ;
    Rect.Left := Min(RTemp.Left,RTemp.Right) ;
    Rect.Right := Max(RTemp.Left,RTemp.Right) ;
    Rect.Top := Min(RTemp.Top,RTemp.Bottom) ;
    Rect.Bottom := Max(RTemp.Top,RTemp.Bottom) ;
    end;
procedure TMainFrm.Image0MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
// -------------------
// Mouse up on image
// -------------------
var
    ch : Integer ;
begin
     MouseDown := False ;
     for ch := 0 to NumPMTChannels-1 do Image0.Cursor := MouseUpCursor ;
     Screen.Cursor :=crDefault ;
     ROIMode := False ;                   // Turn ROI mode off
     FixRectangle(SelectedRectBM);
     FixRectangle(SelectedRect);
     end;

procedure TMainFrm.ImagePageChange(Sender: TObject);
// -----------------------
// PMT display tab changed
// -----------------------
begin
     // Set intensity range and histogram cursors
     SetDisplayIntensityRange( MainFrm.GreyLo[ImagePage.activepageindex],
                               MainFrm.GreyHi[ImagePage.activepageindex] ) ;
     UpdateDisplay := True ;
end;

procedure TMainFrm.InitialiseImage ;
// ------------------------------------------------------
// Re-initialise size of memory buffers and image bitmaps
// ------------------------------------------------------
var
    ch,Ybm,Xbm : Integer ;
    PScanLine : PByteArray ;    // Bitmap line buffer pointer
begin
     // Set size and location of image display panels
     SetImagePanels ;
     // Set intensity range and histogram cursors
//     SetDisplayIntensityRange( MainFrm.GreyLo[ImagePage.activepageindex],
//                               MainFrm.GreyHi[ImagePage.activepageindex] ) ;
     for ch := 0 to NumPMTChannels-1 do
        begin
        if BitMap[ch] <> Nil then SetPalette( BitMap[ch], PaletteType ) ;
        // Update display look up tables
        UpdateLUT( ch, ADCMaxValue );
       //Clear image to zeroes
       for Ybm := 0 to BitMap[ch].Height-1 do
          begin
          PScanLine := BitMap[ch].ScanLine[Ybm] ;
          for xBm := 0 to BitMap[ch].Width-1 do PScanLine[Xbm] := LUT[ch,0] ;
          end ;
        end;
     end ;

procedure TMainFrm.SetImagePanels ;
// -------------------------------------------
// Set size and number of image display panels
// -------------------------------------------
const
    MarginPixels = 16 ;
var
    HeightWidthRatio : Double ;
    ch,Ybm,Xbm : Integer ;
    PScanLine : PByteArray ;    // Bitmap line buffer pointer
begin
     ImageGrp.Width :=  Max( ClientWidth - ImageGrp.Left - 5, 2) ;
     ImageGrp.Height :=  Max( ClientHeight - ImageGrp.Top - 5, 2) ;
     ZoomPanel.Top := ImageGrp.ClientHeight - ZoomPanel.Height - 1 ;
     ZoomPanel.Left := 5 ;
     ZSectionPanel.Top := ZoomPanel.Top ;
     lbReadout.Top := ZSectionPanel.Top ;
     lbReadout.Left :=  ZoomPanel.Left + ZoomPanel.Width + 5 ;
     ImagePage.Width := ImageGrp.ClientWidth - ImagePage.Left - 5 ;
//     ImagePage.Height := ZSectionPanel.Top - ImagePage.Top - 2 ;
     // Set tag to PMT image index (used to determine which PMT image is displayed)
     Image0.Tag := ImagePage.TabIndex ;
     Image0.Top := ImagePage.Top + ImagePage.Height ;
     Image0.Height := ZSectionPanel.Top - Image0.Top - 2 ;
     ZSectionPanel.Left := ImagePage.Width + ImagePage.Left - ZSectionPanel.Width ;
     DisplayMaxWidth := ImageGrp.ClientWidth - Image0.Left ;
     DisplayMaxHeight := ZSectionPanel.Top - Image0.Top ;
     for ch := 0 to NumPMTChannels-1 do
         begin
         if BitMap[ch] <> Nil then BitMap[ch].Free ;
         BitMap[ch] := TBitMap.Create ;
         SetPalette( BitMap[ch], PaletteType ) ;
         // Scale bitmap to fit into window
         BitMap[ch].Width := DisplayMaxWidth ;
         HeightWidthRatio := (FrameHeight*FrameHeightScale)/FrameWidth ;
         BitMap[ch].Height := Round(BitMap[ch].Width*HeightWidthRatio) ;
         if BitMap[ch].Height > DisplayMaxHeight then
            begin
            BitMap[ch].Height := DisplayMaxHeight ;
            BitMap[ch].Width := Round(BitMap[ch].Height/HeightWidthRatio) ;
            BitMap[ch].Width := Min(BitMap[ch].Width,DisplayMaxWidth) ;
            LinesAvailableForDisplay := 0;//FrameHeight ;
            // Add magnification and limit BitMap[ch] to window
            BitMap[ch].Width := Min(BitMap[ch].Width*Magnification,DisplayMaxWidth) ;
            BitMap[ch].Height := Min(BitMap[ch].Height*Magnification,DisplayMaxHeight) ;
            end;
         XScaleToBM := (BitMap[ch].Width*Magnification) / FrameWidth ;
         YScaleToBM := (BitMap[ch].Width*Magnification*FrameHeightScale) / FrameWidth ;
         SetImageSize( Image0 ) ;
         //Clear image to zeroes
         for Ybm := 0 to BitMap[ch].Height-1 do
             begin
             PScanLine := BitMap[ch].ScanLine[Ybm] ;
             for xBm := 0 to BitMap[ch].Width-1 do PScanLine[Xbm] := LUT[ch,0] ;
             end ;
         end;
     end ;

procedure TMainFrm.SetImageSize(
          Image : TImage ) ;
// -------------------------
// Set size of image control
// -------------------------
begin
     Image.Width := BitMap[0].Width ;
     ImagePage.Width := Image.Width ;
     Image.Height := BitMap[0].Height ;
     Image.Canvas.Pen.Color := clWhite ;
     Image.Canvas.Brush.Style := bsClear ;
     Image.Canvas.Font.Color := clWhite ;
     Image.Canvas.TextFlags := 0 ;
     Image.Canvas.Pen.Mode := pmXOR ;
     Image.Canvas.Font.Name := 'Arial' ;
     Image.Canvas.Font.Size := 8 ;
     Image.Canvas.Font.Color := clBlue ;
     end ;

procedure TMainFrm.SetDisplayIntensityRange(
          LoValue : Integer ;
          HiValue : Integer
          ) ;
// --------------------------------------
// Set display contrast range and sliders
// --------------------------------------
begin
     // Indicate PMT channel selected for contrast update
     gpContrast.Caption := format(' Contrast: PMT%d ',[ImagePage.activepageindex]) ;
     if ((edDisplayIntensityRange.LoValue <> LoValue) or
         (edDisplayIntensityRange.HiValue <> HiValue)) then
         begin
         edDisplayIntensityRange.LoValue := LoValue  ;
         edDisplayIntensityRange.HiValue := HiValue  ;
         plHistogram.VerticalCursors[HistogramCursorLo] := LoValue ;
         plHistogram.VerticalCursors[HistogramCursorHi] := HiValue ;
         end;
     end ;

procedure TMainFrm.FormClose(Sender: TObject; var Action: TCloseAction);
// ------------
// Stop program
// ------------
var
    i : Integer ;
begin
     // Close laser shutter
     for i := 0 to MaxLasers-1 do Laser.LaserActive[i] := False ;
     LabIO.Close ;
     if ADCMap <> Nil then FreeMem(ADCMap) ;
     if ADCBuf <> Nil then FreeMem(ADCBuf) ;
     if AvgBuf <> Nil then FreeMem(AvgBuf) ;
     if DACBuf <> Nil then FreeMem(DACBuf) ;
//     if XZLineAverage <> Nil then FreeMem(XZLineAverage) ;
     SaveSettingsToXMLFile( INIFileName ) ;
     end;
procedure TMainFrm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
// ----------------------------------------
// Warn user that program is about to close
// ----------------------------------------
begin
    if MessageDlg( 'Exit Program! Are you Sure? ',
       mtConfirmation,[mbYes,mbNo], 0 ) = mrYes then CanClose := True
                                                else CanClose := False ;
end;

procedure TMainFrm.CreateScanWaveform ;
// ------------------------------
// Create X/Y galvo scan waveform
// ------------------------------
var
    XPeriod,HalfPi,ScanSpeed : Double ;
    XCentre,YCentre,XAmplitude,YAmplitude,YHeight,PCDOne : Double ;
    n,ch,iX,iY,iY1,i,j,k,iShift,kStart,kShift : Integer ;
    SineWaveForwardScan,SineWaveReverseScan,SineWaveCorrection : PBig16BitArray ;
    NumBytes : NativeInt ;
    NumXEdgePixels,NumYEdgePixels : Cardinal ;
    NumPix : Cardinal ;
    NumLinesInDACBuf : Cardinal ;
    YDAC : SmallInt ;
    Amplitude : Double ;
begin

    meStatus.Clear ;
    meStatus.Lines[0] := 'Wait: Creating XY scan waveform' ;

    // No. pixels in scan buffer
    NumXEdgePixels :=  Round(FieldEdge*FrameWidth) ;
    NumXPixels := FrameWidth + (2*NumXEdgePixels) ;
    // Determine line scan time
    PixelDwellTime := Max( 1.0/(MaxScanRate*NumXPixels*2), MinPixelDwellTime ) ;
    LabIO.CheckSamplingInterval(DeviceNum,PixelDwellTime,1) ;
    ScanSpeed := 1.0/(PixelDwellTime*NumXPixels) ;
    if not BidirectionalScan then ScanSpeed := ScanSpeed*0.5 ;
    ScanInfo := format('%.3g lines/s Tdwell=%.3g us',[ScanSpeed,1E6*PixelDwellTime]);
    LineScanTime := NumXPixels*PixelDwellTime ;
    if not BidirectionalScan then LineScanTime := LineScanTime*2.0 ;
    // Determine number of lines per Z step (for XZ mode)
    if cbImageMode.ItemIndex = XZMode then
       begin
       NumLinesPerZStep := Round(edNumRepeats.Value) + Max(Round(ZStage.ZStepTime/LineScanTime),1);
       end
    else NumLinesPerZStep := 1 ;
    NumYEdgePixels := 1 ;
    NumYPixels := (FrameHeight + 2*NumYEdgePixels)*NumLinesPerZStep ;
    if not BidirectionalScan then NumYPixels := NumYPixels*2 ;
    // Allocate image buffers
    NumPix := FrameWidth*FrameHeight*NumLinesPerZStep ;
    for ch := 0 to High(PImageBuf) do
        begin
        if PImageBuf[ch] <> Nil then FreeMem(PImageBuf[ch]) ;
        PImageBuf[ch] := Nil ;
        if ch < NumPMTChannels then
           begin
           PImageBuf[ch] := AllocMem( Int64(NumPix)*SizeOf(SmallInt)) ;
           end;
        end;
    NumPixels := NumXPixels*NumYPixels ;
    // Allocate A/D buffer
    if ADCBuf <> Nil then FreeMem( ADCBuf ) ;
    NumBytes := Int64(NumPixels)*Int64(NumPMTChannels)*SizeOf(SmallInt) ;
    ADCBuf := AllocMem( NumBytes ) ;

    // Allocate D/A waveform databuffer
    if DACBuf <> Nil then FreeMem( DACBuf ) ;
    NumPixelsInDACBuf := NumPixels ;
    NumLinesinDACBuf := NumPixelsInDACBuf div NumXPixels ;
    NumPixelsInDACBuf := NumLinesinDACBuf*NumXPixels ;
    NumBytes := Int64(NumPixels)*Int64(SizeOf(SmallInt)*NumGalvoDACs) ;
    DACBuf := AllocMem( NumBytes ) ;
    GetMem( SineWaveForwardScan, NumXPixels*SizeOf(SmallInt) ) ;
    GetMem( SineWaveReverseScan, NumXPixels*SizeOf(SmallInt) ) ;
    GetMem( SineWaveCorrection, NumXPixels*SizeOf(SmallInt) ) ;
    if ADCMap <> Nil then FreeMem(ADCMap) ;
    NumBytes := Int64(NumPixels)*SizeOf(Integer) ;
    ADCMap := AllocMem(NumBytes) ;

    // Set V -> D/A integer units scale factor
    XScale := (LabIO.DACMaxValue[DeviceNum]/VMax)*XVoltsPerMicron ;
    if XGalvoInvert then XScale := -XScale ;
    YScale := (LabIO.DACMaxValue[DeviceNum]/VMax)*YVoltsPerMicron ;
    if YGalvoInvert then YScale := -YScale ;

    // Amplitude and centre of X scan sine wave
    XAmplitude := (ScanArea[iScanZoom].Right - ScanArea[iScanZoom].Left)*0.5 ;
    XCentre := (ScanArea[iScanZoom].Left + ScanArea[iScanZoom].Right - FullFieldWidthMicrons)*0.5 ;

    // Height and centre of Y linear ramp
    YHeight := ScanArea[iScanZoom].Bottom - ScanArea[iScanZoom].Top ;
    YCentre := (ScanArea[iScanZoom].Top + ScanArea[iScanZoom].Bottom - FullFieldWidthMicrons)*0.5 ;

    XPeriod := (pi)/NumXPixels ;
    case cbImageMode.ItemIndex of
        XTMode,XZMode :
          begin
          // Line scan (XT & XZ) along X axis at YCentre position
          // No Y axis movement
          YStartMicrons := YCentre ;
          YLineSpacingMicrons := 0.0 ;
          end ;
       else
          begin
          // XY and XYZ modes
          YStartMicrons := YCentre - YHeight*0.5 ;
          YEndMicrons := YCentre + YHeight*0.5 ;
          YLineSpacingMicrons := YHeight/(NumYPixels{-2*NumBeamParkLines}) ;
          end ;
       end;
    HalfPi := Pi*0.5 ;
    for iX := 0 to NumXPixels-1 do
        begin
        SineWaveForwardScan^[iX] := Round((XCentre + XAmplitude*sin((iX*XPeriod)-HalfPi))*XScale) ;
        SineWaveReverseScan^[iX] := Round((XCentre + XAmplitude*sin((iX*XPeriod)+HalfPi))*XScale) ;
        SineWaveCorrection^[iX] := Round( (NumXPixels*0.5) + (NumXPixels*0.5)*sin(iX*XPeriod-HalfPi) ) ;
        SineWaveCorrection^[iX] := Min(Max(SineWaveCorrection^[iX],0),NumXPixels-1);
        end ;

    // Create initial DAC buffer
    // -------------------------

    PCDone := 0.0 ;
    j := 0 ;
    n := 0 ;
    for iY := 0 to NumLinesinDACBuf-1 do
        begin
        if (not BidirectionalScan) and ((iY mod 2) <> 0) then iY1 := iy + 1
                                                         else iY1 := iy ;
        YDAC := Round(YScale*((iY1)*YLineSpacingMicrons + YStartMicrons)) ;
        if (iY mod 2) = 0 then
           begin
           // Forward scan
           for iX := 0 to NumXPixels-1 do
               begin
               DACBuf^[j] := SineWaveForwardScan^[iX] ;
               DACBuf^[j+1] := YDAC ;
               j := j + NumGalvoDACs ;
               end ;
           end
        else
           begin
           // Reverse scan
           for iX := 0 to NumXPixels-1 do
               begin
               DACBuf^[j] := SineWaveReverseScan^[iX] ;
               DACBuf^[j+1] := YDAC ;
               j := j + NumGalvoDACs ;
               end ;
           end ;
        if n = 1000 then PercentDone(PCDone,n,NumYPixels)
                    else Inc(n) ;
        end ;

    // Create sine wave correction mapping buffer
    // ------------------------------------------
    k := 0 ;
    n := 0 ;
    for iY := 0 to NumYPixels-1 do
        begin
        kStart := k ;
        if (iY mod 2) = 0 then
           begin
           // Forward scan
           for iX := 0 to NumXPixels-1 do
               begin
               ADCMap^[k] := iY*NumXPixels + iX ;
               Inc(k) ;
               end ;
           end
        else
           begin
           // Reverse scan
           for iX := 0 to NumXPixels-1 do
               begin
               ADCMap^[k] := iY*NumXPixels + NumXPixels -1 - iX ;
               Inc(k) ;
               end ;
           end ;
        if CorrectSineWaveDistortion then
           begin
           for iX := 0 to NumXPixels-1 do
               begin
               ADCMap^[kStart+iX] := SineWaveCorrection^[ADCMap^[kStart+iX]-kStart] + kStart ;
               end ;
           end ;
        if n = 1000 then PercentDone(PCDone,n,NumYPixels)
                    else Inc(n) ;
        end ;
     // Modify first line to smoothly unpark beam from centre position to top/left of imaging area
     j := 0 ;
     for iX := 0 to NumXPixels-1 do
         begin
         XAmplitude := iX/(NumXPixels-1) ;
         YAmplitude := 1.0 - exp(-(iX*4.0)/NumXPixels) ;
         DACBuf^[j] := Round(DACBuf^[j]*XAmplitude) ;
         DACBuf^[j+1] := Round(DACBuf^[j+1]*YAmplitude) ;
         j := j + NumGalvoDACs ;
         end ;
     // Modify last line to smoothly park beam at centre position from bottom/right of imaging area
     j := (NumPixels - NumXPixels)*NumGalvoDACs ;
     for iX := 0 to NumXPixels-1 do
         begin
    //     Amplitude := iX/(NumXPixels-1) ;
         XAmplitude := 1.0 - (iX/(NumXPixels-1)) ;
         YAmplitude := exp(-(iX*4.0)/NumXPixels) ;
         DACBuf^[j] := Round(DACBuf^[j]*XAmplitude) ;
         DACBuf^[j+1] := Round(DACBuf^[j+1]*YAmplitude) ;
         j := j + NumGalvoDACs ;
         end ;
    // Discard reverse scans when in unidirectional scan mode
    if not BidirectionalScan then
       begin
       n := 0 ;
       for iY := 0 to NumYPixels-1 do
           begin
           kStart := iY*NumXPixels ;
           kShift := (iY*NumXPixels) div 2 ;
           if (iY mod 2) = 0 then
              begin
              for iX := 0 to NumXPixels-1 do
                  begin
                  ADCMap^[kStart+iX] := ADCMap^[kStart+iX] - kShift ;
                  end ;
              end
           else
              begin
              for iX := 0 to NumXPixels-1 do ADCMap^[kStart+iX] := 0 ;
              end ;
           if n = 1000 then PercentDone(PCDone,n,NumYPixels)
                       else Inc(n) ;
           end ;
       end ;
    iShift := Round(PhaseShift/PixelDwellTime) ;
    if iShift >= 0 then
       begin
       n := 0 ;
       for i := 0 to NumPixels-1 do
           begin
           ADCMap^[i] := ADCMap^[Max(Min(i+iShift,NumPixels-1),0)] ;
           if n = 1000000 then PercentDone(PCDone,n,NumPixels)
                          else Inc(n) ;
           end ;
       end
    else
       begin
       n := 0 ;
       for i := NumPixels-1 downto 0 do
           begin
           ADCMap^[i] := ADCMap^[Max(Min(i+iShift,NumPixels-1),0)] ;
           if n = 1000000 then PercentDone(PCDone,n,NumPixels)
                          else Inc(n) ;
           end ;
       end ;

    // Adjust mapping to remove X and Y edge pixels from image
    n := 0 ;
    for i := 0 to NumPixels-1 do
        begin
        iY := Max((ADCMap^[i] div NumXPixels) - NumYEdgePixels,0) ;
        iX := Max((ADCMap^[i] mod NumXPixels) - NumXEdgePixels,0) ;
        if true {iX < FrameWidth} then ADCMap^[i] := Min(Max(iY*FrameWidth + iX,0),NumPix)
                           else ADCMap^[i] := 0 ;
        if n = 1000000 then PercentDone(PCDone,n,NumPixels)
                       else Inc(n) ;
        end ;
    FreeMem( SineWaveCorrection ) ;
    FreeMem( SineWaveForwardScan ) ;
    FreeMem( SineWaveReverseScan ) ;

//    outputdebugstring(pchar(format('%d %d %d %d',[DacBuf^[0],DacBuf^[1],DacBuf^[NumPixels*2 -2],DacBuf^[NumPixels*2 -1]])));

    end ;

procedure TMainFrm.PercentDone(
          var PCDone : Double ;
          var n : Integer ;
          var NumPixels : Integer ) ;
begin
     PCDone := PCDone + (n/NumPixels)*20.0 ;
     n := 0 ;
     meStatus.Lines[0] := format('Wait: Creating XY scan waveform %.0f%%',[PCDone]) ;
     Application.ProcessMessages ;
     end;

procedure TMainFrm.DisplayROI(
          BitMap : TBitmap
          ) ;
// ------------------------------------------------------
// Display selected scanning region in full field of view
// ------------------------------------------------------
var
  PaletteType : TPaletteType ;
  PenColor : Integer ;
  Y : Integer ;
  s : string ;
begin
     // Set ROI colour
     PaletteType := TPaletteType(cbPalette.Items.Objects[cbPalette.ItemIndex]) ;
     case PaletteType of
          palGrey : PenColor := clRed ;
          else PenColor := clWhite ;
          end;
     Bitmap.Canvas.Pen.Color := PenColor ;
     Bitmap.Canvas.Pen.Width := 2 ;
     Bitmap.Canvas.Brush.Style := bsClear ;
     Bitmap.Canvas.Font.Color := PenColor ;
     SelectedRectBM.Left := Round((SelectedRect.Left - XLeft)*XScaletoBM) ;
     SelectedRectBM.Right := Round((SelectedRect.Right - XLeft)*XScaletoBM) ;
     SelectedRectBM.Top := Round((SelectedRect.Top - YTop)*YScaletoBM) ;
     SelectedRectBM.Bottom := Round((SelectedRect.Bottom - YTop)*YScaletoBM) ;
     // Display zomm area selection rectangle
     Bitmap.Canvas.Rectangle(SelectedRectBM);
     // Display square corner and mid-point tags
     DisplaySquare( Bitmap, SelectedRectBM.Left, SelectedRectBM.Top ) ;
     DisplaySquare( Bitmap, (SelectedRectBM.Left + SelectedRectBM.Right) div 2, SelectedRectBM.Top ) ;
     DisplaySquare( Bitmap, SelectedRectBM.Right, SelectedRectBM.Top ) ;
     DisplaySquare( Bitmap, SelectedRectBM.Left, (SelectedRectBM.Top + SelectedRectBM.Bottom) div 2) ;
     DisplaySquare( Bitmap, SelectedRectBM.Right, (SelectedRectBM.Top + SelectedRectBM.Bottom) div 2) ;
     DisplaySquare( Bitmap, SelectedRectBM.Left, SelectedRectBM.Bottom ) ;
     DisplaySquare( Bitmap, (SelectedRectBM.Left + SelectedRectBM.Right) div 2, SelectedRectBM.Bottom ) ;
     DisplaySquare( Bitmap, SelectedRectBM.Right, SelectedRectBM.Bottom ) ;
     if (cbImageMode.ItemIndex = XYMode) or (cbImageMode.ItemIndex = XYZMode) then begin
        Bitmap.Canvas.Pen.Color := clRed ;
        //Y := ((SelectedRectBM.Top + SelectedRectBM.Bottom) div 2) ;
        Y := Round(((SelectedRect.Top + SelectedRect.Bottom)*0.5 - YTop + 1)*YScaletoBM) ;
        Bitmap.Canvas.Polyline( [Point(0,Y),Point(Bitmap.Width-1,Y)]);
        Bitmap.Canvas.Pen.Color := clWhite ;
        end;
     Bitmap.Canvas.Pen.Color := clWhite ;
     Bitmap.Canvas.Brush.Style := bsSolid ;
     Bitmap.Canvas.Font.Color := clRed ;
     s := format( '%.2f,%.2f um',
                  [(XLeft*PixelsToMicronsX) + ScanArea[iScanZoom].Left,
                   YTop*PixelsToMicronsY + ScanArea[iScanZoom].Top]);
     Bitmap.Canvas.TextOut( 0,0, s) ;
     s := format( '%.2f,%.2f um',
                  [(XLeft +(BitMap.Width/XScaleToBM))*PixelsToMicronsX
                   + ScanArea[iScanZoom].Left,
                   (YTop + (BitMap.Height/YScaleToBM))*PixelsToMicronsY
                   + ScanArea[iScanZoom].Top]);
     Bitmap.Canvas.TextOut( BitMap.Width - Bitmap.Canvas.TextWidth(s) -1,
                            BitMap.Height - Bitmap.Canvas.TextHeight(s) -1,
                            s ) ;
     end ;

procedure TMainFrm.DisplaySquare(
          Bitmap : TBitmap ;
          X : Integer ;
          Y : Integer ) ;
const
    HalfWidth = 6 ;
var
    Square : TRect ;
begin
     Square.Left := X - HalfWidth ;
     Square.Right := X + HalfWidth ;
     Square.Top := Y - HalfWidth ;
     Square.Bottom := Y + HalfWidth ;
     Bitmap.Canvas.Brush.Style := bsSolid ;
     Bitmap.Canvas.Rectangle(Square);
     end ;


procedure TMainFrm.UpdateImage ;
// --------------
// Display image
// --------------
var
    ch,Ybm,Xbm,Ybm0,Ybm1,i,iLine,iLine0, iLine1,iPreviousLine,nCount,NumLineRepeats,iRepeat : Integer ;
    PScanLine : PByteArray ;    // Bitmap line buffer pointer
    X,Y,dX,dY,Y0,Y1 : Double ;
    XMap,YMap : PIntArray ;
    YBottom,XRight : Integer ;
begin

    Image0.tag := ImagePage.TabIndex ;
    for ch  := 0 to NumPMTChannels-1 do if pImageBuf[ch] <> Nil then
       begin

       Image0.Width := BitMap[ch].Width ;
       Image0.Height := BitMap[ch].Height ;
       DisplayMaxWidth := TabImage0.ClientWidth - TabImage0.Left - 1 ;
       DisplayMaxHeight := TabImage0.ClientHeight - TabImage0.Top - 1 ;

       // Adjust left,top edge of displayed region of image when bottom,right is off image
       XRight := Min(XLeft + Round(BitMap[ch].Width/XScaleToBM),FrameWidth) ;
       XLeft := Max( XRight - Round(BitMap[ch].Width/XScaleToBM), 0 ) ;
       YBottom := Min(YTop + Round(BitMap[ch].Height/YScaleToBM),FrameHeight) ;
       YTop := Max( YBottom - Round(BitMap[ch].Height/YScaleToBM),0) ;

       //  X axis pixel mapping
       X := XLeft ;
       dX := 1.0/XScaleToBM ;
       GetMem( XMap, BitMap[ch].Width*4 ) ;
       for i := 0 to BitMap[ch].Width-1 do
           begin
           XMap^[i] := Min(Max(Round(X),0),FrameWidth-1) ;
           X := X + dX ;
           end;

       // Y axis line mapping
       GetMem( YMap, BitMap[ch].Height*4 ) ;
       Y := YTop ;
       dY := 1.0/YScaleToBM ;
       for i := 0 to BitMap[ch].Height-1 do
           begin
           YMap^[i] := Min(Max(Round(Y),0),FrameHeight-1) ;
           Y := Y + dY ;
           end;

//       if ScanningInProgress then MaxLine := LinesAvailableForDisplay
//                             else MaxLine := FrameHeight ;

       // Copy image to BitMap[ch]
       for Ybm := 0 to BitMap[ch].Height-1 do
          begin
          // Copy line to BitMap[ch]
          if YMap^[Ybm] < FrameHeight then
             begin

             PScanLine := BitMap[ch].ScanLine[Ybm] ;
             iLine := YMap^[Ybm]*FrameWidth ;

             for xBm := 0 to BitMap[ch].Width-1 do
                 begin
                 PScanLine[Xbm] := LUT[ch,pImageBuf[ch]^[XMap^[xBm]+iLine]] ;
                 end ;

             end ;
          end ;

       // Smooth repeated lines
       // ---------------------

       iPreviousLine := -1 ;
       YBm0 := YBm ;
       NumLineRepeats := 0 ;
       for Ybm := 0 to BitMap[ch].Height-1 do
          begin

          if YMap^[Ybm] >= FrameHeight then Break ;

          iLine := YMap^[Ybm]*FrameWidth ;
          if iLine = iPreviousLine then
             begin
             // Repeat of same image line - increment repeat count
             if NumLineRepeats = 0 then YBm0 := YBm ;
             Inc(NumLineRepeats) ;
             end
          else
             begin
             // Linear smoothing of repeated lines
             if NumLineRepeats > 0 then
                begin
                iLine0 := YMap^[Ybm0]*FrameWidth ;
                iLine1 := YMap^[Ybm]*FrameWidth ;
                for iRepeat := 0 to NumLineRepeats-1 do
                    begin
                    PScanLine := BitMap[ch].ScanLine[Ybm0+iRepeat] ;
                    for xBm := 0 to BitMap[ch].Width-1 do
                        begin
                        Y0 := pImageBuf[ch]^[XMap^[xBm]+iLine0] * (1.0 - ((iRepeat+1)/NumLineRepeats)) ;
                        Y1 := pImageBuf[ch]^[XMap^[xBm]+iLine1] * ((iRepeat+1)/NumLineRepeats);
                        PScanLine[Xbm] := LUT[ch,Round(Y0+Y1)] ;
                        end;
                     end ;
                end ;

             NumLineRepeats := 0 ;
             end;

          iPreviousLine := iLine ;

          end;


       // Display ROI in XY and XYZ modde
       if (cbImageMode.ItemIndex <> XZMode) and
          (cbImageMode.ItemIndex <> XTMode) then DisplayROI(BitMap[ch]) ;

       FreeMem(XMap) ;
       FreeMem(YMap) ;
       end ;

    // Update display image with selected PMT
    Image0.Picture.Assign(BitMap[ImagePage.activepageindex]) ;
    Image0.Width := BitMap[ImagePage.activepageindex].Width ;
    Image0.Height := BitMap[ImagePage.activepageindex].Height ;

    lbZoom.Caption := format('Zoom (X%d)',[Magnification]) ;
    if (NumZSectionsAvailable > 1) and (not bStopScan.Enabled)  then
       begin
       ZSectionPanel.Visible := True ;
       if ckKeepRepeats.Checked and (edNumRepeats.Value > 1.0) then
          lbZSection.Caption := format('Avg. %d/%d, Section %d/%d',
                                [(ZSection mod Round(edNumRepeats.Value)) + 1,Round(edNumRepeats.Value),
                                 (ZSection div Round(edNumRepeats.Value)) + 1,NumZSectionsAvailable div Round(edNumRepeats.Value)])
       else lbZSection.Caption := format('Section %d/%d',[ZSection+1,NumZSectionsAvailable]) ;
       end
    else
       begin
       ZSectionPanel.Visible := False ;
       end;
    end ;

procedure TMainFrm.UpdateLUT(
          ch : integer ;
          GreyMax : Integer ) ;
// ----------------------------
// Create display look-up table
// ----------------------------
var
    y : Integer ;
    i,j : Integer ;
    GreyScale : Single ;
begin
     if GreyHi[ch] <> GreyLo[ch] then
        GreyScale := (MaxPaletteColor - MinPaletteColor)/ (GreyHi[ch] - GreyLo[ch])
     else GreyScale := 1.0 ;
     j := 0 ;
     for i := 0 to GreyMax do
         begin
         y := MinPaletteColor + Round((i-GreyLo[ch])*GreyScale) ;
         if y < MinPaletteColor then y := MinPaletteColor ;
         if y > MaxPaletteColor then y := MaxPaletteColor ;
         LUT[ch,j] := y ;
         Inc(j) ;
         end ;
     end ;

procedure TMainFrm.SetPalette(
          BitMap : TBitMap ;              // Bitmap to set (IN)
          PaletteType : TPaletteType ) ;  // Type of palette required (IN)
// ------------------------------------------------------
// Set bitmap palette to 8 bit grey or false colour scale
// ------------------------------------------------------
var
  Pal: PLogPalette;
  hpal: HPALETTE;
  i: Integer;
begin
  // Exit if bitmap does not exist
  if BitMap = Nil then Exit ;
  BitMap.PixelFormat := pf8bit ;
  pal := nil;
  GetMem(pal, sizeof(TLogPalette) + sizeof(TPaletteEntry) * 256);
  try
    // Get existing 10 system colours
    GetSystemPaletteEntries( Canvas.Handle, 0, 10, @(Pal^.palPalEntry)) ;
    // Set remaining 246 as shades of grey
    Pal^.palVersion := $300;
    Pal^.palNumEntries := 256;
    case PaletteType of
       // Grey scale
       PalGrey :
           Begin
           for i := MinPaletteColor to MaxPaletteColor do
               begin
               Pal^.palPalEntry[i].peRed := i ;
               Pal^.palPalEntry[i].peGreen := i ;
               Pal^.palPalEntry[i].peBlue := i ;
               end;
           end ;
       // Green scale
       PalGreen :
           Begin
           for i := MinPaletteColor to MaxPaletteColor do
               begin
               Pal^.palPalEntry[i].peRed := 0;
               Pal^.palPalEntry[i].peGreen := i;
               Pal^.palPalEntry[i].peBlue := 0 ;
               end;
           end ;
       // Red scale
       PalRed :
           Begin
           for i := MinPaletteColor to MaxPaletteColor do
               begin
               Pal^.palPalEntry[i].peRed := i;
               Pal^.palPalEntry[i].peGreen := 0;
               Pal^.palPalEntry[i].peBlue := 0 ;
               end;
           end ;
       // Blue scale
       PalBlue :
           Begin
           for i := MinPaletteColor to MaxPaletteColor do
               begin
               Pal^.palPalEntry[i].peRed := 0;
               Pal^.palPalEntry[i].peGreen := 0;
               Pal^.palPalEntry[i].peBlue := i ;
               end;
           end ;
       // False colour
       PalFalseColor :
           begin
           for i := MinPaletteColor to MaxPaletteColor do
               begin
               if i <= 63 then
                  begin
                  Pal^.palPalEntry[i].peRed := 0 ;
                  Pal^.palPalEntry[i].peGreen := 254 - 4*i ;
                  Pal^.palPalEntry[i].peBlue := 255 ;
                  end
               else if i <= 127 then
                  begin
                  Pal^.palPalEntry[i].peRed := 0 ;
                  Pal^.palPalEntry[i].peGreen := 4*i - 254 ;
                  Pal^.palPalEntry[i].peBlue := 510 - 4*i ;
                  end
               else if i <= 191 then
                  begin
                  Pal^.palPalEntry[i].peRed := 4*i - 510 ;
                  Pal^.palPalEntry[i].peGreen := 255 ;
                  Pal^.palPalEntry[i].peBlue := 0 ;
                  end
               else
                  begin
                  Pal^.palPalEntry[i].peRed := 255 ;
                  Pal^.palPalEntry[i].peGreen := 1022 - 4*i ;
                  Pal^.palPalEntry[i].peBlue := 0 ;
                  end ;
               end;
           // Overload colour = white
           i := MaxPaletteColor ;
           end ;
       end ;
    // Zero entry set to black for all palettes
    i := MinPaletteColor ;
    Pal^.palPalEntry[i].peRed := 0 ;
    Pal^.palPalEntry[i].peGreen := 0 ;
    Pal^.palPalEntry[i].peBlue := 0 ;
    hpal := CreatePalette(Pal^);
//    Bitmap.Palette := CreatePalette(Pal^);
    if hpal <> 0 then Bitmap.Palette := hpal ;
  finally
    FreeMem(Pal);
    end;
  end ;

procedure TMainFrm.bScanFullClick(Sender: TObject);
// ----------------
// Scan full field
// ----------------
begin
    StartNewScan(zmFullField) ;
    end ;


procedure TMainFrm.bScanImageClick(Sender: TObject);
// ----------------------------
// Scan currently selected area
// ----------------------------
begin
    StartNewScan(0) ;
    end ;


procedure TMainFrm.bScanZoomInClick(Sender: TObject);
// -----------------------------------------------------
// Start new scan of area defined by selection rectangle
// -----------------------------------------------------
begin
    Magnification := 1 ;
    StartNewScan(1) ;
    end;


procedure TMainFrm.bScanZoomOutClick(Sender: TObject);
// --------------------------------------------------------
// Zoom out to previously selected scan area and start scan
// --------------------------------------------------------
begin
    StartNewScan(zmZoomOut) ;
    end;


procedure TMainFrm.StartNewScan(
          iZoom : Integer ) ;
// ------------------------------------------------------
// Start new scan (iZoom > 0 zoom in, iZoom < 0 zoom out)
// ------------------------------------------------------
var
    XC,YC : Double ;
begin

    if UnsavedRawImage then
       begin
       if MessageDlg( 'Current Image not saved! Do you want to overwrite image?',
                      mtWarning,[mbYes,mbNo], 0 ) = mrNo then Exit ;
       end;

    NumAverages := 1 ;
    NumRepeats := 1 ;
    ClearAverage := True ;
    //bStopScan.Enabled := True ;
    bScanImage.Enabled := False ;
    bScanZoomIn.Enabled := False ;
    bScanZoomOut.Enabled := False ;
    bScanFull.Enabled := False ;
    bFocusScan.Enabled := False ;

    // Turn off repeat scan if in high resolution mode
    if rbHRScan.Checked then ckRepeat.Checked := False ;
    if cbImageMode.ItemIndex = XYZMode then ckRepeat.Checked := False  ;
    FixRectangle( SelectedRect ) ;
    FixRectangle( SelectedRectBM ) ;

//
//  Set scanning area
//  -----------------

    case cbImageMode.ItemIndex of
      // XY and XYZ imaging mode
      XYMode,XYZMode :
      begin

       case iZoom of

          // Focus mode - Scan centre region of image
          // ----------------------------------------
          zmFocusMode :
          Begin
             iScanZoom := 1 ;
             XC := (ScanArea[0].Left + ScanArea[0].Right)*0.5 ;
             YC := (ScanArea[0].Top + ScanArea[0].Bottom)*0.5 ;
             ScanArea[iScanZoom].Left := XC*(1.0 - FocusModeRegion*0.5) ;
             ScanArea[iScanZoom].Right := XC*(1.0 + FocusModeRegion*0.5) ;
             ScanArea[iScanZoom].Top := YC*(1.0 - FocusModeRegion*0.5) ;
             ScanArea[iScanZoom].Bottom := YC*(1.0 + FocusModeRegion*0.5) ;
             ScanArea[iScanZoom].Width := ScanArea[iScanZoom].Right - ScanArea[iScanZoom].Left ;
             ScanArea[iScanZoom].Height := ScanArea[iScanZoom].Bottom - ScanArea[iScanZoom].Top ;
             ckRepeat.Checked := True ;
             rbHRScan.Checked := False ;
             rbFastScan.Checked := True ;
          end ;


          // Zoom In - Scan area defined by selection rectangle on image
          // -----------------------------------------------------------
          zmZoomIn :
          Begin
             iScanZoom := iScanZoom + 1 ;
             if (SelectedRect.Left > 0) or (SelectedRect.Top > 0) or
                (SelectedRect.Right < (FrameWidth-1)) or
                (SelectedRect.Bottom < (FrameHeight-1)) then
                begin
                ScanArea[iScanZoom].Left := ScanArea[iScanZoom-1].Left + (SelectedRect.Left*PixelsToMicronsX) ;
                ScanArea[iScanZoom].Right := ScanArea[iScanZoom-1].Left + (SelectedRect.Right*PixelsToMicronsX) ;
                ScanArea[iScanZoom].Top := ScanArea[iScanZoom-1].Top + (SelectedRect.Top*PixelsToMicronsY) ;
                ScanArea[iScanZoom].Bottom := ScanArea[iScanZoom-1].Top + (SelectedRect.Bottom*PixelsToMicronsY) ;
                ScanArea[iScanZoom].Width := ScanArea[iScanZoom].Right - ScanArea[iScanZoom].Left ;
                ScanArea[iScanZoom].Height := ScanArea[iScanZoom].Bottom - ScanArea[iScanZoom].Top ;
                end
             else iScanZoom := Max(iScanZoom-1,0) ;
          end ;

          // Zoom out - change to next larger scan area
          // ------------------------------------------
          zmZoomOut :
          begin
            iScanZoom := Max(iScanZoom-1,0) ;
          end ;

          // Zoom out to full scan area
          // --------------------------
          zmFullField :
          begin
            iScanZoom := 0 ;
          end;
       end ;

//
//     Set scanning area
//     -----------------

       if iZoom = zmFocusMode then
          begin
          // Focus mode - fast scanning mode
          FrameWidth := FocusModeFrameWidth ;
          FrameHeight := Max(Round(FrameWidth*(ScanArea[iScanZoom].Height/ScanArea[iScanZoom].Width)),1) ;
          if FrameHeight > FocusModeFrameHeight then
             begin
             FrameHeightScale := FrameHeight/FocusModeFrameHeight ;
             FrameHeight := FocusModeFrameHeight ;
             end
          else FrameHeightScale := 1.0 ;
          BidirectionalScan := FastBidirectionalScan ;
          end
       else if rbFastScan.Checked then
          begin
          // Fast scan mode
          FrameWidth := FastFrameWidth ;
          FrameHeight := Max(Round(FrameWidth*(ScanArea[iScanZoom].Height/ScanArea[iScanZoom].Width)),1) ;
          if FrameHeight > FastFrameHeight then
             begin
             FrameHeightScale := FrameHeight/FastFrameHeight ;
             FrameHeight := FastFrameHeight ;
             end
          else FrameHeightScale := 1.0 ;
          BidirectionalScan := FastBidirectionalScan ;
          end
        else
          begin
          // High resolution scan
          FrameWidth := HRFrameWidth ;
          FrameHeight := Max(Round(FrameWidth*(ScanArea[iScanZoom].Height/ScanArea[iScanZoom].Width)),1) ;
          FrameHeightScale := 1.0 ;
          BidirectionalScan := False ;
          end;
       end ;

    // XT line scan mode
    XTMode :
        begin
        if rbFastScan.Checked then FrameWidth := FastFrameWidth
                              else  FrameWidth := HRFrameWidth ;
        FrameHeight := Round(edLineScanFrameHeight.Value) ;
        FrameHeightScale := 1.0 ;
        BidirectionalScan := False ;
        end ;

    // XZ image mode
    XZMode :
        begin
        if rbFastScan.Checked then
           begin
           FrameWidth := FastFrameWidth ;
           BidirectionalScan := FastBidirectionalScan ;
           end
        else
        begin
          FrameWidth := HRFrameWidth ;
          BidirectionalScan := FastBidirectionalScan ;
          end ;
        FrameHeightScale := 1.0 ;
        FrameHeight := Round(edNumZSteps.Value) ;
        end ;
      end ;

//      Outputdebugstring(pchar(format('frameheightscale %.0f',[FrameHeightScale])));

    // Image pixel to microns scaling factor
    PixelsToMicronsX := ScanArea[iScanZoom].Width/FrameWidth ;
    PixelsToMicronsY := FrameHeightScale*PixelsToMicronsX ;
    meStatus.Clear ;
    SetImagePanels ;
    SelectedRect.Left := 0 ;
    SelectedRect.Right := FrameWidth-1 ;
    SelectedRect.Top := 0 ;
    SelectedRect.Bottom := FrameHeight-1 ;
    // Z sections
    ZSection := 0 ;
    NumZSectionsAvailable := 0 ;
    ZStepSize := edNumPixelsPerZStep.Value*(ScanArea[iScanZoom].Width/HRFrameWidth) ;
    edMicronsPerZStep.Value := ZStepSize ;
    iZStep := 0 ;
    // Save current position of Z stage
    ZStartingPosition := ZStage.ZPosition ;
    // Create scan waveform
    CreateScanWaveform ;
    ScanRequested := 1 ;
    end ;


procedure TMainFrm.StartScan ;
// ---------------
// Scan image scan
// ---------------
var
    i,nSamples : Integer ;
    PMTInUse : Array[0..MaxPMT] of Boolean ;   // PMTs in use
    PMTGain : Array[0..MaxPMT] of Integer ;    // PMT gains
    AOList : Array[0..1] of Integer ;          // List of AO channels in use
    AIList : Array[0..MaxPMT] of Integer ;          // List of AI channels in use
    AIVoltageRange : Array[0..MaxPMT] of Integer ;          // List of AI channels in use
    DACDev : Integer ;
begin
    // Stop A/D & D/A
    MemUsed := 0 ;
    ADCPointer := 0 ;
    XZLine := 0 ;
//    XZAverageLine := 0 ;

    // Stop any existing scan
    if LabIO.ADCActive[DeviceNum] then LabIO.StopADC(DeviceNum) ;
    if LabIO.DACActive[DeviceNum] then LabIO.StopDAC(DeviceNum) ;

    // Clear averaging buffers (if required)

    if ClearAverage then
       begin
       // Dispose of existing display buffers and create new ones
       if AvgBuf <> Nil then FreeMem( AvgBuf ) ;
       AvgBuf := AllocMem( Int64(NumPixels)*Int64(NumPMTChannels)*4 ) ;
       for i := 0 to NumPixels*NumPMTChannels-1 do AvgBuf^[i] := 0 ;
       ClearAverage := False ;
       NumAverages := 1 ;
       end ;

    ADCPointer := 0 ;
    // Set up for XZ mode image
    XZLine := 0 ;
    LinesAvailableForDisplay := 0 ;
    ADCNumNewSamples := 0 ;
    ADCPointer := 0 ;

    // Update PMT control voltages from user-interface settings
    // --------------------------------------------------------
    PMTInUse[0] := ckEnablePMT0.Checked and panelPMT0.visible ;
    PMTInUse[1] := ckEnablePMT1.Checked and panelPMT1.visible ;
    PMTInUse[2] := ckEnablePMT2.Checked and panelPMT2.visible ;
    PMTInUse[3] := ckEnablePMT3.Checked and panelPMT3.visible ;
    PMTGain[0] := cbPMTGain0.ItemIndex ;
    PMTGain[1] := cbPMTGain1.ItemIndex ;
    PMTGain[2] := cbPMTGain2.ItemIndex ;
    PMTGain[3] := cbPMTGain3.ItemIndex ;
    SetAllPMTVoltages ;

    // Set channel #, voltage rnage and A/D value inversion for AI channels associated with PMTs

    NumPMTChannels := 0 ;
    for i := 0 to NumPMTs-1 do if PMTInUse[i] then
        begin

        // AI channel associated with this PMT
        AIList[NumPMTChannels] := i ;

        // AI voltage range associated with this PMT
        AIVoltageRange[NumPMTChannels] := PMTGain[i] ;

        // Inversion AI signal required
        if PMTInvertSignal[i] then InvertADCValue[NumPMTChannels] := -1
                              else InvertADCValue[NumPMTChannels] := 1 ;

        Inc(NumPMTChannels) ;
        end;

    // Select analog output channels for X/Y galvio control
    // ----------------------------------------------------
    AOList[0] := XGalvoAO ;
    AOList[1] := YGalvoAO ;
    if AOList[0] = AOList[1] then
       begin
       ShowMessage('Error: X & Y galvo analog outputs must be on different AO channels!');
       bStopScan.Enabled := True ;
       Exit ;
       end ;

    // Start A/D capture of PMT signals (timed by D/A updates)
    // -------------------------------------------------------
    nSamples := Max(Round(10.0/PixelDwellTime) div NumXPixels,1)*NumXPixels ;
    LabIO.ADCToMemoryExtScan( DeviceNum,AIList,AIVoltageRange,NumPMTChannels,NumXPixels*NumYPixels,False,DeviceNum ) ;

    // Start D/A waveform generation
    // -----------------------------
    LabIO.MemoryToDAC( DeviceNum,
                       DACBuf,
                       AOList,
                       2,
                       NumPixels,
                       NumPixelsinDACBuf,
                       PixelDwellTime,
                       False,
                       False,
                       DeviceNum ) ;
    bStopScan.Enabled := True ;
    bScanImage.Enabled := False ;
    ScanningInProgress := True ;
    InitialiseImage ;

    // Clear image intensity histogram
    ClearHistogram ;

    end;


procedure TMainFrm.SetAllPMTVoltages ;
// --------------------
// Set all PMT voltages
// --------------------
begin
    SetPMTVoltage( 0, edPMTVolts0.Value ) ;
    SetPMTVoltage( 1, edPMTVolts1.Value ) ;
    SetPMTVoltage( 2, edPMTVolts2.Value ) ;
    SetPMTVoltage( 3, edPMTVolts3.Value ) ;
end;

procedure TMainFrm.SetPMTVoltage(
          PMTNum : Integer ;
          PercentMax : Double ) ;
// ---------------
// Set PMT voltage
// ---------------
var
    iPort,iDev,iChan : Integer ;
    V : single ;
begin
    V := PercentMax*0.01*PMTMaxVolts ;
    iPort := 0 ;
    for iDev := 1 to LabIO.NumDevices do
        for iChan := 0 to LabIO.NumDACs[iDev]-1 do
            begin
            if iPort = PMTControls[PMTNum] then
               begin
               LabIO.WriteDAC(iDev,V,iChan);
               end;
            inc(iPort) ;
            end;
    end;


procedure TMainFrm.bCursorsClick(Sender: TObject);
// --------------------------------------------------
// Set display intensity range from histogram cursors
// --------------------------------------------------
var
    Temp : Integer ;
begin
      GreyLo[ImagePage.ActivePageIndex] := Round(plHistogram.VerticalCursors[HistogramCursorLo]) ;
      GreyHi[ImagePage.ActivePageIndex] := Round(plHistogram.VerticalCursors[HistogramCursorHi]) ;
      // Swap if lo cursor > hi cursor
      if GreyLo[ImagePage.ActivePageIndex] > GreyHi[ImagePage.ActivePageIndex] then
         begin
         Temp := GreyLo[ImagePage.ActivePageIndex] ;
         GreyLo[ImagePage.ActivePageIndex] := GreyHi[ImagePage.ActivePageIndex] ;
         GreyHi[ImagePage.ActivePageIndex] := Temp ;
         end;
     // Ensure a non-zero LUT range
        if GreyLo[ImagePage.ActivePageIndex] = GreyHi[ImagePage.ActivePageIndex] then
           begin
           GreyLo[ImagePage.ActivePageIndex] := GreyLo[ImagePage.ActivePageIndex] - 1 ;
           GreyHi[ImagePage.ActivePageIndex] := GreyHi[ImagePage.ActivePageIndex] + 1 ;
           end ;
     UpdateLUT(ImagePage.ActivePageIndex, ADCMaxValue ) ;
     SetDisplayIntensityRange( GreyLo[ImagePage.ActivePageIndex], GreyHi[ImagePage.ActivePageIndex] ) ;
end;


procedure TMainFrm.bFocusScanClick(Sender: TObject);
// ---------------
// Focus mode scan
// ---------------
begin
    StartNewScan(zmFocusMode) ;
end;


procedure TMainFrm.bFullScaleClick(Sender: TObject);
// --------------------------------------------------------
// Set display grey scale to full intensity range of camera
// --------------------------------------------------------
begin
    GreyLo[ImagePage.ActivePageIndex] := 0 ;
    GreyHi[ImagePage.ActivePageIndex] := ADCMaxValue ; ;
    // Set intensity range and sliders
    SetDisplayIntensityRange( GreyLo[ImagePage.ActivePageIndex],GreyHi[ImagePage.ActivePageIndex] ) ;
    UpdateLUT( ImagePage.ActivePageIndex, ADCMaxValue ) ;
    UpdateDisplay := True ;
    end ;

procedure TMainFrm.edDisplayIntensityRangeKeyPress(Sender: TObject;
  var Key: Char);
// ------------------------------
// Update display intensity range
// ------------------------------
begin
     if key = #13 then begin
 //       bRange.Click ;
     end;
     end;

procedure TMainFrm.edGotoZPositionKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #13 then
        begin
        ZStage.MoveTo( ZStage.XPosition,ZStage.YPosition,edGoToZPosition.Value ) ;
        end;
    end;
procedure TMainFrm.edLaserIntensityKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #13 then
       begin
 //      Laser.Intensity := edLaserIntensity.Value ;
       tbLaserIntensity.Position := Round(10.0*edLaserIntensity.Value) ;
       end;
    end;

procedure TMainFrm.edMicronsPerZStepKeyPress(Sender: TObject; var Key: Char);
// -------------------------
// Microns per Z step changed
// -------------------------
begin
      if Key = #13 then
         begin
//         edNumPixelsPerZStep.Value := Max(Round(edMicronsPerZStep.Value / (ScanArea[iScanZoom].Width/HRFrameWidth)),1) ;
         edNumPixelsPerZStep.Value := edMicronsPerZStep.Value / (ScanArea[iScanZoom].Width/HRFrameWidth) ;
         edMicronsPerZStep.Value := edNumPixelsPerZStep.Value*(ScanArea[iScanZoom].Width/HRFrameWidth) ;
         end;
      end;

procedure TMainFrm.edNumPixelsPerZStepKeyPress(Sender: TObject; var Key: Char);
// -------------------------
// Pixels per Z step changed
// -------------------------
begin
      if Key = #13 then
         begin
         edMicronsPerZStep.Value := edNumPixelsPerZStep.Value*(ScanArea[iScanZoom].Width/HRFrameWidth) ;
         end;
      end;

procedure TMainFrm.edPMTVolts0KeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #13 then
       begin
       SetAllPMTVoltages ;
       end;
    end;
procedure TMainFrm.bGotoZPositionClick(Sender: TObject);
// -------------------------
// Go to specified Z position
// --------------------------
begin
    ZStage.MoveTo( ZStage.XPosition, ZStage.YPosition, edGoToZPosition.Value ) ;
    end;

procedure TMainFrm.bMaxContrastClick(Sender: TObject);
// -------------------------------------------------------------
// Request display intensity range to be set for maximum contrast
// -------------------------------------------------------------
begin
     CalculateMaxContrast ;
     // Set intensity range and sliders
     SetDisplayIntensityRange( GreyLo[ImagePage.ActivePageIndex],
                               GreyHi[ImagePage.ActivePageIndex] ) ;
     UpdateDisplay := True ;
     end;


procedure TMainFrm.bRangeClick(Sender: TObject);
// --------------------------------------------------
// Set display intensity range from user entered range
// ---------------------------------------------------
begin
    if edDisplayIntensityRange.LoValue = edDisplayIntensityRange.HiValue then
        begin
        edDisplayIntensityRange.LoValue := edDisplayIntensityRange.LoValue - 1.0 ;
        edDisplayIntensityRange.HiValue := edDisplayIntensityRange.HiValue + 1.0 ;
        end ;
     GreyLo[ImagePage.ActivePageIndex] := Round(edDisplayIntensityRange.LoValue) ;
     GreyHi[ImagePage.ActivePageIndex] := Round(edDisplayIntensityRange.HiValue) ;
     UpdateLUT( ImagePage.ActivePageIndex, ADCMaxValue ) ;
     // Set intensity range and sliders
     SetDisplayIntensityRange( GreyLo[ImagePage.ActivePageIndex],
                               GreyHi[ImagePage.ActivePageIndex] ) ;
     UpdateDisplay := True ;
end;


procedure TMainFrm.CalculateMaxContrast ;
// ---------------------------------------------------------
// Calculate and set display for maximum grey scale contrast
// ---------------------------------------------------------
const
    MaxPoints = 10000 ;
var
     ch,i,NumPixels,iStep : Integer ;
     z,zMean,zSD,zSum : Single ;
     iz,ZMin,ZMax,ZLo,ZHi,ZThreshold : Integer ;
     FrameType,MaxLine : Integer ;
begin
    ch := ImagePage.ActivePageIndex ;
    if ScanningInProgress then MaxLine := LinesAvailableForDisplay
                          else MaxLine := FrameHeight ;
    NumPixels := FrameWidth*MaxLine - 4 ;
    FrameType := 0 ;
    if NumPixels < 2 then Exit ;
    iStep := Max(NumPixels div MaxPoints,1) ;
    if ckContrast6SDOnly.Checked then
       begin
       // Set contrast range to +/- 3 x standard deviation
       ZSum := 0.0 ;
       for i := 0 to NumPixels - 1 do ZSum := ZSum + pImageBuf[ch]^[i] ;
       ZMean := ZSum / NumPixels ;
       ZSum := 0.0 ;
       i := 0 ;
       repeat
         Z :=pImageBuf[ch]^[i] ;
         ZSum := ZSum + (Z - ZMean)*(Z - ZMean) ;
         i := i + iStep ;
         until i >= NumPixels ;
       ZSD := Sqrt( ZSum / (NumPixels-1) ) ;
       ZLo := Max( Round(ZMean - 3*ZSD),0) ;
       ZHi := Min( Round(ZMean + 3*ZSD), ADCMaxValue );
       end
    else
       begin
       // Set contrast range to min-max
       ZMin := ADCMaxValue ;
       ZMax := 0 ;
       i := 0 ;
       repeat
         iz := pImageBuf[ch]^[i] ;
         if iz < ZMin then ZMin := iz ;
         if iz > ZMax then ZMax := iz ;
         i := i + iStep ;
         until i >= NumPixels ;
       ZLo := ZMin ;
       ZHi := ZMax ;
       end ;
    // Update contrast
    ZThreshold := Max((ADCMaxValue div 50),2) ;
    if (not ckAutoOptimise.Checked) or
       (Abs(MainFrm.GreyLo[ch]- ZLo) > 10) then MainFrm.GreyLo[ch] := ZLo ;
    if (not ckAutoOptimise.Checked) or
       (Abs(MainFrm.GreyHi[ch]- ZHi) > 10) then MainFrm.GreyHi[ch] := ZHi ;
    // Ensure a non-zero LUT range
    if MainFrm.GreyLo[ch] = MainFrm.GreyHi[ch] then
       begin
       MainFrm.GreyLo[ch] := MainFrm.GreyLo[ch] - 1 ;
       MainFrm.GreyHi[ch] := MainFrm.GreyHi[ch] + 1 ;
       end ;
    UpdateLUT(ch, ADCMaxValue ) ;
    end ;


procedure TMainFrm.TimerTimer(Sender: TObject);
// -------------------------
// Regular timed operations
// --------------------------
begin

    if ScanningInProgress then EnablePMTControls( False )
                          else EnablePMTControls( True ) ;

    if UpdateDisplay then
       begin ;
       UpdateImage ;
       PlotHistogram ;
       UpdateDisplay := False ;
       end ;

    if ScanRequested > 0 then
       begin
//       if not Laser.ShutterOpen then
//          begin
 //         Laser.ShutterOpen := True ;
  //        Laser.Intensity := edLaserIntensity.Value ;
 //         ScanRequested := Round(Laser.ShutterChangeTime/(Timer.Interval*0.001)) ;
 //         end ;
       ScanRequested := Max(ScanRequested - 1,0) ;
       if ScanRequested <= 0 then
          begin
          StartScan ;
          UpdateImage ;
          PlotHistogram ;
          end ;
       end ;
    GetImageFromPMT ;
    //
    // Z stage rotary control dial
    //
    if ZStage.ZDialAvailable then
       begin
       ZStepsPending := ZStage.GetZDialRotation + ZStepsPending ;
       if (ZStepsPending <> 0.0) and (not ZStage.Moving) and (ZDialWaitCount <= 0) then
          begin
          ZStage.MoveTo( ZStage.XPosition,ZStage.YPosition,ZStage.ZPosition + ZStepsPending ) ;
          ZStepsPending := 0.0 ;
          ZDialWaitCount := 5 ;  // = 5 timer ticks = 0.5s
          end
       else
         begin
         // Decrement wait counter
         ZDialWaitCount :=  Max( ZDialWaitCount - 1,0) ;
         end;
       tbZPosition.Position := Round(ZStage.ZPosition) ;
       rbZDialCoarse.Checked := ZStage.ZDialCoarseStep ;
       rbZDialFine.Checked := not ZStage.ZDialCoarseStep ;
       end
     else
       begin
       // Start monitor of Z dial encoder pulses
       ZStage.StartZDialADC ;
       ZStepsPending := 0.0 ;
       end;
     // Report stage position
     ZStage.UpdateZPosition ;
     edZTop.Text := format('%.1f um',[ZStage.ZPosition]) ;
    end;


procedure TMainFrm.EnablePMTControls( Enabled : Boolean ) ;
// --------------------------------------
// Enable/Disable changes to PMT controls
// --------------------------------------
begin
     if ckEnablePMT0.Enabled <> Enabled then ckEnablePMT0.Enabled := Enabled ;
     if ckEnablePMT1.Enabled <> Enabled then ckEnablePMT1.Enabled := Enabled ;
     if ckEnablePMT2.Enabled <> Enabled then ckEnablePMT2.Enabled := Enabled ;
     if ckEnablePMT3.Enabled <> Enabled then ckEnablePMT3.Enabled := Enabled ;
     if cbPMTGain0.Enabled <> Enabled then cbPMTGain0.Enabled := Enabled ;
     if cbPMTGain1.Enabled <> Enabled then cbPMTGain1.Enabled := Enabled ;
     if cbPMTGain2.Enabled <> Enabled then cbPMTGain2.Enabled := Enabled ;
     if cbPMTGain3.Enabled <> Enabled then cbPMTGain3.Enabled := Enabled ;
     if gpPMTColor0.Enabled <> Enabled then gpPMTColor0.Enabled := Enabled ;
     if gpPMTColor1.Enabled <> Enabled then gpPMTColor1.Enabled := Enabled ;
     if gpPMTColor2.Enabled <> Enabled then gpPMTColor2.Enabled := Enabled ;
     if gpPMTColor3.Enabled <> Enabled then gpPMTColor3.Enabled := Enabled ;
end;


procedure TMainFrm.udPMTVolts0ChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Integer; Direction: TUpDownDirection);
begin
    if Direction = updUp then edPMTVolts0.Value := edPMTVolts0.Value + 1.0
                         else edPMTVolts0.Value := edPMTVolts0.Value - 1.0 ;
    SetAllPMTVoltages ;
    end;

procedure TMainFrm.udPMTVolts1ChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Integer; Direction: TUpDownDirection);
begin
    if Direction = updUp then edPMTVolts1.Value := edPMTVolts1.Value + 1.0
                         else edPMTVolts1.Value := edPMTVolts1.Value - 1.0 ;
    SetAllPMTVoltages ;
    end;

procedure TMainFrm.udPMTVolts2ChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Integer; Direction: TUpDownDirection);
begin
    if Direction = updUp then edPMTVolts2.Value := edPMTVolts2.Value + 1.0
                         else edPMTVolts2.Value := edPMTVolts2.Value - 1.0 ;
    SetAllPMTVoltages ;
    end;

procedure TMainFrm.udPMTVolts3ChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Integer; Direction: TUpDownDirection);
begin
    if Direction = updUp then edPMTVolts3.Value := edPMTVolts3.Value + 1.0
                         else edPMTVolts3.Value := edPMTVolts3.Value - 1.0 ;
    SetAllPMTVoltages ;
    end;


procedure TMainFrm.GetImageFromPMT ;
// ------------------
// Get image from PMT
// ------------------
var
    ch,iPix,iPointer,iPointerStep,iLine,nAvg,iAvg,AvgFrameStart : Integer ;
    i,ADCStart,ADCEnd : NativeInt ;
    NewZSection,ZSect : Integer ;
    Sum,y : Integer ;
    j: Integer;
begin

    // Quit if scan not in progress
    if not LabIO.DACActive[DeviceNum] then exit ;
    if not ScanningInProgress then exit ;

    // Read new A/D converter samples
    if not LabIO.GetADCSamples( DeviceNum, ADCBuf^,ADCStart,ADCEnd ) then Exit ;

    // Copy image from circular ADC buffer into 32 bit display buffer
    // ---------------------------------------------------------------

//       outputdebugstring(pchar(format('ADCBuf start-end = %d, %d, %d, %d',
//       [ADCBuf^[0],ADCBuf^[1],ADCBuf^[(NumPixels*NumPMTChannels)-2],ADCBuf^[(NumPixels*NumPMTChannels)-1]]))) ;

    for i := ADCStart to ADCEnd do
        begin
        ADCPointer := i ;
        AvgBuf^[i] := AvgBuf^[i] + ADCBuf^[i] {+ random(100)} ;

        iPix := i div NumPMTChannels ; // Pixel index
        ch := i mod NumPMTChannels ;   // AI channel index

        iPointer := ADCMap^[iPix] ;
        iPointerStep := ADCMap^[iPix+1] - iPointer ;

        // Average and add black level
        y := InvertADCvalue[ch]*(AvgBuf^[i] div NumAverages) + BlackLevel ;

        // Keep within 16 bit limits
        if y  < 0 then y := 0 ;
        if y > ADCMaxValue then y := ADCmaxValue ;

        pImageBuf[ch]^[iPointer] := y  ;
        if Abs(iPointerStep) = 2 then
           begin
           iPointer := iPointer + Sign(iPointerStep) ;
           pImageBuf[ch]^[iPointer] := y ;
           end ;
        end ;

    // Copy image to display bitmap
    iLine := ADCPointer div (NumXPixels*NumPMTChannels) ;
    iLine := Max(iLine -1,0) ;
    if not BiDirectionalScan then iLine := iLine div 2 ;
    // Increment Z stage in XZ mode
    if cbImageMode.ItemIndex = XZMode then
       begin
       NewZSection := iLine div NumLinesPerZStep ;
       nAvg := Max(Round(edNumRepeats.Value),1) ;
       if (NewZSection <> ZSection) and (XZLine < FrameHeight) then
          begin
          // Average lines for Z section
          AvgFrameStart := ((XZLine*NumLinesPerZStep) + NumLinesPerZStep - 1)*FrameWidth  ;
          for ch := 0 to NumPMTChannels-1 do
              begin
              for i := 0 to FrameWidth-1 do
                  begin
                  Sum := 0 ;
                  j := AvgFrameStart + i ;
                  for iAvg := 1 to nAvg do
                      begin
                      Sum := Sum + pImageBuf[ch]^[j] ;
                      j := j - FrameWidth ;
                      end;
                  pImageBuf[ch]^[(XZLine*FrameWidth)+i] := Sum div nAvg
                  end ;
              end;
          Inc(XZLine) ;
          LinesAvailableForDisplay := XZLine ;
          ZSection := NewZSection ;
          ZStage.MoveTo( ZStage.XPosition,ZStage.YPosition, ZStage.ZPosition + ZStepSize );
          end;
       end
    else
       begin
       LinesAvailableForDisplay := iLine ;//FrameHeight ;
       NewZSection := 0 ;
       end;
    meStatus.Clear ;
    case cbImageMode.ItemIndex of
       XYMode,XTMode :
         begin
         meStatus.Lines[0] := format('Line %5d/%d (%.3f MB)',
                              [iLine,FrameHeight,ADCPointer/1048576.0]);
         meStatus.Lines.Add(format('Average %d/%d',[NumRepeats,Round(edNumRepeats.Value)])) ;
         end;
       XYZMode :
         begin
         meStatus.Lines[0] := format('Line %5d/%d (%.2f MB)',
                              [iLine,FrameHeight,ADCPointer/1048576.0]);
         meStatus.Lines.Add(format('Average %d/%d',[NumRepeats,Round(edNumRepeats.Value)])) ;
         if ckKeepRepeats.Checked then ZSect := Ceil( (ZSection + 1) / edNumRepeats.Value)
                                  else ZSect := ZSection + 1 ;
         meStatus.Lines.Add(format('Section %d/%d',[ZSect,Round(edNumZSteps.Value)]))
         end;
       XZMode :
         begin
         meStatus.Lines[0] := format('Line %5d/%d (%.2f MB)',
                              [NewZSection,Round(edNumZSteps.Value),
                               ADCPointer/(NumLinesPerZStep*1048576.0)]);
         end;
       end;

    meStatus.Lines.Add( ScanInfo ) ;
    ADCNumNewSamples := 0 ;
    if ADCPointer >= (NumPixels*NumPMTChannels-4) then
       begin
       if cbImageMode.ItemIndex = XZMode then
          begin
          NumAverages := Round(edNumRepeats.Value) + 1 ;
          SaveRawImage( RawImagesFileName, 0 ) ;
          end
       else
          begin
          SaveRawImage( RawImagesFileName, ZSection ) ;
          Inc(NumAverages) ;
          Inc(NumRepeats) ;
          // If images are to be saved for later averaging increment section number
          // otherwise only increment when averaging completed
          if not ckRepeat.Checked then
             begin
             if ckKeepRepeats.Checked then Inc(ZSection)
             else if NumAverages > Round(edNumRepeats.Value) then Inc(ZSection) ;
             end;
          end;
       if NumRepeats <= Round(edNumRepeats.Value) then
          begin
          ScanRequested := 1 ;
          if ckKeepRepeats.Checked then ClearAverage := True ;
          end
       else
          begin
          ScanningInProgress := False ;
          if ckRepeat.Checked and (not bScanImage.Enabled) then
             begin
             ScanRequested := 1 ;
             NumAverages := 1 ;
             NumRepeats := 0 ;
             ClearAverage := True ;
             if cbImageMode.ItemIndex = XZMode then ZStage.MoveTo( ZStage.XPosition,ZStage.YPosition,ZStartingPosition );
             end
          else if cbImageMode.ItemIndex = XYZMode then
             begin
             // Increment Z position to next Section
             Inc(iZStep) ;
             ZStage.MoveTo( ZStage.XPosition,ZStage.YPosition,ZStage.ZPosition + ZStepSize );
             if iZStep < Round(edNumZSteps.Value) then
                begin
                ScanRequested := Max(Round(ZStage.ZStepTime/(Timer.Interval*0.001)),1) ;
                NumAverages := 1 ;
                NumRepeats := 1 ;
                ClearAverage := True ;
                end
             else
                begin
                bStopScan.Click ;
             end ;
          end
          else
             begin
             bStopScan.Click ;
          end;
       end ;
    end ;
    UpdateDisplay := True ;
    end ;

procedure TMainFrm.bStopScanClick(Sender: TObject);
// -------------
// Stop scanning
// -------------
//var
//    FileHandle : Integer ;
begin

    if LabIO.ADCActive[DeviceNum] then LabIO.StopADC(DeviceNum) ;
    if LabIO.DACActive[DeviceNum] then LabIO.StopDAC(DeviceNum) ;

    // Centre X/Y galvos
    LabIO.WriteDACs( DeviceNum,[0.0,0.0],2);

    // Turn off voltage to PMTs
    SetPMTVoltage( 0, 0.0 ) ;
    SetPMTVoltage( 1, 0.0 ) ;
    SetPMTVoltage( 2, 0.0 ) ;
    SetPMTVoltage( 3, 0.0 ) ;

    if AvgBuf <> Nil then
      begin
      FreeMem(AvgBuf) ;
      AvgBuf := Nil ;
      end;
    if DACBuf <> Nil then
      begin
      FreeMem(DACBuf) ;
      DACBuf := Nil ;
      end;

    // Re-enable scan buttons

    bStopScan.Enabled := False ;
    bScanImage.Enabled := True ;
    bScanZoomIn.Enabled := True ;
    bScanZoomOut.Enabled := True ;
    bScanFull.Enabled := True ;
    bFocusScan.Enabled := True ;

    ScanRequested := 0 ;
    ScanningInProgress := False ;
    LinesAvailableForDisplay := 0 ;
    // Close laser shutter
 //   Laser.ShutterOpen := False ;
    // Move Z stage back to starting position
    case cbImageMode.ItemIndex of
       XYZMode :
         begin
         //ZStage.MoveTo( ZStartingPosition );
         scZSection.Position := 0 ;
         end;
       XZMode :
         begin
         ZStage.MoveTo( ZStage.XPosition,ZStage.YPosition,ZStartingPosition );
         end;
    end;

    end;

procedure TMainFrm.bZoomInClick(Sender: TObject);
// ---------------
// Magnify display
// ---------------
begin
    Inc(Magnification) ;
    Resize ;
    UpdateDisplay := True ;
    end;
procedure TMainFrm.bZoomOutClick(Sender: TObject);
// -----------------
// Demagnify display
// -----------------
begin
     Magnification := Max(Magnification-1,1) ;
     Resize ;
     UpdateDisplay := True ;
     end;

procedure TMainFrm.cbImageModeChange(Sender: TObject);
// ------------------
// Image mode changed
// ------------------
begin
    ZStackGrp.Visible := False ;
    LineScanGrp.Visible := False ;
    case cbImageMode.ItemIndex of
       XYZMode,XZMode : ZStackGrp.Visible := True ;
       XTMode : LineScanGrp.Visible := True ;
       end ;
    end;
procedure TMainFrm.cbPaletteChange(Sender: TObject);
// ------------------------------
// Display colour palette changed
// ------------------------------
var
    ch : Integer ;
begin
     PaletteType := TPaletteType(cbPalette.Items.Objects[cbPalette.ItemIndex]) ;
     for ch  := 0 to NumPMTChannels-1 do
         if BitMap[ch] <> Nil then SetPalette( BitMap[ch], PaletteType ) ;
     UpdateDisplay := True ;
     end;

procedure TMainFrm.ckEnablePMT0Click(Sender: TObject);
// --------------------
// PMT enabled/disabled
// --------------------
begin
  UpdatePMTSettings ;
  end;
procedure TMainFrm.ckLineScanClick(Sender: TObject);
// ----------------------
// Line scan mode changed
// ----------------------
begin
    UpdateDisplay := True ;
    end;
procedure TMainFrm.mnExitClick(Sender: TObject);
// ------------
// Stop program
// ------------
begin
    Close ;
    end;


procedure TMainFrm.mnScanSettingsClick(Sender: TObject);
// --------------------------
// Show Scan Settings dialog
// --------------------------
begin
     SettingsFrm.ShowModal ;
     edMicronsPerZStep.Value := edNumPixelsPerZStep.Value*(ScanArea[iScanZoom].Width/HRFrameWidth) ;
     //Re-open control port (if in use)
     if LaserControlEnabled then
        begin
     //   LaserControlOpen := OpenComPort( LaserControlCOMHandle, LaserControlCOMPort, CBR_9600 ) ;
        end
     else LaserControlOpen := False ;
     end;

procedure TMainFrm.mnSaveImageClick(Sender: TObject);
// --------------------------
// Save current image to file
// --------------------------
begin
    SaveImage(False);
end;

procedure TMainFrm.SaveImage( OpenImageJ: boolean ) ;
// -----------------------------
// Save current image(s) to file
// -----------------------------
var
    FileName,s : String ;
    iSection,nFrames : Integer ;
    iNum : Integer ;
    iPMT : Integer ;
    Exists : boolean ;
begin
     SaveDialog.InitialDir := SaveDirectory ;
     // Create an unused file name
     iNum := 1 ;
     repeat
        Exists := False ;
        FileName := SaveDialog.InitialDir + '\'
                    + FormatDateTime('yyyy-mm-dd',Now)
                    + format(' %d.tif',[iNum]) ;
        Exists := false ;
        for iPMT := 0 to NumPMTChannels-1 do
            for iSection := 0 to NumZSectionsAvailable-1 do
                begin
                s := SectionFileName(FileName,iPMT,iSection) ;
                Exists := Exists or FileExists(SectionFileName(FileName,iPMT,iSection)) ;
                end;
        Inc(iNum) ;
     until not Exists ;
     // Open save file dialog
     SaveDialog.FileName := ExtractFileName(FileName) ;
     if not SaveDialog.Execute then Exit ;
     // Ensure extension is set
     FileName := ChangeFileExt(SaveDialog.FileName, '.tif' ) ;
     Filename := ReplaceText( FileName, '.ome.tif', '.tif' ) ;
     SaveDirectory := ExtractFilePath(SaveDialog.FileName) ;
     // Check if any files exist already and allow user option to quit
     Exists := False ;
     for iPMT := 0 to NumPMTChannels-1 do
         for iSection := 0 to NumZSectionsAvailable-1 do
             begin
             Exists := Exists or FileExists(SectionFileName(FileName,iPMT,iSection)) ;
             if Exists then Break ;
             end;
     if Exists then if MessageDlg( format(
                    'File %s already exists! Do you want to overwrite it? ',[SectionFileName(FileName,iPMT,iSection)]),
                    mtWarning,[mbYes,mbNo], 0 ) = mrNo then Exit ;
     // Save image
     for iPMT := 0 to NumPMTChannels-1 do
         begin
         for iSection  := 0 to NumZSectionsAvailable-1 do
             begin
             meStatus.Lines.Clear ;
             mestatus.Lines[0] := format('Saving to file %s %d/%d',
                                  [ImageNames[iPMT],iSection+1,NumZSectionsAvailable]);
             // Load image
             LoadRawImage( RawImagesFileName, iSection ) ;
             // Create file
             if (not SaveAsMultipageTIFF) or (iSection = 0) then
                begin
                // Save individual (or first) section in stack
                if SaveAsMultipageTIFF then nFrames := NumZSectionsAvailable
                                       else nFrames := 1 ;
                if not ImageFile.CreateFile( SectionFileName(FileName,iPMT,iSection),
                                             FrameWidth,FrameHeight,
                                             2*8,1,nFrames ) then Exit ;
                ImageFile.XResolution := ScanArea[iScanZoom].Width/FrameWidth ;
                ImageFile.YResolution := ImageFile.XResolution ;
                ImageFile.ZResolution := ZStepSize ;
                ImageFile.SaveFrame( 1, PImageBuf[iPMT] ) ;
                if not SaveAsMultipageTIFF then ImageFile.CloseFile ;
                end
             else
                begin
                // Save subsequent sections of stack
                ImageFile.SaveFrame( iSection+1, PImageBuf[iPMT] ) ;
                end;
             end ;
         // Close file (if a multipage TIFF)
         if SaveAsMultipageTIFF then ImageFile.CloseFile ;
         end;
     // Open in Image-J window
     if OpenImageJ and FileExists(ImageJPath) then
        begin
        if SaveAsMultipageTIFF then nFrames := 1
                               else nFrames := NumZSectionsAvailable ;
        for iPMT := 0 to NumPMTChannels-1 do
            for iSection := 0 to nFrames-1 do
                ShellExecute( Handle,
                      PChar('open'),
                      PChar('"'+ImageJPath+'"'),
                      PChar('"'+SectionFileName(FileName,iPMT,iSection)+'"'),
                      nil,
                      SW_SHOWNORMAL) ;
        end ;
     mestatus.Lines.Add('File saved') ;
     UnsavedRawImage := False ;
end;

function TMainFrm.SectionFileName(
         FileName : string ; // Base file name
         iChannel : Integer ;    // PMT #
         iSection : Integer  // Z section #
         ) : string ;
// ------------------------------------------
// Return file name to of Channel / Z section
// ------------------------------------------
begin
     if (NumZSectionsAvailable > 1) and (not SaveAsMultipageTIFF) then
        begin
        if ckKeepRepeats.Checked then
           begin
           // File ending = <section no.>.<repeat no.>.tif
           Result := ANSIReplaceText( FileName, '.tif',
                     format('.%s.%d.%d.ome.tif',
                                [ImageNames[iChannel],
                                 (iSection div Round(edNumRepeats.Value)) + 1,
                                 (iSection mod Round(edNumRepeats.Value)) + 1]));
           end
        else
           begin
           // File ending = <section no.>.tif
           Result := ANSIReplaceText( FileName, '.tif',
                     format('.%s.%d.ome.tif',[ImageNames[iChannel],iSection+1])) ;
           end;
        end
     else
        begin
        Result := ANSIReplaceText( FileName, '.tif',
                  format('.%s.ome.tif',[ImageNames[iChannel]])) ;
        end;
end;

procedure TMainFrm.edXPixelsKeyPress(Sender: TObject; var Key: Char);
// --------------------------
// No. of X pixels changed
// --------------------------
begin
     if Key = #13 then UpdateDisplay := True ;
     end;
procedure TMainFrm.edYPixelsKeyPress(Sender: TObject; var Key: Char);
begin
     if Key = #13 then UpdateDisplay := True ;
     end;

procedure TMainFrm.FormResize(Sender: TObject);
// ---------------------------------
// Resize controls when form resized
// ---------------------------------
begin
  ImageGrp.Width := Max(ClientWidth - ImageGrp.Left - 5,2) ;
  ImageGrp.Height := Max(ClientHeight - ImageGrp.Top - 5,2) ;
  DisplayMaxWidth := ImageGrp.ClientWidth - Image0.Left - 5 ;
  DisplayMaxHeight := ImageGrp.ClientHeight - Image0.Top - 5 - ZSectionPanel.Height ;
  if PanelPMT3.Visible then PMTGrp.ClientHeight := PanelPMT3.Top + PanelPMT3.Height + 5
  else if PanelPMT2.Visible then PMTGrp.ClientHeight := PanelPMT2.Top + PanelPMT2.Height + 5
  else if PanelPMT1.Visible then PMTGrp.ClientHeight := PanelPMT1.Top + PanelPMT1.Height + 5
  else PMTGrp.ClientHeight := PanelPMT0.Top + PanelPMT0.Height + 5 ;
  LaserGrp.Top := PMTGrp.Top + PMTGrp.Height + 5 ;
  DisplayGrp.Top := LaserGrp.Top + LaserGrp.Height + 5 ;
  StatusGrp.Top := DisplayGrp.Top + DisplayGrp.Height + 5 ;
  SetImagePanels ;
  UpdateDisplay := True ;
  end;

procedure TMainFrm.rbFastScanClick(Sender: TObject);
// ------------------
// Fast scan selected
// ------------------
begin
     rbHRScan.Checked := False ;
     end;
procedure TMainFrm.rbHRScanClick(Sender: TObject);
// ----------------------
// Hi res. scan selected
// ----------------------
begin
     rbFastScan.Checked := False ;
     ckRepeat.Checked := False ;
     end;

procedure TMainFrm.rbImageHistogramClick(Sender: TObject);
begin
LastLineAddedtoHistogram := 1 ;
end;

procedure TMainFrm.scZSectionChange(Sender: TObject);
// ---------------
// Z Section changed
// ---------------
begin
     if not bStopScan.Enabled then
        begin
        ZSection := scZSection.Position ;
        LoadRawImage( RawImagesFileName, ZSection ) ;
        UpdateDisplay := True ;
        end;
     end;

procedure TMainFrm.tbLaserIntensityChange(Sender: TObject);
// --------------------------------------------
// Laser intensity track bar position changed
// --------------------------------------------
begin
     edLaserIntensity.Value := tbLaserIntensity.Position*0.1 ;
     tbLaserIntensity.Position := Round(10.*edLaserIntensity.Value) ;
  //   Laser.Intensity := edLaserIntensity.Value ;
     UpdateDisplay := True ;
     end;

procedure TMainFrm.tbZPositionChange(Sender: TObject);
// ------------------------------------
// Change to Z stage track bar position
// ------------------------------------
begin
    NewZStageTrackbarPosition := True ;
end;

procedure TMainFrm.SaveRawImage(
          FileName : String ;    // File to save to
          iSection : Integer    // Image Section number
          ) ;
// ----------------------
// Save raw image to file
// ----------------------
var
    FileHandle : THandle ;
    FilePointer,DataPointer,NumBytesPerImage : Int64 ;
    i,ch,NumPixels : Integer ;
    Buf16 : PBig16bitArray ;
begin
      // Copy into I/O buf
      NumPixels := FrameWidth*FrameHeight ;
      NumBytesPerImage := NumPixels*2 ;
      Buf16 := AllocMem( NumBytesPerImage ) ;

      if not FileExists(FileName) then FileHandle := FileCreate( FileName )
                                  else FileHandle := FileOpen( FileName, fmOpenWrite ) ;
      NumZSectionsAvailable := Max(NumZSectionsAvailable,iSection+1) ;
      scZSection.Max := NumZSectionsAvailable -1 ;
      scZSection.Position := iSection ;
      lbZSection.Caption := Format('Section %d/%d',[iSection+1,NumZSectionsAvailable]);
      FilePointer := FileSeek( FileHandle, 0, 0 ) ;
      FileWrite( FileHandle, NumZSectionsAvailable, Sizeof(NumZSectionsAvailable)) ;
      FileWrite( FileHandle, NumPMTChannels, SizeOf(NumPMTChannels)) ;
      FileWrite( FileHandle, FrameWidth, Sizeof(FrameWidth)) ;
      FileWrite( FileHandle, FrameHeight, Sizeof(FrameHeight)) ;
      FileWrite( FileHandle, iScanZoom, Sizeof(iScanZoom)) ;
      FileWrite( FileHandle, ScanArea, Sizeof(ScanArea)) ;
      FileWrite( FileHandle, ZStepSize, Sizeof(ZStepSize)) ;
      DataPointer := FileSeek( FileHandle, 0, 1 ) ;
      for ch := 0 to NumPMTChannels-1 do
          begin
          FilePointer := DataPointer +
                         Int64(iSection*NumPMTChannels + ch)*NumBytesPerImage ;
          FileSeek( FileHandle, FilePointer, 0 ) ;
          for i := 0 to NumPixels-1 do Buf16^[i] := Max(PImageBuf[ch]^[i],0) ;
          FileWrite( FileHandle, Buf16^, NumBytesPerImage) ;
          end;
      FileClose(FileHandle) ;
      FreeMem(Buf16) ;
      // Set unsaved flag if image is high res.
      UnsavedRawImage := rbHRScan.Checked ;
      end;

procedure TMainFrm.LoadRawImage(
          FileName : String ;    // File to save to
          iSection : Integer     // Image Section number
          ) ;
// ----------------------
// Load raw image to file
// ----------------------
var
    FileHandle : THandle ;
    FilePointer,DataPointer,NumBytesPerImage : Int64 ;
    i,ch,NumPixels : Integer ;
    Buf16 : PBig16bitArray ;
begin
      FileHandle := FileOpen( FileName, fmOpenRead ) ;
      FilePointer := FileSeek( FileHandle, 0, 0 ) ;
      FileRead( FileHandle, NumZSectionsAvailable, Sizeof(NumZSectionsAvailable)) ;
      FileRead( FileHandle, NumPMTChannels, SizeOf(NumPMTChannels)) ;
      FileRead( FileHandle, FrameWidth, Sizeof(FrameWidth)) ;
      FileRead( FileHandle, FrameHeight, Sizeof(FrameHeight)) ;
      FileRead( FileHandle, iScanZoom, Sizeof(iScanZoom)) ;
      FileRead( FileHandle, ScanArea, Sizeof(ScanArea)) ;
      FileRead( FileHandle, ZStepSize, Sizeof(ZStepSize)) ;
      DataPointer := FileSeek( FileHandle, 0, 1 ) ;
      NumPixels := FrameWidth*FrameHeight ;
      NumBytesPerImage := NumPixels*2 ;
      Buf16 := AllocMem( NumBytesPerImage ) ;
      // (re)allocate full field buffer
      for ch := 0 to NumPMTChannels-1 do
          begin
          if PImageBuf[ch] <> Nil then FreeMem(PImageBuf[ch]);
          PImageBuf[ch] := AllocMem( NumPixels*SizeOf(Integer) ) ;
          end;
      for ch := 0 to NumPMTChannels-1 do
          begin
          FilePointer := DataPointer +
                         Int64(iSection*NumPMTChannels + ch)*NumBytesPerImage ;
          FileSeek( FileHandle, FilePointer, 0 ) ;
          FileRead( FileHandle, Buf16^, NumBytesPerImage) ;
          for i := 0 to NumPixels-1 do PImageBuf[ch]^[i] := Buf16^[i] ;
          end;
      FileClose(FileHandle) ;
      FreeMem(Buf16) ;
      end;

procedure TMainFrm.SaveSettingsToXMLFile(
           FileName : String
           ) ;
// ------------------------------------------
// Save settings to XML file (public method)
// ------------------------------------------
begin
    CoInitialize(Nil) ;
    SaveSettingsToXMLFile1( FileName ) ;
    CoUnInitialize ;
    end ;

procedure  TMainFrm.SaveSettingsToXMLFile1(
           FileName : String
           ) ;
// ----------------------------------
// Save stimulus protocol to XML file
// ----------------------------------
var
   iNode,ProtNode : IXMLNode;
   s : TStringList ;
   XMLDoc : IXMLDocument ;
   ch : Integer ;
begin
    if FileName = '' then Exit ;
    XMLDoc := TXMLDocument.Create(Self);
    XMLDoc.Active := True ;
    // Clear document
    XMLDoc.ChildNodes.Clear ;
    // Add record name
    ProtNode := XMLDoc.AddChild( 'MESOSCANSETTINGS' ) ;
    AddElementInt( ProtNode, 'FASTFRAMEWIDTH', FastFrameWidth ) ;
    AddElementInt( ProtNode, 'FASTFRAMEHEIGHT', FastFrameHeight ) ;
    AddElementInt( ProtNode, 'HRFRAMEWIDTH', HRFrameWidth ) ;
    AddElementBool( ProtNode, 'FASTBIDIRECTIONALSCAN', FastBiDirectionalScan ) ;

    AddElementInt( ProtNode, 'FOCUSMODEFRAMEWIDTH', FocusModeFrameWidth ) ;
    AddElementInt( ProtNode, 'FOCUSMODEFRAMEHEIGHT', FocusModeFrameHeight ) ;
    AddElementDouble( ProtNode, 'FOCUSMODEREGION', FocusModeRegion ) ;

    AddElementInt( ProtNode, 'LINESCANFRAMEHEIGHT', Round(edLineScanFrameHeight.Value) ) ;
    AddElementInt( ProtNode, 'PALETTE', cbPalette.ItemIndex ) ;
    AddElementBool( ProtNode, 'BIDIRECTIONALSCAN', BiDirectionalScan ) ;

    AddElementBool( ProtNode, 'CORRECTSINEWAVEDISTORTION', CorrectSineWaveDistortion ) ;
    AddElementBool( ProtNode, 'REPEATSCANS', ckRepeat.Checked ) ;
    AddElementBool( ProtNode, 'INVERTPMTSIGNAL', InvertPMTSignal ) ;
    AddElementDouble( ProtNode, 'MAXSCANRATE', MaxScanRate ) ;
    AddElementDouble( ProtNode, 'MINPIXELDWELLTIME', MinPixelDwellTime ) ;
    AddElementInt( ProtNode, 'NUMREPEATS', Round(edNumRepeats.Value) ) ;
    AddElementInt( ProtNode, 'BLACKLEVEL', BlackLevel ) ;
    // X/Y galvo control ports
    AddElementInt( ProtNode, 'XGALVOAO', XGalvoAO ) ;
    AddElementInt( ProtNode, 'YGALVOAO', YGalvoAO ) ;
    AddElementBool( ProtNode, 'XGALVOINVERT', XGalvoInvert ) ;
    AddElementBool( ProtNode, 'YGALVOINVERT', YGalvoInvert ) ;

    AddElementDouble( ProtNode, 'XVOLTSPERMICRON', XVoltsPerMicron ) ;
    AddElementDouble( ProtNode, 'YVOLTSPERMICRON', YVoltsPerMicron ) ;
    AddElementDouble( ProtNode, 'PHASESHIFT', PhaseShift ) ;
    AddElementDouble( ProtNode, 'LASERINTENSITY', LaserIntensity ) ;
    AddElementDouble( ProtNode, 'FULLFIELDWIDTHMICRONS', FullFieldWidthMicrons ) ;
    AddElementDouble( ProtNode, 'FIELDEDGE', FieldEdge ) ;
    // Z stack
    iNode := ProtNode.AddChild( 'ZSTACK' ) ;
    AddElementInt( iNode, 'NUMZSECTIONS', Round(edNumZSteps.Value) ) ;
    AddElementDouble( iNode, 'NUMPIXELSPERZSTEP', edNumPixelsPerZStep.Value ) ;
    // Laser control
    iNode := ProtNode.AddChild( 'LASER' ) ;
//    AddElementInt( iNode, 'SHUTTERCONTROLLINE', Laser.ShutterControlLine ) ;
//    AddElementDouble( iNode, 'SHUTTERCHANGETIME', Laser.ShutterChangeTime ) ;
//    AddElementInt( iNode, 'INTENSITYCONTROLLINE', Laser.IntensityControlLine ) ;
//    AddElementDouble( iNode, 'VMAXINTENSITY', Laser.VMaxIntensity ) ;
    AddElementInt( iNode, 'COMPORT', Laser.ControlPort ) ;
    // PMT settings
    AddElementInt( ProtNode, 'NUMPMTS', NumPMTs ) ;
    iNode := ProtNode.AddChild( 'PMT' ) ;
    AddElementBool( iNode, 'ENABLED0', ckEnablePMT0.Checked ) ;
    AddElementBool( iNode, 'ENABLED1', ckEnablePMT1.Checked ) ;
    AddElementBool( iNode, 'ENABLED2', ckEnablePMT2.Checked ) ;
    AddElementBool( iNode, 'ENABLED3', ckEnablePMT3.Checked ) ;
    AddElementINT( iNode, 'GAININDEX0', cbPMTGain0.ItemIndex ) ;
    AddElementINT( iNode, 'GAININDEX1', cbPMTGain1.ItemIndex ) ;
    AddElementINT( iNode, 'GAININDEX2', cbPMTGain2.ItemIndex ) ;
    AddElementINT( iNode, 'GAININDEX3', cbPMTGain3.ItemIndex ) ;
    AddElementDouble( iNode, 'VOLTS0', edPMTVolts0.Value ) ;
    AddElementDouble( iNode, 'VOLTS1', edPMTVolts1.Value ) ;
    AddElementDouble( iNode, 'VOLTS2', edPMTVolts2.Value ) ;
    AddElementDouble( iNode, 'VOLTS3', edPMTVolts3.Value ) ;
    AddElementINT( iNode, 'PMTCOLOR0', Integer(gpPMTColor0.Color) ) ;
    AddElementINT( iNode, 'PMTCOLOR1', Integer(gpPMTColor1.Color) ) ;
    AddElementINT( iNode, 'PMTCOLOR2', Integer(gpPMTColor2.Color) ) ;
    AddElementINT( iNode, 'PMTCOLOR3', Integer(gpPMTColor3.Color) ) ;

    for ch := 0 to High(PMTControls) do
        begin
        AddElementINT( iNode, format('CONTROL%d',[ch]), PMTControls[ch] ) ;
        AddElementBool( iNode, format('INVERTSIGNAL%d',[ch]), PMTInvertSignal[ch] ) ;
        end ;

    AddElementDouble( iNode, 'MAXVOLTS', PMTMaxVolts ) ;
    // Z stage
    iNode := ProtNode.AddChild( 'ZSTAGE' ) ;
    AddElementInt( iNode, 'STAGETYPE', ZStage.StageType ) ;
    AddElementInt( iNode, 'CONTROLPORT', ZStage.ControlPort ) ;
    AddElementInt( iNode, 'BAUDRATE', ZStage.BaudRate ) ;
    AddElementDouble( iNode, 'ZSCALEFACTOR', ZStage.ZScaleFactor ) ;
    AddElementDouble( iNode, 'ZSTEPTIME', ZStage.ZStepTime ) ;
    AddElementDouble( iNode, 'ZPOSITIONMAX', ZStage.ZPositionMax ) ;
    AddElementDouble( iNode, 'ZPOSITIONMIN', ZStage.ZPositionMin ) ;
    AddElementInt( iNode, 'STAGEPROTECTIONTTLTRIGGER', ZStage.StageProtectionTTLTrigger ) ;
    AddElementInt( iNode, 'ZSTAGEZDIALADCINPUTS', ZStage.ZDialADCInputs ) ;
    AddElementDouble( iNode, 'ZSTAGEZDIALMICRONSPERSTEPCOARSE', ZStage.ZDialMicronsPerStepCoarse ) ;
    AddElementDouble( iNode, 'ZSTAGEZDIALMICRONSPERSTEPMEDIUM', ZStage.ZDialMicronsPerStepMedium ) ;
    AddElementDouble( iNode, 'ZSTAGEZDIALMICRONSPERSTEPFINE', ZStage.ZDialMicronsPerStepFine ) ;

    AddElementText( ProtNode, 'SAVEDIRECTORY', SaveDirectory ) ;
    AddElementText( ProtNode, 'IMAGEJPATH', ImageJPath ) ;
    AddElementBool( ProtNode, 'SAVEASMULTIPAGETIFF', SaveAsMultipageTIFF ) ;
    AddElementText( ProtNode, 'RAWIMAGESDIRECTORY', RawImagesDirectory ) ;
     s := TStringList.Create;
     s.Assign(xmlDoc.XML) ;
     //sl.Insert(0,'<!DOCTYPE ns:mys SYSTEM "myXML.dtd">') ;
     s.Insert(0,'<?xml version="1.0"?>') ;
     s.SaveToFile( FileName ) ;
     s.Free ;
     XMLDoc.Active := False ;
     XMLDoc := Nil ;
    end ;

procedure TMainFrm.SavetoImageJ1Click(Sender: TObject);
// ------------------------------------------------
// Save current image to file and open with Image-J
// ------------------------------------------------
begin
    SaveImage(True);
end;
procedure TMainFrm.LoadSettingsFromXMLFile(
          FileName : String                    // XML protocol file
          ) ;
// ----------------------------------
// Load settings from XML file
// ----------------------------------
begin
    CoInitialize(Nil) ;
    LoadSettingsFromXMLFile1( FileName ) ;
    CoUnInitialize ;
    end ;

procedure TMainFrm.LoadSettingsFromXMLFile1(
          FileName : String                    // XML protocol file
          ) ;
// ----------------------------------
// Load settings from XML file
// ----------------------------------
var
   iNode,ProtNode : IXMLNode;
   ch,NodeIndex : Integer ;
   XMLDoc : IXMLDocument ;
begin
    if not FileExists(FileName) then Exit ;
    XMLDoc := TXMLDocument.Create(Self) ;
    XMLDOC.Active := False ;
    XMLDOC.LoadFromFile( FileName ) ;
    XMLDoc.Active := True ;
    ProtNode := xmldoc.DocumentElement ;
    FastFrameWidth := GetElementInt( ProtNode, 'FASTFRAMEWIDTH', FastFrameWidth ) ;
    FastFrameWidth := Min(Max(FastFrameWidth,MinFrameWidth),MaxFrameWidth) ;
    FastFrameHeight := GetElementInt( ProtNode, 'FASTFRAMEHEIGHT', FastFrameHeight ) ;
    FastFrameHeight := Min(Max(FastFrameHeight,MinFrameHeight),MaxFrameHeight) ;
    FastBiDirectionalScan := GetElementBool( ProtNode, 'FASTBIDIRECTIONALSCAN', FastBiDirectionalScan ) ;

    HRFrameWidth := GetElementInt( ProtNode, 'HRFRAMEWIDTH', HRFrameWidth ) ;
    HRFrameWidth := Min(Max(HRFrameWidth,MinFrameWidth),MaxFrameWidth) ;

    FocusModeFrameWidth := GetElementInt( ProtNode, 'FOCUSMODEFRAMEWIDTH', FocusModeFrameWidth ) ;
    FocusModeFrameHeight := GetElementInt( ProtNode, 'FOCUSMODEFRAMEHEIGHT', FocusModeFrameHeight ) ;
    FocusModeRegion := GetElementDouble( ProtNode, 'FOCUSMODEREGION', FocusModeRegion ) ;

    edLineScanFrameHeight.Value := GetElementInt( ProtNode, 'LINESCANFRAMEHEIGHT',
                                                  Round(edLineScanFrameHeight.Value) ) ;
    cbPalette.ItemIndex := GetElementInt( ProtNode, 'PALETTE', cbPalette.ItemIndex ) ;
    PaletteType := TPaletteType(cbPalette.Items.Objects[cbPalette.ItemIndex]) ;
    for ch  := 0 to High(Bitmap) do
       if BitMap[ch] <> Nil then SetPalette( BitMap[ch], PaletteType ) ;
    BiDirectionalScan := GetElementBool( ProtNode, 'BIDIRECTIONALSCAN', BiDirectionalScan ) ;
    CorrectSineWaveDistortion := GetElementBool( ProtNode, 'CORRECTSINEWAVEDISTORTION', CorrectSineWaveDistortion ) ;
    ckRepeat.Checked := GetElementBool( ProtNode, 'REPEATSCANS', ckRepeat.Checked ) ;
    InvertPMTSignal := GetElementBool( ProtNode, 'INVERTPMTSIGNAL', InvertPMTSignal ) ;
    MaxScanRate := GetElementDouble( ProtNode, 'MAXSCANRATE', MaxScanRate ) ;
    MinPixelDwellTime := GetElementDouble( ProtNode, 'MINPIXELDWELLTIME', MinPixelDwellTime ) ;
    edNumRepeats.Value := GetElementInt( ProtNode, 'NUMREPEATS', Round(edNumRepeats.Value) ) ;
    BlackLevel := GetElementInt( ProtNode, 'BLACKLEVEL', BlackLevel ) ;
    // X/Y galvo control ports
    XGalvoAO := GetElementInt( ProtNode, 'XGALVOAO', XGalvoAO ) ;
    YGalvoAO := GetElementInt( ProtNode, 'YGALVOAO', YGalvoAO ) ;
    XGalvoInvert := GetElementBool( ProtNode, 'XGALVOINVERT', XGalvoInvert ) ;
    YGalvoInvert := GetElementBool( ProtNode, 'YGALVOINVERT', YGalvoInvert ) ;
    XVoltsPerMicron := GetElementDouble( ProtNode, 'XVOLTSPERMICRON', XVoltsPerMicron ) ;
    YVoltsPerMicron := GetElementDouble( ProtNode, 'YVOLTSPERMICRON', YVoltsPerMicron ) ;
    PhaseShift := GetElementDouble( ProtNode, 'PHASESHIFT', PhaseShift ) ;
    LaserIntensity := GetElementDouble( ProtNode, 'LASERINTENSITY', LaserIntensity ) ;
    FullFieldWidthMicrons := GetElementDouble( ProtNode, 'FULLFIELDWIDTHMICRONS', FullFieldWidthMicrons ) ;
    FieldEdge := GetElementDouble( ProtNode, 'FIELDEDGE', FieldEdge ) ;
    // Z stage
    NodeIndex := 0 ;
    While FindXMLNode(ProtNode,'ZSTACK',iNode,NodeIndex) do
       begin
       edNumZSteps.Value := GetElementInt( iNode, 'NUMZSECTIONS', Round(edNumZSteps.Value) ) ;
       edNumPixelsPerZStep.Value := GetElementDouble( iNode, 'NUMPIXELSPERZSTEP', edNumPixelsPerZStep.Value ) ;
       Inc(NodeIndex) ;
       end ;
    // PMT settings
    NumPMTs := GetElementInt( ProtNode, 'NUMPMTS', NumPMTs ) ;
    NodeIndex := 0 ;
    While FindXMLNode(ProtNode,'PMT',iNode,NodeIndex) do
          begin
          ckEnablePMT0.Checked := GetElementBool( iNode, 'ENABLED0', ckEnablePMT0.Checked ) ;
          ckEnablePMT1.Checked := GetElementBool( iNode, 'ENABLED1', ckEnablePMT1.Checked ) ;
          ckEnablePMT2.Checked := GetElementBool( iNode, 'ENABLED2', ckEnablePMT2.Checked ) ;
          ckEnablePMT3.Checked := GetElementBool( iNode, 'ENABLED3', ckEnablePMT3.Checked ) ;

          cbPMTGain0.ItemIndex := Min(Max( GetElementINT( iNode, 'GAININDEX0', cbPMTGain0.ItemIndex ),0),cbPMTGain0.Items.Count-1) ;
          cbPMTGain1.ItemIndex := Min(Max(GetElementINT( iNode, 'GAININDEX1', cbPMTGain1.ItemIndex ),0),cbPMTGain1.Items.Count-1) ;
          cbPMTGain2.ItemIndex := Min(Max(GetElementINT( iNode, 'GAININDEX2', cbPMTGain2.ItemIndex ), 0),cbPMTGain2.Items.Count-1) ;
          cbPMTGain3.ItemIndex := Min(Max(GetElementINT( iNode, 'GAININDEX3', cbPMTGain3.ItemIndex ), 0),cbPMTGain3.Items.Count-1) ;

          edPMTVolts0.Value := GetElementDouble( iNode, 'VOLTS0', edPMTVolts0.Value ) ;
          edPMTVolts1.Value := GetElementDouble( iNode, 'VOLTS1', edPMTVolts1.Value ) ;
          edPMTVolts2.Value := GetElementDouble( iNode, 'VOLTS2', edPMTVolts2.Value ) ;
          edPMTVolts3.Value := GetElementDouble( iNode, 'VOLTS3', edPMTVolts3.Value ) ;

          gpPMTColor0.Color := TColor( GetElementINT( iNode, 'PMTCOLOR0', Integer(gpPMTColor0.Color) ) );
          gpPMTColor1.Color := TColor( GetElementINT( iNode, 'PMTCOLOR1', Integer(gpPMTColor1.Color) ) );
          gpPMTColor2.Color := TColor( GetElementINT( iNode, 'PMTCOLOR2', Integer(gpPMTColor2.Color) ) );
          gpPMTColor3.Color := TColor( GetElementINT( iNode, 'PMTCOLOR3', Integer(gpPMTColor3.Color) ) );

          for ch := 0 to High(PMTControls) do
              begin
              PMTControls[ch] := GetElementINT( iNode, format('CONTROL%d',[ch]),PMTControls[ch] ) ;
              PMTInvertSignal[ch] := GetElementBool( iNode, format('INVERTSIGNAL%d',[ch]), PMTInvertSignal[ch] ) ;
              end ;

          PMTMaxVolts := GetElementDouble( iNode, 'MAXVOLTS', PMTMaxVolts ) ;
          Inc(NodeIndex) ;
          end ;

    // Laser control
    NodeIndex := 0 ;
    While FindXMLNode(ProtNode,'LASER',iNode,NodeIndex) do
        begin
//        Laser.ShutterControlLine := GetElementInt( iNode, 'SHUTTERCONTROLLINE', Laser.ShutterControlLine ) ;
//        Laser.ShutterChangeTime := GetElementDouble( iNode, 'SHUTTERCHANGETIME', Laser.ShutterChangeTime ) ;
//        Laser.IntensityControlLine := GetElementInt( iNode, 'INTENSITYCONTROLLINE', Laser.IntensityControlLine ) ;
//        Laser.VMaxIntensity := GetElementDouble( iNode, 'VMAXINTENSITY', Laser.VMaxIntensity ) ;
        Laser.ControlPort := GetElementInt( iNode, 'COMPORT', Laser.ControlPort ) ;
        Inc(NodeIndex) ;
        end ;
    // Z stage
    NodeIndex := 0 ;
    While FindXMLNode(ProtNode,'ZSTAGE',iNode,NodeIndex) do
      begin
      ZStage.StageType := GetElementInt( iNode, 'STAGETYPE', ZStage.StageType ) ;
      ZStage.ControlPort := GetElementInt( iNode, 'CONTROLPORT', ZStage.ControlPort ) ;
      ZStage.BaudRate := GetElementInt( iNode, 'BAUDRATE', ZStage.BaudRate ) ;
      ZStage.ZScaleFactor := GetElementDouble( iNode, 'ZSCALEFACTOR', ZStage.ZScaleFactor ) ;
      ZStage.ZStepTime := GetElementDouble( iNode, 'ZSTEPTIME', ZStage.ZStepTime ) ;
      ZStage.ZPositionMax := GetElementDouble( iNode, 'ZPOSITIONMAX', ZStage.ZPositionMax ) ;
      ZStage.ZPositionMin := GetElementDouble( iNode, 'ZPOSITIONMIN', ZStage.ZPositionMin ) ;
      ZStage.StageProtectionTTLTrigger := GetElementInt( iNode, 'STAGEPROTECTIONTTLTRIGGER', ZStage.StageProtectionTTLTrigger ) ;
      ZStage.ZDialADCInputs := GetElementInt( iNode, 'ZSTAGEZDIALADCINPUTS', ZStage.ZDialADCInputs ) ;
      ZStage.ZDialMicronsPerStepCoarse := GetElementDouble( iNode, 'ZSTAGEZDIALMICRONSPERSTEPCOARSE', ZStage.ZDialMicronsPerStepCoarse ) ;
      ZStage.ZDialMicronsPerStepMedium := GetElementDouble( iNode, 'ZSTAGEZDIALMICRONSPERSTEPMEDIUM', ZStage.ZDialMicronsPerStepMedium ) ;
      ZStage.ZDialMicronsPerStepFine := GetElementDouble( iNode, 'ZSTAGEZDIALMICRONSPERSTEPFINE', ZStage.ZDialMicronsPerStepFine ) ;
      Inc(NodeIndex) ;
      end ;
    edGotoZPosition.HiLimit := ZStage.ZPositionMax ;
    edGotoZPosition.LoLimit := ZStage.ZPositionMin ;
    tbZPosition.Max := Round(ZStage.ZPositionMax) ;
    tbZPosition.Min := Round(ZStage.ZPositionMin) ;
    SaveDirectory := GetElementText( ProtNode, 'SAVEDIRECTORY', SaveDirectory ) ;
    ImageJPath := GetElementText( ProtNode, 'IMAGEJPATH', ImageJPath ) ;
    SaveAsMultipageTIFF := GetElementBool( ProtNode, 'SAVEASMULTIPAGETIFF', SaveAsMultipageTIFF ) ;
    RawImagesDirectory := GetElementText( ProtNode, 'RAWIMAGESDIRECTORY', RawImagesDirectory ) ;
    XMLDoc.Active := False ;
    XMLDoc := Nil ;
    end ;

procedure TMainFrm.UpdatePMTSettings ;
// ---------------------------
// Enable/disable PMT controls
// ---------------------------
var
  ch : Integer ;
begin
  // Ensure at least one PMT is selected
  if (not ckEnablePMT0.Checked) and (not ckEnablePMT1.Checked) and
     (not ckEnablePMT2.Checked) and (not ckEnablePMT3.Checked) then ckEnablePMT0.Checked := True ;
  if NumPMTs <= 3 then PanelPMT3.Visible := false
                  else PanelPMT3.Visible := true ;
  if NumPMTs <= 2 then PanelPMT2.Visible := false
                  else PanelPMT2.Visible := true ;
  if NumPMTs <= 1 then PanelPMT1.Visible := false
                  else PanelPMT1.Visible := true ;
  PanelPMT0.Visible := True ;
  if not PanelPMT0.Visible then ckEnablePMT0.Checked := false ;
  if not PanelPMT1.Visible then ckEnablePMT1.Checked := false ;
  if not PanelPMT2.Visible then ckEnablePMT2.Checked := false ;
  if not PanelPMT3.Visible then ckEnablePMT3.Checked := false ;
  cbPMTGain0.Enabled := ckEnablePMT0.Checked ;
  edPMTVolts0.Enabled := ckEnablePMT0.Checked ;
  udPMTVolts0.Enabled := ckEnablePMT0.Checked ;
  cbPMTGain1.Enabled := ckEnablePMT1.Checked ;
  edPMTVolts1.Enabled := ckEnablePMT1.Checked ;
  udPMTVolts1.Enabled := ckEnablePMT1.Checked ;
  cbPMTGain2.Enabled := ckEnablePMT2.Checked ;
  edPMTVolts2.Enabled := ckEnablePMT2.Checked ;
  udPMTVolts2.Enabled := ckEnablePMT2.Checked ;
  cbPMTGain3.Enabled := ckEnablePMT3.Checked ;
  edPMTVolts3.Enabled := ckEnablePMT3.Checked ;
  udPMTVolts3.Enabled := ckEnablePMT3.Checked ;
  NumPMTChannels := 0 ;
  for ch := 0 to High(ImageNames) do ImageNames[ch] := '' ;
  if ckEnablePMT0.Checked and PanelPMT0.Visible then
     begin
     ImageNames[NumPMTChannels] := 'PMT0' ;
     ImageColors[NumPMTChannels] := gpPMTColor0.Color ;
     Inc(NumPMTChannels) ;
     end;
  if ckEnablePMT1.Checked and PanelPMT1.Visible then
     begin
     ImageNames[NumPMTChannels] := 'PMT1' ;
     ImageColors[NumPMTChannels] := gpPMTColor1.Color ;
     Inc(NumPMTChannels) ;
     end;
  if ckEnablePMT2.Checked and PanelPMT2.Visible then
     begin
     ImageNames[NumPMTChannels] := 'PMT2' ;
     ImageColors[NumPMTChannels] := gpPMTColor2.Color ;
     Inc(NumPMTChannels) ;
     end;
  if ckEnablePMT3.Checked and PanelPMT3.Visible then
     begin
     ImageNames[NumPMTChannels] := 'PMT3' ;
     ImageColors[NumPMTChannels] := gpPMTColor3.Color ;
     Inc(NumPMTChannels) ;
     end;
   TabImage0.Caption := ImageNames[0] ;
   TabImage1.Caption := ImageNames[1] ;
   TabImage2.Caption := ImageNames[2] ;
   TabImage3.Caption := ImageNames[3] ;
   if TabImage0.Caption <> '' then
      begin
      TabImage0.TabVisible := True ;
      TabImage0.Visible := True ;
      TabImage0.Enabled := True ;
      end
   else
      begin
      TabImage0.TabVisible := false ;
      TabImage0.Visible := False ;
      TabImage0.Enabled := False ;
      end;
   if TabImage1.Caption <> '' then
      begin
      TabImage1.TabVisible := True ;
      TabImage1.Visible := True ;
      TabImage1.Enabled := True ;
      end
   else
      begin
      TabImage1.TabVisible := false ;
      TabImage1.Visible := False ;
      TabImage1.Enabled := False ;
      end;
   if TabImage2.Caption <> '' then
      begin
      TabImage2.TabVisible := True ;
      TabImage2.Visible := True ;
      TabImage2.Enabled := True ;
      end
   else
      begin
      TabImage2.TabVisible := false ;
      TabImage2.Visible := False ;
      TabImage2.Enabled := False ;
      end;
   if TabImage3.Caption <> '' then
      begin
      TabImage3.TabVisible := True ;
      TabImage3.Visible := True ;
      TabImage3.Enabled := True ;
      end
   else
      begin
      TabImage3.TabVisible := false ;
      TabImage3.Visible := False ;
      TabImage3.Enabled := False ;
      end;
  ImagePage.ActivePage := TabImage2 ;
  ImagePage.ActivePage := TabImage0 ;
  end;

procedure TMainFrm.FormDestroy(Sender: TObject);
// ------------------------------
// Tidy up when form is destroyed
// ------------------------------
var
    ch : Integer ;
begin
     for ch := 0 to High(BitMap) do if BitMap[ch] <> Nil then
         begin
         Bitmap[ch].ReleasePalette ;
         BitMap[ch].Free ;
         BitMap[ch] := Nil ;
         end;
     end;

procedure TMainFrm.AddElementDouble(
          ParentNode : IXMLNode ;
          NodeName : String ;
          Value : Double
          ) ;
// -------------------------------
// Add element with value to node
// -------------------------------
var
   ChildNode : IXMLNode;
begin
    ChildNode := ParentNode.AddChild( NodeName ) ;
    ChildNode.Text := format('%.10g',[Value]) ;
    end ;

function TMainFrm.GetElementDouble(
         ParentNode : IXMLNode ;
         NodeName : String ;
         Value : Double
          ) : Double ;
// ---------------------
// Get value of element
// ---------------------
var
   ChildNode : IXMLNode;
   OldValue : Single ;
   NodeIndex : Integer ;
   s : string ;
begin
    Result := Value ;
    OldValue := Value ;
    NodeIndex := 0 ;
    if FindXMLNode(ParentNode,NodeName,ChildNode,NodeIndex) then
       begin
       { Correct for use of comma/period as decimal separator }
       s := ChildNode.Text ;
       if (FormatSettings.DECIMALSEPARATOR = '.') then s := ANSIReplaceText(s , ',',FormatSettings.DECIMALSEPARATOR);
       if (FormatSettings.DECIMALSEPARATOR = ',') then s := ANSIReplaceText( s, '.',FormatSettings.DECIMALSEPARATOR);
       try
          Result := StrToFloat(s) ;
       except
          Result := OldValue ;
          end ;
       end ;
    end ;

procedure TMainFrm.AddElementInt(
          ParentNode : IXMLNode ;
          NodeName : String ;
          Value : Integer
          ) ;
// -------------------------------
// Add element with value to node
// -------------------------------
var
   ChildNode : IXMLNode;
begin
    ChildNode := ParentNode.AddChild( NodeName ) ;
    ChildNode.Text := format('%d',[Value]) ;
    end ;

function TMainFrm.GetElementInt(
          ParentNode : IXMLNode ;
          NodeName : String ;
          Value : Integer
          ) : Integer ;
// ---------------------
// Get value of element
// ---------------------
var
   ChildNode : IXMLNode;
   NodeIndex : Integer ;
   OldValue : Integer ;
begin
    Result := Value ;
    OldValue := Value ;
    NodeIndex := 0 ;
    if FindXMLNode(ParentNode,NodeName,ChildNode,NodeIndex) then
       begin
       try
          Result := StrToInt(ChildNode.Text) ;
       except
          Result := OldValue ;
          end ;
       end ;
    end ;

procedure TMainFrm.AddElementBool(
          ParentNode : IXMLNode ;
          NodeName : String ;
          Value : Boolean
          ) ;
// -------------------------------
// Add element with value to node
// -------------------------------
var
   ChildNode : IXMLNode;
begin
    ChildNode := ParentNode.AddChild( NodeName ) ;
    if Value = True then ChildNode.Text := 'T'
                    else ChildNode.Text := 'F' ;
    end ;

function TMainFrm.GetElementBool(
          ParentNode : IXMLNode ;
          NodeName : String ;
          Value : Boolean
          ) : Boolean ;
// ---------------------
// Get value of element
// ---------------------
var
   ChildNode : IXMLNode;
   NodeIndex : Integer ;
begin
    Result := Value ;
    NodeIndex := 0 ;
    if FindXMLNode(ParentNode,NodeName,ChildNode,NodeIndex) then
       begin
       if ANSIContainsText(ChildNode.Text,'T') then Value := True
                                               else Value := False ;
       Result := Value ;
       end ;
    end ;

procedure TMainFrm.AddElementText(
          ParentNode : IXMLNode ;
          NodeName : String ;
          Value : String
          ) ;
// -------------------------------
// Add element with value to node
// -------------------------------
var
   ChildNode : IXMLNode;
begin
    ChildNode := ParentNode.AddChild( NodeName ) ;
    ChildNode.Text := Value ;
    end ;

function TMainFrm.GetElementText(
          ParentNode : IXMLNode ;
          NodeName : String ;
          Value : String
          ) : string ;
// ---------------------
// Get value of element
// ---------------------
var
   ChildNode : IXMLNode;
   NodeIndex : Integer ;
begin
    Result := Value ;
    NodeIndex := 0 ;
    if FindXMLNode(ParentNode,NodeName,ChildNode,NodeIndex) then
       begin
       Result := ChildNode.Text ;
       end ;
    end ;

function TMainFrm.FindXMLNode(
         const ParentNode : IXMLNode ;  // Node to be searched
         NodeName : String ;            // Element name to be found
         var ChildNode : IXMLNode ;     // Child Node of found element
         var NodeIndex : Integer        // ParentNode.ChildNodes Index #
                                        // Starting index on entry, found index on exit
         ) : Boolean ;
// -------------
// Find XML node
// -------------
var
    i : Integer ;
begin
    Result := False ;
    for i := NodeIndex to ParentNode.ChildNodes.Count-1 do
      begin
      if ParentNode.ChildNodes[i].NodeName = WideString(NodeName) then
         begin
         Result := True ;
         ChildNode := ParentNode.ChildNodes[i] ;
         NodeIndex := i ;
         Break ;
         end ;
      end ;
    end ;

procedure TMainFrm.PlotHistogram ;
// ---------------------------------------------------------
// Calculate and set display for maximum grey scale contrast
// ---------------------------------------------------------
const
    MaxPoints = 10000 ;
    HistogramNumBins = 200 ;
var
     i,j,ch,ix : Integer ;
     XLo,XMid,XHi: single ;
     MaxLine : Integer ;
  iLine: Integer;
begin
    //if not ScanningInProgress then exit ;
    ch := 0 ;
    if pImageBuf[ch] = Nil then Exit ;
    if ScanningInProgress then
       begin
       MaxLine := LinesAvailableForDisplay - 1
       end
    else
       begin
       MaxLine := FrameHeight - 1 ;
       LastLineAddedToHistogram := 1 ;
       end;
    if MaxLine < 0 then Exit ;
    if MaxLine >= FrameHeight then Exit ;
//    outputdebugstring(pchar(format('LinesAvailableForDisplay=%d',[MaxLine])));
    // Clear histogram (if in line histogram mode
    if rbLineHistogram.Checked then
       begin
       ClearHistogram ;
       LastLineAddedToHistogram := MaxLine ;
       end;
    for ch := 0 to NumPMTChannels-1 do
        begin
        for iLine := LastLineAddedToHistogram to MaxLine do
            begin
            // Fill bins
            j := iLine*FrameWidth ;
            for i := 0 to FrameWidth-1 do
                begin
                ix := Max(Min(pImageBuf[ch]^[j] div BinWidth,HistogramNumBins-1),0) ;
                Histogram[ch,ix] := Histogram[ch,ix] + 1.0 ;
                Inc(j) ;
                end;
            // Find max. bin value
            for i := 0 to HistogramNumBins-1 do
                begin
                if YMax < Histogram[ch,i] then YMax := Histogram[ch,i] ;
                end ;
            end ;
        end;
    LastLineAddedToHistogram := MaxLine ;
    if rbYAxisLog.Checked then
       begin
       // Logarithmic Y axis
       plHistogram.YAxisLaw := axLog ;
       plHistogram.yAxisMin := 1.0 ;
       plHistogram.yAxisMax := Max(YMax,1000.0);
       end
    else
       begin
       // Linear Y axis
       plHistogram.YAxisLaw := axLinear ;
       plHistogram.yAxisMin := 0.0 ;
       plHistogram.yAxisMax := YMax ;
       plHistogram.yAxisTick := YMax ;
       end;
    plHistogram.ClearPlot ;
    for ch := 0 to NumPMTChannels-1 do
        begin
        // Create Histogram plot
        plHistogram.CreateLine( ch, ImageColors[ch], msNone, psSolid ) ;
        XLo := 0.0 ;
       for i := 0 to HistogramNumBins-1 do
           begin
           XHi := XLo + BinWidth ;
           XMid := XLo + BinWidth*0.5 ;
           plHistogram.AddPoint( ch,XMid,Histogram[ch,i]) ;
           XLo := XLo + BinWidth ;
           end ;
        end ;
end ;

procedure TMainFrm.ClearHistogram ;
// -----------------------
// Clear bins in histogram
// -----------------------
var
    ch,i : Integer ;
begin
    for ch := 0 to NumPMTChannels-1 do
        begin
        for i := 0 to HistogramNumBins-1 do
            begin
            Histogram[ch,i] := 1.0 ;
            end;
        end;
    LastLineAddedToHistogram := 1 ;
    YMax := FrameWidth*0.1 ;
    if rbLineHistogram.Checked then YMax := YMax*FrameHeight*0.1 ;
    end;
procedure TMainFrm.CreateHistogramPlot ;
// ------------------------------
// Create plot of image histogram
// ------------------------------
begin
    BinWidth := (ADCMaxValue+1) div HistogramNumBins ;
    // Plot new Histogram }
    plHistogram.xAxisAutoRange := False ;
    plHistogram.xAxisMin := 0.0 ;
    plHistogram.xAxisMax := BinWidth*(HistogramNumBins+1) ;
    plHistogram.XAxisTick := plHistogram.xAxisMax ;
    plHistogram.XAxisLabel := '' ;
    plHistogram.yAxisAutoRange := False ;
    plHistogram.yAxisMin := 1.0 ;
    plHistogram.yAxisMax := FrameWidth ;
    plHistogram.yAxisTick := FrameWidth ;
    plHistogram.YAxisLabel := '' ;
    plHistogram.ClearVerticalCursors ;
    HistogramCursorLo := plHistogram.AddVerticalCursor( clGray, '|', 0 ) ;
    HistogramCursorHi := plHistogram.AddVerticalCursor( clGray, '|', 0 ) ;
    plHistogram.LinkVerticalCursors( HistogramCursorLo, HistogramCursorHi ) ;
    plHistogram.VerticalCursors[HistogramCursorLo] := GreyLo[ImagePage.activepageindex] ;
    plHistogram.VerticalCursors[HistogramCursorHi] := GreyHi[ImagePage.activepageindex] ;
    end ;

function TMainFrm.GetSpecialFolder(const ASpecialFolderID: Integer): string;
// --------------------------
// Get Windows special folder
// --------------------------
var
  vSpecialPath : array[0..MAX_PATH] of Char;
begin
    SHGetFolderPath( 0, ASpecialFolderID, 0,0,vSpecialPath) ;
    Result := StrPas(vSpecialPath);
    end;

procedure TMainFrm.gpPMTColor0Click(Sender: TObject);
// -----------------------
// PMT Colour box clicked
// -----------------------
begin
    ColorDialog.Execute ;
    TGroupBox(Sender).Color := ColorDialog.Color ;
end;
end.

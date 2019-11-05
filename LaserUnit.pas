unit LaserUnit;
// ========================================================================
// MesoScan: Laser control module
// (c) J.Dempster, Strathclyde Institute for Pharmacy & Biomedical Sciences
// ========================================================================
// 8.07.14

interface

uses
  System.SysUtils, System.Classes, Windows, FMX.Dialogs, math ;

const
    MaxLasers = 8 ;

type
  TLaser = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    FLaserType : Integer ;            // Type of laser unit
    FComPort : Integer ;              // Com port #
    FComHandle : THandle ;     // Com port handle
    FControlPort : DWord ;    // Control port number
    FComPortOpen : Boolean ;          // Com port open flag
    FBaudRate : DWord ;       // Com port baud rate
    FShutterOpen : Boolean ;
    FShutterChangeTime : Double ;

    Status : String ;         // Laser status report
    FControlState : Integer ;  // Laser control state
    FIntensityControlPort : Array[0..MaxLasers-1] of Integer ;      // Laser intensity control port
    FIntensity : Array[0..MaxLasers-1] of Double ;                  // Laser intensity
    FVMaxIntensity: Array[0..MaxLasers-1] of Double ;               // Voltage at 100% intensity
    FActiveControlPort : Array[0..MaxLasers-1] of Integer ;         // Laser on/off control port
    FLaserActive : Array[0..MaxLasers-1] of Boolean ;               // Laser On/Off status
    FName : Array[0..MaxLasers-1] of string ;                       // Laser name

    procedure SetCOMPort( Value : Integer ) ;
    procedure OpenCOMPort ;
    procedure CloseCOMPort ;
    procedure ResetCOMPort ;
    procedure SetLaserType( Value : Integer ) ;
    procedure SetControlPort( Value : DWord ) ;
    procedure SetBaudRate( Value : DWord ) ;
    procedure UpdateLasersExternal ;
    procedure SetIntensity(
              i : Integer ;
              Value : Double ) ;
    function GetVMaxIntensity(
             i : Integer
             ) :Double  ;
    procedure SetVMaxIntensity(
              i : Integer ;
              Value : Double ) ;
    function GetIntensity(
             i : Integer
             ) :Double  ;
    procedure SetLaserActive(
              i : Integer ;
              Value : Boolean ) ;
    function GetLaserActive(
             i : Integer
             ) : Boolean  ;
    procedure SetLaserName(
              i : Integer ;
              Value : string ) ;
    function GetLaserName(
             i : Integer
             ) : string  ;
    procedure SetIntensityControlPort(
              i : Integer ;
              Value : Integer ) ;
    function GetIntensityControlPort(
             i : Integer
             ) : Integer  ;
    procedure SetActiveControlPort(
              i : Integer ;
              Value : Integer ) ;
    function GetActiveControlPort(
             i : Integer
             ) : Integer  ;

  public
    { Public declarations }
    procedure GetLaserTypes( List : TStrings ) ;
    procedure GetActiveControlLines( List : TStrings ) ;
    procedure GetIntensityControlLines( List : TStrings ) ;
    procedure GetCOMPorts( List : TStrings ) ;
    procedure Open ;
    procedure Close ;
    procedure UpdateLasers ;
    Property LaserType : Integer read FLaserType write SetLaserType ;
    Property ControlPort : DWORD read FControlPort write SetControlPort ;
    Property BaudRate : DWORD read FBaudRate write SetBaudRate ;
    Property ShutterChangeTime : Double read FShutterChangeTime write FShutterChangeTime ;
    Property IntensityControlPort[Laser : Integer] : Integer read GetIntensityControlPort write SetIntensityControlPort ;
    Property ActiveControlPort[Laser : Integer] : Integer read GetActiveControlPort write SetActiveControlPort ;
    Property VMaxIntensity[i : Integer] : Double read GetVMaxIntensity write SetVMaxIntensity ;
    Property Intensity[i : Integer] : Double read GetIntensity write SetIntensity ;
    Property LaserActive[i : Integer] : Boolean read GetLaserActive write SetLaserActive ;
    Property LaserName[i : Integer] : String read GetLaserName write SetLaserName ;
  end;

var
  Laser: TLaser;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses LabIOUnit;

{$R *.dfm}
const
    lsNone = 0 ;
    lsExternal  = 1 ;
    lsOBIS = 2 ;

    csIdle = 0 ;

procedure TLaser.DataModuleCreate(Sender: TObject);
//
// Initialisation when module created
// ----------------------------------
var
    i : Integer ;
begin
  FLaserType := lsNone ;
  FCOMPort := 0 ;
  FShutterOpen := False ;
  FShutterChangeTime := 0.5 ;

  for i := 0 to MaxLasers-1 do
      begin
      FIntensity[i] := 0.0 ;
      FLaserActive[i] := False ;
      FName[i] := format('Laser %d.',[i]);
      FVMaxIntensity[i] := 5.0 ;
      end;
  end;

procedure TLaser.GetLaserTypes( List : TStrings ) ;
// ---------------------------------------
// Get list of supported laser controllers
// ---------------------------------------
begin
      List.Clear ;
      List.Add('None') ;
      List.Add('External Analogue/Digital') ;
      List.Add('Coherent OBIS') ;
      end;


procedure TLaser.GetActiveControlLines( List : TStrings ) ;
// -----------------------------------
// Get list of available control ports
// -----------------------------------
begin
     LabIO.GetPOPorts( List ) ;
     end ;


procedure TLaser.GetIntensityControlLines( List : TStrings ) ;
// -------------------------------------------
// Get list of available analogue output ports
// -------------------------------------------
begin
     LabIO.GetAOPorts( List ) ;
     end;


procedure TLaser.GetCOMPorts( List : TStrings ) ;
// -------------------------------
// Get list of available COM ports
// -------------------------------
var
    i : Integer ;
begin
     List.Clear ;
     List.Add('None') ;
     for i := 1 to 8 do
         begin
         List.Add(Format('COM%d',[i])) ;
         end;
     end ;


procedure TLaser.Open ;
// -----------------------------------
// Open laser controller for operation
// -----------------------------------
begin
    // Close COM port (if open)
    if FComPortOpen then CloseComPort ;

    // Open com port (if required)
    case FLaserType of
        lsOBIS :
          begin
          OpenComPort ;
          end ;
        end;
    end;

procedure TLaser.Close ;
// ---------------------------
// Close down laser controller
// ---------------------------
begin
    if FComPortOpen then CloseComPort ;
    end;



procedure  TLaser.OpenCOMPort ;
// ----------------------------------------
// Establish communications with COM port
// ----------------------------------------
var
   DCB : TDCB ;           { Device control block for COM port }
   CommTimeouts : TCommTimeouts ;
begin
     if FComPortOpen then Exit ;

     { Open com port  }
     FComHandle :=  CreateFile( PCHar(format('COM%d',[FControlPort+1])),
                     GENERIC_READ or GENERIC_WRITE,
                     0,
                     Nil,
                     OPEN_EXISTING,
                     FILE_ATTRIBUTE_NORMAL,
                     0) ;

     if FComHandle < 0 then Exit ;

     { Get current state of COM port and fill device control block }
     GetCommState( FComHandle, DCB ) ;
     { Change settings to those required for 1902 }
     DCB.BaudRate := CBR_9600 ;
     DCB.ByteSize := 8 ;
     DCB.Parity := NOPARITY ;
     DCB.StopBits := ONESTOPBIT ;

     { Update COM port }
     SetCommState( FComHandle, DCB ) ;

     { Initialise Com port and set size of transmit/receive buffers }
     SetupComm( FComHandle, 4096, 4096 ) ;

     { Set Com port timeouts }
     GetCommTimeouts( FComHandle, CommTimeouts ) ;
     CommTimeouts.ReadIntervalTimeout := $FFFFFFFF ;
     CommTimeouts.ReadTotalTimeoutMultiplier := 0 ;
     CommTimeouts.ReadTotalTimeoutConstant := 0 ;
     CommTimeouts.WriteTotalTimeoutMultiplier := 0 ;
     CommTimeouts.WriteTotalTimeoutConstant := 5000 ;
     SetCommTimeouts( FComHandle, CommTimeouts ) ;

     FComPortOpen := True ;
      Status := '' ;
    FControlState := csIdle ;

end ;


procedure  TLaser.CloseCOMPort ;
// ----------------------
// Close serial COM port
// ----------------------
begin
     if FComPortOpen then CloseHandle( FComHandle ) ;
     FComPortOpen := False ;
end ;


procedure TLaser.SetControlPort( Value : DWord ) ;
// ----------------
// Set Control Port
//-----------------
begin
    FControlPort := Max(Value,0) ;
    ResetCOMPort ;
    end;


procedure TLaser.SetBaudRate( Value : DWord ) ;
// ----------------------
// Set com Port baud rate
//-----------------------
begin
    if Value <= 0 then Exit ;
    FBaudRate := Value ;
    ResetCOMPort ;
    end;


procedure TLaser.ResetCOMPort ;
// --------------------------
// Reset COM port (if in use)
// --------------------------
begin
    case FLaserType of
        lsOBIS :
          begin
          if FComPortOpen then
             begin
             CloseComPort ;
             OpenComPort ;
             end;
          end;
        end;
    end;


procedure TLaser.SetIntensity(
          i : Integer ;    // Laser # (0..
          Value : Double ) ;  // Intensity (0-1.0)
// -------------------
// Set laser intensity
// -------------------
begin
     if (i < 0) and (i >= MaxLasers) then Exit ;
     Intensity[i] := Value ;
     UpdateLasers ;
end ;


function TLaser.GetIntensity(
          i : Integer // Laser # 0..
          ) : Double ;     // Intensity (0-1.0)
// -------------------
// Get laser intensity
// -------------------
begin
     if (i >= 0) and (i < MaxLasers) then Result := Intensity[i]
                                          else Result := 0.0 ;
end ;


procedure TLaser.SetVMaxIntensity(
          i : Integer ;    // Laser # (0..
          Value : Double ) ;  // Intensity (0-1.0)
// --------------------------------------
// Set Voltage at maximum laser intensity
// --------------------------------------
begin
     if (i < 0) and (i >= MaxLasers) then Exit ;
     FVMaxIntensity[i] := Value ;
     UpdateLasers ;
end ;


function TLaser.GetVMaxIntensity(
          i : Integer // Laser # 0..
          ) : Double ;     // Intensity (0-1.0)
// --------------------------------------
// Get Voltage at maximum laser intensity
// --------------------------------------
begin
     if (i >= 0) and (i < MaxLasers) then Result := FVMaxIntensity[i]
                                     else Result := 0.0 ;
end ;


procedure TLaser.SetLaserActive(
          i : Integer ;    // Laser # (0..
          Value : Boolean ) ;  // True=ON,False=OFF
// -----------------
// Set laser on/off
// -----------------
begin
     if (i < 0) and (i >= MaxLasers) then Exit ;
     FLaserActive[i] := Value ;
     UpdateLasers ;
end ;


function TLaser.GetLaserActive(
          i : Integer // Laser # 0..
          ) : Boolean ;   // True=ON,False=OFF
// ----------------------
// Get laser on/off state
// ----------------------
begin
     if (i >= 0) and (i < MaxLasers) then Result := FLaserActive[i]
                                     else Result := False ;
end ;


procedure TLaser.SetActiveControlPort(
          i : Integer ;    // Laser # (0..
          Value : Integer ) ;  // Control line #
// -----------------------------
// Set laser on/off control port
// -----------------------------
begin
     if (i < 0) and (i >= MaxLasers) then Exit ;
     FActiveControlPort[i] := Value ;
     UpdateLasers ;
end ;


function TLaser.GetActiveControlPort(
          i : Integer // Laser # 0..
          ) : Integer ;   // Control line #
// -----------------------------
// Get laser on/off control port
// -----------------------------
begin
     if (i >= 0) and (i < MaxLasers) then Result := FActiveControlPort[i]
                                     else Result := MaxResources ;
end ;


procedure TLaser.SetIntensityControlPort(
          i : Integer ;    // Laser # (0..
          Value : Integer ) ;  // Control line #
// -----------------------------
// Set laser intensity control port
// -----------------------------
begin
     if (i < 0) and (i >= MaxLasers) then Exit ;
     FIntensityControlPort[i] := Value ;
     UpdateLasers ;
end ;


function TLaser.GetIntensityControlPort(
          i : Integer // Laser # 0..
          ) : Integer ;   // Control line #
// -----------------------------
// Get laser intensity control port
// -----------------------------
begin
     if (i >= 0) and (i < MaxLasers) then Result := FIntensityControlPort[i]
                                     else Result := MaxResources ;
end ;


procedure TLaser.SetLaserName(
          i : Integer ;    // Laser # (0..
          Value : string ) ;   // Name
// --------------
// Set laser name
// --------------
begin
     if (i < 0) and (i >= MaxLasers) then Exit ;
     FName[i] := Value ;
end ;


function TLaser.GetLaserName(
          i : Integer // Laser # 0..
          ) : string ;    // name
// --------------
// Get laser name
// --------------
begin
     if (i >= 0) and (i < MaxLasers) then Result := FName[i]
                                     else Result := 'Error' ;
end ;


procedure TLaser.UpdateLasers ;
// ---------------------
// Update laser settings
// ---------------------
begin
    case FLaserType of
//        lsOBIS :
        lsExternal : UpdateLasersExternal ;
    end;
end;

procedure TLaser.UpdateLasersExternal ;
// ----------------------------------------
// Update laser settings (external control)
// ----------------------------------------
var
    iLaser,i : Integer ;
    V : Double ;
begin

  for iLaser := 0 to MaxLasers-1 do
      begin
      // Intensity control
      i := FIntensityControlPort[iLaser] ;
      if  i < MaxResources then
          begin
          if FLaserActive[iLaser] then V := FIntensity[iLaser]*VMaxIntensity[iLaser]
                                  else V := 0.0 ;
          LabIO.WriteDAC( LabIO.Resource[i].Device,V,LabIO.Resource[i].StartChannel);
          end;

      // On/off control
      if i < MaxResources then
          begin
          i := FActiveControlPort[iLaser] ;
          LabIO.WriteBit( LabIO.Resource[i].Device,
                          FLaserActive[iLaser],
                          LabIO.Resource[i].StartChannel);
          end;
      end ;

  end;


procedure TLaser.SetLaserType( Value : Integer ) ;
// ----------------------------
// Set type of laser controller
// ----------------------------
begin
      // Close existing stage
      Close ;
      FLaserType := Value ;
      // Reopen new stage
      Open ;
      end;


procedure TLaser.SetCOMPort( Value : Integer ) ;
// --------------------------
// Set laser control COM port
// --------------------------
begin
    FCOMPort := Value ;
    end;
    end.

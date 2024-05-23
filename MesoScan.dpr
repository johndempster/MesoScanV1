program MesoScan;

uses
  Winapi.Windows,System.SysUtils,VCL.Dialogs,   { Required for CreateMutex 22.5.24}
  Forms,
  MainUnit in 'MainUnit.pas' {MainFrm},
  nidaqmxlib in 'nidaqmxlib.pas',
  nidaqlib in 'nidaqlib.pas',
  LabIOUnit in 'LabIOUnit.pas' {LabIO: TDataModule},
  SettingsUnit in 'SettingsUnit.pas' {SettingsFrm},
  ZStageUnit in 'ZStageUnit.pas' {ZStage: TDataModule},
  LaserUnit in 'LaserUnit.pas' {Laser: TDataModule};

{$R *.res}

begin

 // Prevent multiple instances
  if CreateMutex(nil, True, 'Dempster.MesoScan') = 0 then RaiseLastOSError ;
  if GetLastError = ERROR_ALREADY_EXISTS then
     begin
     ShowMessage('MesoScan - Program alreading running! Unable to start another.');
     Exit;
     end;

  Application.Initialize;
  Application.CreateForm(TMainFrm, MainFrm);
  Application.CreateForm(TLabIO, LabIO);
  Application.CreateForm(TSettingsFrm, SettingsFrm);
  Application.CreateForm(TZStage, ZStage);
  Application.CreateForm(TLaser, Laser);
  Application.Run;
end.

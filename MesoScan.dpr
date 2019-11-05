program MesoScan;

uses
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
  Application.Initialize;
  Application.CreateForm(TMainFrm, MainFrm);
  Application.CreateForm(TLabIO, LabIO);
  Application.CreateForm(TSettingsFrm, SettingsFrm);
  Application.CreateForm(TZStage, ZStage);
  Application.CreateForm(TLaser, Laser);
  Application.Run;
end.

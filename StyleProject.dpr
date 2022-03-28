program StyleProject;

uses
  System.StartUpCopy,
  FMX.Forms,
  StyleUnit in 'StyleUnit.pas' {FormPrincipale},
  StyleUEnfant in 'StyleUEnfant.pas' {FormSecond},
  StyleData in 'StyleData.pas' {DataStyle: TDataModule},
  StyleDataAndroid in 'StyleDataAndroid.pas' {AndroidStyle: TDataModule},
  StyleDataOther in 'StyleDataOther.pas' {OtherStyle: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDataStyle, DataStyle);
  Application.CreateForm(TFormPrincipale, FormPrincipale);
  Application.Run;
end.

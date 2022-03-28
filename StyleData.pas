unit StyleData;

interface

uses
  System.SysUtils, System.Classes,
  System.Messaging,
  FMX.Types, FMX.Controls, FMX.Styles, FMX.Forms,
  FMX.Platform,
  {$IFDEF ANDROID}
   StyleDataAndroid;
  {$ELSE}
   StyleDataOther;
  {$ENDIF}

type
  TModuleOfStyles = class (TDataModule)
    Dark : TStyleBook;
    Light : TStyleBook;
  end;

  TDataStyle = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
  private
    { Déclarations privées }
    Fdarktheme: boolean;
    FOSStyle: TModuleOfStyles;
    procedure Setdarktheme(const Value: boolean);
    {$IFDEF MSWINDOWS}
    function WindowsDarkMode : Boolean;
    {$ENDIF}
  public
    { Déclarations publiques }
    property OSStyle : TModuleOfStyles read FOSStyle;
    property darktheme : boolean read Fdarktheme write Setdarktheme;
    procedure SetStyle;
    procedure SetStyleForm(const aform : TCustomForm);
  end;

var
  DataStyle: TDataStyle;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}
{$IFDEF MSWINDOWS}
uses
  Winapi.Windows,       // for the pre-defined registry key constants
  System.Win.Registry;  // for the registry read access
{$ENDIF}

{ TDataStyle }

procedure TDataStyle.DataModuleCreate(Sender: TObject);
var svc : IFMXSystemAppearanceService;
begin
if TPlatFormServices.Current.SupportsPlatformService(IFMXSystemAppearanceService,svc) then
  darktheme:=svc.ThemeKind=TSystemThemeKind.Dark
else begin
 darktheme:=false;
 {$IFDEF MSWINDOWS}
 DarkTheme:=WindowsDarkMode;
 {$ENDIF}
end;
{$IFDEF ANDROID}
FOSStyle:=TModuleOfStyles(TAndroidStyle.Create(Self));
{$ELSE}
FOSStyle:=TModuleOfStyles(TOtherStyle.Create(Self))
{$ENDIF}
end;

procedure TDataStyle.Setdarktheme(const Value: boolean);
begin
  if Fdarktheme<>value then
   begin
      fDarkTheme:= Value;
      SetStyle;
   end;
end;

procedure TDataStyle.SetStyle;
var cf : TCommonCustomForm;
begin
if not Assigned(OSStyle) then exit;

cf:=Application.MainForm;
if darktheme then
 begin
     OSStyle.Light.UseStyleManager:=False;
     OSStyle.Dark.UseStyleManager:=True;
     TStyleManager.SetStyle(OSStyle.Dark.Style.Clone(self));
     if assigned(cf) then cf.Stylebook:=OSStyle.Dark
 end
 else begin
   OSStyle.Dark.UseStyleManager:=False;
   OSStyle.Light.UseStyleManager:=True;
   TStyleManager.SetStyle(OSStyle.Light.Style.Clone(Self));
   if assigned(cf) then cf.Stylebook:=OSStyle.Light;
 end;
end;

procedure TDataStyle.SetStyleForm(const aForm : TCustomForm);
begin
if darktheme then
 begin
     OSStyle.Light.UseStyleManager:=False;
     OSStyle.Dark.UseStyleManager:=True;
     TStyleManager.SetStyle(OSStyle.Dark.Style.Clone(self));
     aForm.Stylebook:=OSStyle.Dark
 end
 else begin
   OSStyle.Dark.UseStyleManager:=False;
   OSStyle.Light.UseStyleManager:=True;
   TStyleManager.SetStyle(OSStyle.Light.Style.Clone(Self));
   aform.Stylebook:=OSStyle.Light;
 end;
end;


{$IFDEF MSWINDOWS}
function TDataStyle.WindowsDarkMode: Boolean;
// https://github.com/checkdigits/delphidarkmode/blob/master/WindowsDarkMode.pas
const
  TheKey   = 'Software\Microsoft\Windows\CurrentVersion\Themes\Personalize\';
  TheValue = 'AppsUseLightTheme';
var
  Reg: TRegistry;
begin

  Result := False;  // There is no dark side - the Jedi are victorious!

// This relies on a registry setting only available on MS Windows
// If the developer has somehow managed to get to this point then tell
// them not to do this!
  Reg    := TRegistry.Create(KEY_READ);
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.KeyExists(TheKey) then
      if Reg.OpenKey(TheKey, False) then
      try
        if Reg.ValueExists(TheValue) then
          Result := Reg.ReadInteger(TheValue) = 0;
      finally
        Reg.CloseKey;
      end;
  finally
    Reg.Free;
  end;
end;
{$ENDIF}

end.

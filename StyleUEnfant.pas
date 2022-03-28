unit StyleUEnfant;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts;

type
  TFormSecond = class(TForm)
    Button1: TButton;
    Switch1: TSwitch;
    ModeLabel: TLabel;
    MainLayout: TLayout;
    Panel1: TPanel;
    Label1: TLabel;
    Panel2: TPanel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Switch1Switch(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    Layoutfrom : TLayout;
  end;

var
  FormSecond: TFormSecond;

implementation

{$R *.fmx}

uses StyleData;

procedure TFormSecond.Button1Click(Sender: TObject);
begin
Close;
end;

procedure TFormSecond.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action:=TCloseAction.caFree;
if Sametext(modelabel.text,'docked')
 and assigned(Layoutfrom)
  then Layoutfrom.Visible:=true;
end;

procedure TFormSecond.FormCreate(Sender: TObject);
begin
Switch1.IsChecked:=DataStyle.darktheme;
if sametext(ModeLabel.text,'docked') then exit;

{$IFDEF ANDROID}
 if DataStyle.darktheme then
    StyleBook := DataStyle.OSStyle.Dark
  else
    StyleBook := DataStyle.OSStyle.Light;
{$ENDIF}
end;

procedure TFormSecond.Switch1Switch(Sender: TObject);
begin
DataStyle.Darktheme:=Switch1.IsChecked;
{$IFDEF ANDROID}dataStyle.SetStyleForm(Self);{$ELSE}Datastyle.SetStyle;{$ENDIF}
end;

end.

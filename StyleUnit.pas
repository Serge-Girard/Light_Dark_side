unit StyleUnit;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.Styles,
  FMX.EditBox, FMX.ComboTrackBar, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.Layouts, FMX.ListBox, StyleData, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo,
  FMX.DateTimeCtrls;

type
  TFormPrincipale = class(TForm)
    btnSwitchTheme: TButton;
    Label1: TLabel;
    RadioButton1: TRadioButton;
    TrackBar1: TTrackBar;
    ComboTrackBar1: TComboTrackBar;
    btnNewWindow: TButton;
    Memo1: TMemo;
    btnMessage: TButton;
    GroupBox1: TGroupBox;
    btnDock: TButton;
    btnDialog: TButton;
    DateEdit1: TDateEdit;
    MainLayout: TLayout;
    procedure btnSwitchThemeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnNewWindowClick(Sender: TObject);
    procedure btnMessageClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnDialogClick(Sender: TObject);
    procedure btnDockClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormPrincipale: TFormPrincipale;

implementation

{$R *.fmx}

uses StyleUEnfant,
  FMX.Platform; // pour dialogues

procedure TFormPrincipale.btnSwitchThemeClick(Sender: TObject);
begin
  DataStyle.DarkTheme := Not DataStyle.DarkTheme;
  DataStyle.SetStyle();
end;

procedure TFormPrincipale.btnDialogClick(Sender: TObject);
var
  msgService: IFMXDialogService;
begin
  // sync ou async delphi choisi selon plateforme
  if SupportsPlatformService(IFMXDialogService, msgService) then
    msgService.MessageDialog('Un dialogue n''utilise pas les thémes',
      TMsgdlgType.mtInformation, [TMsgDlgBtn.mbOK], TMsgDlgBtn.mbOK, 0, 0, 0,
      EmptyStr);
end;

procedure TFormPrincipale.btnDockClick(Sender: TObject);
var
  f: TFormSecond;
begin
  f := TFormSecond.Create(Self);
  f.ModeLabel.Text := 'Docked';
  f.Layoutfrom := MainLayout;
  MainLayout.Visible := False;
  f.MainLayout.Parent := Self;
end;

procedure TFormPrincipale.btnMessageClick(Sender: TObject);
begin
  Showmessage('une fenêtre message n''utilise pas les thémes');
end;

procedure TFormPrincipale.btnNewWindowClick(Sender: TObject);
var
  f: TFormSecond;
begin
  f := TFormSecond.Create(Self);
  try
{$IFDEF ANDROID}
    f.ModeLabel.Text := 'Show';
    f.Show;
{$ELSE}
    f.Position := TFormPosition.OwnerformCenter;
    f.ModeLabel.Text := 'Show modal';
    f.ShowModal;
{$ENDIF}
  finally
  end;
end;

procedure TFormPrincipale.FormCreate(Sender: TObject);
begin
{$IFNDEF ANDROID}DataStyle.SetStyle; {$ENDIF}
end;

procedure TFormPrincipale.FormShow(Sender: TObject);
begin
{$IFDEF ANDROID}DataStyle.SetStyle; {$ENDIF}
end;

end.

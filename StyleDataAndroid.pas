unit StyleDataAndroid;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls;

type
  TAndroidStyle = class(TDataModule)
    StyleBookDark: TStyleBook;
    StyleBookLight: TStyleBook;
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
  end;

var
  AndroidStyle: TAndroidStyle;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.

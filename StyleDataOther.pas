unit StyleDataOther;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls;

type
  TOtherStyle = class(TDataModule)
    StyleBookDark: TStyleBook;
    StyleBookLight: TStyleBook;
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
  end;

var
  OtherStyle: TOtherStyle;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.

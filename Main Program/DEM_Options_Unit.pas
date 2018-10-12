unit DEM_Options_Unit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FileCtrl, LabeledNumericEdit, ExtCtrls;

type
  TDEM_Options_Form = class(TForm)
    DisplayComputationTimes_CheckBox: TCheckBox;
    OK_Button: TButton;
    Cancel_Button: TButton;
    ComputeCastShadows_CheckBox: TCheckBox;
    CastShadow_ColorBox: TColorBox;
    Label2: TLabel;
    Save_Button: TButton;
    Restore_Button: TButton;
    GridStepMultiplier_LabeledNumericEdit: TLabeledNumericEdit;
    Label4: TLabel;
    MultiplyByAlbedoCheckBox: TCheckBox;
    RecalculateDEMonRecenter_CheckBox: TCheckBox;
    DrawTerminatorOnDEM_CheckBox: TCheckBox;
    ChangeDEM_Button: TButton;
    DEMFilename_Label: TLabel;
    OpenDialog1: TOpenDialog;
    Lambertian_RadioButton: TRadioButton;
    LommelSeeliger_RadioButton: TRadioButton;
    LunarLambert_RadioButton: TRadioButton;
    PhotometricModel_GroupBox: TGroupBox;
    LommelSeeligerNoDataColor_ColorBox: TColorBox;
    Label1: TLabel;
    ShowDemInfo_CheckBox: TCheckBox;
    MultipliedDemGammaBoost_LabeledNumericEdit: TLabeledNumericEdit;
    MultipliedDemIntensitiesBoost_LabeledNumericEdit: TLabeledNumericEdit;
    procedure OK_ButtonClick(Sender: TObject);
    procedure Cancel_ButtonClick(Sender: TObject);
    procedure Save_ButtonClick(Sender: TObject);
    procedure Restore_ButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ChangeDEM_ButtonClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MultiplyByAlbedoCheckBoxClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ChangeOptions : Boolean;

    TempDEMFilename : String;

    procedure RefreshLabels;
  end;

var
  DEM_Options_Form: TDEM_Options_Form;

implementation

{$R *.dfm}

uses LTVT_Unit;

procedure TDEM_Options_Form.RefreshLabels;
begin
  DEMFilename_Label.Caption := MinimizeName(TempDEMFilename,DEMFilename_Label.Canvas,DEMFilename_Label.Width);
  MultipliedDemGammaBoost_LabeledNumericEdit.Visible := MultiplyByAlbedoCheckBox.Checked;
  MultipliedDemIntensitiesBoost_LabeledNumericEdit.Visible := MultiplyByAlbedoCheckBox.Checked;
end;

procedure TDEM_Options_Form.FormShow(Sender: TObject);
begin
  RefreshLabels;
end;

procedure TDEM_Options_Form.ChangeDEM_ButtonClick(Sender: TObject);
begin
  with OpenDialog1 do
    begin
      Title := 'Select DEM file';
      if TempDEMFilename='' then
        FileName := LTVT_Form.FullFilename('LALT_GGT_MAP.IMG')
      else
        FileName := TempDEMFilename;
      Filter := 'PDS image array (*.IMG)|*.IMG|ISIS data cube (*.CUB)|*.CUB|USGS BIL format with supporting files (*.BIL)|*.BIL|All files|*.*';
      if Execute then
        begin
          TempDEMFilename := FileName;
          DEMFilename_Label.Caption := MinimizeName(TempDEMFilename,DEMFilename_Label.Canvas,DEMFilename_Label.Width);
        end;
    end;
end;

procedure TDEM_Options_Form.OK_ButtonClick(Sender: TObject);
begin
  ChangeOptions := True;
  Close;
end;

procedure TDEM_Options_Form.Cancel_ButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TDEM_Options_Form.Save_ButtonClick(Sender: TObject);
begin
  with LTVT_Form do
    begin
      ReadDemOptionsFromForm;
      SaveDemOptions;
    end;
end;

procedure TDEM_Options_Form.Restore_ButtonClick(Sender: TObject);
begin
  with LTVT_Form do
    begin
      RestoreDemOptions;
      WriteDemOptionsToForm;
    end;
  RefreshLabels;
end;

procedure TDEM_Options_Form.MultiplyByAlbedoCheckBoxClick(Sender: TObject);
begin
  RefreshLabels;
end;

procedure TDEM_Options_Form.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_ESCAPE then
    Cancel_Button.Click
  else
    LTVT_Form.DisplayF1Help(Key,Shift,'DemOptionsForm.htm');
end;

end.

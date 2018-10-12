unit H_MoonEventPredictor_Unit;
{
v1.4:
  1. Added box for observer elevation.
  2. Reduce tabulation to two shades of gray (Moon up or Moon down).

v0.0: (= v1.5 renamed)
  1. Corrected JPL routine so it can silently cross 50-year boundaries.
  2. Corrected Sub-observer point lon/lat display (librations) which was reversed!
  3. Completely re-wrote SunAngle search algorithm.
  4. Add check-box to filter output: print only results within tolerance.

v0.3
  1. Improved longitude/latitude tooltips to indicate E=+ W=- N=+ S = -.

v0.5
  1. Add button to launch LibrationTabulator form.
  2. Refresh Memo1 area after each output line is printed.  Otherwise output
     can be held making program appear frozen.

v0.6
  1. Add Abort button and "search completed" messages.

                                                                   3/6/09}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, LabeledNumericEdit, StdCtrls, ComCtrls, Math, DateUtils, ExtCtrls,
  H_JPL_Ephemeris, MoonPosition, Constnts, {TimLib,} MP_Defs;

type
  TMoonEventPredictor_Form = class(TForm)
    Label1: TLabel;
    Date_DateTimePicker: TDateTimePicker;
    Time_DateTimePicker: TDateTimePicker;
    ObserverLongitude_LabeledNumericEdit: TLabeledNumericEdit;
    ObserverLatitude_LabeledNumericEdit: TLabeledNumericEdit;
    CalculateCircumstances_Button: TButton;
    Crater_Lon_LabeledNumericEdit: TLabeledNumericEdit;
    Crater_Lat_LabeledNumericEdit: TLabeledNumericEdit;
    SunAngle_LabeledNumericEdit: TLabeledNumericEdit;
    Colongitude_LabeledNumericEdit: TLabeledNumericEdit;
    ColongitudeMode_RadioButton: TRadioButton;
    SunAngleMode_RadioButton: TRadioButton;
    Memo1: TRichEdit;
    ClearMemo_Button: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Tabulate_Button: TButton;
    StartDate_DateTimePicker: TDateTimePicker;
    EndDate_DateTimePicker: TDateTimePicker;
    SolarLatitude_LabeledNumericEdit: TLabeledNumericEdit;
    Font_Button: TButton;
    FontDialog1: TFontDialog;
    IncTolerance_LabeledNumericEdit: TLabeledNumericEdit;
    ObserverElevation_LabeledNumericEdit: TLabeledNumericEdit;
    SunAzimuth_LabeledNumericEdit: TLabeledNumericEdit;
    AzTolerance_LabeledNumericEdit: TLabeledNumericEdit;
    ObserverLocation_GroupBox: TGroupBox;
    ColongitudeMode_GroupBox: TGroupBox;
    SunAltitudeMode_GroupBox: TGroupBox;
    SunAngleTimeStep_LabeledNumericEdit: TLabeledNumericEdit;
    FilterOutput_CheckBox: TCheckBox;
    GeocentricObserver_CheckBox: TCheckBox;
    Label2: TLabel;
    Abort_Button: TButton;
    ObservatoryList_ComboBox: TComboBox;
    AddLocation_Button: TButton;
    procedure CalculateCircumstances_ButtonClick(Sender: TObject);
    procedure ClearMemo_ButtonClick(Sender: TObject);
    procedure Tabulate_ButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Font_ButtonClick(Sender: TObject);
    procedure ColongitudeMode_RadioButtonClick(Sender: TObject);
    procedure SunAngleMode_RadioButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GeocentricObserver_CheckBoxClick(Sender: TObject);
    procedure Date_DateTimePickerKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Time_DateTimePickerKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CalculateCircumstances_ButtonKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure ColongitudeMode_RadioButtonKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure SunAngleMode_RadioButtonKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure GeocentricObserver_CheckBoxKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure Crater_Lon_LabeledNumericEditNumericEditKeyDown(
      Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SunAngle_LabeledNumericEditNumericEditKeyDown(
      Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SunAngleTimeStep_LabeledNumericEditNumericEditKeyDown(
      Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Crater_Lat_LabeledNumericEditNumericEditKeyDown(
      Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SunAzimuth_LabeledNumericEditNumericEditKeyDown(
      Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure AzTolerance_LabeledNumericEditNumericEditKeyDown(
      Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Colongitude_LabeledNumericEditNumericEditKeyDown(
      Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure IncTolerance_LabeledNumericEditNumericEditKeyDown(
      Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure StartDate_DateTimePickerKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure EndDate_DateTimePickerKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FilterOutput_CheckBoxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Tabulate_ButtonKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Memo1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Font_ButtonKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ClearMemo_ButtonKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ObserverLongitude_LabeledNumericEditNumericEditKeyDown(
      Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ObserverLatitude_LabeledNumericEditNumericEditKeyDown(
      Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ObserverElevation_LabeledNumericEditNumericEditKeyDown(
      Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SolarLatitude_LabeledNumericEditNumericEditKeyDown(
      Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LibrationTabulator_ButtonKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure Abort_ButtonKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Abort_ButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ObservatoryList_ComboBoxSelect(Sender: TObject);
    procedure ObserverLongitude_LabeledNumericEditNumericEditChange(
      Sender: TObject);
    procedure ObserverLatitude_LabeledNumericEditNumericEditChange(
      Sender: TObject);
    procedure ObserverElevation_LabeledNumericEditNumericEditChange(
      Sender: TObject);
    procedure ObservatoryList_ComboBoxKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure AddLocation_ButtonKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure AddLocation_ButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ObsNameList, ObsLatList, ObsLonList, ObsElevList : TStrings;

    AbortTabulation : Boolean;

    MEP_JPL_Filename, MEP_JPL_Path : string;

    SubSolarPoint : TPolarCoordinates;
    SolarColongitude : extended;  {in rad}

    function EW_Tag(const Longitude : extended): string;
    {returns 'E' or 'W'}

    function NS_Tag(const Latitude : extended): string;
    {returns 'N' or 'S'}

    function JPL_File_Valid(const Desired_MJD : extended) : boolean;
    {returns true if Desired_MJD falls within range of current ephemeris file;
      if not attempts to load the appropriate file}

    procedure CalculateSolarColongitude(const MJD_for_CL :extended);  {UT MJD}

    procedure RefreshSelection;

  end;

var
  MoonEventPredictor_Form: TMoonEventPredictor_Form;

implementation

uses Win_Ops, NumericEdit, LTVT_Unit, LibrationTabulator_Unit, H_Terminator_SetYear_Unit, ObserverLocationName_Unit;

{$R *.dfm}

var
  SelectingItem : Boolean;   // flag to avoid refreshing Combo-box selection during a new selection

procedure TMoonEventPredictor_Form.FormCreate(Sender: TObject);
begin
  MEP_JPL_Filename := 'UNXP2000.405'; //overwritten by calling program
  MEP_JPL_Path := '';

  if not LTVT_Form.LinuxCompatibilityMode then
    begin
      Date_DateTimePicker.MinDate := EncodeDateDay(1601,1);
      StartDate_DateTimePicker.MinDate := EncodeDateDay(1601,1);
      EndDate_DateTimePicker.MinDate := EncodeDateDay(1601,1);
    end;

  try
    StartDate_DateTimePicker.Date := EncodeDateDay(CurrentYear,1);
  except
  end;

  try
    EndDate_DateTimePicker.Date := EncodeDateDay(CurrentYear+1,1);
  except
  end;

  ObsNameList := TStringList.Create;
  ObsLatList := TStringList.Create;
  ObsLonList := TStringList.Create;
  ObsElevList := TStringList.Create;

  SelectingItem := False;
end;

procedure TMoonEventPredictor_Form.FormDestroy(Sender: TObject);
begin
  ObsNameList.Free;
  ObsLatList.Free;;
  ObsLonList.Free;;
  ObsElevList.Free;;
end;

procedure TMoonEventPredictor_Form.FormShow(Sender: TObject);
var
  ObsListFile : TextFile;
  DataLine : String;
begin
//  ShortDateFormat := 'yyyy/mm/dd';
  LongTimeFormat := 'hh:nn:ss';
  ThousandSeparator := #0;
  DecimalSeparator := '.';

  ObsNameList.Clear;
  ObsLatList.Clear;
  ObsLonList.Clear;
  ObsElevList.Clear;
  if FileExists(LTVT_Form.ObservatoryListFilename) then
    begin
      AssignFile(ObsListFile,LTVT_Form.ObservatoryListFilename);
      Reset(ObsListFile);
      while (not EOF(ObsListFile)) {and (Length(FeatureList)<100)} do
        begin
          Readln(ObsListFile,DataLine);
          DataLine := Trim(DataLine);
          if (DataLine<>'') and (Substring(DataLine,1,1)<>'*') then
            begin
              ObsLonList.Add(LeadingElement(DataLine,','));
              ObsLatList.Add(LeadingElement(DataLine,','));
              ObsElevList.Add(LeadingElement(DataLine,','));
              ObsNameList.Add(Trim(DataLine));
            end;
        end;
      CloseFile(ObsListFile);
    end;

  ObservatoryList_ComboBox.Items.Clear;
  ObservatoryList_ComboBox.Items.AddStrings(ObsNameList);
  RefreshSelection;

  ObserverLocation_GroupBox.Visible := not GeocentricObserver_CheckBox.Checked;
end;

procedure TMoonEventPredictor_Form.RefreshSelection;
var
  i : Integer;
begin
  if ObservatoryList_ComboBox.Visible and not SelectingItem then
    begin
      i := 0;
      while (i<ObsNameList.Count) and
        (    (ObserverLongitude_LabeledNumericEdit.NumericEdit.Text<>ObsLonList[i])
          or (ObserverLatitude_LabeledNumericEdit.NumericEdit.Text<>ObsLatList[i])
          or (ObserverElevation_LabeledNumericEdit.NumericEdit.Text<>ObsElevList[i])
        ) do Inc(i);

      if i<ObservatoryList_ComboBox.Items.Count then
        ObservatoryList_ComboBox.ItemIndex := i
      else
        begin
          if FileExists(LTVT_Form.ObservatoryListFilename) then
            begin
              ObservatoryList_ComboBox.ItemIndex := -1;
              ObservatoryList_ComboBox.Text := LTVT_Form.ObservatoryComboBoxDefaultText;
            end
          else
            begin
              ObservatoryList_ComboBox.ItemIndex := -1;
              ObservatoryList_ComboBox.Text := LTVT_Form.ObservatoryNoFileText;
            end
        end;
    end;
end;

procedure TMoonEventPredictor_Form.ObservatoryList_ComboBoxSelect(Sender: TObject);
begin
  with ObservatoryList_ComboBox do if ItemIndex>=0 then
    begin
      SelectingItem := True;
      ObserverLongitude_LabeledNumericEdit.NumericEdit.Text := ObsLonList[ItemIndex];
      ObserverLatitude_LabeledNumericEdit.NumericEdit.Text := ObsLatList[ItemIndex];
      ObserverElevation_LabeledNumericEdit.NumericEdit.Text := ObsElevList[ItemIndex];
      SelectingItem := False;
    end
  else
    ShowMessage('Please try again:  you must click on an item in the list');
end;

procedure TMoonEventPredictor_Form.ObserverLongitude_LabeledNumericEditNumericEditChange(Sender: TObject);
begin
  RefreshSelection;
end;

procedure TMoonEventPredictor_Form.ObserverLatitude_LabeledNumericEditNumericEditChange(Sender: TObject);
begin
  RefreshSelection;
end;

procedure TMoonEventPredictor_Form.ObserverElevation_LabeledNumericEditNumericEditChange(Sender: TObject);
begin
  RefreshSelection;
end;

procedure TMoonEventPredictor_Form.AddLocation_ButtonClick(Sender: TObject);
var
  ObsListFile : TextFile;
  NameToAdd : String;
begin
  with ObserverLocationName_Form do
    begin
      ShowModal;
      if CancelAction then Exit;

      NameToAdd := Trim(Name_Edit.Text);
    end;

  AssignFile(ObsListFile,LTVT_Form.ObservatoryListFilename);

  if FileExists(LTVT_Form.ObservatoryListFilename) then
    begin
      Append(ObsListFile);
    end
  else
    begin
      Rewrite(ObsListFile);
      Writeln(ObsListFile,'* List of observatory locations for use by LTVT');
      Writeln(ObsListFile,'*   (blank lines and lines with ''*'' in the first column are ignored)');
      Writeln(ObsListFile,'');
      Writeln(ObsListFile,'*   The observatory name can include any characters -- including commas');
      Writeln(ObsListFile,'*   Longitudes and latitudes must be in decimal degrees (NOT degrees-minutes-seconds)');
      Writeln(ObsListFile,'*   Important: you must use ''.'' (period) for for the decimal point');
      Writeln(ObsListFile,'');
      Writeln(ObsListFile,'* List items in this format (using commas to separate items):');
      Writeln(ObsListFile,'* ObservatoryEastLongitude_degrees, ObservatoryNorthLatitude_degrees, ObservatoryElevation_meters, ObservatoryName');
      Writeln(ObsListFile,'');
    end;

  Writeln(ObsListFile,
    Trim(ObserverLongitude_LabeledNumericEdit.NumericEdit.Text)+', '+
    Trim(ObserverLatitude_LabeledNumericEdit.NumericEdit.Text)+', '+
    Trim(ObserverElevation_LabeledNumericEdit.NumericEdit.Text)+', '+
    NameToAdd);
  CloseFile(ObsListFile);

  ObsLonList.Add(Trim(ObserverLongitude_LabeledNumericEdit.NumericEdit.Text));
  ObsLatList.Add(Trim(ObserverLatitude_LabeledNumericEdit.NumericEdit.Text));
  ObsElevList.Add(Trim(ObserverElevation_LabeledNumericEdit.NumericEdit.Text));
  ObsNameList.Add(NameToAdd);

  ObservatoryList_ComboBox.Items.Add(NameToAdd);

//  ShowMessage('Location added to '+LTVT_Form.ObservatoryListFilename);
  RefreshSelection;
end;

function TMoonEventPredictor_Form.EW_Tag(const Longitude : extended): string;
  begin
    if Longitude>=0 then
      Result := 'E'
    else
      Result := 'W';
  end;

function TMoonEventPredictor_Form.NS_Tag(const Latitude : extended): string;
  begin
    if Latitude>=0 then
      Result := 'N'
    else
      Result := 'S';
  end;

function TMoonEventPredictor_Form.JPL_File_Valid(const Desired_MJD : extended) : boolean;
{returns true if Desired_MJD falls within range of current ephemeris file;
  if not attempts to load the appropriate file}
var
  JED : extended;

  procedure LookForJPLFile;
    var
      JPL_Year : integer;
    begin  // try to silently load another file
      JPL_Year := Round(YearOf(ModifiedJulianDateToDateTime(Desired_MJD)));
      LoadJPL_File(MEP_JPL_Path+'UNXP'+IntToStr(50*(JPL_Year div 50))+'.405');
    end;

begin
  JED := Desired_MJD + MJDOffset;

  if not EphemerisFileLoaded then
    begin
      LoadJPL_File(MEP_JPL_Filename);  // load default file if it has not yet been done
      if EphemerisFileLoaded then
        begin
          MEP_JPL_Filename := EphemerisFilname; // save as default if something was selected
          MEP_JPL_Path := ExtractFilePath(EphemerisFilname);
        end;
    end;

  if EphemerisFileLoaded and ((JED<SS[1]) or (JED>SS[2])) then
    begin // ask for assistance only if necessary
      LookForJPLFile;
    end;

  if (not EphemerisFileLoaded) or ((JED<SS[1]) or (JED>SS[2])) then
    begin
      ShowMessage('Cannot estimate geometry -- ephemeris file not loaded');
      Result := False;
    end
  else
    Result := True;

end;

procedure TMoonEventPredictor_Form.CalculateCircumstances_ButtonClick(Sender: TObject);
var
  UT_MJD, CraterLat, CraterLon, SunLat, SunLon, AngleToSun, SunAzimuth : extended;

begin {CalculateCircumstances_ButtonClick}
  UT_MJD := DateTimeToModifiedJulianDate(DateOf(Date_DateTimePicker.Date) + TimeOf(Time_DateTimePicker.Time));

  CalculateSolarColongitude(UT_MJD);

  Memo1.Lines.Add('');
  Memo1.Lines.Add('Lunar lighting conditions calculated for:  '+
    LTVT_Form.CorrectedDateTimeToStr(ModifiedJulianDateToDateTime(UT_MJD))+' UT');

  Colongitude_LabeledNumericEdit.NumericEdit.Text := Format('%0.4f',[RadToDeg(SolarColongitude)]);
  SolarLatitude_LabeledNumericEdit.NumericEdit.Text := Format('%0.3f',[RadToDeg(SubSolarPoint.Latitude)]);

  CraterLon := DegToRad(Crater_Lon_LabeledNumericEdit.NumericEdit.ExtendedValue);
  CraterLat := DegToRad(Crater_Lat_LabeledNumericEdit.NumericEdit.ExtendedValue);
  SunLon := SubSolarPoint.Longitude;
  SunLat := SubSolarPoint.Latitude;

  ComputeDistanceAndBearing(CraterLon, CraterLat, SunLon, SunLat, AngleToSun, SunAzimuth);
//  SunAngle := PiByTwo - ArcCos(Sin(CraterLat)*Sin(SunLat) + Cos(CraterLat)*Cos(SunLat)*Cos(SunLon - CraterLon));

  SunAngle_LabeledNumericEdit.NumericEdit.Text := Format('%0.4f',[RadToDeg(PiByTwo - AngleToSun)]);
  SunAzimuth_LabeledNumericEdit.NumericEdit.Text := Format('%0.4f',[RadToDeg(SunAzimuth)]);

end;  {CalculateCircumstances_ButtonClick}

procedure TMoonEventPredictor_Form.ClearMemo_ButtonClick(Sender: TObject);
begin
  Memo1.Clear;
end;

procedure TMoonEventPredictor_Form.CalculateSolarColongitude(const MJD_for_CL :extended);
  begin
    if not JPL_File_Valid(MJD_for_CL) then exit;

    SubSolarPoint := SubSolarPointOnMoon(MJD_for_CL);

    SolarColongitude := PiByTwo - SubSolarPoint.Longitude;
    while SolarColongitude>TwoPi do SolarColongitude := SolarColongitude - TwoPi;
    while SolarColongitude<0     do SolarColongitude := SolarColongitude + TwoPi;
  end;

procedure TMoonEventPredictor_Form.Tabulate_ButtonClick(Sender: TObject);
const
  SynodicMonth =  29.53;  {days}
  CL_Rate = SynodicMonth/TwoPi;  {inverse rate of increase in days/radian}
  WithinToleranceSymbol = '+';
  MoonUpSunDownSymbol = '%';
  TargetVisibleSymbol = '*';

var
  LinesPrinted : integer;

  OldGeocentricMode : boolean;

  SunAngleMJDStep,  // interval between tests for SunAngle crossing Target value
  StartMJD, EndMJD, AllowableError, OldSunAngle, NewSunAngle,
  MJD, TargetCL, TargetSolarLat, TargetSolarAzimuth, CL_Error,  {angles in rad}
  TargetAngle,
  SinCraterLat, CosCraterLat, CraterLon,
  CraterLonDeg, CraterLatDeg, SunAngleDeg,
  AllowableLatitudeErrorDegrees, AllowableAzimuthErrorDegrees : Extended;

procedure UpdateCL;
  begin
    CalculateSolarColongitude(MJD);

    CL_Error := TargetCL - SolarColongitude;
    while CL_Error>Pi  do CL_Error := CL_Error - TwoPi;
    while CL_Error<-Pi do CL_Error := CL_Error + TwoPi;
  end;

procedure RefineCL;
  begin
    MJD := MJD + CL_Error*CL_Rate;
    UpdateCL;
  end;

function SunAngle(const MJD_for_Angle: Extended): Extended;
  var
    SunLat, SunLon : Extended;
  begin
    CalculateSolarColongitude(MJD_for_Angle);
    SunLat := SubSolarPoint.Latitude;
    SunLon := SubSolarPoint.Longitude;
    SunAngle := PiByTwo - ArcCos(SinCraterLat*Sin(SunLat) + CosCraterLat*Cos(SunLat)*Cos(SunLon - CraterLon));
  end;

procedure RefineSunAngleDate;
{ this routine is entered iff
     OldSunAngle = SunAngle(MJD)
     NewSunAngle = SunAngle(MJD + SunAngleMJDStep)
     TargetAngle lies between these
}
  const
    MaxMJDError = 0.1*OneSecond/OneDay;
  var
    StartMJD, EndMJD, MiddleMJD, StartAngle, {EndAngle,} MiddleAngle : Extended;
  begin
    StartMJD := MJD;
    StartAngle := OldSunAngle;
    EndMJD := MJD + SunAngleMJDStep;
//    EndAngle := NewSunAngle;    // not needed in test
    MiddleMJD := (EndMJD + StartMJD)/2;
    while Abs(EndMJD - StartMJD)>MaxMJDError do
      begin
        MiddleMJD := (EndMJD + StartMJD)/2;
        MiddleAngle := SunAngle(MiddleMJD);
        if ((TargetAngle>=StartAngle) and (TargetAngle<=MiddleAngle)) or ((TargetAngle<=StartAngle) and (TargetAngle>=MiddleAngle)) then
          begin  // TargetAngle is between StartAngle and MiddleAngle
            EndMJD := MiddleMJD;
//            EndAngle := MiddleAngle;  // not needed in test
          end
        else     // TargetAngle is between MiddleAngle and EndAngle
          begin
            StartMJD := MiddleMJD;
            StartAngle := MiddleAngle;
          end;
      end;
    MJD := MiddleMJD;
  end;

procedure PrintHeader;
  begin
    if GeocentricSubEarthMode then
      begin
        Memo1.Lines.Add('Librations, elongation and percent illumination calculated for a geocentric observer');
        Memo1.Lines.Add('');
        if ColongitudeMode_RadioButton.Checked then
          begin
            Memo1.Lines.Add('                          Terminators      Sub-Solar Point     Librations                Phase   ');
            Memo1.Lines.Add('   Date      Time UT   Morning   Evening    Colong    Lat.    Long.   Lat.     Elong.   %Illum.    Age');
          end
        else
          begin
            Memo1.Lines.Add('                           Sun Angle       Sub-Solar Point     Librations                Phase   ');
            Memo1.Lines.Add('   Date      Time UT   Altitude  Azimuth    Colong    Lat.    Long.   Lat.     Elong.   %Illum.    Age');
          end;
      end
    else
      begin
        Memo1.Lines.Add(Format('Librations and Moon/Sun positions calculated for observer at %0.4f %s  %0.4f %s  %0.0f m',
          [Abs(-ObserverLongitude),EW_Tag(-ObserverLongitude),Abs(ObserverLatitude),NS_Tag(ObserverLatitude),ObserverElevation]));
        Memo1.Lines.Add('');
        if ColongitudeMode_RadioButton.Checked then
          begin
            Memo1.Lines.Add('                          Terminators      Sub-Solar Point     Librations      Center of Moon      Center of Sun');
            Memo1.Lines.Add('   Date      Time UT   Morning   Evening    Colong    Lat.    Long.   Lat.      Alt.     Azi.       Alt.     Azi');
          end
        else
          begin
            Memo1.Lines.Add('                           Sun Angle       Sub-Solar Point     Librations      Center of Moon      Center of Sun');
            Memo1.Lines.Add('   Date      Time UT   Altitude  Azimuth    Colong    Lat.    Long.   Lat.      Alt.     Azi.       Alt.     Azi');
          end;
      end;
  end;

procedure PrintData;
  var
    SunPosition, MoonPosition : PositionResultRecord;
    WithinToleranceCode, MoonUpSunDownCode, TargetVisibleCode : String;
    CraterLat, CraterLon, SunLat, SunLon, AngleToSun, SolarElevation, SolarAzimuth,
    TargetDistance, TargetAzimuth, AzimuthDifferenceDegrees : Extended;
    CL, MT, ET : extended;
    SunMoonAngle, SunMoonBearing,
    Lon1, Lat1, Lon2, Lat2, CosTheta : extended;
    PrintDateTime : TDateTime;
    SubEarthPoint : TPolarCoordinates;

  begin {PrintData}
    CalculateSolarColongitude(MJD);

    SubEarthPoint := SubEarthPointOnMoon(MJD);
    while SubEarthPoint.Longitude>Pi do SubEarthPoint.Longitude := SubEarthPoint.Longitude - TwoPi;
    CalculatePosition(MJD,Moon,BlankStarDataRecord,MoonPosition);
    CalculatePosition(MJD,Sun, BlankStarDataRecord,SunPosition);

    if (MoonPosition.TopocentricAlt>0) and (SunPosition.TopocentricAlt<0) and not GeocentricSubEarthMode then
      MoonUpSunDownCode := MoonUpSunDownSymbol
    else
      MoonUpSunDownCode := ' ';

    CL := RadToDeg(SolarColongitude);

    ET := 180 - CL;
    MT := -CL;
    if MT<-180 then MT := MT + 360;

    PrintDateTime := ModifiedJulianDateToDateTime(MJD);
    if (PrintDateTime<0) and (Frac(PrintDateTime)<>0) then PrintDateTime := Int(PrintDateTime) - Frac(PrintDateTime) - 2; // Correct for error in default display of negative DateTimes

    if (MoonPosition.TopocentricAlt<0) and not GeocentricSubEarthMode then
      Memo1.SelAttributes.Color := clLtGray
    else
      Memo1.SelAttributes.Color := clBlack;

    if GeocentricSubEarthMode then
      begin
        Lon1 := SubEarthPoint.Longitude;
        Lat1 := SubEarthPoint.Latitude;
        Lon2 := SubSolarPoint.Longitude;
        Lat2 := SubSolarPoint.Latitude;

        CosTheta := Sin(Lat1)*Sin(Lat2) + Cos(Lat1)*Cos(Lat2)*Cos(Lon2 - Lon1);

        ComputeDistanceAndBearing(MoonPosition.Azimuth*OneDegree,MoonPosition.TopocentricAlt*OneDegree,SunPosition.Azimuth*OneDegree,SunPosition.TopocentricAlt*OneDegree,SunMoonAngle,SunMoonBearing);
      end
    else
      begin
        CosTheta := 0;   // compiler is insisting this might not be initialized
        SunMoonAngle := 0;
      end;

    if SunAngleMode_RadioButton.Checked then
      begin
        CraterLon := DegToRad(Crater_Lon_LabeledNumericEdit.NumericEdit.ExtendedValue);
        CraterLat := DegToRad(Crater_Lat_LabeledNumericEdit.NumericEdit.ExtendedValue);
        SunLat := SubSolarPoint.Latitude;
        SunLon := SubSolarPoint.Longitude;
        ComputeDistanceAndBearing(CraterLon, CraterLat, SunLon, SunLat, AngleToSun, SolarAzimuth);
        SolarElevation := PiByTwo - AngleToSun;

        AzimuthDifferenceDegrees := RadToDeg(SolarAzimuth-TargetSolarAzimuth);
        while AzimuthDifferenceDegrees>180 do AzimuthDifferenceDegrees := AzimuthDifferenceDegrees - 360;
        while AzimuthDifferenceDegrees<-180 do AzimuthDifferenceDegrees := AzimuthDifferenceDegrees + 360;

        if Abs(AzimuthDifferenceDegrees)<AllowableAzimuthErrorDegrees then
          WithinToleranceCode := WithinToleranceSymbol
        else
          WithinToleranceCode := ' ';

        ComputeDistanceAndBearing(SubEarthPoint.Longitude, SubEarthPoint.Latitude, CraterLon, CraterLat, TargetDistance, TargetAzimuth);

        if TargetDistance<PiByTwo then
          TargetVisibleCode := TargetVisibleSymbol
        else
          TargetVisibleCode := ' ';

        if (WithinToleranceCode=WithinToleranceSymbol) or not FilterOutput_CheckBox.Checked then
          begin
            if GeocentricSubEarthMode then
              Memo1.Lines.Add(Format('%10s%10s%10.4f%10.4f%10.3f%8.3f%8.3f%8.3f%11.3f%9.3f%9.3f  %1s%1s%1s',
                [DateToStr(PrintDateTime),TimeToStr(PrintDateTime),RadToDeg(SolarElevation),
                RadToDeg(SolarAzimuth),CL,RadToDeg(SubSolarPoint.Latitude),
                RadToDeg(SubEarthPoint.Longitude),RadToDeg(SubEarthPoint.Latitude),
                SunMoonAngle/OneDegree, 50*(1 + CosTheta), LunarAge(MJD),
                TargetVisibleCode,WithinToleranceCode,MoonUpSunDownCode]))
            else
              Memo1.Lines.Add(Format('%10s%10s%10.4f%10.4f%10.3f%8.3f%8.3f%8.3f%10.3f%10.3f%10.3f%10.3f  %1s%1s%1s',
                [DateToStr(PrintDateTime),TimeToStr(PrintDateTime),RadToDeg(SolarElevation),
                RadToDeg(SolarAzimuth),CL,RadToDeg(SubSolarPoint.Latitude),
                RadToDeg(SubEarthPoint.Longitude),RadToDeg(SubEarthPoint.Latitude),
                MoonPosition.TopocentricAlt,MoonPosition.Azimuth,
                SunPosition.TopocentricAlt,SunPosition.Azimuth,
                TargetVisibleCode,WithinToleranceCode,MoonUpSunDownCode]));

            Memo1.Refresh;
          end;
      end
    else  // colongitude mode
      begin
        if Abs(RadToDeg(SubSolarPoint.Latitude-TargetSolarLat))<AllowableLatitudeErrorDegrees then
          WithinToleranceCode := WithinToleranceSymbol
        else
          WithinToleranceCode := ' ';

        if (WithinToleranceCode=WithinToleranceSymbol) or not FilterOutput_CheckBox.Checked then
          begin
            if GeocentricSubEarthMode then
              Memo1.Lines.Add(Format('%10s%10s%9.3f%1s%9.3f%1s%10.3f%8.3f%8.3f%8.3f%11.3f%9.3f%9.3f  %1s%1s',
                [DateToStr(PrintDateTime),TimeToStr(PrintDateTime),Abs(MT),EW_Tag(MT),Abs(ET),EW_Tag(ET),
                CL,RadToDeg(SubSolarPoint.Latitude),
                RadToDeg(SubEarthPoint.Longitude),RadToDeg(SubEarthPoint.Latitude),
                SunMoonAngle/OneDegree, 50*(1 + CosTheta), LunarAge(MJD),
                WithinToleranceCode,MoonUpSunDownCode]))
            else
              Memo1.Lines.Add(Format('%10s%10s%9.3f%1s%9.3f%1s%10.3f%8.3f%8.3f%8.3f%10.3f%10.3f%10.3f%10.3f  %1s%1s',
                [DateToStr(PrintDateTime),TimeToStr(PrintDateTime),Abs(MT),EW_Tag(MT),Abs(ET),EW_Tag(ET),
                CL,RadToDeg(SubSolarPoint.Latitude),
                RadToDeg(SubEarthPoint.Longitude),RadToDeg(SubEarthPoint.Latitude),
                MoonPosition.TopocentricAlt,MoonPosition.Azimuth,
                SunPosition.TopocentricAlt,SunPosition.Azimuth,
                WithinToleranceCode,MoonUpSunDownCode]));

            Memo1.Refresh;
          end;
      end;

    Inc(LinesPrinted);
    Memo1.SelAttributes.Color := clBlack; // restore default

  end;  {PrintData}

begin {Tabulate_ButtonClick}
  Memo1.SetFocus;  // this forces scroll bars to move down as text is added

  Memo1.Lines.Add('');
  CurrentObserver := Special;

  Memo1.SelAttributes.Color := clBlack;

  OldGeocentricMode := GeocentricSubEarthMode; // record status of calling program
  GeocentricSubEarthMode := GeocentricObserver_Checkbox.Checked;  // note: observer position does not affect subsolar point/colongitude/sun angle calculations

  ObserverLongitude := -ObserverLongitude_LabeledNumericEdit.NumericEdit.ExtendedValue;
  ObserverLatitude := ObserverLatitude_LabeledNumericEdit.NumericEdit.ExtendedValue;
  ObserverElevation := ObserverElevation_LabeledNumericEdit.NumericEdit.ExtendedValue;

  StartMJD := DateTimeToModifiedJulianDate(DateOf(StartDate_DateTimePicker.Date));
  EndMJD   := DateTimeToModifiedJulianDate(DateOf(EndDate_DateTimePicker.Date));

  if not JPL_File_Valid(StartMJD) then exit;

  LinesPrinted := 0;
  AbortTabulation := False;

  if ColongitudeMode_RadioButton.Checked then
    begin
      TargetSolarLat := DegToRad(SolarLatitude_LabeledNumericEdit.NumericEdit.ExtendedValue);
      AllowableLatitudeErrorDegrees := Abs(IncTolerance_LabeledNumericEdit.NumericEdit.ExtendedValue);

      TargetCL := DegToRad(Colongitude_LabeledNumericEdit.NumericEdit.ExtendedValue);
      Memo1.Lines.Add(Format('Searching for Colong = %0.3f  with  Solar Lat = %0.3f',
        [RadToDeg(TargetCL),RadToDeg(TargetSolarLat)]));
      PrintHeader;

      AllowableError := DegToRad(0.00001);
      MJD := StartMJD;
      while (MJD<EndMJD) and (not AbortTabulation) do
        begin
          UpdateCL;
          while Abs(CL_Error)>AllowableError do RefineCL;
          PrintData;
          MJD := MJD+SynodicMonth;
          Application.ProcessMessages;
        end;
    end
  else {Altitude mode}
    begin
      TargetSolarAzimuth := DegToRad(SunAzimuth_LabeledNumericEdit.NumericEdit.ExtendedValue);
      SunAngleMJDStep := SunAngleTimeStep_LabeledNumericEdit.NumericEdit.ExtendedValue*OneMinute/OneDay;
      AllowableAzimuthErrorDegrees := Abs(AzTolerance_LabeledNumericEdit.NumericEdit.ExtendedValue);

      CraterLonDeg := Crater_Lon_LabeledNumericEdit.NumericEdit.ExtendedValue;
      CraterLatDeg := Crater_Lat_LabeledNumericEdit.NumericEdit.ExtendedValue;
      SunAngleDeg  := SunAngle_LabeledNumericEdit.NumericEdit.ExtendedValue;

      Memo1.Lines.Add(Format('Searching for Sun Angle = %0.4f deg over feature at %0.3f %s   %0.3f %s',
        [SunAngleDeg,Abs(CraterLonDeg),EW_Tag(CraterLonDeg),Abs(CraterLatDeg),NS_Tag(CraterLatDeg)]));

      TargetAngle := DegToRad(SunAngle_LabeledNumericEdit.NumericEdit.ExtendedValue);
      CosCraterLat := Cos(DegToRad(CraterLatDeg));
      SinCraterLat := Sin(DegToRad(CraterLatDeg));
      CraterLon := DegToRad(CraterLonDeg);
      PrintHeader;
      MJD := StartMJD;
//      Memo1.Lines.Add(Format('Start date Sun angle = %0.3f',[RadToDeg(SunAngle(MJD))]));
//      Memo1.Lines.Add(Format('Refined date Sun angle = %0.3f',[RadToDeg(SunAngle(MJD))]));
      OldSunAngle := SunAngle(MJD);
      while (MJD<EndMJD) and (not AbortTabulation) do
        begin
          NewSunAngle := SunAngle(MJD+SunAngleMJDStep);
          if ((TargetAngle>=OldSunAngle) and (TargetAngle<=NewSunAngle)) or ((TargetAngle<=OldSunAngle) and (TargetAngle>=NewSunAngle)) then
            begin  // TargetAngle is between OldSunAngle and NewSunAngle
              RefineSunAngleDate;  // sets MJD to when SunAngle(MJD) = TargetAngle, within this interval
              PrintData;
              Memo1.Refresh;
            end;
          MJD := MJD+SunAngleMJDStep;
          OldSunAngle := NewSunAngle;
          Application.ProcessMessages;
        end;
    end;

  if LinesPrinted>0 then
    begin
      Memo1.Lines.Add('');

      if SunAngleMode_RadioButton.Checked then
        begin
          Memo1.Lines.Add(Format('  %s = Target feature on visible disk',[TargetVisibleSymbol]));
          Memo1.Lines.Add(Format('  %s = Azimuth of Sun within %0.2f deg of target (= %0.3f)',[WithinToleranceSymbol,AllowableAzimuthErrorDegrees,RadToDeg(TargetSolarAzimuth)]));
        end
      else
        Memo1.Lines.Add(Format('  %s = Latitude of sub-solar point within %0.2f deg of target (= %0.3f)',[WithinToleranceSymbol,AllowableLatitudeErrorDegrees,RadToDeg(TargetSolarLat)]));

      if not GeocentricSubEarthMode then Memo1.Lines.Add(Format('  %s = Moon above horizon/Sun below horizon',[MoonUpSunDownSymbol]));
      Memo1.Lines.Add('');
      if AbortTabulation then
        Memo1.Lines.Add('                     *** tabulation aborted ***')
      else
        Memo1.Lines.Add('                      *** search completed ***');
    end
  else
    begin
      Memo1.Lines.Add('');
      if AbortTabulation then
        Memo1.Lines.Add('                     *** tabulation aborted ***')
      else
        Memo1.Lines.Add('                      *** no events found ***');
    end;

  GeocentricSubEarthMode := OldGeocentricMode; // restore status of calling program

end;  {Tabulate_ButtonClick}

procedure TMoonEventPredictor_Form.Font_ButtonClick(Sender: TObject);
begin
  if FontDialog1.Execute then Memo1.Font := FontDialog1.Font;
end;

procedure TMoonEventPredictor_Form.ColongitudeMode_RadioButtonClick(Sender: TObject);
begin
  ColongitudeMode_GroupBox.Show;
  SunAltitudeMode_GroupBox.Hide;
end;

procedure TMoonEventPredictor_Form.SunAngleMode_RadioButtonClick(Sender: TObject);
begin
  ColongitudeMode_GroupBox.Hide;
  SunAltitudeMode_GroupBox.Show;
end;

procedure TMoonEventPredictor_Form.GeocentricObserver_CheckBoxClick(Sender: TObject);
begin
  ObserverLocation_GroupBox.Visible := not GeocentricObserver_CheckBox.Checked;
end;

procedure TMoonEventPredictor_Form.Abort_ButtonClick(Sender: TObject);
begin
  AbortTabulation := True;
end;

procedure TMoonEventPredictor_Form.Date_DateTimePickerKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=27 then with Terminator_SetYear_Form do
    begin
      ShowModal;
      if SetYearRequested then
        Date_DateTimePicker.DateTime :=
          EncodeDate(DesiredYear_LabeledNumericEdit.NumericEdit.IntegerValue,
            MonthOf(Date_DateTimePicker.DateTime),DayOf(Date_DateTimePicker.DateTime));
    end
  else
    LTVT_Form.DisplayF1Help(Key,Shift,'MoonEventPredictorForm.htm');
end;

procedure TMoonEventPredictor_Form.Time_DateTimePickerKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  LTVT_Form.DisplayF1Help(Key,Shift,'MoonEventPredictorForm.htm');
end;

procedure TMoonEventPredictor_Form.CalculateCircumstances_ButtonKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  LTVT_Form.DisplayF1Help(Key,Shift,'MoonEventPredictorForm.htm');
end;

procedure TMoonEventPredictor_Form.ColongitudeMode_RadioButtonKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  LTVT_Form.DisplayF1Help(Key,Shift,'MoonEventPredictorForm.htm');
end;

procedure TMoonEventPredictor_Form.SunAngleMode_RadioButtonKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  LTVT_Form.DisplayF1Help(Key,Shift,'MoonEventPredictorForm.htm');
end;

procedure TMoonEventPredictor_Form.GeocentricObserver_CheckBoxKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  LTVT_Form.DisplayF1Help(Key,Shift,'MoonEventPredictorForm.htm');
end;

procedure TMoonEventPredictor_Form.Crater_Lon_LabeledNumericEditNumericEditKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  LTVT_Form.DisplayF1Help(Key,Shift,'MoonEventPredictorForm.htm');
end;

procedure TMoonEventPredictor_Form.SunAngle_LabeledNumericEditNumericEditKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  LTVT_Form.DisplayF1Help(Key,Shift,'MoonEventPredictorForm.htm');
end;

procedure TMoonEventPredictor_Form.SunAngleTimeStep_LabeledNumericEditNumericEditKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  LTVT_Form.DisplayF1Help(Key,Shift,'MoonEventPredictorForm.htm');
end;

procedure TMoonEventPredictor_Form.Crater_Lat_LabeledNumericEditNumericEditKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  LTVT_Form.DisplayF1Help(Key,Shift,'MoonEventPredictorForm.htm');
end;

procedure TMoonEventPredictor_Form.SunAzimuth_LabeledNumericEditNumericEditKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  LTVT_Form.DisplayF1Help(Key,Shift,'MoonEventPredictorForm.htm');
end;

procedure TMoonEventPredictor_Form.AzTolerance_LabeledNumericEditNumericEditKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  LTVT_Form.DisplayF1Help(Key,Shift,'MoonEventPredictorForm.htm');
end;

procedure TMoonEventPredictor_Form.Colongitude_LabeledNumericEditNumericEditKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  LTVT_Form.DisplayF1Help(Key,Shift,'MoonEventPredictorForm.htm');
end;

procedure TMoonEventPredictor_Form.IncTolerance_LabeledNumericEditNumericEditKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  LTVT_Form.DisplayF1Help(Key,Shift,'MoonEventPredictorForm.htm');
end;

procedure TMoonEventPredictor_Form.StartDate_DateTimePickerKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=27 then with Terminator_SetYear_Form do
    begin
      ShowModal;
      if SetYearRequested then
        StartDate_DateTimePicker.DateTime :=
          EncodeDate(DesiredYear_LabeledNumericEdit.NumericEdit.IntegerValue,
            MonthOf(StartDate_DateTimePicker.DateTime),DayOf(StartDate_DateTimePicker.DateTime));
    end
  else
    LTVT_Form.DisplayF1Help(Key,Shift,'MoonEventPredictorForm.htm');
end;

procedure TMoonEventPredictor_Form.EndDate_DateTimePickerKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=27 then with Terminator_SetYear_Form do
    begin
      ShowModal;
      if SetYearRequested then
        EndDate_DateTimePicker.DateTime :=
          EncodeDate(DesiredYear_LabeledNumericEdit.NumericEdit.IntegerValue,
            MonthOf(EndDate_DateTimePicker.DateTime),DayOf(EndDate_DateTimePicker.DateTime));
    end
  else
    LTVT_Form.DisplayF1Help(Key,Shift,'MoonEventPredictorForm.htm');
end;

procedure TMoonEventPredictor_Form.FilterOutput_CheckBoxKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  LTVT_Form.DisplayF1Help(Key,Shift,'MoonEventPredictorForm.htm');
end;

procedure TMoonEventPredictor_Form.Tabulate_ButtonKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  LTVT_Form.DisplayF1Help(Key,Shift,'MoonEventPredictorForm.htm');
end;

procedure TMoonEventPredictor_Form.Memo1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  LTVT_Form.DisplayF1Help(Key,Shift,'MoonEventPredictorForm.htm');
end;

procedure TMoonEventPredictor_Form.Font_ButtonKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  LTVT_Form.DisplayF1Help(Key,Shift,'MoonEventPredictorForm.htm');
end;

procedure TMoonEventPredictor_Form.ClearMemo_ButtonKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  LTVT_Form.DisplayF1Help(Key,Shift,'MoonEventPredictorForm.htm');
end;

procedure TMoonEventPredictor_Form.ObserverLongitude_LabeledNumericEditNumericEditKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  LTVT_Form.DisplayF1Help(Key,Shift,'MoonEventPredictorForm.htm');
end;

procedure TMoonEventPredictor_Form.ObserverLatitude_LabeledNumericEditNumericEditKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  LTVT_Form.DisplayF1Help(Key,Shift,'MoonEventPredictorForm.htm');
end;

procedure TMoonEventPredictor_Form.ObserverElevation_LabeledNumericEditNumericEditKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  LTVT_Form.DisplayF1Help(Key,Shift,'MoonEventPredictorForm.htm');
end;

procedure TMoonEventPredictor_Form.SolarLatitude_LabeledNumericEditNumericEditKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  LTVT_Form.DisplayF1Help(Key,Shift,'MoonEventPredictorForm.htm');
end;

procedure TMoonEventPredictor_Form.LibrationTabulator_ButtonKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  LTVT_Form.DisplayF1Help(Key,Shift,'MoonEventPredictorForm.htm');
end;

procedure TMoonEventPredictor_Form.Abort_ButtonKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  LTVT_Form.DisplayF1Help(Key,Shift,'MoonEventPredictorForm.htm');
end;

procedure TMoonEventPredictor_Form.ObservatoryList_ComboBoxKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  LTVT_Form.DisplayF1Help(Key,Shift,'MoonEventPredictorForm.htm');
end;

procedure TMoonEventPredictor_Form.AddLocation_ButtonKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  LTVT_Form.DisplayF1Help(Key,Shift,'MoonEventPredictorForm.htm');
end;

end.

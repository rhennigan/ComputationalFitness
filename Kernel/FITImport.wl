(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "RH`ComputationalFitness`" ];

FITImport // ClearAll;

Begin[ "`Private`" ];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Config*)
$timeOffset       = 0;
$ftp              = Automatic;
$maxHR            = Automatic;
$weight           = Automatic;
$sport            = Automatic;
$fileByteCount    = 0;
$pzPlotWidth      = 650;
$invalidSINT8     = 127;
$invalidUINT8     = 255;
$invalidUINT8Z    = 0;
$invalidSINT16    = 32767;
$invalidUINT16    = 65535;
$invalidUINT16Z   = 0;
$invalidSINT32    = 2147483647;
$invalidUINT32    = 4294967295;
$invalidUINT32Z   = 0;
$invalidTimestamp = 2840036400;
$fitTerm          = 1685024357;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Units*)
$altitudeUnits    := $UnitSystem;
$distanceUnits    := $UnitSystem;
$heightUnits      := $UnitSystem;
$speedUnits       := $UnitSystem;
$temperatureUnits := $UnitSystem;
$weightUnits      := $UnitSystem;
$pressureUnits    := $UnitSystem;

$units := <| |>

(* ::**********************************************************************:: *)
(* ::Section:: *)
(*Messages*)
FITImport::Internal =
"An unexpected error occurred. `1`";

FITImport::InvalidFile =
"First argument `1` is not a valid file, directory, or URL specification.";

FITImport::InvalidFitFile =
"Cannot import data as FIT format.";

FITImport::InvalidElement =
"The import element \"`1`\" is not present when importing as FIT.";

FITImport::BadElementSpecification =
"The import element specification \"`1`\" is not valid.";

FITImport::FileNotFound =
"File `1` not found."

FITImport::IncompatibleSystemID =
"FITImport is not compatible with the system ID \"`1`\".";

FITImport::IncompatibleSystemID2 =
"FITImport is not compatible with the system ID \"`1`\". Supported platforms \
are: `2`.";

FITImport::CompileOnDemand =
"FITImport does not include compiled libraries for the system ID \"`1`\". \
Attempting to compile a library from sources...";

FITImport::CompileFailure =
"FITImport was unable to compile a library for the system ID \"`1`\".";

FITImport::CloudLibraryFunction =
"FITImport is not supported in the cloud.";

FITImport::LibraryFunctionLoadFail =
"FITImport could not load the library function \"`1`\".";

FITImport::CopyTemporaryFailed =
"Failed to copy source to a temporary file.";

FITImport::ArgumentCount =
"FITImport called with `1` arguments; between 1 and 2 arguments are expected.";

FITImport::InvalidFTP =
"The value `1` is not a valid value for functional threshold power.";

FITImport::InvalidMaxHR =
"The value `1` is not a valid value for maximum heart rate.";

FITImport::InvalidWeight =
"The value `1` is not a valid value for weight.";

FITImport::InvalidUnitSystem =
"The value `1` is not a valid value for UnitSystem.";

FITImport::LibraryError =
"Encountered an internal library error: `1`";

FITImport::LibraryErrorConversion =
"Invalid FIT format: `1`";

FITImport::LibraryErrorUnexpectedEOF =
"Encountered an unexpected end of file in `1`.";

FITImport::LibraryErrorUnsupportedProtocol =
"Library error: FIT_IMPORT_ERROR_UNSUPPORTED_PROTOCOL (`1`).";

FITImport::LibraryErrorInternal =
"Library error: FIT_IMPORT_ERROR_INTERNAL (`1`). `4`";

FITImport::LibraryErrorOpenFile =
"Cannot read from file `2`. Check permissions and try again.";

FITImport::NoFTPValue =
"No functional threshold power specified.";

FITImport::NoRecordsAvailable =
"No records available in the specified FIT file.";

(* ::**********************************************************************:: *)
(* ::Section:: *)
(*Attributes*)
FITImport // Attributes = { };

(* ::**********************************************************************:: *)
(* ::Section:: *)
(*Options*)
FITImport // Options = {
    "FunctionalThresholdPower" -> Automatic,
    "MaxHeartRate"             -> Automatic,
    "Weight"                   -> Automatic,
    "Sport"                    -> Automatic,
    UnitSystem                 :> $UnitSystem
};

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Argument patterns*)

$$string          = _String? StringQ;
$$bytes           = _ByteArray? ByteArrayQ;
$$assoc           = _Association? AssociationQ;
$$file            = File[ $$string ];
$$url             = URL[ $$string ];
$$co              = HoldPattern[ CloudObject ][ $$string, OptionsPattern[ ] ];
$$lo              = HoldPattern[ LocalObject ][ $$string, OptionsPattern[ ] ];
$$resp            = HoldPattern[ HTTPResponse ][ $$bytes, $$assoc, OptionsPattern[ ] ];
$$source          = $$string | $$file | $$url | $$co | $$lo | $$resp;
$$fitRecordKeys   = _? fitRecordKeyQ  | { ___? fitRecordKeyQ  };
$$fitEventKeys    = _? fitEventKeyQ | { ___? fitEventKeyQ };
$$elements        = _? elementQ | { ___? elementQ };
$$prop            = _? fitEventKeyQ | _? fitRecordKeyQ | _? elementQ;
$$propList        = { $$prop... };
$$props           = $$prop | $$propList;
$$messageType     = _? messageTypeQ;
$$messageTypes    = $$messageType | { $$messageType... };

(* ::**********************************************************************:: *)
(* ::Section:: *)
(*Main definition*)
FITImport[ file_, opts: OptionsPattern[ ] ] :=
    catchTop @ FITImport[ file, "Dataset", opts ];

FITImport[ file_? FileExistsQ, "RawData", opts: OptionsPattern[ ] ] :=
    fitOptionsBlock[ fitImport @ ExpandFileName @ file, opts ];

FITImport[ file_? FileExistsQ, "Data", opts: OptionsPattern[ ] ] :=
    fitOptionsBlock[
        Module[ { data, messages },
            data     = FITImport[ file, "RawData", opts ];
            messages = selectMessageType[ data, "Record" ];
            formatFitData @ messages
        ],
        opts
    ];

FITImport[ file_? FileExistsQ, type: $$messageTypes, opts: OptionsPattern[ ] ] :=
    fitOptionsBlock[
        Module[ { data },
            data = FITImport[ file, "RawData", opts ];
            makeMessageTypeData[ data, type ]
        ],
        opts
    ];

FITImport[ file_? FileExistsQ, "Dataset", opts: OptionsPattern[ ] ] :=
    catchTop @ Module[ { data },
        data = FITImport[ file, "Data", opts ];
        If[ MatchQ[ data, { __Association } ],\
            Dataset @ KeyDrop[ data, "MessageType" ],
            throwFailure[ FITImport::NoRecordsAvailable ]
        ]
    ];

FITImport[ file_, type: "Events"|"Records"|"Laps", opts: OptionsPattern[ ] ] :=
    catchTop @ FITImport[ file, StringDelete[ type, "s"~~EndOfString, opts ] ];

FITImport[ file: $$file|$$string, prop_, opts: OptionsPattern[ ] ] /;
    ! FileExistsQ @ file :=
        With[ { found = findFile @ file },
            FITImport[ found, prop, opts ] /; FileExistsQ @ found
        ];

FITImport[ file_, "MessageInformation", opts: OptionsPattern[ ] ] :=
    fitOptionsBlock[
        Module[ { data, gathered, format, formatted, drop, grouped },
            data      = fitMessageTypes @ file;
            gathered  = GatherBy[ data, #[[ 2 ]] & ];
            format    = Append[ makeFitAssociation @ #[[ 1 ]], "Count" -> Length @ # ] &;
            formatted = format /@ gathered;
            drop      = { "MessageIndex", "MessageTypeName", "FileOffset" };
            grouped   = #MessageTypeName -> KeyDrop[ #, drop ] & /@ formatted;
            Dataset @ Association @ grouped
        ],
        opts
    ];

FITImport[ file_, "MessageCounts", opts: OptionsPattern[ ] ] :=
    fitOptionsBlock[
        Module[ { data },
            data = fitMessageTypes @ file;
            Counts[ fitMessageType /@ data[[ All, 2 ]] ]
        ],
        opts
    ];

FITImport[ file_, "Messages", opts: OptionsPattern[ ] ] :=
    fitOptionsBlock[
        DeleteMissing /@ formatFitData @ FITImport[ file, "RawData", opts ],
        opts
    ];

FITImport[ file_, "MessageData", opts: OptionsPattern[ ] ] :=
    fitOptionsBlock[
        Dataset @ GroupBy[
            FITImport[ file, "Messages", opts ],
            #MessageType &
        ],
        opts
    ];

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Special Properties*)
FITImport[ _, "Elements", OptionsPattern[ ] ] :=
    Union[ $fitElements, $messageTypes ];

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*TimeSeries Data*)
FITImport[ file_, "TimeSeries", opts: OptionsPattern[ ] ] :=
    catchTop @ FITImport[ file, { "TimeSeries", $fitRecordKeys }, opts ];

FITImport[ file_, key: $$fitRecordKeys, opts: OptionsPattern[ ] ] :=
    catchTop @ FITImport[ file, { "TimeSeries", key }, opts ];

FITImport[ file_, { "TimeSeries", key: $$fitRecordKeys }, opts: OptionsPattern[ ] ] :=
    fitOptionsBlock[
        Module[ { data, records },
            data = FITImport[ file, "RawData", opts ];
            records = selectMessageType[ data, "Record" ];
            makeTimeSeriesData[ "Record", records, key ]
        ],
        opts
    ];

FITImport[ file_, All, opts: OptionsPattern[ ] ] :=
    catchTop @ FITImport[ file, { "TimeSeries", All }, opts ];

FITImport[ file_, { "TimeSeries", All }, opts: OptionsPattern[ ] ] :=
    catchTop @ Module[ { data, records },
        data  = FITImport[ file, "RawData", opts ];
        records = selectMessageType[ data, "Record" ];
        DeleteMissing @ makeTimeSeriesData[
            "Record",
            records,
            DeleteCases[ $fitRecordKeys, "MessageType"|"Timestamp" ]
        ]
    ];

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Mixed Elements*)
FITImport[ file_, props: $$propList, opts: OptionsPattern[ ] ] :=
    catchTop @ Module[ { data, fitKeys, elements, ts, as, joined },
        data     = FITImport[ file, "RawData", opts ];
        fitKeys  = Select[ props, fitRecordKeyQ ];
        elements = Select[ props, elementQ ];
        ts       = makeTimeSeriesData[ data, fitKeys ];
        as       = makeElementData[ file, data, elements, opts ];
        joined   = Association[ ts, as ];

        If[ AssociationQ @ joined,
            KeyTake[ joined, props ],
            throwInternalFailure @ FITImport[ file, props, opts ]
        ]
    ];

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Graphics*)
FITImport[ file_, "PowerZonePlot", opts: OptionsPattern[ ] ] :=
    fitOptionsBlock[
        powerZonePlot @ FITImport[ file, "Power", opts ],
        opts
    ];

FITImport[ file_, "AveragePowerPhasePlot", opts: OptionsPattern[ ] ] :=
    fitOptionsBlock[
        averagePowerPhasePlot @ FITImport[ file, "Session", opts ],
        opts
    ];

FITImport[ file_, "CriticalPowerCurvePlot", opts: OptionsPattern[ ] ] :=
    fitOptionsBlock[
        criticalPowerCurve @ FITImport[ file, "Power", opts ],
        opts
    ];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Error cases*)
FITImport[ $$source, { ___, e: Except[ $$props ], ___ }, OptionsPattern[ ] ] :=
    catchTop[
        If[ StringQ @ e,
            throwFailure[ FITImport::InvalidElement         , e ],
            throwFailure[ FITImport::BadElementSpecification, e ]
        ]
    ];


FITImport[ $$source, e: Except[ $$props ], OptionsPattern[ ] ] :=
    catchTop[
        If[ StringQ @ e,
            throwFailure[ FITImport::InvalidElement         , e ],
            throwFailure[ FITImport::BadElementSpecification, e ]
        ]
    ];

FITImport[ source: $$source, _, opts: OptionsPattern[ ] ] :=
    catchTop @ throwFailure[ FITImport::FileNotFound, source ];

FITImport[ source: Except @ $$source, _, opts: OptionsPattern[ ] ] :=
    catchTop @ throwFailure[ FITImport::InvalidFile, source ];

FITImport[ source: $$source, elem_String, opts: OptionsPattern[ ] ] /;
    ! elementQ @ elem :=
        catchTop @ throwFailure[ FITImport::InvalidElement, elem ];

FITImport[ args___ ] :=
    catchTop @ With[ { len = Length @ HoldComplete @ args },
        throwFailure[ FITImport::ArgumentCount, len ]
    ];

(* ::**********************************************************************:: *)
(* ::Section:: *)
(*Dependencies*)

$fitElements = {
    "Data",
    "Dataset",
    "Elements",
    "Events",
    "RawData",
    "Records",
    "MessageInformation",
    "MessageData",
    "Messages",
    "PowerZonePlot",
    "AveragePowerPhasePlot",
    "CriticalPowerCurvePlot"
};

$messageTypes = {
    "FileID",
    "Event",
    "Record",
    "DeviceInformation",
    "Session",
    "UserProfile",
    "Activity",
    "Lap",
    "DeviceSettings",
    "ZonesTarget",
    "FileCreator",
    "Sport",
    "DeveloperDataID",
    "FieldDescription",
    "TrainingFile",
    "HeartRateVariability",
    "WorkoutStep"
};

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*fitOptionsBlock*)
fitOptionsBlock // beginDefinition;
fitOptionsBlock // Attributes = { HoldFirst };

fitOptionsBlock[ eval_, opts: OptionsPattern[ FITImport ] ] :=
    catchTop @ Block[
        {
            $UnitSystem     = setUnitSystem @ OptionValue @ UnitSystem, (* FIXME: fix it! *)
            $ftp            = setFTP @ OptionValue @ FunctionalThresholdPower,
            $maxHR          = setMaxHR @ OptionValue @ MaxHeartRate,
            $weight         = setWeight @ OptionValue @ Weight,
            $sport          = setSport @ OptionValue @ Sport,
            $timeOffset     = 0,
            $fileByteCount  = 0,
            $lastHRV        = None,
            fitOptionsBlock = # &
        },
        eval
    ];

fitOptionsBlock // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*setPreferences*)
setPreferences // beginDefinition;

setPreferences[ data_ ] := (
    setUnitPrefs  @ data;
    setTimeOffset @ data;
    setWeightPref @ data;
    setFTPPref    @ data;
    setMaxHRPref  @ data;
);

setPreferences[ data_List ] :=
    Module[ { reverse, profile, activity, session, sport },

        reverse  = Reverse @ data;
        profile  = selectFirstMessageType[ data   , "UserProfile" ];
        activity = selectFirstMessageType[ reverse, "Activity"    ];
        session  = selectFirstMessageType[ reverse, "Session"     ];
        sport    = selectFirstMessageType[ data   , "Sport"       ];

        setPreferences0 @ DeleteMissing @ <|
            "UserProfile" -> profile,
            "Activity"    -> activity,
            "Session"     -> session,
            "Sport"       -> sport
        |>
    ];

setPreferences // endDefinition;

setPreferences0 // beginDefinition;
setPreferences0[ config_ ] := (
    setSportPref  @ config;
    setUnitPrefs  @ config;
    setTimeOffset @ config;
    setWeightPref @ config;
    setFTPPref    @ config;
    setMaxHRPref  @ config;
);
setPreferences0 // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*setSportPref*)
setSportPref // beginDefinition;

setSportPref[ config_ ] := setSportPref[ config, $sport ];

setSportPref[ as_Association, Automatic ] :=
    Module[ { v, sport },
        v = Lookup[ as, "Sport", Lookup[ as, "Session" ] ];
        sport = If[ ListQ @ v, fitValue[ "Sport", "Sport", v ], v ];
        If[ StringQ @ sport,
            $sport = setSport @ sport,
            $sport = setSport @ PersistentSymbol[ "FITImport/Sport" ];
        ]
    ];

setSportPref[ as_Association, sport_ ] :=
    $sport = setSport @ sport;

setSportPref // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*setUnitPrefs*)
setUnitPrefs // beginDefinition;

setUnitPrefs[ config_ ] := setUnitPrefs[ config, $unitSystem ];

setUnitPrefs[ config_Association, Automatic ] :=
    setUnitPrefs[ config, $autoUnits, config[ "UserProfile" ] ];

setUnitPrefs[ config_, as: KeyValuePattern @ { } ] :=
    setUnitPrefs[
        config,
        Association[ $autoUnits, as ],
        config[ "UserProfile" ]
    ];

setUnitPrefs[ config_, _ ] := Null;

setUnitPrefs[ config_, as_Association, v_List ] := (
    setAltitudePrefs[    Lookup[ as, "Altitude"   , Automatic ], v ];
    setDistancePrefs[    Lookup[ as, "Distance"   , Automatic ], v ];
    setHeightPrefs[      Lookup[ as, "Height"     , Automatic ], v ];
    setSpeedPrefs[       Lookup[ as, "Speed"      , Automatic ], v ];
    setTemperaturePrefs[ Lookup[ as, "Temperature", Automatic ], v ];
    setWeightPrefs[      Lookup[ as, "Weight"     , Automatic ], v ];
    setPressurePrefs[    Lookup[ as, "Pressure"   , Automatic ], v ];
);

setUnitPrefs[ config_, Automatic, _ ] :=
    $unitSystem = setUnitSystem @ PersistentSymbol[ "FITImport/UnitSystem" ];

setUnitPrefs // endDefinition;

$autoUnits = <|
    "Altitude"    -> Automatic,
    "Distance"    -> Automatic,
    "Height"      -> Automatic,
    "Speed"       -> Automatic,
    "Temperature" -> Automatic,
    "Weight"      -> Automatic,
    "Pressure"    -> Automatic
|>;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*setProfileUnits*)
setProfileUnits // beginDefinition;
setProfileUnits // Attributes = { HoldFirst };

setProfileUnits[ s_Symbol, key_String, v_List ] :=
    s = setUnitSystem @ fitValue[ "UserProfile", key, v ];

setProfileUnits // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*setAltitudePrefs*)
setAltitudePrefs // beginDefinition;

setAltitudePrefs[ Automatic, v_List ] :=
    setProfileUnits[ $altitudeUnits, "ElevationSetting", v ];

setAltitudePrefs[ setting_, _ ] :=
    $altitudeUnits = setUnitSystem @ setting;

setAltitudePrefs // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*setTimeOffset*)
setTimeOffset // beginDefinition;

setTimeOffset[ config_Association ] :=
    setTimeOffset[ config, config[ "Activity" ] ];

setTimeOffset[ config_, v_List ] :=
    Module[ { t1, t2 },
        t1 = fitValue[ "Activity", "Timestamp"     , v ];
        t2 = fitValue[ "Activity", "LocalTimestamp", v ];
        If[ MatchQ[ { t1, t2 }, { _DateObject, _DateObject } ],
            $timeOffset = AbsoluteTime @ t1 - AbsoluteTime @ t2,
            $timeOffset = 0
        ]
    ];

setTimeOffset[ data_, _Missing ] :=
    Null;

setTimeOffset // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*setFTPPref*)
setFTPPref // beginDefinition;

setFTPPref[ config_ ] := setFTPPref[ config, $ftp ];

setFTPPref[ config_Association, Automatic ] :=
    setFTPPref[ config, Automatic, config[ "Session" ] ];

setFTPPref[ config_, _ ] := Null;

setFTPPref[ config_, Automatic, v_List ] :=
    Module[ { ftp },
        ftp = fitValue[ "Session", "ThresholdPower", v ];
        If[ TrueQ @ Positive @ ftp,
            $ftp = setFTP @ ftp,
            $ftp = setFTP @ PersistentSymbol[ "FITImport/FunctionalThresholdPower" ]
        ]
    ];

setFTPPref[ config_, Automatic, _ ] :=
    $ftp = setFTP @ PersistentSymbol[ "FITImport/FunctionalThresholdPower" ];

setFTPPref // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*setMaxHRPref*)
setMaxHRPref // beginDefinition;

setMaxHRPref[ config_ ] := setMaxHRPref[ config, $maxHR ];

setMaxHRPref[ config_Association, Automatic ] :=
    setMaxHRPref[ config, Automatic, config[ "UserProfile" ] ];

setMaxHRPref[ config_, _ ] := Null;

setMaxHRPref[ config_, Automatic, v_List ] :=
    Module[ { maxHR },
        maxHR = fitValue[ "UserProfile", "DefaultMaxHeartRate", v ];
        If[ TrueQ @ Positive @ maxHR,
            $maxHR = setMaxHR @ maxHR,
            $maxHR = setMaxHR @ PersistentSymbol[ "FITImport/MaxHeartRate" ]
        ]
    ];

setMaxHRPref[ config_, Automatic, _ ] :=
    $maxHR = setMaxHR @ PersistentSymbol[ "FITImport/MaxHeartRate" ];

setMaxHRPref // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*setWeightPref*)
setWeightPref // beginDefinition;

setWeightPref[ config_ ] := setWeightPref[ config, $weight ];

setWeightPref[ config_Association, Automatic ] :=
    setWeightPref[ data, Automatic, config[ "UserProfile" ] ];

setWeightPref[ config_, _ ] := Null;

setWeightPref[ config_, Automatic, v_List ] :=
    Module[ { weight },
        weight = fitValue[ "UserProfile", "Weight", v ];
        If[ TrueQ @ Positive @ weight,
            $weight = setWeight @ weight,
            $weight = setWeight @ PersistentSymbol[ "FITImport/Weight" ]
        ]
    ];

setWeightPref[ config_, Automatic, _ ] :=
    $weight = setWeight @ PersistentSymbol[ "FITImport/Weight" ];

setFTPPref // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*selectMessageType*)
selectMessageType // beginDefinition;

selectMessageType[ data_, type_String ] :=
    selectMessageType[ data, fitMessageTypeNumber @ type ];

selectMessageType[ data_, type_Integer ] :=
    Developer`ToPackedArray @ Select[ data, #[[ 1 ]] === type & ];

selectMessageType[ data_, type_ ] :=
    With[ { p = type /. s_String :> RuleCondition @ fitMessageTypeNumber @ s },
        Developer`ToPackedArray @ Select[ data, MatchQ[ #[[ 1 ]], p ] & ]
    ];

selectMessageType // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*selectFirstMessageType*)
selectFirstMessageType // beginDefinition;

selectFirstMessageType[ data_, type_String ] :=
    selectFirstMessageType[ data, fitMessageTypeNumber @ type ];

selectFirstMessageType[ data_, type_Integer ] :=
    FirstCase[ data, { type, ___ } ];

selectFirstMessageType // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*setUnitSystem*)
setUnitSystem // beginDefinition;
setUnitSystem[ Automatic|None|_Missing ] := $UnitSystem;
setUnitSystem[ units: "Imperial"|"Metric" ] := units;
setUnitSystem[ "Statute" ] := "Imperial";
setUnitSystem[ "SI" ] := "Metric";
setUnitSystem[ KeyValuePattern[ "UnitSystem" -> u_ ] ] := setUnitSystem @ u;
setUnitSystem[ KeyValuePattern[ UnitSystem -> u_ ] ] := setUnitSystem @ u;
setUnitSystem[ units_ ] := throwFailure[ FITImport::InvalidUnitSystem, units ];
setUnitSystem // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*setFTP*)
setFTP // beginDefinition;
setFTP[ Automatic     ] := Automatic;
setFTP[ None|_Missing ] := None;
setFTP[ ftp_Integer   ] := N @ ftp;
setFTP[ ftp_Real      ] := ftp;
setFTP[ Quantity[ ftp_, "Watts" ] ] := setFTP @ ftp;
setFTP[ ftp_Quantity ] := setFTP @ UnitConvert[ ftp, "Watts" ];
setFTP[ ftp_ ] := throwFailure[ FITImport::InvalidFTP, ftp ];
setFTP // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*setMaxHR*)
setMaxHR // beginDefinition;
setMaxHR[ Automatic     ] := Automatic;
setMaxHR[ None|_Missing ] := None;
setMaxHR[ hr_Integer    ] := N @ hr;
setMaxHR[ hr_Real       ] := hr;
setMaxHR[ Quantity[ hr_, "Beats"/"Minutes" ] ] := setMaxHR @ hr;
setMaxHR[ hr_Quantity ] := setMaxHR @ UnitConvert[ hr, "Beats"/"Minutes" ];
setMaxHR[ hr_ ] := throwFailure[ FITImport::InvalidMaxHR, hr ];
setMaxHR // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*setWeight*)
setWeight // beginDefinition;
setWeight[ Automatic     ] := Automatic;
setWeight[ None|_Missing ] := None;
setWeight[ w_Integer     ] := N @ w;
setWeight[ w_Real        ] := w;
setWeight[ Quantity[ w_, "Kilograms" ] ] := setWeight @ w;
setWeight[ w_Quantity ] := setWeight @ UnitConvert[ w, "Kilograms" ];
setWeight[ w_ ] := throwFailure[ FITImport::InvalidWeight, w ];
setWeight // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*setSport*)
setSport // beginDefinition;
setSport[ Automatic     ] := Automatic;
setSport[ None|_Missing ] := None;
setSport[ s_String      ] := s;
setSport[ s_            ] := throwFailure[ FITImport::InvalidSport, s ];
setSport // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*elementQ*)
elementQ[ elem_String ] := MemberQ[ $fitElements, elem ];
elementQ[ ___         ] := False;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*messageTypeQ*)
messageTypeQ[ type_String ] := MemberQ[ $messageTypes, type ];
messageTypeQ[ ___         ] := False;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*fitImport*)
fitImport // beginDefinition;
fitImport[ source: $$source ] := cached @ fitImport0 @ source;
fitImport // endDefinition;


fitImport0 // beginDefinition;

fitImport0[ source_ ] :=
    Block[ { $tempFiles = Internal`Bag[ ] },
        WithCleanup[
            fitImport0[ source, toFileString @ source ],
            DeleteFile /@ Internal`BagPart[ $tempFiles, All ]
        ]
    ];

fitImport0[ source_, file_String ] :=
    fitImport0[
        source,
        file,
        Quiet[ fitImportLibFunction @ file, LibraryFunction::rterr ]
    ];

fitImport0[ source_, file_, data_List? rawDataQ ] := (
    (* $start = data[[ 1, 1 ]]; *) (* Broken: need to ensure value is a timestamp *)
    setPreferences @ data;
    data
);

fitImport0[ source_, file_, err_LibraryFunctionError ] :=
    libraryError[ source, file, err ];

fitImport0 // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*fitMessageTypes*)
fitMessageTypes // beginDefinition;

fitMessageTypes[ source: $$source ] :=
    Block[ { $tempFiles = Internal`Bag[ ] },
        WithCleanup[
            fitMessageTypes[ source, toFileString @ source ],
            DeleteFile /@ Internal`BagPart[ $tempFiles, All ]
        ]
    ];

fitMessageTypes[ source_, file_String ] :=
    fitMessageTypes[
        source,
        file,
        Quiet[ fitMessageTypesLibFunction @ file, LibraryFunction::rterr ]
    ];

fitMessageTypes[ source_, file_, data_List? rawDataQ ] :=
    data;

fitMessageTypes[ source_, file_, err_LibraryFunctionError ] :=
    libraryError[ source, file, err ];

fitImport // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*libraryError*)
libraryError // beginDefinition;

libraryError[
    source_,
    file_,
    LibraryFunctionError[ "LIBRARY_USER_ERROR", code_ ]
] := libraryUserError[ source, file, code ];

libraryError[ source_, file_, err_LibraryFunctionError ] :=
    throwFailure[ FITImport::LibraryError, err ];

libraryError // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*libraryUserError*)
libraryUserError // beginDefinition;

libraryUserError[ source_, file_, n_Integer ] :=
    With[ { tag = Lookup[ $libraryErrorCodes, n ] },
        throwFailure[
            MessageName[ FITImport, tag ],
            source,
            file,
            n,
            $bugReportLink
        ] /; IntegerQ @ n
    ];

libraryUserError // endDefinition;

$libraryErrorCodes = <|
    8  -> "LibraryErrorConversion",
    9  -> "LibraryErrorUnexpectedEOF",
    10 -> "LibraryErrorConversion",
    11 -> "LibraryErrorUnsupportedProtocol",
    12 -> "LibraryErrorInternal",
    13 -> "LibraryErrorOpenFile"
|>;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*rawDataQ*)
rawDataQ[ { { } }  ] := False;
rawDataQ[ raw_List ] := MatrixQ[ raw, IntegerQ ];
rawDataQ[ ___      ] := False;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*makeMessageTypeData*)
makeMessageTypeData // beginDefinition;

makeMessageTypeData[ data_, type: $$messageType ] :=
    Module[ { ds },
        ds = makeMessageTypeData0[ data, type ];
        If[ MissingQ @ ds,
            ds,
            Dataset @ ds
        ]
    ];

makeMessageTypeData[ data_, types: { $$messageType.. } ] :=
    Dataset @ AssociationMap[ makeMessageTypeData0[ data, # ] &, types ];

makeMessageTypeData // endDefinition;

makeMessageTypeData0[ data_, type_ ] :=
    Module[ { formatted },
        formatted = formatFitData @ selectMessageType[ data, type ];
        If[ MissingQ @ formatted,
            formatted,
            KeyDrop[ formatted, "MessageType" ]
        ]
    ];

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*makeTimeSeriesData*)
makeTimeSeriesData // beginDefinition;

makeTimeSeriesData[ data_, key_ ] :=
    makeTimeSeriesData[ "Record", selectMessageType[ data, "Record" ], key ];

makeTimeSeriesData[ type_, data_, key_ ] :=
    makeTimeSeriesData[
        type,
        data,
        key,
        (fitValue[ type, "Timestamp", #1 ] &) /@ data
    ];

makeTimeSeriesData[ type_, data_, key_String, time_ ] :=
    Module[ { value },
        value = fitValue[ type, key, # ] & /@ data;
        If[ AllTrue[ value, MissingQ ],
            Missing[ "NotAvailable" ],
            TimeSeries[
                DeleteCases[ Transpose @ { time, value }, { _, _Missing } ],
                MissingDataMethod -> missingDataMethod @ key
            ]
        ]
    ];

makeTimeSeriesData[ type_, data_, keys_List, time_ ] :=
    AssociationMap[ makeTimeSeriesData[ type, data, #, time ] &, keys ];

makeTimeSeriesData // endDefinition;

missingDataMethod // beginDefinition;
missingDataMethod[ "GeoPosition" ] := { "Interpolation", InterpolationOrder -> 0 };
missingDataMethod[ _ ] := { "Interpolation", InterpolationOrder -> 1 };
missingDataMethod // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*makeElementData*)
makeElementData // beginDefinition;

makeElementData[ file_, data_, elements_List, opts: OptionsPattern[ ] ] :=
    AssociationMap[ FITImport[ file, #, opts ] &, elements ];

makeElementData[ file_, data_, element_, opts: OptionsPattern[ ] ] :=
    FITImport[ file, element, opts ];

makeElementData // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*powerZonePlot*)
powerZonePlot // beginDefinition;

powerZonePlot[ power: _TimeSeries|_TemporalData ] :=
    powerZonePlot[ power, $ftp ];

powerZonePlot[ power: _TimeSeries|_TemporalData, ftp_? NumberQ ] :=
    Module[ { mean, top, resampled, cf },
        mean = Mean @ power;
        top  = Max[ 1.2 * Max @ power, Quantity[ 1.5 * ftp, "Watts" ] ];
        resampled = TimeSeriesResample[ power, (power["LastDate"] - power["FirstDate"]) / 1600 ];
        cf = powerZonePlotCF @ ftp;
        DateListPlot[
            resampled,
            AspectRatio          -> 1 / 5,
            Filling              -> Bottom,
            ColorFunction        -> cf,
            ColorFunctionScaling -> False,
            PlotLegends          -> Placed[ $pzLegend, After ],
            ImageSize            -> $pzPlotWidth,
            PlotRange            -> { All, { Quantity[ 0, "Watts" ], top } },
            GridLines            -> {
                None,
                {
                    {
                        mean,
                        Directive[ Dashed, Gray ]
                    },
                    {
                        Quantity[ ftp, "Watts" ],
                        Directive[ Gray ]
                    }
                }
            }
        ]
    ];

powerZonePlot[ power_, Automatic|None|_Missing ] :=
    Module[ { mean, top, resampled },
        messageFailure[ FITImport::NoFTPValue ];
        mean = Mean @ power;
        top  = 1.2 * Max @ power;
        resampled = TimeSeriesResample[ power, (power["LastDate"] - power["FirstDate"]) / 1600 ];
        DateListPlot[
            resampled,
            AspectRatio          -> 1 / 5,
            Filling              -> Bottom,
            ImageSize            -> $pzPlotWidth,
            PlotRange            -> { All, { Quantity[ 0, "Watts" ], top } },
            GridLines            -> {
                None,
                { { mean, Directive[ Dashed, Gray ] } }
            }
        ]
    ];

powerZonePlot // endDefinition;


$pzLegend :=
    With[ { c = Reverse @ KeySort @ $powerZoneColors },
        SwatchLegend[
            Values @ c,
            Style[ #, FontSize -> 10 ] & /@ Lookup[ $pzDescriptions, Keys @ c ],
            LegendMarkers -> Graphics @ { Rectangle[ ] },
            (* LegendLabel   -> "zone", *)
            LegendMargins -> 2
        ]
    ];

$pzDescriptions = <|
    1 -> "Active Recovery",
    2 -> "Endurance",
    3 -> "Tempo",
    4 -> "Lactate Threshold",
    5 -> "\!\(\*SubscriptBox[\(VO\), \(2\)]\) max",
    6 -> "Anaerobic Capacity",
    7 -> "Neuromuscular Power"
|>;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*averagePowerPhasePlot*)
averagePowerPhasePlot // beginDefinition;

averagePowerPhasePlot[ session0_Dataset ] /; Length @ session0 >= 1 := Enclose[
    Module[
        {
            session, cq, cn, watts, percent, phase1, phase2, peak1, peak2,
            color, left, right, legend
        },
        session = session0[ 1 ];
        cq = ConfirmBy[ #, QuantityQ ] &;
        cn = ConfirmBy[ #, NumberQ ] &;

        watts = cq @ session[ "AveragePower" ];
        percent = cq @ session[ "LeftRightBalance" ][ 1 ];
        phase1 = cn @ Normal @ session[ "AverageLeftPowerPhaseStart" ];
        phase2 = cn @ Normal @ session[ "AverageLeftPowerPhaseEnd" ];
        peak1 = cn @ Normal @ session[ "AverageLeftPowerPhasePeakStart" ];
        peak2 = cn @ Normal @ session[ "AverageLeftPowerPhasePeakEnd" ];
        color = ColorData[ 97 ][ 3 ];

        left = phasePlotHalf[
            { phase1, phase2 },
            { peak1, peak2 },
            color,
            watts,
            percent,
            "LEFT"
        ];

        percent = cq @ session[ "LeftRightBalance" ][ 2 ];
        phase1 = cn @ Normal @ session[ "AverageRightPowerPhaseStart" ];
        phase2 = cn @ Normal @ session[ "AverageRightPowerPhaseEnd" ];
        peak1 = cn @ Normal @ session[ "AverageRightPowerPhasePeakStart" ];
        peak2 = cn @ Normal @ session[ "AverageRightPowerPhasePeakEnd" ];
        color = ColorData[ 97 ][ 1 ];

        right = phasePlotHalf[
            { phase1, phase2 },
            { peak1, peak2 },
            color,
            watts,
            percent,
            "RIGHT"
        ];

        legend = SwatchLegend[
            {
                Lighter[ ColorData[ 97 ][ 3 ], 0.35 ],
                ColorData[ 97 ][ 3 ],
                Lighter[ ColorData[ 97 ][ 1 ], 0.35 ],
                ColorData[ 97 ][ 1 ]
            },
            Map[
                Style[ #1, FontColor -> GrayLevel[ 0.4 ] ] &,
                {
                    "Left Power Phase",
                    "Left Peak Power Phase",
                    "Right Power Phase",
                    "Right Peak Power Phase"
                }
            ]
        ];

        GraphicsRow[ { left, right, legend } ]
    ],
    Missing[ "NotAvailable" ] &
];

averagePowerPhasePlot[ missing_Missing ] := missing;

averagePowerPhasePlot // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*phasePlotHalf*)
phasePlotHalf // beginDefinition;

phasePlotHalf[
    { phase1_, phase2_ },
    { peak1_, peak2_ },
    color_,
    watts_,
    percent_,
    label_
] :=
    Module[ { phase1Pt, phase2Pt, peak1Pt, peak2Pt },

        phase1Pt = { Sin @ phase1, Cos @ phase1 };
        phase2Pt = { Sin @ phase2, Cos @ phase2 };
        peak1Pt = { Sin @ peak1, Cos @ peak1 };
        peak2Pt = { Sin @ peak2, Cos @ peak2 };

        Graphics[
            {
                GrayLevel[ 0.75 ],
                Annulus[ { 0, 0 }, { 1, 1.1 } ],
                Lighter[ color, 0.35 ],
                Annulus[
                    { 0, 0 },
                    { 1, 1.2 },
                    -{ phase2, phase1 + (-1) * 2 * Pi } + Pi / 2
                ],
                White,
                Thick,
                Line @ { phase1Pt, 1.2 * phase1Pt },
                Line @ { phase2Pt, 1.2 * phase2Pt },
                color,
                Annulus[
                    { 0, 0 },
                    { 1, 1.35 },
                    -{ peak2, peak1 } + Pi / 2
                ],
                White,
                Line @ { peak1Pt, 1.35 * peak1Pt },
                Line @ { peak2Pt, 1.35 * peak2Pt },
                GrayLevel[ 0.4 ],
                Thickness[ 0.005 ],
                Line @ { { 0, 0.875 }, { 0, 0.925 } },
                Line @ { { 0, -0.875 }, { 0, -0.925 } },
                Line @ { { -0.95, 0 }, { -0.875, 0 } },
                Line @ { { 0.95, 0 }, { 0.875, 0 } },
                Text[
                    Style[
                        "TDC",
                        FontSize -> Scaled[ 1 / 25 ],
                        FontColor -> GrayLevel[ 0.5 ]
                    ],
                    { 0, 0.75 },
                    Automatic
                ],
                Text[
                    Style[
                        "BDC",
                        FontSize -> Scaled[ 1 / 25 ],
                        FontColor -> GrayLevel[ 0.5 ]
                    ],
                    { 0, -0.75 },
                    Automatic
                ],
                Black,
                (* Text[
                    Style[
                        label,
                        FontSize -> Scaled[ 1 / 14 ],
                        FontColor -> GrayLevel[ 0.5 ],
                        FontWeight -> Bold
                    ],
                    { 0, 0.45 },
                    Automatic
                ], *)
                Text[
                    Style[
                        Round[ percent, 0.1 ],
                        FontSize -> Scaled[ 1 / 8 ],
                        FontWeight -> Bold,
                        FontColor -> GrayLevel[ 0.25 ]
                    ],
                    { 0, 0.2 }
                ],
                Text[
                    Style[
                        Round[ Normal @ percent * watts, 0.1 ],
                        FontSize -> Scaled[ 1 / 12 ],
                        FontColor -> GrayLevel[ 0.5 ]
                    ],
                    { 0, -0.2 }
                ],
                GrayLevel[ 0.4 ],
                Thickness[ 0.01 ],
                Text[
                    Style[
                        Round @ Quantity[
                            360 * (phase1 / (2 * Pi)),
                            "AngularDegrees"
                        ],
                        FontSize -> Scaled[ 1 / 16 ],
                        FontColor -> GrayLevel[ 0.5 ]
                    ],
                    1.4 * phase1Pt,
                    Automatic
                ],
                Text[
                    Style[
                        Round @ Quantity[
                            360 * (phase2 / (2 * Pi)),
                            "AngularDegrees"
                        ],
                        FontSize -> Scaled[ 1 / 16 ],
                        FontColor -> GrayLevel[ 0.5 ]
                    ],
                    1.4 * phase2Pt,
                    Automatic
                ],
                Text[
                    Style[
                        Round @ Quantity[
                            360 * (peak1 / (2 * Pi)),
                            "AngularDegrees"
                        ],
                        FontSize -> Scaled[ 1 / 16 ],
                        FontColor -> GrayLevel[ 0.5 ]
                    ],
                    1.6 * peak1Pt,
                    Automatic
                ],
                Text[
                    Style[
                        Round @ Quantity[
                            360 * (peak2 / (2 * Pi)),
                            "AngularDegrees"
                        ],
                        FontSize -> Scaled[ 1 / 16 ],
                        FontColor -> GrayLevel[ 0.5 ]
                    ],
                    1.6 * peak2Pt,
                    Automatic
                ],
                GrayLevel[ 0.65 ],
                Arrowheads[ 0.075 ],
                Arrow @ BezierCurve @ {
                    { -1.275, -0.4 },
                    { -1.45, 0 },
                    { -1.275, 0.4 }
                }
            },
            ImageSize -> 200,
            PlotRange -> { { -1.65, 1.65 }, { -1.65, 1.65 } }
        ]
    ];

phasePlotHalf // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*criticalPowerCurve*)
criticalPowerCurve // beginDefinition;

criticalPowerCurve[ power_TemporalData ] :=
    Module[ { t1, t2, duration, cpCurve },

        t1 = power[ "FirstDate" ];
        t2 = power[ "LastDate" ];
        duration = t2 - t1;

        cpCurve = Map[
            { #1, Max @ MovingMap[ Mean, power, #1 ] } &,
            TakeWhile[ $criticalPowerPoints, LessThan @ duration ]
        ];

        ListLinePlot[
            Append[ cpCurve, { duration, Mean @ power } ],
            ScalingFunctions -> { "Log", None },
            Filling          -> Bottom,
            Ticks            -> { $cpTicks, Automatic },
            AspectRatio      -> 1 / 5,
            PlotRange        -> {
                { Quantity[ 1, "Seconds" ], All },
                All
            },
            GridLines -> {
                $cpTicks,
                None
            }
        ]
    ];

criticalPowerCurve // endDefinition;

$criticalPowerPoints = {
    Quantity[  1, "Seconds" ],
    Quantity[  5, "Seconds" ],
    Quantity[ 10, "Seconds" ],
    Quantity[ 20, "Seconds" ],
    Quantity[ 30, "Seconds" ],
    Quantity[  1, "Minutes" ],
    Quantity[  3, "Minutes" ],
    Quantity[  5, "Minutes" ],
    Quantity[ 10, "Minutes" ],
    Quantity[ 20, "Minutes" ],
    Quantity[ 30, "Minutes" ],
    Quantity[  1, "Hours"   ],
    Quantity[ 90, "Minutes" ],
    Quantity[  2, "Hours"   ],
    Quantity[  3, "Hours"   ],
    Quantity[  4, "Hours"   ],
    Quantity[  5, "Hours"   ]
};

$cpTicks = {
    Quantity[  5, "Seconds" ],
    Quantity[ 20, "Seconds" ],
    Quantity[  1, "Minutes" ],
    Quantity[  5, "Minutes" ],
    Quantity[ 20, "Minutes" ],
    Quantity[  1, "Hours"   ],
    Quantity[  2, "Hours"   ],
    Quantity[  5, "Hours"   ]
};

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*toFileString*)
toFileString // beginDefinition;

toFileString[ file_ ] :=
    With[ { str = toFileString0 @ file },
        If[ StringQ @ str,
            $fileByteCount = FileByteCount @ file;
            str,
            throwFailure[ FITImport::InvalidFile, file ]
        ]
    ];

toFileString // endDefinition;

toFileString0 // beginDefinition;
toFileString0[ source: $$string ] := ExpandFileName @ source;
toFileString0[ source: $$file   ] := ExpandFileName @ source;
toFileString0[ source: $$url    ] := createTemporary @ source;
toFileString0[ source: $$co     ] := createTemporary @ source;
toFileString0[ source: $$lo     ] := createTemporary @ source;
toFileString0[ source: $$resp   ] := createTemporary @ source;
toFileString0 // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*createTemporary*)
createTemporary // beginDefinition;

createTemporary[ source: $$url ] :=
    addTempFile @ URLDownload[ source, $tempFile ];

createTemporary[ source: $$co ] :=
    addTempFile @ CopyFile[ source, $tempFile ];

createTemporary[ source: $$lo ] :=
    addTempFile @ CopyFile[ source, $tempFile ];

createTemporary[ source: $$resp ] :=
    addTempFile @ With[ { file = $tempFile },
        WithCleanup[
            BinaryWrite[ file, First @ source ],
            Close @ file
        ]
    ];

createTemporary // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*addTempFile*)
addTempFile // beginDefinition;

addTempFile[ file_? FileExistsQ ] :=
    addTempFile[ ExpandFileName @ file, $tempFiles ];

addTempFile[ file: $$string, files_Internal`Bag ] := (
    Internal`StuffBag[ files, file ];
    file
);

addTempFile[ other_ ] := throwFailure[ FITImport::CopyTemporaryFailed, other ];

addTempFile // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*$tempFile*)
$tempFile // ClearAll;
$tempFile := FileNameJoin @ {
    GeneralUtilities`EnsureDirectory @ { $TemporaryDirectory, "FITImport" },
    CreateUUID[ ] <> ".fit"
};

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitImportLibFunction*)
If[ MatchQ[ fitImportLibFunction, _LibraryFunction ],
    Quiet[ LibraryFunctionUnload @ fitImportLibFunction,
           LibraryFunction::nofun
    ]
];

fitImportLibFunction // ClearAll;
fitImportLibFunction := libraryFunctionLoad[
    $libraryFile,
    "FITImport",
    { String },
    { Integer, 2 }
];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitMessageTypesLibFunction*)
If[ MatchQ[ fitMessageTypesLibFunction, _LibraryFunction ],
    Quiet[ LibraryFunctionUnload @ fitMessageTypesLibFunction,
           LibraryFunction::nofun
    ]
];

fitMessageTypesLibFunction // ClearAll;
fitMessageTypesLibFunction := libraryFunctionLoad[
    $libraryFile,
    "FITMessageTypes",
    { String },
    { Integer, 2 }
];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*libraryFunctionLoad*)
libraryFunctionLoad // ClearAll;
libraryFunctionLoad[ args___ ] := libraryFunctionLoad0[ $SessionID, args ];


libraryFunctionLoad0 // beginDefinition;

libraryFunctionLoad0[ id_Integer, file_, a___ ] :=
    libraryFunctionLoad0[ id, file, a ] =
        Quiet[
            Check[
                LibraryFunctionLoad[ file, a ],
                If[ $CloudEvaluation,
                    throwFailure[ FITImport::CloudLibraryFunction ],
                    throwFailure[ FITImport::LibraryFunctionLoadFail, file ]
                ],
                LibraryFunction::noopen
            ],
            LibraryFunction::noopen
        ];

libraryFunctionLoad0 // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*fitRecordKeyQ*)
fitRecordKeyQ // ClearAll;
fitRecordKeyQ[ key_ ] := MemberQ[ $fitRecordKeys, key ];
fitRecordKeyQ[ ___  ] := False;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*fitEventKeyQ*)
fitEventKeyQ // ClearAll;
fitEventKeyQ[ key_ ] := MemberQ[ $fitEventKeys, key ];
fitEventKeyQ[ ___  ] := False;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Fit Keys*)
fitKeys // beginDefinition;
fitKeys[ "FileID"               ] := $fitFileIDKeys;
fitKeys[ "UserProfile"          ] := $fitUserProfileKeys;
fitKeys[ "Activity"             ] := $fitActivityKeys;
fitKeys[ "Lap"                  ] := $fitLapKeys;
fitKeys[ "DeviceSettings"       ] := $fitDeviceSettingsKeys;
fitKeys[ "Record"               ] := $fitRecordKeys;
fitKeys[ "Event"                ] := $fitEventKeys;
fitKeys[ "DeviceInformation"    ] := $fitDeviceInformationKeys;
fitKeys[ "Session"              ] := $fitSessionKeys;
fitKeys[ "ZonesTarget"          ] := $fitZonesTargetKeys;
fitKeys[ "FileCreator"          ] := $fitFileCreatorKeys;
fitKeys[ "Sport"                ] := $fitSportKeys;
fitKeys[ "DeveloperDataID"      ] := $fitDeveloperDataIDKeys;
fitKeys[ "FieldDescription"     ] := $fitFieldDescriptionKeys;
fitKeys[ "TrainingFile"         ] := $fitTrainingFileKeys;
fitKeys[ "HeartRateVariability" ] := $fitHeartRateVariabilityKeys;
fitKeys[ "WorkoutStep"          ] := $fitWorkoutStepKeys;
fitKeys[ "MessageInformation"   ] := $fitMessageInformationKeys;
fitKeys[ _                      ] := $fitDefaultKeys;
fitKeys // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*$fitFileIDKeys*)
$fitFileIDKeys // ClearAll;
$fitFileIDKeys = {
    "MessageType",
    "SerialNumber",
    "TimeCreated",
    "Manufacturer",
    "Product",
    "Number",
    "Type",
    "ProductName"
};

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*$fitUserProfileKeys*)
$fitUserProfileKeys // ClearAll;
$fitUserProfileKeys = {
    "MessageType",
    "MessageIndex",
    "Weight",
    "LocalID",
    "UserRunningStepLength",
    "UserWalkingStepLength",
    "Gender",
    "Age",
    "Height",
    "Language",
    "ElevationSetting",
    "WeightSetting",
    "RestingHeartRate",
    "DefaultMaxRunningHeartRate",
    "DefaultMaxBikingHeartRate",
    "DefaultMaxHeartRate",
    "HeartRateSetting",
    "SpeedSetting",
    "DistanceSetting",
    "PowerSetting",
    "ActivityClass",
    "PositionSetting",
    "TemperatureSetting",
    "HeightSetting",
    "FriendlyName",
    "GlobalID"
};

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*$fitActivityKeys*)
$fitActivityKeys // ClearAll;
$fitActivityKeys = {
    "MessageType",
    "Timestamp",
    "TotalTimerTime",
    "LocalTimestamp",
    "NumberOfSessions",
    "Type",
    "Event",
    "EventType",
    "LocalTimestamp",
    "EventGroup"
};

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*$fitLapKeys*)
$fitLapKeys // ClearAll;
$fitLapKeys = {
    "MessageType",
    "Timestamp",
    "StartTime",
    "StartPosition",
    "EndPosition",
    "TotalElapsedTime",
    "TotalTimerTime",
    "TotalDistance",
    "TotalCycles",
    "TotalWork",
    "TotalMovingTime",
    "TimeInHeartRateZone",
    "TimeInSpeedZone",
    "TimeInCadenceZone",
    "TimeInPowerZone",
    "MessageIndex",
    "TotalCalories",
    "TotalFatCalories",
    "AverageSpeed",
    "MaxSpeed",
    "AveragePower",
    "MaxPower",
    "TotalAscent",
    "TotalDescent",
    "NumberOfLengths",
    "NormalizedPower",
    "LeftRightBalance",
    "FirstLengthIndex",
    "AverageStrokeDistance",
    "NumberOfActiveLengths",
    "AverageAltitude",
    "MaxAltitude",
    "AverageGrade",
    "AveragePositiveGrade",
    "AverageNegativeGrade",
    "MaxPositiveGrade",
    "MaxNegativeGrade",
    "AveragePositiveVerticalSpeed",
    "AverageNegativeVerticalSpeed",
    "MaxPositiveVerticalSpeed",
    "MaxNegativeVerticalSpeed",
    "RepetitionNumber",
    "MinAltitude",
    "WorkoutStepIndex",
    "OpponentScore",
    "StrokeCount",
    "ZoneCount",
    "AverageVerticalOscillation",
    "AverageStanceTimePercent",
    "AverageStanceTime",
    "PlayerScore",
    "AverageTotalHemoglobinConcentration",
    "MinimumTotalHemoglobinConcentration",
    "MaximumTotalHemoglobinConcentration",
    "AverageSaturatedHemoglobinPercent",
    "MinimumSaturatedHemoglobinPercent",
    "MaximumSaturatedHemoglobinPercent",
    "AverageVAM",
    "Event",
    "EventType",
    "AverageHeartRate",
    "MaxHeartRate",
    "AverageCadence",
    "MaxCadence",
    "Intensity",
    "LapTrigger",
    "Sport",
    "EventGroup",
    "SwimStroke",
    "SubSport",
    "GPSAccuracy",
    "AverageTemperature",
    "MaxTemperature",
    "MinHeartRate"
};

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*$fitDeviceSettingsKeys*)
$fitDeviceSettingsKeys // ClearAll;
$fitDeviceSettingsKeys = {
    "MessageType",
    "UTCOffset",
    "TimeOffset",
    "ClockTime",
    "PagesEnabled",
    "DefaultPage",
    "AutoSyncMinSteps",
    "AutoSyncMinTime",
    "ActiveTimeZone",
    "TimeMode",
    "TimeZoneOffset",
    "BacklightMode",
    "ActivityTrackerEnabled",
    "MoveAlertEnabled",
    "DateMode",
    "DisplayOrientation",
    "MountingSide",
    "TapSensitivity"
};

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*$fitRecordKeys*)
$fitRecordKeys // ClearAll;
$fitRecordKeys = {
    "MessageType",
    "Timestamp",
    "GeoPosition",
    "Distance",
    "TimeFromCourse",
    "TotalCycles",
    (* "AccumulatedPower", *) (* Currently broken *)
    "Altitude",
    "Speed",
    "Power",
    "Grade",
    "CompressedAccumulatedPower",
    "VerticalSpeed",
    "Calories",
    "VerticalOscillation",
    "StanceTimePercent",
    "StanceTime",
    "BallSpeed",
    "Cadence256",
    "TotalHemoglobinConcentration",
    "TotalHemoglobinConcentrationMin",
    "TotalHemoglobinConcentrationMax",
    "SaturatedHemoglobinPercent",
    "SaturatedHemoglobinPercentMin",
    "SaturatedHemoglobinPercentMax",
    "HeartRate",
    "Cadence",
    "Resistance",
    "CycleLength",
    "Temperature",
    "Cycles",
    "LeftRightBalance",
    "GPSAccuracy",
    "ActivityType",
    "LeftTorqueEffectiveness",
    "RightTorqueEffectiveness",
    "LeftPedalSmoothness",
    "RightPedalSmoothness",
    "CombinedPedalSmoothness",
    "Time128",
    "StrokeType",
    "Zone",
    "DeviceIndex",
    "PowerZone",
    "HeartRateZone",
    "LeftPlatformCenterOffset",
    "RightPlatformCenterOffset",
    "LeftPowerPhaseStart",
    "LeftPowerPhaseEnd",
    "RightPowerPhaseStart",
    "RightPowerPhaseEnd",
    "LeftPowerPhasePeakStart",
    "LeftPowerPhasePeakEnd",
    "RightPowerPhasePeakStart",
    "RightPowerPhasePeakEnd",
    (* "Unknown61", *)
    "PerformanceCondition",
    (* "Unknown90", *)
    "RespirationRate",
    "HeartRateVariability"
};

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*$fitEventKeys*)
$fitEventKeys // ClearAll;
$fitEventKeys = {
    "MessageType",
    "Timestamp",
    "Data",
    "Data16",
    "Score",
    "OpponentScore",
    "Event",
    "EventType",
    "EventGroup",
    "FrontGearNum",
    "FrontGear",
    "RearGearNum",
    "RearGear",
    "RadarThreatLevelType",
    "RadarThreatCount"
};

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*$fitDeviceInformationKeys*)
$fitDeviceInformationKeys // ClearAll;
$fitDeviceInformationKeys = {
    "MessageType",
    "Timestamp",
    "DeviceType",
    "Manufacturer",
    "ProductName",
    "BatteryVoltage",
    "BatteryStatus",
    "Product",
    "SerialNumber",
    "CumulativeOperatingTime",
    "SoftwareVersion",
    "ANTDeviceNumber",
    "DeviceIndex",
    "HardwareVersion",
    "SensorPosition",
    "ANTTransmissionType",
    "ANTNetwork",
    "SourceType"
};

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*$fitSessionKeys*)
$fitSessionKeys // ClearAll;
$fitSessionKeys = {
    "MessageType",
    "Sport",
    "SubSport",
    "Timestamp",
    "StartTime",
    "StartPosition",
    "TotalElapsedTime",
    "TotalTimerTime",
    "TotalDistance",
    "TotalCycles",
    "AverageStrokeCount",
    "TotalWork",
    "TotalMovingTime",
    "NormalizedPower",
    "TrainingStressScore",
    "IntensityFactor",
    "LeftRightBalance",
    "TimeInHeartRateZone",
    "TimeInSpeedZone",
    "TimeInCadenceZone",
    "TimeInPowerZone",
    "AverageLapTime",
    "TotalCalories",
    "TotalFatCalories",
    "AverageSpeed",
    "MaxSpeed",
    "AveragePower",
    "MaxPower",
    "TotalAscent",
    "TotalDescent",
    "NumberOfLaps",
    "NumberOfLengths",
    "AverageStrokeDistance",
    "PoolLength",
    "ThresholdPower",
    "NumberOfActiveLengths",
    "AverageAltitude",
    "MaxAltitude",
    "AverageGrade",
    "AveragePositiveGrade",
    "AverageNegativeGrade",
    "MaxPositiveGrade",
    "MaxNegativeGrade",
    "AveragePositiveVerticalSpeed",
    "AverageNegativeVerticalSpeed",
    "MaxPositiveVerticalSpeed",
    "MaxNegativeVerticalSpeed",
    "BestLapIndex",
    "MinAltitude",
    "PlayerScore",
    "OpponentScore",
    "StrokeCount",
    "ZoneCount",
    "MaxBallSpeed",
    "AverageBallSpeed",
    "AverageVerticalOscillation",
    "AverageStanceTimePercent",
    "AverageStanceTime",
    "AverageVAM",
    "Event",
    "EventType",
    "AverageHeartRate",
    "MaxHeartRate",
    "AverageCadence",
    "MaxCadence",
    "TotalAerobicTrainingEffect",
    "TotalAerobicTrainingEffectDescription",
    "TotalAnaerobicTrainingEffect",
    "TotalAnaerobicTrainingEffectDescription",
    "EventGroup",
    "Trigger",
    "SwimStroke",
    "PoolLengthUnit",
    "GeoBoundingBox",
    "GPSAccuracy",
    "AverageTemperature",
    "MaxTemperature",
    "MinHeartRate",
    "FirstLapIndex",
    "MessageIndex",
    "AverageLeftPlatformCenterOffset",
    "AverageRightPlatformCenterOffset",
    "AverageLeftPowerPhaseStart",
    "AverageLeftPowerPhaseEnd",
    "AverageRightPowerPhaseStart",
    "AverageRightPowerPhaseEnd",
    "AverageLeftPowerPhasePeakStart",
    "AverageLeftPowerPhasePeakEnd",
    "AverageRightPowerPhasePeakStart",
    "AverageRightPowerPhasePeakEnd",
    "SportIndex"
};

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*$fitZonesTargetKeys*)
$fitZonesTargetKeys // ClearAll;
$fitZonesTargetKeys = {
    "MessageType",
    "FunctionalThresholdPower",
    "MaxHeartRate",
    "ThresholdHeartRate",
    "HeartRateCalculationType",
    "PowerZoneCalculationType"
};

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*$fitFileCreatorKeys*)
$fitFileCreatorKeys // ClearAll;
$fitFileCreatorKeys = {
    "MessageType",
    "SoftwareVersion",
    "HardwareVersion"
};

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*$fitSportKeys*)
$fitSportKeys // ClearAll;
$fitSportKeys = {
    "MessageType",
    "Name",
    "Sport",
    "SubSport"
};

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*$fitDeveloperDataIDKeys*)
$fitDeveloperDataIDKeys // ClearAll;
$fitDeveloperDataIDKeys = {
    "MessageType",
    "DeveloperID",
    "ApplicationID",
    "ApplicationVersion",
    "ManufacturerID",
    "DeveloperDataIndex"
};

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*$fitFieldDescriptionKeys*)
$fitFieldDescriptionKeys // ClearAll;
$fitFieldDescriptionKeys = {
    "MessageType",
    "FieldName",
    "Units",
    "FitBaseUnitID",
    "NativeMessageNumber",
    "DeveloperDataIndex",
    "FieldDefinitionNumber",
    "FitBaseTypeID",
    "Scale",
    "Offset",
    "NativeFieldNumber"
};

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*$fitTrainingFileKeys*)
$fitTrainingFileKeys // ClearAll;
$fitTrainingFileKeys = {
    "MessageType",
    "Timestamp",
    "SerialNumber",
    "TimeCreated",
    "Manufacturer",
    "Product",
    "ProductName",
    "Type"
};

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*$fitHeartRateVariabilityKeys*)
$fitHeartRateVariabilityKeys // ClearAll;
$fitHeartRateVariabilityKeys = {
    "MessageType",
    "Time"
};

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*$fitWorkoutStepKeys*)
$fitWorkoutStepKeys // ClearAll;
$fitWorkoutStepKeys = {
    "MessageType",
    "WorkoutStepName",
    "DurationValue",
    "TargetValue",
    "CustomTargetValueLow",
    "CustomTargetValueHigh",
    "SecondaryTargetValue",
    "SecondaryCustomTargetValueLow",
    "SecondaryCustomTargetValueHigh",
    "MessageIndex",
    "ExerciseCategory",
    "DurationType",
    "TargetType",
    "Intensity",
    "Notes",
    "Equipment",
    "SecondaryTargetType"
};

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*$fitDefaultKeys*)
$fitDefaultKeys // ClearAll;
$fitDefaultKeys = {
    "MessageType",
    "RawData"
};

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*$fitMessageInformationKeys*)
$fitMessageInformationKeys // ClearAll;
$fitMessageInformationKeys = {
    "MessageIndex",
    "MessageTypeName",
    "MessageIDNumber",
    "MessageSize",
    "FieldCount",
    "ByteOrdering",
    "FileOffset",
    "Supported"
};

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*formatFitData*)
formatFitData // beginDefinition;
formatFitData[ data_ ] := cached @ formatFitData0 @ data;
formatFitData // endDefinition;

formatFitData0 // beginDefinition;

formatFitData0[ data_ ] :=
    Module[ { fa, tr, filtered, res },
        (* fa = Block[ { $start = data[[ 1, 1 ]] }, makeFitAssociation /@ data ]; *) (* Broken: need to ensure value is a timestamp *)
        fa = If[ TrueQ @ $debug,
                 $fitValueTimings = Internal`Bag[ ];
                 makeFitAssociationTimed /@ data,
                 makeFitAssociation /@ data
             ];

        If[ ! MatchQ[ fa, { __Association } ],
            Throw[ Missing[ "NotAvailable" ], $tag ]
        ];
        tr = GeneralUtilities`AssociationTranspose @ fa;
        filtered = Select[ tr, Composition[ Not, allMissingOrZeroQ ] ];
        res = GeneralUtilities`AssociationTranspose @ filtered;
        If[ Length @ res === 1,
            DeleteCases[ res, _Missing | Quantity[ 0 | 0.0, _ ], { 2 } ],
            res
        ]
    ] ~Catch~ $tag;

formatFitData0 // endDefinition;



allMissingOrZeroQ // ClearAll;
allMissingOrZeroQ[ { _ } ] := False;
allMissingOrZeroQ[ a_List ] := AllTrue[ a, missingOrZeroQ ];
allMissingOrZeroQ[ ___ ] := False;


missingOrZeroQ // ClearAll;
missingOrZeroQ[ _Missing ] := True;
missingOrZeroQ[ 0 | 0.0 ] := True;
missingOrZeroQ[ r_Real ] := Chop @ r === 0;
missingOrZeroQ[ Quantity[ _? missingOrZeroQ, _ ] ] := True;
missingOrZeroQ[ Interval[ { _? missingOrZeroQ, _? missingOrZeroQ } ] ] := True;
missingOrZeroQ[ ___ ] := False;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*computeGradeQ*)
computeGradeQ // ClearAll;
computeGradeQ[ data_ ] := MatchQ[ data[[ All, 13 ]], { $invalidSINT16 .. } ];
computeGradeQ[ ___   ] := False;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*makeFitAssociation*)
makeFitAssociation // beginDefinition;

makeFitAssociation[ values_ ] :=
    With[ { msgType = fitMessageType @ values },
        AssociationMap[ fitValue[ msgType, #1, values ] &, fitKeys @ msgType ]
    ];

makeFitAssociation // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*makeFitAssociationTimed*)
makeFitAssociationTimed // beginDefinition;

makeFitAssociationTimed[ values_ ] := (
    With[ { msgType = fitMessageType @ values },
        AssociationMap[
            fitValueTimed[ msgType, #1, values ] &,
            fitKeys @ msgType
        ]
    ]
);

makeFitAssociationTimed // endDefinition;


fitValueTimed // ClearAll;
fitValueTimed[ type_, name_, v_ ] :=
    Module[ { time, res },
        { time, res } = AbsoluteTiming @ fitValue[ type, name, v ];
        Internal`StuffBag[ $fitValueTimings, { type, name } -> time ];
        res
    ];

$fitValueTimings := $fitValueTimings = Internal`Bag[ ];

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*fitMessageType*)
fitMessageType // beginDefinition;
fitMessageType[ v_List ] := fitMessageType @ v[[ 1 ]];
fitMessageType[ n_Integer ] := Lookup[ $fitMessageTypes, n, "UNKNOWN" ];
fitMessageType // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*toNiceCamelCase*)
toNiceCamelCase // beginDefinition;

toNiceCamelCase[ s_String ] :=
    snakeToCamel @ StringDelete[ s, StartOfString~~$deletePrefixes ];

toNiceCamelCase // endDefinition;

$deletePrefixes = Alternatives[
    "FIT_MESG_NUM_"
];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*snakeToCamel*)
snakeToCamel // beginDefinition;

snakeToCamel[ s_String ] :=
    StringReplace[
        StringJoin @ ReplaceAll[
            capitalize @ ToLowerCase @ StringSplit[ s, "_" ],
            $capitalizationRules1
        ],
        $capitalizationRules2
    ];

snakeToCamel // endDefinition;

capitalize // beginDefinition;
capitalize // Attributes = { Listable };

capitalize[ s_String ] :=
    If[ TrueQ[ StringLength @ s <= 3 && ! DictionaryWordQ @ s ],
        ToUpperCase @ s,
        Capitalize @ s
    ];

capitalize // endDefinition;

$capitalizationRules1 // ClearAll;
$capitalizationRules1 = {
    "Ant"   -> "ANT",
    "Auto"  -> "Automatic",
    "Aux"   -> "Auxiliary",
    "AUX"   -> "Auxiliary",
    "COMM"  -> "Communication",
    "Elev"  -> "Elevation",
    "ENV"   -> "Environment",
    "EXD"   -> "ExtendedDisplay",
    "Ftp"   -> "FTP",
    "Hr"    -> "HeartRate",
    "HR"    -> "HeartRate",
    "Hrm"   -> "HeartRateMonitor",
    "HRM"   -> "HeartRateMonitor",
    "Hrv"   -> "HeartRateVariability",
    "HRV"   -> "HeartRateVariability",
    "Ia"    -> "IA",
    "Ib"    -> "IB",
    "Id"    -> "ID",
    "Iia"   -> "IIA",
    "Iib"   -> "IIB",
    "Iiia"  -> "IIIA",
    "Iiib"  -> "IIIB",
    "Info"  -> "Information",
    "Iva"   -> "IVA",
    "Ivb"   -> "IVB",
    "Mesg"  -> "Message",
    "Met"   -> "MET",
    "Nmea"  -> "NMEA",
    "Obdii" -> "OBDII",
    "Ohr"   -> "OHR",
    "PWR"   -> "Power",
    "Ref"   -> "Reference",
    "REF"   -> "Reference",
    "Rso"   -> "RSO",
    "RX"    -> "Receive",
    "TX"    -> "Transmit",
    "Ups"   -> "UPS",
    "Utm"   -> "UTM",
    "WKT"   -> "Workout"
};


$capitalizationRules2 // ClearAll;
$capitalizationRules2 = {
    "Antfs"   -> "ANTFS",
    "Antplus" -> "ANTPlus",
    "CadLow"  -> "CadenceLow",
    "CadHigh" -> "CadenceHigh"
};

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*$fitMessageTypes*)
$fitMessageTypes0 = <|
    0          -> "FIT_MESG_NUM_FILE_ID",
    1          -> "FIT_MESG_NUM_CAPABILITIES",
    2          -> "FIT_MESG_NUM_DEVICE_SETTINGS",
    3          -> "FIT_MESG_NUM_USER_PROFILE",
    4          -> "FIT_MESG_NUM_HRM_PROFILE",
    5          -> "FIT_MESG_NUM_SDM_PROFILE",
    6          -> "FIT_MESG_NUM_BIKE_PROFILE",
    7          -> "FIT_MESG_NUM_ZONES_TARGET",
    8          -> "FIT_MESG_NUM_HR_ZONE",
    9          -> "FIT_MESG_NUM_POWER_ZONE",
    10         -> "FIT_MESG_NUM_MET_ZONE",
    12         -> "FIT_MESG_NUM_SPORT",
    15         -> "FIT_MESG_NUM_GOAL",
    18         -> "FIT_MESG_NUM_SESSION",
    19         -> "FIT_MESG_NUM_LAP",
    20         -> "FIT_MESG_NUM_RECORD",
    21         -> "FIT_MESG_NUM_EVENT",
    23         -> "FIT_MESG_NUM_DEVICE_INFO",
    26         -> "FIT_MESG_NUM_WORKOUT",
    27         -> "FIT_MESG_NUM_WORKOUT_STEP",
    28         -> "FIT_MESG_NUM_SCHEDULE",
    30         -> "FIT_MESG_NUM_WEIGHT_SCALE",
    31         -> "FIT_MESG_NUM_COURSE",
    32         -> "FIT_MESG_NUM_COURSE_POINT",
    33         -> "FIT_MESG_NUM_TOTALS",
    34         -> "FIT_MESG_NUM_ACTIVITY",
    35         -> "FIT_MESG_NUM_SOFTWARE",
    37         -> "FIT_MESG_NUM_FILE_CAPABILITIES",
    38         -> "FIT_MESG_NUM_MESG_CAPABILITIES",
    39         -> "FIT_MESG_NUM_FIELD_CAPABILITIES",
    49         -> "FIT_MESG_NUM_FILE_CREATOR",
    51         -> "FIT_MESG_NUM_BLOOD_PRESSURE",
    53         -> "FIT_MESG_NUM_SPEED_ZONE",
    55         -> "FIT_MESG_NUM_MONITORING",
    72         -> "FIT_MESG_NUM_TRAINING_FILE",
    78         -> "FIT_MESG_NUM_HRV",
    80         -> "FIT_MESG_NUM_ANT_RX",
    81         -> "FIT_MESG_NUM_ANT_TX",
    82         -> "FIT_MESG_NUM_ANT_CHANNEL_ID",
    101        -> "FIT_MESG_NUM_LENGTH",
    103        -> "FIT_MESG_NUM_MONITORING_INFO",
    105        -> "FIT_MESG_NUM_PAD",
    106        -> "FIT_MESG_NUM_SLAVE_DEVICE",
    127        -> "FIT_MESG_NUM_CONNECTIVITY",
    128        -> "FIT_MESG_NUM_WEATHER_CONDITIONS",
    129        -> "FIT_MESG_NUM_WEATHER_ALERT",
    131        -> "FIT_MESG_NUM_CADENCE_ZONE",
    132        -> "FIT_MESG_NUM_HR",
    142        -> "FIT_MESG_NUM_SEGMENT_LAP",
    145        -> "FIT_MESG_NUM_MEMO_GLOB",
    148        -> "FIT_MESG_NUM_SEGMENT_ID",
    149        -> "FIT_MESG_NUM_SEGMENT_LEADERBOARD_ENTRY",
    150        -> "FIT_MESG_NUM_SEGMENT_POINT",
    151        -> "FIT_MESG_NUM_SEGMENT_FILE",
    158        -> "FIT_MESG_NUM_WORKOUT_SESSION",
    159        -> "FIT_MESG_NUM_WATCHFACE_SETTINGS",
    160        -> "FIT_MESG_NUM_GPS_METADATA",
    161        -> "FIT_MESG_NUM_CAMERA_EVENT",
    162        -> "FIT_MESG_NUM_TIMESTAMP_CORRELATION",
    164        -> "FIT_MESG_NUM_GYROSCOPE_DATA",
    165        -> "FIT_MESG_NUM_ACCELEROMETER_DATA",
    167        -> "FIT_MESG_NUM_THREE_D_SENSOR_CALIBRATION",
    169        -> "FIT_MESG_NUM_VIDEO_FRAME",
    174        -> "FIT_MESG_NUM_OBDII_DATA",
    177        -> "FIT_MESG_NUM_NMEA_SENTENCE",
    178        -> "FIT_MESG_NUM_AVIATION_ATTITUDE",
    184        -> "FIT_MESG_NUM_VIDEO",
    185        -> "FIT_MESG_NUM_VIDEO_TITLE",
    186        -> "FIT_MESG_NUM_VIDEO_DESCRIPTION",
    187        -> "FIT_MESG_NUM_VIDEO_CLIP",
    188        -> "FIT_MESG_NUM_OHR_SETTINGS",
    200        -> "FIT_MESG_NUM_EXD_SCREEN_CONFIGURATION",
    201        -> "FIT_MESG_NUM_EXD_DATA_FIELD_CONFIGURATION",
    202        -> "FIT_MESG_NUM_EXD_DATA_CONCEPT_CONFIGURATION",
    206        -> "FIT_MESG_NUM_FIELD_DESCRIPTION",
    207        -> "FIT_MESG_NUM_DEVELOPER_DATA_ID",
    208        -> "FIT_MESG_NUM_MAGNETOMETER_DATA",
    209        -> "FIT_MESG_NUM_BAROMETER_DATA",
    210        -> "FIT_MESG_NUM_ONE_D_SENSOR_CALIBRATION",
    225        -> "FIT_MESG_NUM_SET",
    227        -> "FIT_MESG_NUM_STRESS_LEVEL",
    258        -> "FIT_MESG_NUM_DIVE_SETTINGS",
    259        -> "FIT_MESG_NUM_DIVE_GAS",
    262        -> "FIT_MESG_NUM_DIVE_ALARM",
    264        -> "FIT_MESG_NUM_EXERCISE_TITLE",
    268        -> "FIT_MESG_NUM_DIVE_SUMMARY",
    285        -> "FIT_MESG_NUM_JUMP",
    317        -> "FIT_MESG_NUM_CLIMB_PRO",
    375        -> "FIT_MESG_NUM_DEVICE_AUX_BATTERY_INFO",
    65535      -> "FIT_MESG_NUM_INVALID",
    1768842863 -> "FIT_MESG_NUM_MESSAGE_INFORMATION"
|>;

$fitMessageTypes = toNiceCamelCase /@ $fitMessageTypes0;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*unsupportedMessageTypeQ*)
unsupportedMessageTypeQ[ type_ ] := MemberQ[ $unsupportedMessageTypes, type ];
unsupportedMessageTypeQ[ ___ ] := False;

$unsupportedMessageTypes = Complement[
    Values @ $fitMessageTypes,
    $messageTypes
];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitMessageTypeNumber*)
fitMessageTypeNumber // beginDefinition;

fitMessageTypeNumber[ "Events"  ] := fitMessageTypeNumber[ "Event"  ];
fitMessageTypeNumber[ "Records" ] := fitMessageTypeNumber[ "Record" ];
fitMessageTypeNumber[ "Laps"    ] := fitMessageTypeNumber[ "Lap"    ];

fitMessageTypeNumber[ type_String ] :=
    With[ { n = $fitMessageTypeNumbers[ type ] }, n /; IntegerQ @ n ];

fitMessageTypeNumber // endDefinition;

$fitMessageTypeNumbers = AssociationMap[ Reverse, $fitMessageTypes ];

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*fitValue*)
fitValue // beginDefinition;
fitValue[ type_, "MessageType", v_ ] := type;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*FileID*)
fitValue[ "FileID", "SerialNumber", v_ ] := fitSerialNumber @ v[[ 2 ]];
fitValue[ "FileID", "TimeCreated" , v_ ] := fitDateTime @ v[[ 3 ]];
fitValue[ "FileID", "Manufacturer", v_ ] := fitManufacturer @ v[[ 4 ]];
fitValue[ "FileID", "Product"     , v_ ] := fitProduct @ v[[ 5 ]];
fitValue[ "FileID", "Number"      , v_ ] := fitUINT16 @ v[[ 6 ]];
fitValue[ "FileID", "Type"        , v_ ] := fitFile @ v[[ 7 ]];
fitValue[ "FileID", "ProductName" , v_ ] := fitProductName[ v[[ 4;;5 ]], v[[ 8;;27 ]] ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*UserProfile*)
fitValue[ "UserProfile", "MessageIndex"              , v_ ] := fitUINT16 @ v[[ 2 ]];
fitValue[ "UserProfile", "Weight"                    , v_ ] := fitWeight @ v[[ 3 ]];
fitValue[ "UserProfile", "LocalID"                   , v_ ] := fitUINT16 @ v[[ 4 ]];
fitValue[ "UserProfile", "UserRunningStepLength"     , v_ ] := fitStepLength @ v[[ 5 ]];
fitValue[ "UserProfile", "UserWalkingStepLength"     , v_ ] := fitStepLength @ v[[ 6 ]];
fitValue[ "UserProfile", "Gender"                    , v_ ] := fitGender @ v[[ 7 ]];
fitValue[ "UserProfile", "Age"                       , v_ ] := fitAge @ v[[ 8 ]];
fitValue[ "UserProfile", "Height"                    , v_ ] := fitHeight @ v[[ 9 ]];
fitValue[ "UserProfile", "Language"                  , v_ ] := fitLanguage @ v[[ 10 ]];
fitValue[ "UserProfile", "ElevationSetting"          , v_ ] := fitDisplayMeasure @ v[[ 11 ]];
fitValue[ "UserProfile", "WeightSetting"             , v_ ] := fitDisplayMeasure @ v[[ 12 ]];
fitValue[ "UserProfile", "RestingHeartRate"          , v_ ] := fitHeartRate @ v[[ 13 ]];
fitValue[ "UserProfile", "DefaultMaxRunningHeartRate", v_ ] := fitHeartRate @ v[[ 14 ]];
fitValue[ "UserProfile", "DefaultMaxBikingHeartRate" , v_ ] := fitHeartRate @ v[[ 15 ]];
fitValue[ "UserProfile", "DefaultMaxHeartRate"       , v_ ] := fitHeartRate @ v[[ 16 ]];
fitValue[ "UserProfile", "HeartRateSetting"          , v_ ] := fitDisplayHeart @ v[[ 17 ]];
fitValue[ "UserProfile", "SpeedSetting"              , v_ ] := fitDisplayMeasure @ v[[ 18 ]];
fitValue[ "UserProfile", "DistanceSetting"           , v_ ] := fitDisplayMeasure @ v[[ 19 ]];
fitValue[ "UserProfile", "PowerSetting"              , v_ ] := fitDisplayPower @ v[[ 20 ]];
fitValue[ "UserProfile", "ActivityClass"             , v_ ] := fitActivityClass @ v[[ 21 ]];
fitValue[ "UserProfile", "PositionSetting"           , v_ ] := fitDisplayPosition @ v[[ 22 ]];
fitValue[ "UserProfile", "TemperatureSetting"        , v_ ] := fitDisplayMeasure @ v[[ 23 ]];
fitValue[ "UserProfile", "HeightSetting"             , v_ ] := fitDisplayMeasure @ v[[ 24 ]];
fitValue[ "UserProfile", "FriendlyName"              , v_ ] := fitString @ v[[ 25 ;; 40 ]];
fitValue[ "UserProfile", "GlobalID"                  , v_ ] := fitGlobalID @ v[[ 41 ;; 46 ]];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Activity*)
fitValue[ "Activity", "Timestamp"       , v_ ] := fitDateTime @ v[[ 2 ]];
fitValue[ "Activity", "TotalTimerTime"  , v_ ] := fitTime32 @ v[[ 3 ]];
fitValue[ "Activity", "LocalTimestamp"  , v_ ] := fitLocalTimestamp @ v[[ 4 ]];
fitValue[ "Activity", "NumberOfSessions", v_ ] := fitUINT16 @ v[[ 5 ]];
fitValue[ "Activity", "Type"            , v_ ] := fitActivity @ v[[ 6 ]];
fitValue[ "Activity", "Event"           , v_ ] := fitEvent @ v[[ 7 ]];
fitValue[ "Activity", "EventType"       , v_ ] := fitEventType @ v[[ 8 ]];
fitValue[ "Activity", "EventGroup"      , v_ ] := fitEventGroup @ v[[ 9 ]];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Lap*)
fitValue[ "Lap", "Timestamp"                          , v_ ] := fitDateTime @ v[[ 2 ]];
fitValue[ "Lap", "StartTime"                          , v_ ] := fitDateTime @ v[[ 3 ]];
fitValue[ "Lap", "StartPosition"                      , v_ ] := fitGeoPosition @ v[[ 4;;5 ]];
fitValue[ "Lap", "EndPosition"                        , v_ ] := fitGeoPosition @ v[[ 6;;7 ]];
fitValue[ "Lap", "TotalElapsedTime"                   , v_ ] := fitTime32 @ v[[ 8 ]];
fitValue[ "Lap", "TotalTimerTime"                     , v_ ] := fitTime32 @ v[[ 9 ]];
fitValue[ "Lap", "TotalDistance"                      , v_ ] := fitDistance @ v[[ 10 ]];
fitValue[ "Lap", "TotalCycles"                        , v_ ] := fitCycles32[ v[[ 11 ]], v[[ 84 ]] ];
fitValue[ "Lap", "TotalWork"                          , v_ ] := fitWork @ v[[ 12 ]];
fitValue[ "Lap", "TotalMovingTime"                    , v_ ] := fitTime32 @ v[[ 13 ]];
fitValue[ "Lap", "TimeInHeartRateZone"                , v_ ] := fitTime32 @ v[[ 14 ]];
fitValue[ "Lap", "TimeInSpeedZone"                    , v_ ] := fitTime32 @ v[[ 15 ]];
fitValue[ "Lap", "TimeInCadenceZone"                  , v_ ] := fitTime32 @ v[[ 16 ]];
fitValue[ "Lap", "TimeInPowerZone"                    , v_ ] := fitTime32 @ v[[ 17 ]];
fitValue[ "Lap", "MessageIndex"                       , v_ ] := fitMessageIndex @ v[[ 23 ]];
fitValue[ "Lap", "TotalCalories"                      , v_ ] := fitCalories @ v[[ 24 ]];
fitValue[ "Lap", "TotalFatCalories"                   , v_ ] := fitCalories @ v[[ 25 ]];
fitValue[ "Lap", "AverageSpeed"                       , v_ ] := fitSpeedSelect[ v[[ 18 ]], v[[ 26 ]] ];
fitValue[ "Lap", "MaxSpeed"                           , v_ ] := fitSpeedSelect[ v[[ 19 ]], v[[ 27 ]] ];
fitValue[ "Lap", "AveragePower"                       , v_ ] := fitPower @ v[[ 28 ]];
fitValue[ "Lap", "MaxPower"                           , v_ ] := fitPower @ v[[ 29 ]];
fitValue[ "Lap", "TotalAscent"                        , v_ ] := fitAscent @ v[[ 30 ]];
fitValue[ "Lap", "TotalDescent"                       , v_ ] := fitAscent @ v[[ 31 ]];
fitValue[ "Lap", "NumberOfLengths"                    , v_ ] := fitLengths @ v[[ 32 ]];
fitValue[ "Lap", "NormalizedPower"                    , v_ ] := fitPower @ v[[ 33 ]];
fitValue[ "Lap", "LeftRightBalance"                   , v_ ] := fitLeftRightBalance @ v[[ 34 ]];
fitValue[ "Lap", "FirstLengthIndex"                   , v_ ] := fitUINT16 @ v[[ 35 ]];
fitValue[ "Lap", "AverageStrokeDistance"              , v_ ] := fitMeters100 @ v[[ 36 ]];
fitValue[ "Lap", "NumberOfActiveLengths"              , v_ ] := fitLengths @ v[[ 37 ]];
fitValue[ "Lap", "AverageAltitude"                    , v_ ] := fitAltitudeSelect[ v[[ 20 ]], v[[ 38 ]] ];
fitValue[ "Lap", "MaxAltitude"                        , v_ ] := fitAltitudeSelect[ v[[ 22 ]], v[[ 39 ]] ];
fitValue[ "Lap", "AverageGrade"                       , v_ ] := fitGrade @ v[[ 40 ]];
fitValue[ "Lap", "AveragePositiveGrade"               , v_ ] := fitGrade @ v[[ 41 ]];
fitValue[ "Lap", "AverageNegativeGrade"               , v_ ] := fitGrade @ v[[ 42 ]];
fitValue[ "Lap", "MaxPositiveGrade"                   , v_ ] := fitGrade @ v[[ 43 ]];
fitValue[ "Lap", "MaxNegativeGrade"                   , v_ ] := fitGrade @ v[[ 44 ]];
fitValue[ "Lap", "AveragePositiveVerticalSpeed"       , v_ ] := fitVerticalSpeed @ v[[ 45 ]];
fitValue[ "Lap", "AverageNegativeVerticalSpeed"       , v_ ] := fitVerticalSpeed @ v[[ 46 ]];
fitValue[ "Lap", "MaxPositiveVerticalSpeed"           , v_ ] := fitVerticalSpeed @ v[[ 47 ]];
fitValue[ "Lap", "MaxNegativeVerticalSpeed"           , v_ ] := fitVerticalSpeed @ v[[ 48 ]];
fitValue[ "Lap", "RepetitionNumber"                   , v_ ] := fitUINT16 @ v[[ 49 ]];
fitValue[ "Lap", "MinAltitude"                        , v_ ] := fitAltitudeSelect[ v[[ 21 ]], v[[ 50 ]] ];
fitValue[ "Lap", "WorkoutStepIndex"                   , v_ ] := fitMessageIndex @ v[[ 51 ]];
fitValue[ "Lap", "OpponentScore"                      , v_ ] := fitUINT16 @ v[[ 52 ]];
fitValue[ "Lap", "StrokeCount"                        , v_ ] := fitStrokeCount @ v[[ 53 ]];
fitValue[ "Lap", "ZoneCount"                          , v_ ] := fitUINT16 @ v[[ 54 ]];
fitValue[ "Lap", "AverageVerticalOscillation"         , v_ ] := fitVerticalOscillation @ v[[ 55 ]];
fitValue[ "Lap", "AverageStanceTimePercent"           , v_ ] := fitStanceTimePercent @ v[[ 56 ]];
fitValue[ "Lap", "AverageStanceTime"                  , v_ ] := fitStanceTime @ v[[ 57 ]];
fitValue[ "Lap", "PlayerScore"                        , v_ ] := fitUINT16 @ v[[ 58 ]];
fitValue[ "Lap", "AverageTotalHemoglobinConcentration", v_ ] := fitHemoglobin @ v[[ 59 ]];
fitValue[ "Lap", "MinimumTotalHemoglobinConcentration", v_ ] := fitHemoglobin @ v[[ 60 ]];
fitValue[ "Lap", "MaximumTotalHemoglobinConcentration", v_ ] := fitHemoglobin @ v[[ 61 ]];
fitValue[ "Lap", "AverageSaturatedHemoglobinPercent"  , v_ ] := fitHemoglobinPercent @ v[[ 62 ]];
fitValue[ "Lap", "MinimumSaturatedHemoglobinPercent"  , v_ ] := fitHemoglobinPercent @ v[[ 63 ]];
fitValue[ "Lap", "MaximumSaturatedHemoglobinPercent"  , v_ ] := fitHemoglobinPercent @ v[[ 64 ]];
fitValue[ "Lap", "AverageVAM"                         , v_ ] := fitVAM @ v[[ 65 ]];
fitValue[ "Lap", "Event"                              , v_ ] := fitEvent @ v[[ 66 ]];
fitValue[ "Lap", "EventType"                          , v_ ] := fitEventType @ v[[ 67 ]];
fitValue[ "Lap", "AverageHeartRate"                   , v_ ] := fitHeartRate @ v[[ 68 ]];
fitValue[ "Lap", "MaxHeartRate"                       , v_ ] := fitHeartRate @ v[[ 69 ]];
fitValue[ "Lap", "AverageCadence"                     , v_ ] := fitCadence[ v[[ 70 ]], v[[ 82 ]] ];
fitValue[ "Lap", "MaxCadence"                         , v_ ] := fitCadence[ v[[ 71 ]], v[[ 83 ]] ];
fitValue[ "Lap", "Intensity"                          , v_ ] := fitIntensity @ v[[ 72 ]];
fitValue[ "Lap", "LapTrigger"                         , v_ ] := fitLapTrigger @ v[[ 73 ]];
fitValue[ "Lap", "Sport"                              , v_ ] := fitSport @ v[[ 74 ]];
fitValue[ "Lap", "EventGroup"                         , v_ ] := fitUINT8 @ v[[ 75 ]];
fitValue[ "Lap", "SwimStroke"                         , v_ ] := fitSwimStroke @ v[[ 76 ]];
fitValue[ "Lap", "SubSport"                           , v_ ] := fitSubSport @ v[[ 77 ]];
fitValue[ "Lap", "GPSAccuracy"                        , v_ ] := fitGPSAccuracy @ v[[ 78 ]];
fitValue[ "Lap", "AverageTemperature"                 , v_ ] := fitTemperature @ v[[ 79 ]];
fitValue[ "Lap", "MaxTemperature"                     , v_ ] := fitTemperature @ v[[ 80 ]];
fitValue[ "Lap", "MinHeartRate"                       , v_ ] := fitHeartRate @ v[[ 81 ]];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*DeviceSettings*)
fitValue[ "DeviceSettings", "UTCOffset"             , v_ ] := fitUINT32 @ v[[ 2 ]];
fitValue[ "DeviceSettings", "TimeOffset"            , v_ ] := fitTimeOffset @ v[[ 3;;4 ]];
fitValue[ "DeviceSettings", "ClockTime"             , v_ ] := fitDateTime @ v[[ 5 ]];
fitValue[ "DeviceSettings", "PagesEnabled"          , v_ ] := fitUINT16BF @ v[[ 6 ]];
fitValue[ "DeviceSettings", "DefaultPage"           , v_ ] := fitUINT16BF @ v[[ 7 ]];
fitValue[ "DeviceSettings", "AutosyncMinSteps"      , v_ ] := fitSteps @ v[[ 8 ]];
fitValue[ "DeviceSettings", "AutosyncMinTime"       , v_ ] := fitMinutes @ v[[ 9 ]];
fitValue[ "DeviceSettings", "ActiveTimeZone"        , v_ ] := fitUINT8 @ v[[ 10 ]];
fitValue[ "DeviceSettings", "TimeMode"              , v_ ] := fitTimeModeArr @ v[[ 11;;12 ]];
fitValue[ "DeviceSettings", "TimeZoneOffset"        , v_ ] := fitTimeZoneOffset @ v[[ 13;;14 ]];
fitValue[ "DeviceSettings", "BacklightMode"         , v_ ] := fitBacklightMode @ v[[ 15 ]];
fitValue[ "DeviceSettings", "ActivityTrackerEnabled", v_ ] := fitBool @ v[[ 16 ]];
fitValue[ "DeviceSettings", "MoveAlertEnabled"      , v_ ] := fitBool @ v[[ 17 ]];
fitValue[ "DeviceSettings", "DateMode"              , v_ ] := fitDateMode @ v[[ 18 ]];
fitValue[ "DeviceSettings", "DisplayOrientation"    , v_ ] := fitDisplayOrientation @ v[[ 19 ]];
fitValue[ "DeviceSettings", "MountingSide"          , v_ ] := fitSide @ v[[ 20 ]];
fitValue[ "DeviceSettings", "TapSensitivity"        , v_ ] := fitTapSensitivity @ v[[ 21 ]];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Record*)
fitValue[ "Record", "Timestamp"                      , v_ ] := fitDateTime @ v[[ 2 ]];
fitValue[ "Record", "GeoPosition"                    , v_ ] := fitGeoPosition @ v[[ 3;;4 ]];
fitValue[ "Record", "Distance"                       , v_ ] := fitDistance @ v[[ 5 ]];
fitValue[ "Record", "TimeFromCourse"                 , v_ ] := fitTimeFromCourse @ v[[ 6 ]];
fitValue[ "Record", "TotalCycles"                    , v_ ] := fitCycles32 @ v[[ 7 ]];
fitValue[ "Record", "AccumulatedPower"               , v_ ] := fitAccumulatedPower @ v[[ { 2, 8 } ]];
fitValue[ "Record", "Altitude"                       , v_ ] := fitAltitudeSelect[ v[[ 10 ]], v[[ 11 ]] ];
fitValue[ "Record", "Speed"                          , v_ ] := fitSpeedSelect[ v[[ 9 ]], v[[ 12 ]] ];
fitValue[ "Record", "Power"                          , v_ ] := fitPower @ v[[ 13 ]];
fitValue[ "Record", "Grade"                          , v_ ] := fitGrade @ v[[ 14 ]];
fitValue[ "Record", "CompressedAccumulatedPower"     , v_ ] := fitCompressedAccumulatedPower @ v[[ 15 ]];
fitValue[ "Record", "VerticalSpeed"                  , v_ ] := fitVerticalSpeed @ v[[ 16 ]];
fitValue[ "Record", "Calories"                       , v_ ] := fitCalories @ v[[ 17 ]];
fitValue[ "Record", "VerticalOscillation"            , v_ ] := fitVerticalOscillation @ v[[ 18 ]];
fitValue[ "Record", "StanceTimePercent"              , v_ ] := fitStanceTimePercent @ v[[ 19 ]];
fitValue[ "Record", "StanceTime"                     , v_ ] := fitStanceTime @ v[[ 20 ]];
fitValue[ "Record", "BallSpeed"                      , v_ ] := fitBallSpeed @ v[[ 21 ]];
fitValue[ "Record", "Cadence256"                     , v_ ] := fitCadence256 @ v[[ 22 ]];
fitValue[ "Record", "TotalHemoglobinConcentration"   , v_ ] := fitHemoglobin @ v[[ 23 ]];
fitValue[ "Record", "TotalHemoglobinConcentrationMin", v_ ] := fitHemoglobin @ v[[ 24 ]];
fitValue[ "Record", "TotalHemoglobinConcentrationMax", v_ ] := fitHemoglobin @ v[[ 25 ]];
fitValue[ "Record", "SaturatedHemoglobinPercent"     , v_ ] := fitHemoglobinPercent @ v[[ 26 ]];
fitValue[ "Record", "SaturatedHemoglobinPercentMin"  , v_ ] := fitHemoglobinPercent @ v[[ 27 ]];
fitValue[ "Record", "SaturatedHemoglobinPercentMax"  , v_ ] := fitHemoglobinPercent @ v[[ 28 ]];
fitValue[ "Record", "HeartRate"                      , v_ ] := fitHeartRate @ v[[ 29 ]];
fitValue[ "Record", "Cadence"                        , v_ ] := fitCadence[ v[[ 30 ]], v[[ 46 ]] ];
fitValue[ "Record", "Resistance"                     , v_ ] := fitResistance @ v[[ 31 ]];
fitValue[ "Record", "CycleLength"                    , v_ ] := fitCycleLength @ v[[ 32 ]];
fitValue[ "Record", "Temperature"                    , v_ ] := fitTemperature @ v[[ 33 ]];
fitValue[ "Record", "Cycles"                         , v_ ] := fitCycles8 @ v[[ 34 ]];
fitValue[ "Record", "LeftRightBalance"               , v_ ] := fitLeftRightBalance @ v[[ 35 ]];
fitValue[ "Record", "GPSAccuracy"                    , v_ ] := fitGPSAccuracy @ v[[ 36 ]];
fitValue[ "Record", "ActivityType"                   , v_ ] := fitActivityType @ v[[ 37 ]];
fitValue[ "Record", "LeftTorqueEffectiveness"        , v_ ] := fitTorqueEffectiveness @ v[[ 38 ]];
fitValue[ "Record", "RightTorqueEffectiveness"       , v_ ] := fitTorqueEffectiveness @ v[[ 39 ]];
fitValue[ "Record", "LeftPedalSmoothness"            , v_ ] := fitPedalSmoothness @ v[[ 40 ]];
fitValue[ "Record", "RightPedalSmoothness"           , v_ ] := fitPedalSmoothness @ v[[ 41 ]];
fitValue[ "Record", "CombinedPedalSmoothness"        , v_ ] := fitPedalSmoothness @ v[[ 42 ]];
fitValue[ "Record", "Time128"                        , v_ ] := fitTime128 @ v[[ 43 ]];
fitValue[ "Record", "StrokeType"                     , v_ ] := fitStrokeType @ v[[ 44 ]];
fitValue[ "Record", "Zone"                           , v_ ] := fitZone @ v[[ 45 ]];
fitValue[ "Record", "DeviceIndex"                    , v_ ] := fitDeviceIndex @ v[[ 47 ]];
fitValue[ "Record", "LeftPlatformCenterOffset"       , v_ ] := fitPCO @ v[[ 48 ]];
fitValue[ "Record", "RightPlatformCenterOffset"      , v_ ] := fitPCO @ v[[ 49 ]];
fitValue[ "Record", "LeftPowerPhaseStart"            , v_ ] := fitPowerPhase @ v[[ 50 ]];
fitValue[ "Record", "LeftPowerPhaseEnd"              , v_ ] := fitPowerPhase @ v[[ 51 ]];
fitValue[ "Record", "LeftPowerPhasePeakStart"        , v_ ] := fitPowerPhase @ v[[ 52 ]];
fitValue[ "Record", "LeftPowerPhasePeakEnd"          , v_ ] := fitPowerPhase @ v[[ 53 ]];
fitValue[ "Record", "RightPowerPhaseStart"           , v_ ] := fitPowerPhase @ v[[ 54 ]];
fitValue[ "Record", "RightPowerPhaseEnd"             , v_ ] := fitPowerPhase @ v[[ 55 ]];
fitValue[ "Record", "RightPowerPhasePeakStart"       , v_ ] := fitPowerPhase @ v[[ 56 ]];
fitValue[ "Record", "RightPowerPhasePeakEnd"         , v_ ] := fitPowerPhase @ v[[ 57 ]];
fitValue[ "Record", "BatterySOC"                     , v_ ] := fitPercent @ v[[ 58 ]];
fitValue[ "Record", "MotorPower"                     , v_ ] := fitPower8 @ v[[ 59 ]];
fitValue[ "Record", "VerticalRatio"                  , v_ ] := fitPercent @ v[[ 60 ]];
fitValue[ "Record", "StanceTimeBalance"              , v_ ] := fitPercent @ v[[ 61 ]];
fitValue[ "Record", "StepLength"                     , v_ ] := fitMM8 @ v[[ 62 ]];
fitValue[ "Record", "AbsolutePressure"               , v_ ] := fitPressure @ v[[ 63 ]];
fitValue[ "Record", "Unknown61"                      , v_ ] := fitUINT16 @ v[[ 64 ]];
fitValue[ "Record", "PerformanceCondition"           , v_ ] := fitSINT8 @ v[[ 65 ]];
fitValue[ "Record", "Unknown90"                      , v_ ] := fitSINT8 @ v[[ 66 ]];
fitValue[ "Record", "RespirationRate"                , v_ ] := fitRespirationRate @ v[[ 67 ]];
fitValue[ "Record", "HeartRateVariability"           , v_ ] := fitHRV @ v[[ 68 ]];
fitValue[ "Record", "PowerZone"                      , v_ ] := fitPowerZone @ v[[ 13 ]];
fitValue[ "Record", "HeartRateZone"                  , v_ ] := fitHeartRateZone @ v[[ 29 ]];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Event*)
fitValue[ "Event", "Timestamp"           , v_ ] := fitDateTime @ v[[ 2 ]];
fitValue[ "Event", "Data"                , v_ ] := fitUINT32 @ v[[ 3 ]];
fitValue[ "Event", "Data16"              , v_ ] := fitUINT16 @ v[[ 4 ]];
fitValue[ "Event", "Score"               , v_ ] := fitUINT16 @ v[[ 5 ]];
fitValue[ "Event", "OpponentScore"       , v_ ] := fitUINT16 @ v[[ 6 ]];
fitValue[ "Event", "Event"               , v_ ] := fitEvent @ v[[ 7 ]];
fitValue[ "Event", "EventType"           , v_ ] := fitEventType @ v[[ 8 ]];
fitValue[ "Event", "EventGroup"          , v_ ] := fitEventGroup @ v[[ 9 ]];
fitValue[ "Event", "FrontGearNum"        , v_ ] := fitFrontGearNum @ v[[ 10 ]];
fitValue[ "Event", "FrontGear"           , v_ ] := fitFrontGear @ v[[ 11 ]];
fitValue[ "Event", "RearGearNum"         , v_ ] := fitRearGearNum @ v[[ 12 ]];
fitValue[ "Event", "RearGear"            , v_ ] := fitRearGear @ v[[ 13 ]];
fitValue[ "Event", "RadarThreatLevelType", v_ ] := fitRadarThreatLevelType @ v[[ 14 ]];
fitValue[ "Event", "RadarThreatCount"    , v_ ] := fitRadarThreatCount @ v[[ 15 ]];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*DeviceInformation*)
fitValue[ "DeviceInformation", "Timestamp"              , v_ ] := fitDateTime @ v[[ 2 ]];
fitValue[ "DeviceInformation", "SerialNumber"           , v_ ] := fitSerialNumber @ v[[ 3 ]];
fitValue[ "DeviceInformation", "CumulativeOperatingTime", v_ ] := fitCumulativeOperatingTime @ v[[ 4 ]];
fitValue[ "DeviceInformation", "Manufacturer"           , v_ ] := fitManufacturer @ v[[ 5 ]];
fitValue[ "DeviceInformation", "Product"                , v_ ] := fitProduct @ v[[ 6 ]];
fitValue[ "DeviceInformation", "SoftwareVersion"        , v_ ] := fitSoftwareVersion @ v[[ 7 ]];
fitValue[ "DeviceInformation", "BatteryVoltage"         , v_ ] := fitBatteryVoltage @ v[[ 8 ]];
fitValue[ "DeviceInformation", "ANTDeviceNumber"        , v_ ] := fitANTDeviceNumber @ v[[ 9 ]];
fitValue[ "DeviceInformation", "DeviceIndex"            , v_ ] := fitDeviceIndex @ v[[ 10 ]];
fitValue[ "DeviceInformation", "DeviceType"             , v_ ] := fitANTPlusDeviceType @ v[[ 11 ]];
fitValue[ "DeviceInformation", "HardwareVersion"        , v_ ] := fitHardwareVersion @ v[[ 12 ]];
fitValue[ "DeviceInformation", "BatteryStatus"          , v_ ] := fitBatteryStatus @ v[[ 13 ]];
fitValue[ "DeviceInformation", "SensorPosition"         , v_ ] := fitBodyLocation @ v[[ 14 ]];
fitValue[ "DeviceInformation", "ANTTransmissionType"    , v_ ] := fitANTTransmissionType @ v[[ 15 ]];
fitValue[ "DeviceInformation", "ANTNetwork"             , v_ ] := fitANTNetwork @ v[[ 16 ]];
fitValue[ "DeviceInformation", "SourceType"             , v_ ] := fitSourceType @ v[[ 17 ]];
fitValue[ "DeviceInformation", "ProductName"            , v_ ] := fitProductName[ v[[ 5;;6 ]], v[[ 18;;37 ]] ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Session*)
fitValue[ "Session", "Timestamp"                              , v_ ] := fitDateTime @ v[[ 2 ]];
fitValue[ "Session", "StartTime"                              , v_ ] := fitDateTime @ v[[ 3 ]];
fitValue[ "Session", "StartPosition"                          , v_ ] := fitGeoPosition @ v[[ 4;;5 ]];
fitValue[ "Session", "TotalElapsedTime"                       , v_ ] := fitTime32 @ v[[ 6 ]];
fitValue[ "Session", "TotalTimerTime"                         , v_ ] := fitTime32 @ v[[ 7 ]];
fitValue[ "Session", "TotalDistance"                          , v_ ] := fitDistance @ v[[ 8 ]];
fitValue[ "Session", "TotalCycles"                            , v_ ] := fitCycles32[ v[[ 9 ]], v[[ 89 ]] ];
fitValue[ "Session", "GeoBoundingBox"                         , v_ ] := fitGeoBoundingBox @ v[[ 10;;13 ]];
fitValue[ "Session", "AverageStrokeCount"                     , v_ ] := fitAverageStrokeCount @ v[[ 14 ]];
fitValue[ "Session", "TotalWork"                              , v_ ] := fitWork @ v[[ 15 ]];
fitValue[ "Session", "TotalMovingTime"                        , v_ ] := fitTime32 @ v[[ 16 ]];
fitValue[ "Session", "TimeInHeartRateZone"                    , v_ ] := fitTimeInZone @ v[[ 17 ]];
fitValue[ "Session", "TimeInSpeedZone"                        , v_ ] := fitTimeInZone @ v[[ 18 ]];
fitValue[ "Session", "TimeInCadenceZone"                      , v_ ] := fitTimeInZone @ v[[ 19 ]];
fitValue[ "Session", "TimeInPowerZone"                        , v_ ] := fitTimeInZone @ v[[ 20 ]];
fitValue[ "Session", "AverageLapTime"                         , v_ ] := fitTime32 @ v[[ 21 ]];
fitValue[ "Session", "MessageIndex"                           , v_ ] := fitMessageIndex @ v[[ 27 ]];
fitValue[ "Session", "TotalCalories"                          , v_ ] := fitCalories @ v[[ 28 ]];
fitValue[ "Session", "TotalFatCalories"                       , v_ ] := fitCalories @ v[[ 29 ]];
fitValue[ "Session", "AverageSpeed"                           , v_ ] := fitSpeedSelect[ v[[ 22 ]], v[[ 30 ]] ];
fitValue[ "Session", "MaxSpeed"                               , v_ ] := fitSpeedSelect[ v[[ 23 ]], v[[ 31 ]] ];
fitValue[ "Session", "AveragePower"                           , v_ ] := fitPower @ v[[ 32 ]];
fitValue[ "Session", "MaxPower"                               , v_ ] := fitPower @ v[[ 33 ]];
fitValue[ "Session", "TotalAscent"                            , v_ ] := fitAscent @ v[[ 34 ]];
fitValue[ "Session", "TotalDescent"                           , v_ ] := fitAscent @ v[[ 35 ]];
fitValue[ "Session", "FirstLapIndex"                          , v_ ] := fitUINT16 @ v[[ 36 ]];
fitValue[ "Session", "NumberOfLaps"                           , v_ ] := fitLaps @ v[[ 37 ]];
fitValue[ "Session", "NumberOfLengths"                        , v_ ] := fitLengths @ v[[ 38 ]];
fitValue[ "Session", "NormalizedPower"                        , v_ ] := fitPower @ v[[ 39 ]];
fitValue[ "Session", "TrainingStressScore"                    , v_ ] := fitTrainingStressScore @ v[[ 40 ]];
fitValue[ "Session", "IntensityFactor"                        , v_ ] := fitIntensityFactor @ v[[ 41 ]];
fitValue[ "Session", "LeftRightBalance"                       , v_ ] := fitLeftRightBalance @ v[[ 42 ]];
fitValue[ "Session", "AverageStrokeDistance"                  , v_ ] := fitMeters100 @ v[[ 43 ]];
fitValue[ "Session", "PoolLength"                             , v_ ] := fitMeters100 @ v[[ 44 ]];
fitValue[ "Session", "ThresholdPower"                         , v_ ] := fitPower @ v[[ 45 ]];
fitValue[ "Session", "NumberOfActiveLengths"                  , v_ ] := fitLengths @ v[[ 46 ]];
fitValue[ "Session", "AverageAltitude"                        , v_ ] := fitAltitudeSelect[ v[[ 24 ]], v[[ 47 ]] ];
fitValue[ "Session", "MaxAltitude"                            , v_ ] := fitAltitudeSelect[ v[[ 26 ]], v[[ 48 ]] ];
fitValue[ "Session", "AverageGrade"                           , v_ ] := fitGrade @ v[[ 49 ]];
fitValue[ "Session", "AveragePositiveGrade"                   , v_ ] := fitGrade @ v[[ 50 ]];
fitValue[ "Session", "AverageNegativeGrade"                   , v_ ] := fitGrade @ v[[ 51 ]];
fitValue[ "Session", "MaxPositiveGrade"                       , v_ ] := fitGrade @ v[[ 52 ]];
fitValue[ "Session", "MaxNegativeGrade"                       , v_ ] := fitGrade @ v[[ 53 ]];
fitValue[ "Session", "AveragePositiveVerticalSpeed"           , v_ ] := fitVerticalSpeed @ v[[ 54 ]];
fitValue[ "Session", "AverageNegativeVerticalSpeed"           , v_ ] := fitVerticalSpeed @ v[[ 55 ]];
fitValue[ "Session", "MaxPositiveVerticalSpeed"               , v_ ] := fitVerticalSpeed @ v[[ 56 ]];
fitValue[ "Session", "MaxNegativeVerticalSpeed"               , v_ ] := fitVerticalSpeed @ v[[ 57 ]];
fitValue[ "Session", "BestLapIndex"                           , v_ ] := fitUINT16 @ v[[ 58 ]];
fitValue[ "Session", "MinAltitude"                            , v_ ] := fitAltitudeSelect[ v[[ 25 ]], v[[ 59 ]] ];
fitValue[ "Session", "PlayerScore"                            , v_ ] := fitUINT16 @ v[[ 60 ]];
fitValue[ "Session", "OpponentScore"                          , v_ ] := fitUINT16 @ v[[ 61 ]];
fitValue[ "Session", "StrokeCount"                            , v_ ] := fitStrokeCount @ v[[ 62 ]];
fitValue[ "Session", "ZoneCount"                              , v_ ] := fitZoneCount @ v[[ 63 ]];
fitValue[ "Session", "MaxBallSpeed"                           , v_ ] := fitBallSpeed @ v[[ 64 ]];
fitValue[ "Session", "AverageBallSpeed"                       , v_ ] := fitBallSpeed @ v[[ 65 ]];
fitValue[ "Session", "AverageVerticalOscillation"             , v_ ] := fitVerticalOscillation @ v[[ 66 ]];
fitValue[ "Session", "AverageStanceTimePercent"               , v_ ] := fitStanceTimePercent @ v[[ 67 ]];
fitValue[ "Session", "AverageStanceTime"                      , v_ ] := fitStanceTime @ v[[ 68 ]];
fitValue[ "Session", "AverageVAM"                             , v_ ] := fitVAM @ v[[ 69 ]];
fitValue[ "Session", "Event"                                  , v_ ] := fitEvent @ v[[ 70 ]];
fitValue[ "Session", "EventType"                              , v_ ] := fitEventType @ v[[ 71 ]];
fitValue[ "Session", "Sport"                                  , v_ ] := fitSport @ v[[ 72 ]];
fitValue[ "Session", "SubSport"                               , v_ ] := fitSubSport @ v[[ 73 ]];
fitValue[ "Session", "AverageHeartRate"                       , v_ ] := fitHeartRate @ v[[ 74 ]];
fitValue[ "Session", "MaxHeartRate"                           , v_ ] := fitHeartRate @ v[[ 75 ]];
fitValue[ "Session", "AverageCadence"                         , v_ ] := fitCadence[ v[[ 76 ]], v[[ 87 ]] ];
fitValue[ "Session", "MaxCadence"                             , v_ ] := fitCadence[ v[[ 77 ]], v[[ 88 ]] ];
fitValue[ "Session", "TotalAerobicTrainingEffect"             , v_ ] := fitTrainingEffect @ v[[ 78 ]];
fitValue[ "Session", "TotalAerobicTrainingEffectDescription"  , v_ ] := fitTrainingEffectDescription @ v[[ 78 ]];
fitValue[ "Session", "EventGroup"                             , v_ ] := fitEventGroup @ v[[ 79 ]];
fitValue[ "Session", "Trigger"                                , v_ ] := fitSessionTrigger @ v[[ 80 ]];
fitValue[ "Session", "SwimStroke"                             , v_ ] := fitSwimStroke @ v[[ 81 ]];
fitValue[ "Session", "PoolLengthUnit"                         , v_ ] := fitDisplayMeasure @ v[[ 82 ]];
fitValue[ "Session", "GPSAccuracy"                            , v_ ] := fitGPSAccuracy @ v[[ 83 ]];
fitValue[ "Session", "AverageTemperature"                     , v_ ] := fitTemperature @ v[[ 84 ]];
fitValue[ "Session", "MaxTemperature"                         , v_ ] := fitTemperature @ v[[ 85 ]];
fitValue[ "Session", "MinHeartRate"                           , v_ ] := fitHeartRate @ v[[ 86 ]];
fitValue[ "Session", "SportIndex"                             , v_ ] := fitUINT8 @ v[[ 90 ]];
fitValue[ "Session", "TotalAnaerobicTrainingEffect"           , v_ ] := fitTrainingEffect @ v[[ 91 ]];
fitValue[ "Session", "TotalAnaerobicTrainingEffectDescription", v_ ] := fitTrainingEffectDescription @ v[[ 91 ]];
fitValue[ "Session", "AverageLeftPlatformCenterOffset"        , v_ ] := fitPCO @ v[[ 92 ]];
fitValue[ "Session", "AverageRightPlatformCenterOffset"       , v_ ] := fitPCO @ v[[ 93 ]];
fitValue[ "Session", "AverageLeftPowerPhaseStart"             , v_ ] := fitPowerPhase @ v[[ 94 ]];
fitValue[ "Session", "AverageLeftPowerPhaseEnd"               , v_ ] := fitPowerPhase @ v[[ 95 ]];
fitValue[ "Session", "AverageLeftPowerPhasePeakStart"         , v_ ] := fitPowerPhase @ v[[ 96 ]];
fitValue[ "Session", "AverageLeftPowerPhasePeakEnd"           , v_ ] := fitPowerPhase @ v[[ 97 ]];
fitValue[ "Session", "AverageRightPowerPhaseStart"            , v_ ] := fitPowerPhase @ v[[ 98 ]];
fitValue[ "Session", "AverageRightPowerPhaseEnd"              , v_ ] := fitPowerPhase @ v[[ 99 ]];
fitValue[ "Session", "AverageRightPowerPhasePeakStart"        , v_ ] := fitPowerPhase @ v[[ 100 ]];
fitValue[ "Session", "AverageRightPowerPhasePeakEnd"          , v_ ] := fitPowerPhase @ v[[ 101 ]];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*ZonesTarget*)
fitValue[ "ZonesTarget", "FunctionalThresholdPower", v_ ] := fitFTPSetting @ v[[ 2 ]];
fitValue[ "ZonesTarget", "MaxHeartRate"            , v_ ] := fitMaxHRSetting @ v[[ 3 ]];
fitValue[ "ZonesTarget", "ThresholdHeartRate"      , v_ ] := fitHeartRate @ v[[ 4 ]];
fitValue[ "ZonesTarget", "HeartRateCalculationType", v_ ] := fitHeartRateZoneCalc @ v[[ 5 ]];
fitValue[ "ZonesTarget", "PowerZoneCalculationType", v_ ] := fitPowerZoneCalc @ v[[ 6 ]];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*FileCreator*)
fitValue[ "FileCreator", "SoftwareVersion", v_ ] := fitUINT16 @ v[[ 2 ]];
fitValue[ "FileCreator", "HardwareVersion", v_ ] := fitUINT8 @ v[[ 3 ]];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Sport*)
fitValue[ "Sport", "Name"    , v_ ] := fitString @ v[[ 2;;17 ]];
fitValue[ "Sport", "Sport"   , v_ ] := fitSport @ v[[ 18 ]];
fitValue[ "Sport", "SubSport", v_ ] := fitSubSport @ v[[ 19 ]];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*DeveloperDataID*)
fitValue[ "DeveloperDataID", "DeveloperID"       , v_ ] := fitHexString @ v[[ 2;;17 ]];
fitValue[ "DeveloperDataID", "ApplicationID"     , v_ ] := fitHexString @ v[[ 18;;33 ]];
fitValue[ "DeveloperDataID", "ApplicationVersion", v_ ] := fitUINT32 @ v[[ 34 ]];
fitValue[ "DeveloperDataID", "ManufacturerID"    , v_ ] := fitManufacturer @ v[[ 35 ]];
fitValue[ "DeveloperDataID", "DeveloperDataIndex", v_ ] := fitUINT8 @ v[[ 36 ]];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*MessageInformation*)
fitValue[ "MessageInformation", "MessageTypeName", v_ ] := fitMessageType @ v[[ 2 ]];
fitValue[ "MessageInformation", "MessageIDNumber", v_ ] := v[[ 2 ]];
fitValue[ "MessageInformation", "MessageSize"    , v_ ] := v[[ 3 ]];
fitValue[ "MessageInformation", "Supported"      , v_ ] := messageTypeQ @ fitMessageType @ v[[ 2 ]];
fitValue[ "MessageInformation", "ByteOrdering"   , v_ ] := fitByteOrder @ v[[ 4 ]];
fitValue[ "MessageInformation", "FieldCount"     , v_ ] := v[[ 5 ]];
fitValue[ "MessageInformation", "FileOffset"     , v_ ] := fitFileOffset @ v[[ 6 ]];
fitValue[ "MessageInformation", "MessageIndex"   , v_ ] := v[[ 7 ]];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*FieldDescription*)
fitValue[ "FieldDescription", "FieldName"            , v_ ] := fitString @ v[[ 2;;65 ]];
fitValue[ "FieldDescription", "Units"                , v_ ] := fitString @ v[[ 66;;81 ]];
fitValue[ "FieldDescription", "FitBaseUnitID"        , v_ ] := fitFitBaseUnit @ v[[ 82 ]];
fitValue[ "FieldDescription", "NativeMessageNumber"  , v_ ] := fitUINT16 @ v[[ 83 ]];
fitValue[ "FieldDescription", "DeveloperDataIndex"   , v_ ] := fitUINT8 @ v[[ 84 ]];
fitValue[ "FieldDescription", "FieldDefinitionNumber", v_ ] := fitUINT8 @ v[[ 85 ]];
fitValue[ "FieldDescription", "FitBaseTypeID"        , v_ ] := fitFitBaseType @ v[[ 86 ]];
fitValue[ "FieldDescription", "Scale"                , v_ ] := fitUINT8 @ v[[ 87 ]];
fitValue[ "FieldDescription", "Offset"               , v_ ] := fitSINT8 @ v[[ 88 ]];
fitValue[ "FieldDescription", "NativeFieldNumber"    , v_ ] := fitUINT8 @ v[[ 89 ]];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*TrainingFile*)
fitValue[ "TrainingFile", "Timestamp"   , v_ ] := fitDateTime @ v[[ 2 ]];
fitValue[ "TrainingFile", "SerialNumber", v_ ] := fitUINT32Z @ v[[ 3 ]];
fitValue[ "TrainingFile", "TimeCreated" , v_ ] := fitDateTime @ v[[ 4 ]];
fitValue[ "TrainingFile", "Manufacturer", v_ ] := fitManufacturer @ v[[ 5 ]];
fitValue[ "TrainingFile", "Product"     , v_ ] := fitProduct @ v[[ 6 ]];
fitValue[ "TrainingFile", "Type"        , v_ ] := fitFile @ v[[ 7 ]];
fitValue[ "TrainingFile", "ProductName" , v_ ] := fitProductName @ v[[ 5;;6 ]];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*WorkoutStep*)
fitValue[ "WorkoutStep", "WorkoutStepName"               , v_ ] := fitString @ v[[ 2;;17 ]];
fitValue[ "WorkoutStep", "DurationValue"                 , v_ ] := fitUINT32 @ v[[ 18 ]]; (* TODO: interpret values *)
fitValue[ "WorkoutStep", "TargetValue"                   , v_ ] := fitUINT32 @ v[[ 19 ]];
fitValue[ "WorkoutStep", "CustomTargetValueLow"          , v_ ] := fitUINT32 @ v[[ 20 ]];
fitValue[ "WorkoutStep", "CustomTargetValueHigh"         , v_ ] := fitUINT32 @ v[[ 21 ]];
fitValue[ "WorkoutStep", "SecondaryTargetValue"          , v_ ] := fitUINT32 @ v[[ 22 ]];
fitValue[ "WorkoutStep", "SecondaryCustomTargetValueLow" , v_ ] := fitUINT32 @ v[[ 23 ]];
fitValue[ "WorkoutStep", "SecondaryCustomTargetValueHigh", v_ ] := fitUINT32 @ v[[ 24 ]];
fitValue[ "WorkoutStep", "MessageIndex"                  , v_ ] := fitMessageIndex @ v[[ 25 ]];
fitValue[ "WorkoutStep", "ExerciseCategory"              , v_ ] := fitExerciseCategory @ v[[ 26 ]];
fitValue[ "WorkoutStep", "DurationType"                  , v_ ] := fitWorkoutStepDuration @ v[[ 27 ]];
fitValue[ "WorkoutStep", "TargetType"                    , v_ ] := fitWorkoutStepTarget @ v[[ 28 ]];
fitValue[ "WorkoutStep", "Intensity"                     , v_ ] := fitIntensity @ v[[ 29 ]];
fitValue[ "WorkoutStep", "Notes"                         , v_ ] := fitString @ v[[ 30;;79 ]];
fitValue[ "WorkoutStep", "Equipment"                     , v_ ] := fitWorkoutEquipment @ v[[ 80 ]];
fitValue[ "WorkoutStep", "SecondaryTargetType"           , v_ ] := fitWorkoutStepTarget @ v[[ 81 ]];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*HeartRateVariability*)
fitValue[ "HeartRateVariability", "Time", v_ ] := fitHRV @ v[[ 2 ]];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Defaults*)
fitValue[ _, "RawData", v_ ] := ByteArray @ v[[ 2;; ]];
fitValue[ _, _, _ ] := Missing[ "NotAvailable" ];
fitValue // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitBool*)
fitBool // ClearAll;
fitBool[ 0 ] := False;
fitBool[ 1 ] := True;
fitBool[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitByteOrder*)
fitByteOrder // ClearAll;
fitByteOrder[ 0 ] := -1;
fitByteOrder[ 1 ] :=  1;
fitByteOrder[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitFileOffset*)
fitFileOffset // ClearAll;
fitFileOffset[ n_Integer ] := fitFileOffset[ n, $fileByteCount ];
fitFileOffset[ n_Integer, size_Integer? Positive ] := size - n;
fitFileOffset[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitHexString*)
fitHexString // ClearAll;
fitHexString[ { $invalidUINT8.. } ] := Missing[ "NotAvailable" ];
fitHexString[ v_List ] := StringJoin[ (IntegerString[ #, 16 ] &) /@ v ];
fitHexString[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitSINT8*)
fitSINT8 // ClearAll;
fitSINT8[ $invalidSINT8 ] := Missing[ "NotAvailable" ];
fitSINT8[ n_Integer ] := n;
fitSINT8[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitUINT8*)
fitUINT8 // ClearAll;
fitUINT8[ $invalidUINT8 ] := Missing[ "NotAvailable" ];
fitUINT8[ n_Integer ] := n;
fitUINT8[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitUINT16*)
fitUINT16 // ClearAll;
fitUINT16[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitUINT16[ n_Integer ] := n;
fitUINT16[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitSINT16*)
fitSINT16 // ClearAll;
fitSINT16[ $invalidSINT16 ] := Missing[ "NotAvailable" ];
fitSINT16[ n_Integer ] := n;
fitSINT16[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitUINT32*)
fitUINT32 // ClearAll;
fitUINT32[ $invalidUINT32 ] := Missing[ "NotAvailable" ];
fitUINT32[ n_Integer ] := n;
fitUINT32[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitUINT32Z*)
fitUINT32Z // ClearAll;
fitUINT32Z[ $invalidUINT32Z ] := Missing[ "NotAvailable" ];
fitUINT32Z[ n_Integer ] := n;
fitUINT32Z[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitString*)
fitString // ClearAll;
fitString[ { 0, ___ } ] := Missing[ "NotAvailable" ];
fitString[ bytes: { __Integer } ] := FromCharacterCode[ TakeWhile[ bytes, Positive ], "UTF-8" ];
fitString[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitUINT16BF*)
fitUINT16BF // ClearAll;
fitUINT16BF[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitUINT16BF[ n_Integer ] := With[ { d = IntegerDigits[ n, 2 ] }, Pick[ Range @ Length @ d, d, 1 ] ];
fitUINT16BF[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitGlobalID*)
fitGlobalID // ClearAll;
fitGlobalID[ { 255 .. } ] := Missing[ "NotAvailable" ];
fitGlobalID[ bytes: { __Integer } ] := FromDigits[ bytes, 256 ];
fitGlobalID[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitDateTime*)
fitDateTime // ClearAll;
fitDateTime[ $invalidTimestamp ] := Missing[ "NotAvailable" ];
fitDateTime[ n_Integer ] := TimeZoneConvert @ DateObject[ n + $timeOffset, TimeZone -> 0 ];
fitDateTime[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitLocalTimestamp*)
fitLocalTimestamp // ClearAll;
fitLocalTimestamp[ $invalidTimestamp ] := Missing[ "NotAvailable" ];
fitLocalTimestamp[ n_Integer ] := TimeZoneConvert @ DateObject[ n, TimeZone -> 0 ];
fitLocalTimestamp[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTime16*)
fitTime16 // ClearAll;
fitTime16[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitTime16[ n___ ] := fitTime @ n;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTime32*)
fitTime32 // ClearAll;
fitTime32[ $invalidUINT32 ] := Missing[ "NotAvailable" ];
fitTime32[ n___ ] := fitTime @ n;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTime*)
fitTime // ClearAll;
fitTime[ n_Integer ] := secondsToQuantity[ n/1000.0 ];
fitTime[ ___ ] := Missing[ "NotAvailable" ];

secondsToQuantity := secondsToQuantity =
    ResourceFunction[ "SecondsToQuantity", "Function" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitMinutes*)
fitMinutes // ClearAll;
fitMinutes[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitMinutes[ n_Integer ] := secondsToQuantity[ n*60 ];
fitMinutes[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitGeoPosition*)
fitGeoPosition // ClearAll;
fitGeoPosition[ { $invalidSINT32|0, _ } ] := Missing[ "NotAvailable" ];
fitGeoPosition[ { _, $invalidSINT32|0 } ] := Missing[ "NotAvailable" ];
fitGeoPosition[ { a_, b_ } ] := GeoPosition[ 8.381903175442434*^-8*{ a, b } ];
fitGeoPosition[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitGeoBoundingBox*)
fitGeoBoundingBox // ClearAll;

fitGeoBoundingBox[ { neLat_, neLon_, swLat_, swLon_ } ] :=
    fitGeoBoundingBox @ {
        fitGeoPosition @ { swLat, swLon },
        fitGeoPosition @ { neLat, neLon }
    };

fitGeoBoundingBox[ bounds: { _GeoPosition, _GeoPosition } ] :=
    bounds;

fitGeoBoundingBox[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitWeight*)
fitWeight // ClearAll;
fitWeight[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitWeight[ n_Integer ] := fitWeight[ n, $weightUnits ];
fitWeight[ n_Integer, "Imperial" ] := Quantity[ 0.220462 * n, "Pounds" ];
fitWeight[ n_Integer, _ ] := Quantity[ n/10.0, "Kilograms" ];
fitWeight[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitAge*)
fitAge // ClearAll;
fitAge[ $invalidUINT8 ] := Missing[ "NotAvailable" ];
fitAge[ n_Integer ] := Quantity[ n, "Years" ];
fitAge[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitHeight*)
fitHeight // ClearAll;
fitHeight[ $invalidUINT8 ] := Missing[ "NotAvailable" ];
fitHeight[ n_Integer ] := fitHeight[ n, $heightUnits ];
fitHeight[ n_Integer, "Imperial" ] := Quantity[ With[ { x = 0.0328 * n }, MixedMagnitude @ { IntegerPart @ x, 12 * FractionalPart @ x } ], MixedUnit @ { "Feet", "Inches" } ];
fitHeight[ n_Integer, _ ] := Quantity[ n/100.0, "Meters" ];
fitHeight[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitDistance*)
fitDistance // ClearAll;
fitDistance[ $invalidUINT32 ] := Missing[ "NotAvailable" ];
fitDistance[ n_Integer ] := fitDistance[ n, $distanceUnits ];
fitDistance[ n_, "Imperial" ] := Quantity[ 6.213711922373339*^-6*n, "Miles" ];
fitDistance[ n_, _ ] := Quantity[ n/100.0, "Meters" ];
fitDistance[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitMM8*)
fitMM8 // ClearAll;
fitMM8[ $invalidUINT8 ] := Missing[ "NotAvailable" ];
fitMM8[ n_Integer ] := fitMM8[ n, $distanceUnits ];
fitMM8[ n_Integer, "Imperial" ] := Quantity[ 0.03937 * n, "Inches" ];
fitMM8[ n_Integer, _ ] := Quantity[ 1.0 * n, "Millimeters" ];
fitMM8[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitWork*)
fitWork // ClearAll;
fitWork[ $invalidUINT32 ] := Missing[ "NotAvailable" ];
fitWork[ n_Integer ] := Quantity[ n/1000.0, "Kilojoules" ];
fitWork[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitPercent*)
fitPercent // ClearAll;
fitPercent[ $invalidUINT8 ] := Missing[ "NotAvailable" ];
fitPercent[ n_Integer ] := Quantity[ n, "Percent" ];
fitPercent[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitPressure*)
fitPressure // ClearAll;
fitPressure[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitPressure[ n_Integer ] := fitPressure[ n, $pressureUnits ];
fitPressure[ n_Integer, "Imperial" ] := Quantity[ 0.00014504 * n, "PoundsForce"/"Inches"^2 ];
fitPressure[ n_Integer, _ ] := Quantity[ 1.0 * n, "Pascals" ];
fitPressure[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTimeFromCourse*)
fitTimeFromCourse // ClearAll;
fitTimeFromCourse[ $invalidSINT32 ] := Missing[ "NotAvailable" ];
fitTimeFromCourse[ n_Integer ] := secondsToQuantity[ n/1000.0 ];
fitTimeFromCourse[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitCycles32*)
fitCycles32 // ClearAll;
fitCycles32[ $invalidUINT32|0 ] := Missing[ "NotAvailable" ];
fitCycles32[ $invalidUINT32|0, n_ ] := fitFractionalCycles @ n;
fitCycles32[ c_Integer, $invalidUINT32|0 ] := cycleQuantity @ c;
fitCycles32[ c_Integer, f_Integer ] := cycleQuantity[ c + f / 128.0 ];
fitCycles32[ c_Integer ] := cycleQuantity @ c;
fitCycles32[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitCycles8*)
fitCycles8 // ClearAll;
fitCycles8[ $invalidUINT8|0 ] := Missing[ "NotAvailable" ];
fitCycles8[ $invalidUINT8|0, n_ ] := fitFractionalCycles @ n;
fitCycles8[ c_Integer, $invalidUINT8|0 ] := cycleQuantity @ c;
fitCycles8[ c_Integer, f_Integer ] := cycleQuantity[ c + f / 128.0 ];
fitCycles8[ c_Integer ] := cycleQuantity @ c;
fitCycles8[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitFractionalCycles*)
fitFractionalCycles // ClearAll;
fitFractionalCycles[ $invalidUINT8|0 ] := Missing[ "NotAvailable" ];
fitFractionalCycles[ n_Integer ] := cycleQuantity[ n/128.0 ];
fitFractionalCycles[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTimeInZone*)
fitTimeInZone // ClearAll;
fitTimeInZone[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitAccumulatedPower*)
fitAccumulatedPower // ClearAll;
fitAccumulatedPower[ { $invalidUINT32, _ } ] := Missing[ "NotAvailable" ];
fitAccumulatedPower[ { _, $invalidUINT32 } ] := Quantity[ 0.0, "Kilojoules" ];
fitAccumulatedPower[ a_ ] := fitAccumulatedPower[ $start, a ];
fitAccumulatedPower[ t0_Integer, { t_Integer, n_Integer } ] := Quantity[ 0.001 * n * (t - t0), "Kilojoules" ];
fitAccumulatedPower[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitAltitudeSelect*)
fitAltitudeSelect // ClearAll;
fitAltitudeSelect[ a32_, a16_ ] := fitAltitudeSelect[ a32, a16, fitAltitude32 @ a32 ];
fitAltitudeSelect[ a32_, a16_, a_Quantity ] := a;
fitAltitudeSelect[ a32_, a16_, _ ] := fitAltitude16 @ a16;
fitAltitudeSelect[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitAltitude32*)
fitAltitude32 // ClearAll;
fitAltitude32[ $invalidUINT32 ] := Missing[ "NotAvailable" ];
fitAltitude32[ n___ ] := fitAltitude @ n;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitAltitude16*)
fitAltitude16 // ClearAll;
fitAltitude16[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitAltitude16[ n___ ] := fitAltitude @ n;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitAltitude*)
fitAltitude[ n_Integer ] := fitAltitude[ n, $altitudeUnits ];
fitAltitude[ n_, "Imperial" ] := Quantity[ 0.656168 n - 1640.42, "Feet" ];
fitAltitude[ n_, _ ] := Quantity[ 0.2 n - 500.0, "Meters" ];
fitAltitude[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitAscent*)
fitAscent // ClearAll;
fitAscent[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitAscent[ n_Integer ] := fitAscent[ n, $altitudeUnits ];
fitAscent[ n_, "Imperial" ] := Quantity[ 3.28084 * n, "Feet" ];
fitAscent[ n_, _ ] := Quantity[ n, "Meters" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitSpeedSelect*)
fitSpeedSelect // ClearAll;
fitSpeedSelect[ s32_, s16_ ] := fitSpeedSelect[ s32, s16, fitSpeed32 @ s32 ];
fitSpeedSelect[ s32_, s16_, s_Quantity ] := s;
fitSpeedSelect[ s32_, s16_, _ ] := fitSpeed16 @ s16;
fitSpeedSelect[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitSpeed16*)
fitSpeed16 // ClearAll;
fitSpeed16[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitSpeed16[ n___ ] := fitSpeed @ n;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitSpeed32*)
fitSpeed32 // ClearAll;
fitSpeed32[ $invalidUINT32 ] := Missing[ "NotAvailable" ];
fitSpeed32[ n___ ] := fitSpeed @ n;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitSpeed*)
fitSpeed // ClearAll;
fitSpeed[ 0 ] := Missing[ "NotAvailable" ];
fitSpeed[ n_Integer ] := fitSpeed[ n, $speedUnits ];
fitSpeed[ n_, "Imperial" ] := Quantity[ 0.0022369362920544025*n, "Miles"/"Hours" ];
fitSpeed[ n_, _ ] := Quantity[ n/1000.0, "Meters"/"Seconds" ];
fitSpeed[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitPower*)
fitPower // ClearAll;
fitPower[ $invalidUINT16 ] := Quantity[ 0.0, "Watts" ];
fitPower[ n_Integer ] := Quantity[ 1.0*n, "Watts" ];
fitPower[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitPower8*)
fitPower8 // ClearAll;
fitPower8[ $invalidUINT8 ] := Quantity[ 0, "Watts" ];
fitPower8[ n_Integer ] := Quantity[ n, "Watts" ];
fitPower8[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitFTPSetting*)
fitFTPSetting // ClearAll;
fitFTPSetting[ n_ ] := fitFTPSetting[ fitPower @ n, $ftp ];
fitFTPSetting[ watts_Quantity, Automatic ] := ($ftp = setFTP @ watts; watts);
fitFTPSetting[ watts_Quantity, _ ] := watts;
fitFTPSetting[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitGrade*)
fitGrade // ClearAll;
fitGrade[ $invalidSINT16 ] := Missing[ "NotAvailable" ];
fitGrade[ n_Integer ] := Quantity[ 0.01 * n, "Percent" ];
fitGrade[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitCompressedAccumulatedPower*)
fitCompressedAccumulatedPower // ClearAll;
fitCompressedAccumulatedPower[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitCompressedAccumulatedPower[ n_Integer ] := Quantity[ 0.001 * n, "Kilojoules" ];
fitCompressedAccumulatedPower[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitVerticalSpeed*)
fitVerticalSpeed // ClearAll;
fitVerticalSpeed[ $invalidSINT16 ] := Missing[ "NotAvailable" ];
fitVerticalSpeed[ n_Integer ] := fitVerticalSpeed[ n, $speedUnits ];
fitVerticalSpeed[ n_, "Imperial" ] := Quantity[ 0.00328084 * n, "Feet"/"Seconds" ];
fitVerticalSpeed[ n_, _ ] := Quantity[ n / 1000.0, "Meters"/"Seconds" ];
fitVerticalSpeed[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitVAM*)
fitVAM // ClearAll;
fitVAM[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitVAM[ n_Integer ] := fitVAM[ n, $speedUnits ];
fitVAM[ n_, "Imperial" ] := Quantity[ 0.00328084 * n, "Feet"/"Seconds" ];
fitVAM[ n_, _ ] := Quantity[ n / 1000.0, "Meters"/"Seconds" ];
fitVAM[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitCalories*)
fitCalories // ClearAll;
fitCalories[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitCalories[ n_Integer ] := Quantity[ n, "DietaryCalories" ];
fitCalories[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitRespirationRate*)
fitRespirationRate // ClearAll;
(* Undocumented field, so this probably isn't 100% correct *)
fitRespirationRate[ $invalidUINT8|$invalidUINT16|0 ] := Missing[ "NotAvailable" ];
fitRespirationRate[ n_Integer ] := Quantity[ 2.4 * Mod[ n, 64 ] + 3.6, IndependentUnit[ "Breaths" ] / "Minutes" ];
fitRespirationRate[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitVerticalOscillation*)
fitVerticalOscillation // ClearAll;
fitVerticalOscillation[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitVerticalOscillation[ n_Integer ] := fitVerticalOscillation[ n, $distanceUnits ];
fitVerticalOscillation[ n_, "Imperial" ] := Quantity[ 0.003937 * n, "Inches" ];
fitVerticalOscillation[ n_, _ ] := Quantity[ n / 10.0, "Millimeters" ];
fitVerticalOscillation[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitStanceTimePercent*)
fitStanceTimePercent // ClearAll;
fitStanceTimePercent[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitStanceTimePercent[ n_Integer ] := Quantity[ 0.01 * n, "Percent" ];
fitStanceTimePercent[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitStanceTime*)
fitStanceTime // ClearAll;
fitStanceTime[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitStanceTime[ n_Integer ] := Quantity[ n/10.0, "Milliseconds" ];
fitStanceTime[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitBallSpeed*)
fitBallSpeed // ClearAll;
fitBallSpeed[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitBallSpeed[ n_Integer ] := fitBallSpeed[ n, $speedUnits ];
fitBallSpeed[ n_, "Imperial" ] := Quantity[ 0.032808 * n, "Feet"/"Seconds" ];
fitBallSpeed[ n_, _ ] := Quantity[ n / 100.0, "Meters"/"Seconds" ];
fitBallSpeed[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitCadence256*)
fitCadence256 // ClearAll;
fitCadence256[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitCadence256[ n_Integer ] := Quantity[ n/256.0, "Revolutions"/"Minutes" ];
fitCadence256[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitHemoglobin*)
fitHemoglobin // ClearAll;
fitHemoglobin[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitHemoglobin[ n_Integer ] := Quantity[ n/100.0, "Grams"/"Deciliters" ];
fitHemoglobin[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitHemoglobinPercent*)
fitHemoglobinPercent // ClearAll;
fitHemoglobinPercent[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitHemoglobinPercent[ n_Integer ] := Quantity[ n / 10.0, "Percent" ];
fitHemoglobinPercent[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitHeartRate*)
fitHeartRate // ClearAll;
fitHeartRate[ $invalidUINT8 | 0 ] := Missing[ "NotAvailable" ];
fitHeartRate[ n_Integer ] := Quantity[ n, "Beats"/"Minutes" ];
fitHeartRate[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitMaxHRSetting*)
fitMaxHRSetting // ClearAll;
fitMaxHRSetting[ n_ ] := fitMaxHRSetting[ fitHeartRate @ n, $maxHR ];
fitMaxHRSetting[ hr_Quantity, Automatic ] := ($maxHR = setMaxHR @ hr; hr);
fitMaxHRSetting[ hr_Quantity, _ ] := hr;
fitMaxHRSetting[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitCadence*)
fitCadence // ClearAll;
fitCadence[ $invalidUINT8|0 ] := Missing[ "NotAvailable" ];
fitCadence[ $invalidUINT8|0, n_ ] := fitFractionalCadence @ n;
fitCadence[ c_Integer, $invalidUINT8|0 ] := cadenceQuantity @ c;
fitCadence[ c_Integer, f_Integer ] := cadenceQuantity[ c + f / 128.0 ];
fitCadence[ c_Integer ] := cadenceQuantity @ c;
fitCadence[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitFractionalCadence*)
fitFractionalCadence // ClearAll;
fitFractionalCadence[ $invalidUINT8|0 ] := Missing[ "NotAvailable" ];
fitFractionalCadence[ n_Integer ] := cadenceQuantity[ n / 128.0 ];
fitFractionalCadence[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitResistance*)
fitResistance // ClearAll;
fitResistance[ $invalidUINT8 ] := Missing[ "NotAvailable" ];
fitResistance[ n_Integer ] := Quantity[ n / 254.0, "Percent" ];
fitResistance[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitCycleLength*)
fitCycleLength // ClearAll;
fitCycleLength[ $invalidUINT8 ] := Missing[ "NotAvailable" ];
fitCycleLength[ n_Integer ] := fitCycleLength[ n, $distanceUnits ];
fitCycleLength[ n_, "Imperial" ] := Quantity[ 0.032808 * n, "Feet" ];
fitCycleLength[ n_, _ ] := Quantity[ n / 100.0, "Meters" ];
fitCycleLength[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTemperature*)
fitTemperature // ClearAll;
fitTemperature[ $invalidSINT8 ] := Missing[ "NotAvailable" ];
fitTemperature[ n_Integer ] := fitTemperature[ n, $temperatureUnits ];
fitTemperature[ n_Integer, "Imperial" ] := Quantity[ 32.0 + 1.8 n, "DegreesFahrenheit" ];
fitTemperature[ n_Integer, _ ] := Quantity[ 1.0 * n, "DegreesCelsius" ];
fitTemperature[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitSteps*)
fitSteps // ClearAll;
fitSteps[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitSteps[ n_Integer ] := Quantity[ n, "Steps" ];
fitSteps[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitStepLength*)
fitStepLength // ClearAll;
fitStepLength[ 0 ] := Automatic;
fitStepLength[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitStepLength[ n_Integer ] := fitStepLength[ n, $distanceUnits ];
fitStepLength[ n_Integer, "Imperial" ] := Quantity[ 0.00328084 * n, "Feet" ];
fitStepLength[ n_Integer, _ ] := Quantity[ 0.001 * n, "Meters" ];
fitStepLength[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitLeftRightBalance*)
fitLeftRightBalance // ClearAll;
fitLeftRightBalance[ $invalidUINT16 ] := Missing[ "NotAvailable" ];

fitLeftRightBalance[ n_Integer ] /; n >= 32768 :=
    With[ { bal = BitAnd[ n, 16383 ] / 100.0 },
        {
            Quantity[ 100 - bal, "Percent" ],
            Quantity[ bal      , "Percent" ]
        }
    ];

fitLeftRightBalance[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitGPSAccuracy*)
fitGPSAccuracy // ClearAll;
fitGPSAccuracy[ $invalidUINT8 ] := Missing[ "NotAvailable" ];
fitGPSAccuracy[ n_Integer ] := Quantity[ n, "Meters" ];
fitGPSAccuracy[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTorqueEffectiveness*)
fitTorqueEffectiveness // ClearAll;
fitTorqueEffectiveness[ $invalidUINT8 ] := Missing[ "NotAvailable" ];
fitTorqueEffectiveness[ n_Integer ] := Quantity[ n / 2.0, "Percent" ];
fitTorqueEffectiveness[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitPedalSmoothness*)
fitPedalSmoothness // ClearAll;
fitPedalSmoothness[ $invalidUINT8 ] := Missing[ "NotAvailable" ];
fitPedalSmoothness[ n_Integer ] := Quantity[ n / 2.0, "Percent" ];
fitPedalSmoothness[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitPCO*)
fitPCO // ClearAll;
fitPCO[ $invalidSINT8|0 ] := Missing[ "NotAvailable" ];
fitPCO[ n_Integer ] := Quantity[ n, "Millimeters" ];
fitPCO[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitPowerPhase*)
fitPowerPhase // ClearAll;
fitPowerPhase[ { $invalidUINT8, _ } ] := Missing[ "NotAvailable" ];
fitPowerPhase[ { _, $invalidUINT8 } ] := Missing[ "NotAvailable" ];
fitPowerPhase[ $invalidUINT8 ] := Missing[ "NotAvailable" ];
fitPowerPhase[ { n_Integer, m_Integer } ] := Interval[ fitPowerPhase /@ { n, m } ];
fitPowerPhase[ n_Integer ] := Quantity[ n / 0.7111111, "AngularDegrees" ];
fitPowerPhase[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTime128*)
fitTime128 // ClearAll;
fitTime128[ $invalidUINT8 ] := Missing[ "NotAvailable" ];
fitTime128[ n_Integer ] := secondsToQuantity[ n / 128.0 ];
fitTime128[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitZone*)
fitZone // ClearAll;
fitZone[ $invalidUINT8 ] := Missing[ "NotAvailable" ];
fitZone[ n_Integer ] := n;
fitZone[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitPowerZone*)
fitPowerZone // ClearAll;
fitPowerZone[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitPowerZone[ n_Integer ] := fitPowerZone[ n, $ftp ];
fitPowerZone[ n_, ftp_Real ] := fitPowerZone0[ n / ftp ];
fitPowerZone[ a___ ] := Missing[ "NotAvailable" ];

fitPowerZone0[ p_ ] :=
    Which[ p > 1.50, 7,
           p > 1.20, 6,
           p > 1.05, 5,
           p > 0.90, 4,
           p > 0.75, 3,
           p > 0.55, 2,
           p > 0.05, 1,
           True,     Missing[ "NotAvailable" ]
    ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitHeartRateZone*)
fitHeartRateZone // ClearAll;
fitHeartRateZone[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitHeartRateZone[ n_Integer ] := fitHeartRateZone[ n, $maxHR ];
fitHeartRateZone[ n_Integer, max_Real ] := fitHeartRateZone0[ n / max ];
fitHeartRateZone[ ___ ] := Missing[ "NotAvailable" ];

fitHeartRateZone0[ p_ ] :=
    Which[ p > 1.06, 5,
           p > 0.95, 4,
           p > 0.84, 3,
           p > 0.69, 2,
           True,     1
    ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitMessageIndex*)
fitMessageIndex // ClearAll;
fitMessageIndex[ 32768 ] := "Selected";
fitMessageIndex[ 28672 ] := "Reserved";
fitMessageIndex[ 4095  ] := "Mask";
fitMessageIndex[ ___   ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitEventGroup*)
fitEventGroup // ClearAll;
fitEventGroup[ $invalidUINT8 ] := Missing[ "NotAvailable" ];
fitEventGroup[ n_Integer ] := n;
fitEventGroup[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitFrontGearNum*)
fitFrontGearNum // ClearAll;
fitFrontGearNum[ $invalidUINT8Z ] := Missing[ "NotAvailable" ];
fitFrontGearNum[ n_Integer ] := n;
fitFrontGearNum[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitFrontGear*)
fitFrontGear // ClearAll;
fitFrontGear[ $invalidUINT8Z ] := Missing[ "NotAvailable" ];
fitFrontGear[ n_Integer ] := n;
fitFrontGear[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitRearGearNum*)
fitRearGearNum // ClearAll;
fitRearGearNum[ $invalidUINT8Z ] := Missing[ "NotAvailable" ];
fitRearGearNum[ n_Integer ] := n;
fitRearGearNum[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitRearGear*)
fitRearGear // ClearAll;
fitRearGear[ $invalidUINT8Z ] := Missing[ "NotAvailable" ];
fitRearGear[ n_Integer ] := n;
fitRearGear[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitRadarThreatCount*)
fitRadarThreatCount // ClearAll;
fitRadarThreatCount[ $invalidUINT8 ] := Missing[ "NotAvailable" ];
fitRadarThreatCount[ n_Integer ] := n;
fitRadarThreatCount[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitSerialNumber*)
fitSerialNumber // ClearAll;
fitSerialNumber[ $invalidUINT32Z ] := Missing[ "NotAvailable" ];
fitSerialNumber[ n_Integer ] := n;
fitSerialNumber[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitCumulativeOperatingTime*)
fitCumulativeOperatingTime // ClearAll;
fitCumulativeOperatingTime[ $invalidUINT32 ] := Missing[ "NotAvailable" ];
fitCumulativeOperatingTime[ n_Integer ] := Quantity[ n, "Seconds" ];
fitCumulativeOperatingTime[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTimeOffset*)
fitTimeOffset // ClearAll;
fitTimeOffset[ { $invalidUINT32, $invalidUINT32 } ] := Missing[ "NotAvailable" ];
fitTimeOffset[ { a_Integer, b_Integer } ] := { a, b };
fitTimeOffset[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTimeModeArr*)
fitTimeModeArr // ClearAll;
fitTimeModeArr[ { a_Integer, b_Integer } ] := fitTimeMode @ a;
fitTimeModeArr[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTimeZoneOffset*)
fitTimeZoneOffset // ClearAll;
fitTimeZoneOffset[ { $invalidUINT32, $invalidUINT32 } ] := Missing[ "NotAvailable" ];
fitTimeZoneOffset[ { a_Integer, b_Integer } ] := { a, b };
fitTimeZoneOffset[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitProduct*)
fitProduct // ClearAll;
fitProduct[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitProduct[ n_Integer ] := n;
fitProduct[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitSoftwareVersion*)
fitSoftwareVersion // ClearAll;
fitSoftwareVersion[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitSoftwareVersion[ n_Integer ] := n;
fitSoftwareVersion[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitBatteryVoltage*)
fitBatteryVoltage // ClearAll;
fitBatteryVoltage[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitBatteryVoltage[ n_Integer ] := Quantity[ n / 256.0, "Volts" ];
fitBatteryVoltage[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitANTDeviceNumber*)
fitANTDeviceNumber // ClearAll;
fitANTDeviceNumber[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitANTDeviceNumber[ n_Integer ] := n;
fitANTDeviceNumber[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitHardwareVersion*)
fitHardwareVersion // ClearAll;
fitHardwareVersion[ $invalidUINT8 ] := Missing[ "NotAvailable" ];
fitHardwareVersion[ n_Integer ] := n;
fitHardwareVersion[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitANTTransmissionType*)
fitANTTransmissionType // ClearAll;
fitANTTransmissionType[ $invalidUINT8Z ] := Missing[ "NotAvailable" ];
fitANTTransmissionType[ n_Integer ] := n;
fitANTTransmissionType[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitProductName*)
fitProductName // ClearAll;
fitProductName[ mp_, { 0, ___ } ] := fitProductName @ mp;
fitProductName[ _, bytes: { __Integer } ] := FromCharacterCode[ TakeWhile[ bytes, Positive ], "UTF-8" ];
fitProductName[ { 1  , id_Integer } ] := fitGarminProduct @ id;
fitProductName[ { 263, id_Integer } ] := fitFaveroProduct @ id;
fitProductName[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitStrokeCount*)
fitStrokeCount // ClearAll;
fitStrokeCount[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitStrokeCount[ n_Integer ] := Quantity[ n, "Strokes" ];
fitStrokeCount[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitZoneCount*)
fitZoneCount // ClearAll;
fitZoneCount[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitZoneCount[ n_Integer ] := n;
fitZoneCount[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitAverageStrokeCount*)
fitAverageStrokeCount // ClearAll;
fitAverageStrokeCount[ $invalidUINT32 ] := Missing[ "NotAvailable" ];
fitAverageStrokeCount[ n_Integer ] := Quantity[ n / 10.0, "Strokes" ];
fitAverageStrokeCount[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitLaps*)
fitLaps // ClearAll;
fitLaps[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitLaps[ n_Integer ] := Quantity[ n, "Laps" ];
fitLaps[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitLengths*)
fitLengths // ClearAll;
fitLengths[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitLengths[ n_Integer ] := Quantity[ n, IndependentUnit[ "PoolLengths" ] ];
fitLengths[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTrainingStressScore*)
fitTrainingStressScore // ClearAll;
fitTrainingStressScore[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitTrainingStressScore[ n_Integer ] := n / 10.0;
fitTrainingStressScore[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitIntensityFactor*)
fitIntensityFactor // ClearAll;
fitIntensityFactor[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitIntensityFactor[ n_Integer ] := n / 1000.0;
fitIntensityFactor[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitMeters100*)
fitMeters100 // ClearAll;
fitMeters100[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitMeters100[ n_Integer ] := fitMeters100[ n, $distanceUnits ];
fitMeters100[ n_Integer, "Metric" ] := Quantity[ n / 100.0, "Meters" ];
fitMeters100[ n_Integer, "Imperial" ] := Quantity[ 0.0328084 * n, "Feet" ];
fitMeters100[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTrainingEffect*)
fitTrainingEffect // ClearAll;
fitTrainingEffect[ $invalidUINT8|0 ] := Missing[ "NotAvailable" ];
fitTrainingEffect[ n_Integer ] := n/10.0;
fitTrainingEffect[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTrainingEffectDescription*)
fitTrainingEffectDescription // ClearAll;
fitTrainingEffectDescription[ $invalidUINT8 ] := Missing[ "NotAvailable" ];
fitTrainingEffectDescription[ n_Integer ] :=
    Which[ n >= 50, "Overreaching",
           n >= 40, "Highly Impacting",
           n >= 30, "Impacting",
           n >= 20, "Maintaining",
           n >= 10, "Some Benefit",
           True   , "No Benefit"
    ];

fitTrainingEffectDescription[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitHRV*)
fitHRV // ClearAll;
fitHRV[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitHRV[ n_Integer ] := fitHRV[ 1.0*n, $lastHRV ];
fitHRV[ a_Real, b_Real ] /; a/b > 1.75 := Missing[ "NotAvailable" ];
fitHRV[ a_Real, _ ] := ($lastHRV = a; Quantity[ a, "Milliseconds" ]);
fitHRV[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitChangeSport*)
fitChangeSport // ClearAll;
fitChangeSport[ n___ ] :=
    With[ { sport = fitSport @ n },
        If[ StringQ @ sport,
            $sport = sport,
            sport
        ]
    ];

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Fit Value Units*)

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*cadenceQuantity*)
cadenceQuantity[ n_ ] := cadenceQuantity[ n, $sport ]; (* TODO: set this up in prefs *)
cadenceQuantity[ n_, "Cycling" ] := Quantity[ 1.0*n, "Revolutions"/"Minutes" ];
cadenceQuantity[ n_, "Walking"|"Running"|"Hiking" ] := Quantity[ 2.0*n, "Steps"/"Minutes" ];
cadenceQuantity[ n_, "Swimming" ] := Quantity[ 2.0*n, "Strokes"/"Minutes" ];
cadenceQuantity[ n_, _ ] := Quantity[ 1.0 * n, IndependentUnit[ "Cycles" ]/"Minutes" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*cycleQuantity*)
cycleQuantity[ n_ ] := cycleQuantity[ n, $sport ];
cycleQuantity[ n_, "Cycling" ] := Quantity[ 1.0*n, "Revolutions" ];
cycleQuantity[ n_, "Walking"|"Running"|"Hiking" ] := Quantity[ 2.0*n, "Steps" ];
cycleQuantity[ n_, "Swimming" ] := Quantity[ 2.0*n, "Strokes" ];
cycleQuantity[ n_, _ ] := Quantity[ 1.0*n, IndependentUnit[ "Cycles" ] ];

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Graphics*)

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*$powerZoneColors*)
$powerZoneColors = <|
    1 -> RGBColor[ "#53b3d1" ],
    2 -> RGBColor[ "#00cba9" ],
    3 -> RGBColor[ "#b4de67" ],
    4 -> RGBColor[ "#e3e562" ],
    5 -> RGBColor[ "#f3b846" ],
    6 -> RGBColor[ "#fa7021" ],
    7 -> RGBColor[ "#fb0052" ]
|>;

$garminPZColors = <|
    1 -> RGBColor[ "#a6a6a6" ],
    2 -> RGBColor[ "#3b97f3" ],
    3 -> RGBColor[ "#82c91e" ],
    4 -> RGBColor[ "#faca48" ],
    5 -> RGBColor[ "#f98925" ],
    6 -> RGBColor[ "#d32020" ],
    7 -> RGBColor[ "#5a30d7" ]
|>;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*$powerZoneThresholds*)
$powerZoneThresholds = { 0.05, 0.55, 0.75, 0.9, 1.05, 1.2, 1.5 };

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*$hrZoneColors*)
$hrZoneColors = <|
    1 -> RGBColor[ "#53b3d1" ],
    2 -> RGBColor[ "#5ad488" ],
    3 -> RGBColor[ "#e3e562" ],
    4 -> RGBColor[ "#f69434" ],
    5 -> RGBColor[ "#fb0052" ]
|>;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*powerZonePlotCF*)
powerZonePlotCF // beginDefinition;

powerZonePlotCF[ ftp_Quantity ] :=
    With[ { watts = UnitConvert[ ftp, "Watts" ] },
        powerZonePlotCF @ QuantityMagnitude @ watts
    ];

powerZonePlotCF[ ftp_? NumberQ ] :=
    With[
        { v = Transpose @ { $powerZoneThresholds, Values @ $powerZoneColors } },
        Function[ { x, y }, Blend[ v, y/ftp ] ]
    ];

powerZonePlotCF // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*FIT Enums*)

removePrefix[ a_, p_ ] :=
    AssociationThread[ Keys @ a -> StringDelete[ Values @ a, p ] ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitGender*)
fitGender // ClearAll;
fitGender[ n_Integer ] := Lookup[ $fitGender, n, Missing[ "NotAvailable" ] ];
fitGender[ ___ ] := Missing[ "NotAvailable" ];

$fitGender0 = <|
    0 -> "FIT_GENDER_FEMALE",
    1 -> "FIT_GENDER_MALE"
|>;

$fitGender = toNiceCamelCase /@ removePrefix[ $fitGender0, "FIT_GENDER_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitLanguage*)
fitLanguage // ClearAll;
fitLanguage[ n_Integer ] := Lookup[ $fitLanguage, n, Missing[ "NotAvailable" ] ];
fitLanguage[ ___ ] := Missing[ "NotAvailable" ];

$fitLanguage0 = <|
    0   -> "FIT_LANGUAGE_ENGLISH",
    1   -> "FIT_LANGUAGE_FRENCH",
    2   -> "FIT_LANGUAGE_ITALIAN",
    3   -> "FIT_LANGUAGE_GERMAN",
    4   -> "FIT_LANGUAGE_SPANISH",
    5   -> "FIT_LANGUAGE_CROATIAN",
    6   -> "FIT_LANGUAGE_CZECH",
    7   -> "FIT_LANGUAGE_DANISH",
    8   -> "FIT_LANGUAGE_DUTCH",
    9   -> "FIT_LANGUAGE_FINNISH",
    10  -> "FIT_LANGUAGE_GREEK",
    11  -> "FIT_LANGUAGE_HUNGARIAN",
    12  -> "FIT_LANGUAGE_NORWEGIAN",
    13  -> "FIT_LANGUAGE_POLISH",
    14  -> "FIT_LANGUAGE_PORTUGUESE",
    15  -> "FIT_LANGUAGE_SLOVAKIAN",
    16  -> "FIT_LANGUAGE_SLOVENIAN",
    17  -> "FIT_LANGUAGE_SWEDISH",
    18  -> "FIT_LANGUAGE_RUSSIAN",
    19  -> "FIT_LANGUAGE_TURKISH",
    20  -> "FIT_LANGUAGE_LATVIAN",
    21  -> "FIT_LANGUAGE_UKRAINIAN",
    22  -> "FIT_LANGUAGE_ARABIC",
    23  -> "FIT_LANGUAGE_FARSI",
    24  -> "FIT_LANGUAGE_BULGARIAN",
    25  -> "FIT_LANGUAGE_ROMANIAN",
    26  -> "FIT_LANGUAGE_CHINESE",
    27  -> "FIT_LANGUAGE_JAPANESE",
    28  -> "FIT_LANGUAGE_KOREAN",
    29  -> "FIT_LANGUAGE_TAIWANESE",
    30  -> "FIT_LANGUAGE_THAI",
    31  -> "FIT_LANGUAGE_HEBREW",
    32  -> "FIT_LANGUAGE_BRAZILIAN_PORTUGUESE",
    33  -> "FIT_LANGUAGE_INDONESIAN",
    34  -> "FIT_LANGUAGE_MALAYSIAN",
    35  -> "FIT_LANGUAGE_VIETNAMESE",
    36  -> "FIT_LANGUAGE_BURMESE",
    37  -> "FIT_LANGUAGE_MONGOLIAN",
    254 -> "FIT_LANGUAGE_CUSTOM"
|>;


toLanguage // beginDefinition;

toLanguage[ "Taiwanese"           ] := Entity[ "Language", "ChineseMinNan" ];
toLanguage[ "Farsi"               ] := Entity[ "Language", "Dari"          ];
toLanguage[ "Slovakian"           ] := Entity[ "Language", "Slovak"        ];
toLanguage[ "BrazilianPortuguese" ] := Entity[ "Language", "Portuguese"    ];
toLanguage[ "Malaysian"           ] := Entity[ "Language", "MalayStandard" ];

toLanguage[ name_String ] :=
    With[ { lang = LanguageData @ name },
        If[ MatchQ[ lang, _Entity ],
            lang,
            Missing[ "NotAvailable" ]
        ]
    ];

toLanguage // endDefinition;


$fitLanguage = DeleteMissing @ Map[
    toLanguage,
    toNiceCamelCase /@ removePrefix[ $fitLanguage0, "FIT_LANGUAGE_" ]
];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitSessionTrigger*)
fitSessionTrigger // ClearAll;
fitSessionTrigger[ n_Integer ] := Lookup[ $fitSessionTrigger, n, Missing[ "NotAvailable" ] ];
fitSessionTrigger[ ___ ] := Missing[ "NotAvailable" ];

$fitSessionTrigger0 = <|
    0 -> "FIT_SESSION_TRIGGER_ACTIVITY_END",
    1 -> "FIT_SESSION_TRIGGER_MANUAL",
    2 -> "FIT_SESSION_TRIGGER_AUTO_MULTI_SPORT",
    3 -> "FIT_SESSION_TRIGGER_FITNESS_EQUIPMENT"
|>;

$fitSessionTrigger = toNiceCamelCase /@ removePrefix[ $fitSessionTrigger0, "FIT_SESSION_TRIGGER_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitSwimStroke*)
fitSwimStroke // ClearAll;
fitSwimStroke[ n_Integer ] := Lookup[ $fitSwimStroke, n, Missing[ "NotAvailable" ] ];
fitSwimStroke[ ___ ] := Missing[ "NotAvailable" ];

$fitSwimStroke0 = <|
    0 -> "FIT_SWIM_STROKE_FREESTYLE",
    1 -> "FIT_SWIM_STROKE_BACKSTROKE",
    2 -> "FIT_SWIM_STROKE_BREASTSTROKE",
    3 -> "FIT_SWIM_STROKE_BUTTERFLY",
    4 -> "FIT_SWIM_STROKE_DRILL",
    5 -> "FIT_SWIM_STROKE_MIXED",
    6 -> "FIT_SWIM_STROKE_IM"
|>;

$fitSwimStroke = toNiceCamelCase /@ removePrefix[ $fitSwimStroke0, "FIT_SWIM_STROKE_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitDisplayMeasure*)
fitDisplayMeasure // ClearAll;
fitDisplayMeasure[ n_Integer ] := Lookup[ $fitDisplayMeasure, n, Missing[ "NotAvailable" ] ];
fitDisplayMeasure[ ___ ] := Missing[ "NotAvailable" ];

$fitDisplayMeasure0 = <|
    0 -> "FIT_DISPLAY_MEASURE_METRIC",
    1 -> "FIT_DISPLAY_MEASURE_STATUTE",
    2 -> "FIT_DISPLAY_MEASURE_NAUTICAL"
|>;

$fitDisplayMeasure = toNiceCamelCase /@ removePrefix[ $fitDisplayMeasure0, "FIT_DISPLAY_MEASURE_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitDisplayHeart*)
fitDisplayHeart // ClearAll;
fitDisplayHeart[ n_Integer ] := Lookup[ $fitDisplayHeart, n, Missing[ "NotAvailable" ] ];
fitDisplayHeart[ ___ ] := Missing[ "NotAvailable" ];

$fitDisplayHeart0 = <|
    0 -> "FIT_DISPLAY_HEART_BPM",
    1 -> "FIT_DISPLAY_HEART_MAX",
    2 -> "FIT_DISPLAY_HEART_RESERVE"
|>;

$fitDisplayHeart = toNiceCamelCase /@ removePrefix[ $fitDisplayHeart0, "FIT_DISPLAY_HEART_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitDisplayPower*)
fitDisplayPower // ClearAll;
fitDisplayPower[ n_Integer ] := Lookup[ $fitDisplayPower, n, Missing[ "NotAvailable" ] ];
fitDisplayPower[ ___ ] := Missing[ "NotAvailable" ];

$fitDisplayPower0 = <|
    0 -> "FIT_DISPLAY_POWER_WATTS",
    1 -> "FIT_DISPLAY_POWER_PERCENT_FTP"
|>;

$fitDisplayPower = toNiceCamelCase /@ removePrefix[ $fitDisplayPower0, "FIT_DISPLAY_POWER_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitActivityClass*)
fitActivityClass // ClearAll;
fitActivityClass[ n_Integer ] := Lookup[ $fitActivityClass, n, Missing[ "NotAvailable" ] ];
fitActivityClass[ ___ ] := Missing[ "NotAvailable" ];

$fitActivityClass0 = <|
    100 -> "FIT_ACTIVITY_CLASS_LEVEL_MAX",
    128 -> "FIT_ACTIVITY_CLASS_ATHLETE"
|>;

$fitActivityClass = toNiceCamelCase /@ removePrefix[ $fitActivityClass0, "FIT_ACTIVITY_CLASS_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitDisplayPosition*)
fitDisplayPosition // ClearAll;
fitDisplayPosition[ n_Integer ] := Lookup[ $fitDisplayPosition, n, Missing[ "NotAvailable" ] ];
fitDisplayPosition[ ___ ] := Missing[ "NotAvailable" ];

$fitDisplayPosition0 = <|
    0  -> "FIT_DISPLAY_POSITION_DEGREE",
    1  -> "FIT_DISPLAY_POSITION_DEGREE_MINUTE",
    2  -> "FIT_DISPLAY_POSITION_DEGREE_MINUTE_SECOND",
    3  -> "FIT_DISPLAY_POSITION_AUSTRIAN_GRID",
    4  -> "FIT_DISPLAY_POSITION_BRITISH_GRID",
    5  -> "FIT_DISPLAY_POSITION_DUTCH_GRID",
    6  -> "FIT_DISPLAY_POSITION_HUNGARIAN_GRID",
    7  -> "FIT_DISPLAY_POSITION_FINNISH_GRID",
    8  -> "FIT_DISPLAY_POSITION_GERMAN_GRID",
    9  -> "FIT_DISPLAY_POSITION_ICELANDIC_GRID",
    10 -> "FIT_DISPLAY_POSITION_INDONESIAN_EQUATORIAL",
    11 -> "FIT_DISPLAY_POSITION_INDONESIAN_IRIAN",
    12 -> "FIT_DISPLAY_POSITION_INDONESIAN_SOUTHERN",
    13 -> "FIT_DISPLAY_POSITION_INDIA_ZONE_0",
    14 -> "FIT_DISPLAY_POSITION_INDIA_ZONE_IA",
    15 -> "FIT_DISPLAY_POSITION_INDIA_ZONE_IB",
    16 -> "FIT_DISPLAY_POSITION_INDIA_ZONE_IIA",
    17 -> "FIT_DISPLAY_POSITION_INDIA_ZONE_IIB",
    18 -> "FIT_DISPLAY_POSITION_INDIA_ZONE_IIIA",
    19 -> "FIT_DISPLAY_POSITION_INDIA_ZONE_IIIB",
    20 -> "FIT_DISPLAY_POSITION_INDIA_ZONE_IVA",
    21 -> "FIT_DISPLAY_POSITION_INDIA_ZONE_IVB",
    22 -> "FIT_DISPLAY_POSITION_IRISH_TRANSVERSE",
    23 -> "FIT_DISPLAY_POSITION_IRISH_GRID",
    24 -> "FIT_DISPLAY_POSITION_LORAN",
    25 -> "FIT_DISPLAY_POSITION_MAIDENHEAD_GRID",
    26 -> "FIT_DISPLAY_POSITION_MGRS_GRID",
    27 -> "FIT_DISPLAY_POSITION_NEW_ZEALAND_GRID",
    28 -> "FIT_DISPLAY_POSITION_NEW_ZEALAND_TRANSVERSE",
    29 -> "FIT_DISPLAY_POSITION_QATAR_GRID",
    30 -> "FIT_DISPLAY_POSITION_MODIFIED_SWEDISH_GRID",
    31 -> "FIT_DISPLAY_POSITION_SWEDISH_GRID",
    32 -> "FIT_DISPLAY_POSITION_SOUTH_AFRICAN_GRID",
    33 -> "FIT_DISPLAY_POSITION_SWISS_GRID",
    34 -> "FIT_DISPLAY_POSITION_TAIWAN_GRID",
    35 -> "FIT_DISPLAY_POSITION_UNITED_STATES_GRID",
    36 -> "FIT_DISPLAY_POSITION_UTM_UPS_GRID",
    37 -> "FIT_DISPLAY_POSITION_WEST_MALAYAN",
    38 -> "FIT_DISPLAY_POSITION_BORNEO_RSO",
    39 -> "FIT_DISPLAY_POSITION_ESTONIAN_GRID",
    40 -> "FIT_DISPLAY_POSITION_LATVIAN_GRID",
    41 -> "FIT_DISPLAY_POSITION_SWEDISH_REF_99_GRID"
|>;

$fitDisplayPosition = toNiceCamelCase /@ removePrefix[ $fitDisplayPosition0, "FIT_DISPLAY_POSITION_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitActivity*)
fitActivity // ClearAll;
fitActivity[ n_Integer ] := Lookup[ $fitActivity, n, Missing[ "NotAvailable" ] ];
fitActivity[ ___ ] := Missing[ "NotAvailable" ];

$fitActivity0 = <|
    0 -> "FIT_ACTIVITY_MANUAL",
    1 -> "FIT_ACTIVITY_AUTO_MULTI_SPORT"
|>;

$fitActivity = toNiceCamelCase /@ removePrefix[ $fitActivity0, "FIT_ACTIVITY_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitEvent*)
fitEvent // ClearAll;
fitEvent[ n_Integer ] := Lookup[ $fitEvent, n, Missing[ "NotAvailable" ] ];
fitEvent[ ___ ] := Missing[ "NotAvailable" ];

$fitEvent0 = <|
    0  -> "FIT_EVENT_TIMER",
    3  -> "FIT_EVENT_WORKOUT",
    4  -> "FIT_EVENT_WORKOUT_STEP",
    5  -> "FIT_EVENT_POWER_DOWN",
    6  -> "FIT_EVENT_POWER_UP",
    7  -> "FIT_EVENT_OFF_COURSE",
    8  -> "FIT_EVENT_SESSION",
    9  -> "FIT_EVENT_LAP",
    10 -> "FIT_EVENT_COURSE_POINT",
    11 -> "FIT_EVENT_BATTERY",
    12 -> "FIT_EVENT_VIRTUAL_PARTNER_PACE",
    13 -> "FIT_EVENT_HR_HIGH_ALERT",
    14 -> "FIT_EVENT_HR_LOW_ALERT",
    15 -> "FIT_EVENT_SPEED_HIGH_ALERT",
    16 -> "FIT_EVENT_SPEED_LOW_ALERT",
    17 -> "FIT_EVENT_CAD_HIGH_ALERT",
    18 -> "FIT_EVENT_CAD_LOW_ALERT",
    19 -> "FIT_EVENT_POWER_HIGH_ALERT",
    20 -> "FIT_EVENT_POWER_LOW_ALERT",
    21 -> "FIT_EVENT_RECOVERY_HR",
    22 -> "FIT_EVENT_BATTERY_LOW",
    23 -> "FIT_EVENT_TIME_DURATION_ALERT",
    24 -> "FIT_EVENT_DISTANCE_DURATION_ALERT",
    25 -> "FIT_EVENT_CALORIE_DURATION_ALERT",
    26 -> "FIT_EVENT_ACTIVITY",
    27 -> "FIT_EVENT_FITNESS_EQUIPMENT",
    28 -> "FIT_EVENT_LENGTH",
    32 -> "FIT_EVENT_USER_MARKER",
    33 -> "FIT_EVENT_SPORT_POINT",
    36 -> "FIT_EVENT_CALIBRATION",
    42 -> "FIT_EVENT_FRONT_GEAR_CHANGE",
    43 -> "FIT_EVENT_REAR_GEAR_CHANGE",
    44 -> "FIT_EVENT_RIDER_POSITION_CHANGE",
    45 -> "FIT_EVENT_ELEV_HIGH_ALERT",
    46 -> "FIT_EVENT_ELEV_LOW_ALERT",
    47 -> "FIT_EVENT_COMM_TIMEOUT",
    75 -> "FIT_EVENT_RADAR_THREAT_ALERT"
|>;

$fitEvent = toNiceCamelCase /@ removePrefix[ $fitEvent0, "FIT_EVENT_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitEventType*)
fitEventType // ClearAll;
fitEventType[ n_Integer ] := Lookup[ $fitEventType, n, Missing[ "NotAvailable" ] ];
fitEventType[ ___ ] := Missing[ "NotAvailable" ];

$fitEventType0 = <|
    0 -> "FIT_EVENT_TYPE_START",
    1 -> "FIT_EVENT_TYPE_STOP",
    2 -> "FIT_EVENT_TYPE_CONSECUTIVE_DEPRECIATED",
    3 -> "FIT_EVENT_TYPE_MARKER",
    4 -> "FIT_EVENT_TYPE_STOP_ALL",
    5 -> "FIT_EVENT_TYPE_BEGIN_DEPRECIATED",
    6 -> "FIT_EVENT_TYPE_END_DEPRECIATED",
    7 -> "FIT_EVENT_TYPE_END_ALL_DEPRECIATED",
    8 -> "FIT_EVENT_TYPE_STOP_DISABLE",
    9 -> "FIT_EVENT_TYPE_STOP_DISABLE_ALL"
|>;

$fitEventType = toNiceCamelCase /@ removePrefix[ $fitEventType0, "FIT_EVENT_TYPE_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitIntensity*)
fitIntensity // ClearAll;
fitIntensity[ n_Integer ] := Lookup[ $fitIntensity, n, Missing[ "NotAvailable" ] ];
fitIntensity[ ___ ] := Missing[ "NotAvailable" ];

$fitIntensity0 = <|
    0 -> "FIT_INTENSITY_ACTIVE",
    1 -> "FIT_INTENSITY_REST",
    2 -> "FIT_INTENSITY_WARMUP",
    3 -> "FIT_INTENSITY_COOLDOWN",
    4 -> "FIT_INTENSITY_RECOVERY",
    5 -> "FIT_INTENSITY_INTERVAL",
    6 -> "FIT_INTENSITY_OTHER"
|>;

$fitIntensity = toNiceCamelCase /@ removePrefix[ $fitIntensity0, "FIT_INTENSITY_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitLapTrigger*)
fitLapTrigger // ClearAll;
fitLapTrigger[ n_Integer ] := Lookup[ $fitLapTrigger, n, Missing[ "NotAvailable" ] ];
fitLapTrigger[ ___ ] := Missing[ "NotAvailable" ];

$fitLapTrigger0 = <|
    0 -> "FIT_LAP_TRIGGER_MANUAL",
    1 -> "FIT_LAP_TRIGGER_TIME",
    2 -> "FIT_LAP_TRIGGER_DISTANCE",
    3 -> "FIT_LAP_TRIGGER_POSITION_START",
    4 -> "FIT_LAP_TRIGGER_POSITION_LAP",
    5 -> "FIT_LAP_TRIGGER_POSITION_WAYPOINT",
    6 -> "FIT_LAP_TRIGGER_POSITION_MARKED",
    7 -> "FIT_LAP_TRIGGER_SESSION_END",
    8 -> "FIT_LAP_TRIGGER_FITNESS_EQUIPMENT"
|>;

$fitLapTrigger = toNiceCamelCase /@ removePrefix[ $fitLapTrigger0, "FIT_LAP_TRIGGER_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitBacklightMode*)
fitBacklightMode // ClearAll;
fitBacklightMode[ n_Integer ] := Lookup[ $fitBacklightMode, n, Missing[ "NotAvailable" ] ];
fitBacklightMode[ ___ ] := Missing[ "NotAvailable" ];

$fitBacklightMode0 = <|
    0 -> "FIT_BACKLIGHT_MODE_OFF",
    1 -> "FIT_BACKLIGHT_MODE_MANUAL",
    2 -> "FIT_BACKLIGHT_MODE_KEY_AND_MESSAGES",
    3 -> "FIT_BACKLIGHT_MODE_AUTO_BRIGHTNESS",
    4 -> "FIT_BACKLIGHT_MODE_SMART_NOTIFICATIONS",
    5 -> "FIT_BACKLIGHT_MODE_KEY_AND_MESSAGES_NIGHT",
    6 -> "FIT_BACKLIGHT_MODE_KEY_AND_MESSAGES_AND_SMART_NOTIFICATIONS"
|>;

$fitBacklightMode = toNiceCamelCase /@ removePrefix[ $fitBacklightMode0, "FIT_BACKLIGHT_MODE_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitDateMode*)
fitDateMode // ClearAll;
fitDateMode[ n_Integer ] := Lookup[ $fitDateMode, n, Missing[ "NotAvailable" ] ];
fitDateMode[ ___ ] := Missing[ "NotAvailable" ];

$fitDateMode0 = <|
    0 -> "FIT_DATE_MODE_DAY_MONTH",
    1 -> "FIT_DATE_MODE_MONTH_DAY"
|>;

$fitDateMode = toNiceCamelCase /@ removePrefix[ $fitDateMode0, "FIT_DATE_MODE_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitDisplayOrientation*)
fitDisplayOrientation // ClearAll;
fitDisplayOrientation[ n_Integer ] := Lookup[ $fitDisplayOrientation, n, Missing[ "NotAvailable" ] ];
fitDisplayOrientation[ ___ ] := Missing[ "NotAvailable" ];

$fitDisplayOrientation0 = <|
    0 -> "FIT_DISPLAY_ORIENTATION_AUTO",
    1 -> "FIT_DISPLAY_ORIENTATION_PORTRAIT",
    2 -> "FIT_DISPLAY_ORIENTATION_LANDSCAPE",
    3 -> "FIT_DISPLAY_ORIENTATION_PORTRAIT_FLIPPED",
    4 -> "FIT_DISPLAY_ORIENTATION_LANDSCAPE_FLIPPED"
|>;

$fitDisplayOrientation = toNiceCamelCase /@ removePrefix[ $fitDisplayOrientation0, "FIT_DISPLAY_ORIENTATION_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitSide*)
fitSide // ClearAll;
fitSide[ n_Integer ] := Lookup[ $fitSide, n, Missing[ "NotAvailable" ] ];
fitSide[ ___ ] := Missing[ "NotAvailable" ];

$fitSide0 = <|
    0 -> "FIT_SIDE_RIGHT",
    1 -> "FIT_SIDE_LEFT"
|>;

$fitSide = toNiceCamelCase /@ removePrefix[ $fitSide0, "FIT_SIDE_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTapSensitivity*)
fitTapSensitivity // ClearAll;
fitTapSensitivity[ n_Integer ] := Lookup[ $fitTapSensitivity, n, Missing[ "NotAvailable" ] ];
fitTapSensitivity[ ___ ] := Missing[ "NotAvailable" ];

$fitTapSensitivity0 = <|
    0 -> "FIT_TAP_SENSITIVITY_HIGH",
    1 -> "FIT_TAP_SENSITIVITY_MEDIUM",
    2 -> "FIT_TAP_SENSITIVITY_LOW"
|>;

$fitTapSensitivity = toNiceCamelCase /@ removePrefix[ $fitTapSensitivity0, "FIT_TAP_SENSITIVITY_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTimeMode*)
fitTimeMode // ClearAll;
fitTimeMode[ n_Integer ] := Lookup[ $fitTimeMode, n, Missing[ "NotAvailable" ] ];
fitTimeMode[ ___ ] := Missing[ "NotAvailable" ];

$fitTimeMode0 = <|
    0 -> "FIT_TIME_MODE_HOUR12",
    1 -> "FIT_TIME_MODE_HOUR24",
    2 -> "FIT_TIME_MODE_MILITARY",
    3 -> "FIT_TIME_MODE_HOUR_12_WITH_SECONDS",
    4 -> "FIT_TIME_MODE_HOUR_24_WITH_SECONDS",
    5 -> "FIT_TIME_MODE_UTC"
|>;

$fitTimeMode = toNiceCamelCase /@ removePrefix[ $fitTimeMode0, "FIT_TIME_MODE_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitActivityType*)
fitActivityType // ClearAll;
fitActivityType[ n_Integer ] := Lookup[ $fitActivityType, n, Missing[ "NotAvailable" ] ];
fitActivityType[ ___ ] := Missing[ "NotAvailable" ];

$fitActivityType0 = <|
    0   -> "FIT_ACTIVITY_TYPE_GENERIC",
    1   -> "FIT_ACTIVITY_TYPE_RUNNING",
    2   -> "FIT_ACTIVITY_TYPE_CYCLING",
    3   -> "FIT_ACTIVITY_TYPE_TRANSITION",
    4   -> "FIT_ACTIVITY_TYPE_FITNESS_EQUIPMENT",
    5   -> "FIT_ACTIVITY_TYPE_SWIMMING",
    6   -> "FIT_ACTIVITY_TYPE_WALKING",
    8   -> "FIT_ACTIVITY_TYPE_SEDENTARY",
    254 -> "FIT_ACTIVITY_TYPE_ALL"
|>;

$fitActivityType = toNiceCamelCase /@ removePrefix[ $fitActivityType0, "FIT_ACTIVITY_TYPE_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitStrokeType*)
fitStrokeType // ClearAll;
fitStrokeType[ n_Integer ] := Lookup[ $fitStrokeType, n, Missing[ "NotAvailable" ] ];
fitStrokeType[ ___ ] := Missing[ "NotAvailable" ];

$fitStrokeType0 = <|
    0 -> "FIT_STROKE_TYPE_NO_EVENT",
    1 -> "FIT_STROKE_TYPE_OTHER",
    2 -> "FIT_STROKE_TYPE_SERVE",
    3 -> "FIT_STROKE_TYPE_FOREHAND",
    4 -> "FIT_STROKE_TYPE_BACKHAND",
    5 -> "FIT_STROKE_TYPE_SMASH"
|>;

$fitStrokeType = toNiceCamelCase /@ removePrefix[ $fitStrokeType0, "FIT_STROKE_TYPE_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitDeviceIndex*)
fitDeviceIndex // ClearAll;
fitDeviceIndex[ n_Integer ] := Lookup[ $fitDeviceIndex, n, Missing[ "NotAvailable" ] ];
fitDeviceIndex[ ___ ] := Missing[ "NotAvailable" ];

$fitDeviceIndex0 = <|
    0 -> "FIT_DEVICE_INDEX_CREATOR"
|>;

$fitDeviceIndex = toNiceCamelCase /@ removePrefix[ $fitDeviceIndex0, "FIT_DEVICE_INDEX_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitManufacturer*)
fitManufacturer // ClearAll;
fitManufacturer[ n_Integer ] := Lookup[ $fitManufacturer, n, Missing[ "NotAvailable" ] ];
fitManufacturer[ ___ ] := Missing[ "NotAvailable" ];

$fitManufacturer0 = <|
    1    -> "FIT_MANUFACTURER_GARMIN",
    2    -> "FIT_MANUFACTURER_GARMIN_FR405_ANTFS",
    3    -> "FIT_MANUFACTURER_ZEPHYR",
    4    -> "FIT_MANUFACTURER_DAYTON",
    5    -> "FIT_MANUFACTURER_IDT",
    6    -> "FIT_MANUFACTURER_SRM",
    7    -> "FIT_MANUFACTURER_QUARQ",
    8    -> "FIT_MANUFACTURER_IBIKE",
    9    -> "FIT_MANUFACTURER_SARIS",
    10   -> "FIT_MANUFACTURER_SPARK_HK",
    11   -> "FIT_MANUFACTURER_TANITA",
    12   -> "FIT_MANUFACTURER_ECHOWELL",
    13   -> "FIT_MANUFACTURER_DYNASTREAM_OEM",
    14   -> "FIT_MANUFACTURER_NAUTILUS",
    15   -> "FIT_MANUFACTURER_DYNASTREAM",
    16   -> "FIT_MANUFACTURER_TIMEX",
    17   -> "FIT_MANUFACTURER_METRIGEAR",
    18   -> "FIT_MANUFACTURER_XELIC",
    19   -> "FIT_MANUFACTURER_BEURER",
    20   -> "FIT_MANUFACTURER_CARDIOSPORT",
    21   -> "FIT_MANUFACTURER_A_AND_D",
    22   -> "FIT_MANUFACTURER_HMM",
    23   -> "FIT_MANUFACTURER_SUUNTO",
    24   -> "FIT_MANUFACTURER_THITA_ELEKTRONIK",
    25   -> "FIT_MANUFACTURER_GPULSE",
    26   -> "FIT_MANUFACTURER_CLEAN_MOBILE",
    27   -> "FIT_MANUFACTURER_PEDAL_BRAIN",
    28   -> "FIT_MANUFACTURER_PEAKSWARE",
    29   -> "FIT_MANUFACTURER_SAXONAR",
    30   -> "FIT_MANUFACTURER_LEMOND_FITNESS",
    31   -> "FIT_MANUFACTURER_DEXCOM",
    32   -> "FIT_MANUFACTURER_WAHOO_FITNESS",
    33   -> "FIT_MANUFACTURER_OCTANE_FITNESS",
    34   -> "FIT_MANUFACTURER_ARCHINOETICS",
    35   -> "FIT_MANUFACTURER_THE_HURT_BOX",
    36   -> "FIT_MANUFACTURER_CITIZEN_SYSTEMS",
    37   -> "FIT_MANUFACTURER_MAGELLAN",
    38   -> "FIT_MANUFACTURER_OSYNCE",
    39   -> "FIT_MANUFACTURER_HOLUX",
    40   -> "FIT_MANUFACTURER_CONCEPT2",
    41   -> "FIT_MANUFACTURER_SHIMANO",
    42   -> "FIT_MANUFACTURER_ONE_GIANT_LEAP",
    43   -> "FIT_MANUFACTURER_ACE_SENSOR",
    44   -> "FIT_MANUFACTURER_BRIM_BROTHERS",
    45   -> "FIT_MANUFACTURER_XPLOVA",
    46   -> "FIT_MANUFACTURER_PERCEPTION_DIGITAL",
    47   -> "FIT_MANUFACTURER_BF1SYSTEMS",
    48   -> "FIT_MANUFACTURER_PIONEER",
    49   -> "FIT_MANUFACTURER_SPANTEC",
    50   -> "FIT_MANUFACTURER_METALOGICS",
    51   -> "FIT_MANUFACTURER_4IIIIS",
    52   -> "FIT_MANUFACTURER_SEIKO_EPSON",
    53   -> "FIT_MANUFACTURER_SEIKO_EPSON_OEM",
    54   -> "FIT_MANUFACTURER_IFOR_POWELL",
    55   -> "FIT_MANUFACTURER_MAXWELL_GUIDER",
    56   -> "FIT_MANUFACTURER_STAR_TRAC",
    57   -> "FIT_MANUFACTURER_BREAKAWAY",
    58   -> "FIT_MANUFACTURER_ALATECH_TECHNOLOGY_LTD",
    59   -> "FIT_MANUFACTURER_MIO_TECHNOLOGY_EUROPE",
    60   -> "FIT_MANUFACTURER_ROTOR",
    61   -> "FIT_MANUFACTURER_GEONAUTE",
    62   -> "FIT_MANUFACTURER_ID_BIKE",
    63   -> "FIT_MANUFACTURER_SPECIALIZED",
    64   -> "FIT_MANUFACTURER_WTEK",
    65   -> "FIT_MANUFACTURER_PHYSICAL_ENTERPRISES",
    66   -> "FIT_MANUFACTURER_NORTH_POLE_ENGINEERING",
    67   -> "FIT_MANUFACTURER_BKOOL",
    68   -> "FIT_MANUFACTURER_CATEYE",
    69   -> "FIT_MANUFACTURER_STAGES_CYCLING",
    70   -> "FIT_MANUFACTURER_SIGMASPORT",
    71   -> "FIT_MANUFACTURER_TOMTOM",
    72   -> "FIT_MANUFACTURER_PERIPEDAL",
    73   -> "FIT_MANUFACTURER_WATTBIKE",
    76   -> "FIT_MANUFACTURER_MOXY",
    77   -> "FIT_MANUFACTURER_CICLOSPORT",
    78   -> "FIT_MANUFACTURER_POWERBAHN",
    79   -> "FIT_MANUFACTURER_ACORN_PROJECTS_APS",
    80   -> "FIT_MANUFACTURER_LIFEBEAM",
    81   -> "FIT_MANUFACTURER_BONTRAGER",
    82   -> "FIT_MANUFACTURER_WELLGO",
    83   -> "FIT_MANUFACTURER_SCOSCHE",
    84   -> "FIT_MANUFACTURER_MAGURA",
    85   -> "FIT_MANUFACTURER_WOODWAY",
    86   -> "FIT_MANUFACTURER_ELITE",
    87   -> "FIT_MANUFACTURER_NIELSEN_KELLERMAN",
    88   -> "FIT_MANUFACTURER_DK_CITY",
    89   -> "FIT_MANUFACTURER_TACX",
    90   -> "FIT_MANUFACTURER_DIRECTION_TECHNOLOGY",
    91   -> "FIT_MANUFACTURER_MAGTONIC",
    92   -> "FIT_MANUFACTURER_1PARTCARBON",
    93   -> "FIT_MANUFACTURER_INSIDE_RIDE_TECHNOLOGIES",
    94   -> "FIT_MANUFACTURER_SOUND_OF_MOTION",
    95   -> "FIT_MANUFACTURER_STRYD",
    96   -> "FIT_MANUFACTURER_ICG",
    97   -> "FIT_MANUFACTURER_MIPULSE",
    98   -> "FIT_MANUFACTURER_BSX_ATHLETICS",
    99   -> "FIT_MANUFACTURER_LOOK",
    100  -> "FIT_MANUFACTURER_CAMPAGNOLO_SRL",
    101  -> "FIT_MANUFACTURER_BODY_BIKE_SMART",
    102  -> "FIT_MANUFACTURER_PRAXISWORKS",
    103  -> "FIT_MANUFACTURER_LIMITS_TECHNOLOGY",
    104  -> "FIT_MANUFACTURER_TOPACTION_TECHNOLOGY",
    105  -> "FIT_MANUFACTURER_COSINUSS",
    106  -> "FIT_MANUFACTURER_FITCARE",
    107  -> "FIT_MANUFACTURER_MAGENE",
    108  -> "FIT_MANUFACTURER_GIANT_MANUFACTURING_CO",
    109  -> "FIT_MANUFACTURER_TIGRASPORT",
    110  -> "FIT_MANUFACTURER_SALUTRON",
    111  -> "FIT_MANUFACTURER_TECHNOGYM",
    112  -> "FIT_MANUFACTURER_BRYTON_SENSORS",
    113  -> "FIT_MANUFACTURER_LATITUDE_LIMITED",
    114  -> "FIT_MANUFACTURER_SOARING_TECHNOLOGY",
    115  -> "FIT_MANUFACTURER_IGPSPORT",
    116  -> "FIT_MANUFACTURER_THINKRIDER",
    117  -> "FIT_MANUFACTURER_GOPHER_SPORT",
    118  -> "FIT_MANUFACTURER_WATERROWER",
    119  -> "FIT_MANUFACTURER_ORANGETHEORY",
    120  -> "FIT_MANUFACTURER_INPEAK",
    121  -> "FIT_MANUFACTURER_KINETIC",
    122  -> "FIT_MANUFACTURER_JOHNSON_HEALTH_TECH",
    123  -> "FIT_MANUFACTURER_POLAR_ELECTRO",
    124  -> "FIT_MANUFACTURER_SEESENSE",
    125  -> "FIT_MANUFACTURER_NCI_TECHNOLOGY",
    126  -> "FIT_MANUFACTURER_IQSQUARE",
    127  -> "FIT_MANUFACTURER_LEOMO",
    128  -> "FIT_MANUFACTURER_IFIT_COM",
    129  -> "FIT_MANUFACTURER_COROS_BYTE",
    130  -> "FIT_MANUFACTURER_VERSA_DESIGN",
    131  -> "FIT_MANUFACTURER_CHILEAF",
    132  -> "FIT_MANUFACTURER_CYCPLUS",
    133  -> "FIT_MANUFACTURER_GRAVAA_BYTE",
    134  -> "FIT_MANUFACTURER_SIGEYI",
    135  -> "FIT_MANUFACTURER_COOSPO",
    136  -> "FIT_MANUFACTURER_GEOID",
    137  -> "FIT_MANUFACTURER_BOSCH",
    138  -> "FIT_MANUFACTURER_KYTO",
    139  -> "FIT_MANUFACTURER_KINETIC_SPORTS",
    140  -> "FIT_MANUFACTURER_DECATHLON_BYTE",
    141  -> "FIT_MANUFACTURER_TQ_SYSTEMS",
    142  -> "FIT_MANUFACTURER_TAG_HEUER",
    143  -> "FIT_MANUFACTURER_KEISER_FITNESS",
    144  -> "FIT_MANUFACTURER_ZWIFT_BYTE",
    255  -> "FIT_MANUFACTURER_DEVELOPMENT",
    257  -> "FIT_MANUFACTURER_HEALTHANDLIFE",
    258  -> "FIT_MANUFACTURER_LEZYNE",
    259  -> "FIT_MANUFACTURER_SCRIBE_LABS",
    260  -> "FIT_MANUFACTURER_ZWIFT",
    261  -> "FIT_MANUFACTURER_WATTEAM",
    262  -> "FIT_MANUFACTURER_RECON",
    263  -> "FIT_MANUFACTURER_FAVERO_ELECTRONICS",
    264  -> "FIT_MANUFACTURER_DYNOVELO",
    265  -> "FIT_MANUFACTURER_STRAVA",
    266  -> "FIT_MANUFACTURER_PRECOR",
    267  -> "FIT_MANUFACTURER_BRYTON",
    268  -> "FIT_MANUFACTURER_SRAM",
    269  -> "FIT_MANUFACTURER_NAVMAN",
    270  -> "FIT_MANUFACTURER_COBI",
    271  -> "FIT_MANUFACTURER_SPIVI",
    272  -> "FIT_MANUFACTURER_MIO_MAGELLAN",
    273  -> "FIT_MANUFACTURER_EVESPORTS",
    274  -> "FIT_MANUFACTURER_SENSITIVUS_GAUGE",
    275  -> "FIT_MANUFACTURER_PODOON",
    276  -> "FIT_MANUFACTURER_LIFE_TIME_FITNESS",
    277  -> "FIT_MANUFACTURER_FALCO_E_MOTORS",
    278  -> "FIT_MANUFACTURER_MINOURA",
    279  -> "FIT_MANUFACTURER_CYCLIQ",
    280  -> "FIT_MANUFACTURER_LUXOTTICA",
    281  -> "FIT_MANUFACTURER_TRAINER_ROAD",
    282  -> "FIT_MANUFACTURER_THE_SUFFERFEST",
    283  -> "FIT_MANUFACTURER_FULLSPEEDAHEAD",
    284  -> "FIT_MANUFACTURER_VIRTUALTRAINING",
    285  -> "FIT_MANUFACTURER_FEEDBACKSPORTS",
    286  -> "FIT_MANUFACTURER_OMATA",
    287  -> "FIT_MANUFACTURER_VDO",
    288  -> "FIT_MANUFACTURER_MAGNETICDAYS",
    289  -> "FIT_MANUFACTURER_HAMMERHEAD",
    290  -> "FIT_MANUFACTURER_KINETIC_BY_KURT",
    291  -> "FIT_MANUFACTURER_SHAPELOG",
    292  -> "FIT_MANUFACTURER_DABUZIDUO",
    293  -> "FIT_MANUFACTURER_JETBLACK",
    294  -> "FIT_MANUFACTURER_COROS",
    295  -> "FIT_MANUFACTURER_VIRTUGO",
    296  -> "FIT_MANUFACTURER_VELOSENSE",
    297  -> "FIT_MANUFACTURER_CYCLIGENTINC",
    298  -> "FIT_MANUFACTURER_TRAILFORKS",
    299  -> "FIT_MANUFACTURER_MAHLE_EBIKEMOTION",
    300  -> "FIT_MANUFACTURER_NURVV",
    301  -> "FIT_MANUFACTURER_MICROPROGRAM",
    302  -> "FIT_MANUFACTURER_ZONE5CLOUD",
    303  -> "FIT_MANUFACTURER_GREENTEG",
    304  -> "FIT_MANUFACTURER_YAMAHA_MOTORS",
    305  -> "FIT_MANUFACTURER_WHOOP",
    306  -> "FIT_MANUFACTURER_GRAVAA",
    307  -> "FIT_MANUFACTURER_ONELAP",
    308  -> "FIT_MANUFACTURER_MONARK_EXERCISE",
    309  -> "FIT_MANUFACTURER_FORM",
    310  -> "FIT_MANUFACTURER_DECATHLON",
    311  -> "FIT_MANUFACTURER_SYNCROS",
    312  -> "FIT_MANUFACTURER_HEATUP",
    313  -> "FIT_MANUFACTURER_CANNONDALE",
    314  -> "FIT_MANUFACTURER_TRUE_FITNESS",
    315  -> "FIT_MANUFACTURER_RGT_CYCLING",
    316  -> "FIT_MANUFACTURER_VASA",
    317  -> "FIT_MANUFACTURER_RACE_REPUBLIC",
    318  -> "FIT_MANUFACTURER_FAZUA",
    319  -> "FIT_MANUFACTURER_OREKA_TRAINING",
    320  -> "FIT_MANUFACTURER_ISEC",
    321  -> "FIT_MANUFACTURER_LULULEMON_STUDIO",
    5759 -> "FIT_MANUFACTURER_ACTIGRAPHCORP"
|>;

$fitManufacturer = toNiceCamelCase /@ removePrefix[ $fitManufacturer0, "FIT_MANUFACTURER_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitANTPlusDeviceType*)
fitANTPlusDeviceType // ClearAll;
fitANTPlusDeviceType[ n_Integer ] := Lookup[ $fitANTPlusDeviceType, n, Missing[ "NotAvailable" ] ];
fitANTPlusDeviceType[ ___ ] := Missing[ "NotAvailable" ];

$fitANTPlusDeviceType0 = <|
    1   -> "FIT_ANTPLUS_DEVICE_TYPE_ANTFS",
    11  -> "FIT_ANTPLUS_DEVICE_TYPE_BIKE_POWER",
    12  -> "FIT_ANTPLUS_DEVICE_TYPE_ENVIRONMENT_SENSOR_LEGACY",
    15  -> "FIT_ANTPLUS_DEVICE_TYPE_MULTI_SPORT_SPEED_DISTANCE",
    16  -> "FIT_ANTPLUS_DEVICE_TYPE_CONTROL",
    17  -> "FIT_ANTPLUS_DEVICE_TYPE_FITNESS_EQUIPMENT",
    18  -> "FIT_ANTPLUS_DEVICE_TYPE_BLOOD_PRESSURE",
    19  -> "FIT_ANTPLUS_DEVICE_TYPE_GEOCACHE_NODE",
    20  -> "FIT_ANTPLUS_DEVICE_TYPE_LIGHT_ELECTRIC_VEHICLE",
    25  -> "FIT_ANTPLUS_DEVICE_TYPE_ENV_SENSOR",
    26  -> "FIT_ANTPLUS_DEVICE_TYPE_RACQUET",
    27  -> "FIT_ANTPLUS_DEVICE_TYPE_CONTROL_HUB",
    31  -> "FIT_ANTPLUS_DEVICE_TYPE_MUSCLE_OXYGEN",
    34  -> "FIT_ANTPLUS_DEVICE_TYPE_SHIFTING",
    35  -> "FIT_ANTPLUS_DEVICE_TYPE_BIKE_LIGHT_MAIN",
    36  -> "FIT_ANTPLUS_DEVICE_TYPE_BIKE_LIGHT_SHARED",
    38  -> "FIT_ANTPLUS_DEVICE_TYPE_EXD",
    40  -> "FIT_ANTPLUS_DEVICE_TYPE_BIKE_RADAR",
    46  -> "FIT_ANTPLUS_DEVICE_TYPE_BIKE_AERO",
    119 -> "FIT_ANTPLUS_DEVICE_TYPE_WEIGHT_SCALE",
    120 -> "FIT_ANTPLUS_DEVICE_TYPE_HEART_RATE",
    121 -> "FIT_ANTPLUS_DEVICE_TYPE_BIKE_SPEED_CADENCE",
    122 -> "FIT_ANTPLUS_DEVICE_TYPE_BIKE_CADENCE",
    123 -> "FIT_ANTPLUS_DEVICE_TYPE_BIKE_SPEED",
    124 -> "FIT_ANTPLUS_DEVICE_TYPE_STRIDE_SPEED_DISTANCE"
|>;

$fitANTPlusDeviceType = toNiceCamelCase /@ removePrefix[ $fitANTPlusDeviceType0, "FIT_ANTPLUS_DEVICE_TYPE_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitBatteryStatus*)
fitBatteryStatus // ClearAll;
fitBatteryStatus[ n_Integer ] := Lookup[ $fitBatteryStatus, n, Missing[ "NotAvailable" ] ];
fitBatteryStatus[ ___ ] := Missing[ "NotAvailable" ];

$fitBatteryStatus0 = <|
    1 -> "FIT_BATTERY_STATUS_NEW",
    2 -> "FIT_BATTERY_STATUS_GOOD",
    3 -> "FIT_BATTERY_STATUS_OK",
    4 -> "FIT_BATTERY_STATUS_LOW",
    5 -> "FIT_BATTERY_STATUS_CRITICAL",
    6 -> "FIT_BATTERY_STATUS_CHARGING",
    7 -> "FIT_BATTERY_STATUS_UNKNOWN"
|>;

$fitBatteryStatus = toNiceCamelCase /@ removePrefix[ $fitBatteryStatus0, "FIT_BATTERY_STATUS_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitBodyLocation*)
fitBodyLocation // ClearAll;
fitBodyLocation[ n_Integer ] := Lookup[ $fitBodyLocation, n, Missing[ "NotAvailable" ] ];
fitBodyLocation[ ___ ] := Missing[ "NotAvailable" ];

$fitBodyLocation0 = <|
    0  -> "FIT_BODY_LOCATION_LEFT_LEG",
    1  -> "FIT_BODY_LOCATION_LEFT_CALF",
    2  -> "FIT_BODY_LOCATION_LEFT_SHIN",
    3  -> "FIT_BODY_LOCATION_LEFT_HAMSTRING",
    4  -> "FIT_BODY_LOCATION_LEFT_QUAD",
    5  -> "FIT_BODY_LOCATION_LEFT_GLUTE",
    6  -> "FIT_BODY_LOCATION_RIGHT_LEG",
    7  -> "FIT_BODY_LOCATION_RIGHT_CALF",
    8  -> "FIT_BODY_LOCATION_RIGHT_SHIN",
    9  -> "FIT_BODY_LOCATION_RIGHT_HAMSTRING",
    10 -> "FIT_BODY_LOCATION_RIGHT_QUAD",
    11 -> "FIT_BODY_LOCATION_RIGHT_GLUTE",
    12 -> "FIT_BODY_LOCATION_TORSO_BACK",
    13 -> "FIT_BODY_LOCATION_LEFT_LOWER_BACK",
    14 -> "FIT_BODY_LOCATION_LEFT_UPPER_BACK",
    15 -> "FIT_BODY_LOCATION_RIGHT_LOWER_BACK",
    16 -> "FIT_BODY_LOCATION_RIGHT_UPPER_BACK",
    17 -> "FIT_BODY_LOCATION_TORSO_FRONT",
    18 -> "FIT_BODY_LOCATION_LEFT_ABDOMEN",
    19 -> "FIT_BODY_LOCATION_LEFT_CHEST",
    20 -> "FIT_BODY_LOCATION_RIGHT_ABDOMEN",
    21 -> "FIT_BODY_LOCATION_RIGHT_CHEST",
    22 -> "FIT_BODY_LOCATION_LEFT_ARM",
    23 -> "FIT_BODY_LOCATION_LEFT_SHOULDER",
    24 -> "FIT_BODY_LOCATION_LEFT_BICEP",
    25 -> "FIT_BODY_LOCATION_LEFT_TRICEP",
    26 -> "FIT_BODY_LOCATION_LEFT_BRACHIORADIALIS",
    27 -> "FIT_BODY_LOCATION_LEFT_FOREARM_EXTENSORS",
    28 -> "FIT_BODY_LOCATION_RIGHT_ARM",
    29 -> "FIT_BODY_LOCATION_RIGHT_SHOULDER",
    30 -> "FIT_BODY_LOCATION_RIGHT_BICEP",
    31 -> "FIT_BODY_LOCATION_RIGHT_TRICEP",
    32 -> "FIT_BODY_LOCATION_RIGHT_BRACHIORADIALIS",
    33 -> "FIT_BODY_LOCATION_RIGHT_FOREARM_EXTENSORS",
    34 -> "FIT_BODY_LOCATION_NECK",
    35 -> "FIT_BODY_LOCATION_THROAT",
    36 -> "FIT_BODY_LOCATION_WAIST_MID_BACK",
    37 -> "FIT_BODY_LOCATION_WAIST_FRONT",
    38 -> "FIT_BODY_LOCATION_WAIST_LEFT",
    39 -> "FIT_BODY_LOCATION_WAIST_RIGHT"
|>;

$fitBodyLocation = toNiceCamelCase /@ removePrefix[ $fitBodyLocation0, "FIT_BODY_LOCATION_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitANTNetwork*)
fitANTNetwork // ClearAll;
fitANTNetwork[ n_Integer ] := Lookup[ $fitANTNetwork, n, Missing[ "NotAvailable" ] ];
fitANTNetwork[ ___ ] := Missing[ "NotAvailable" ];

$fitANTNetwork0 = <|
    0 -> "FIT_ANT_NETWORK_PUBLIC",
    1 -> "FIT_ANT_NETWORK_ANTPLUS",
    2 -> "FIT_ANT_NETWORK_ANTFS",
    3 -> "FIT_ANT_NETWORK_PRIVATE"
|>;

$fitANTNetwork = toNiceCamelCase /@ removePrefix[ $fitANTNetwork0, "FIT_ANT_NETWORK_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitSourceType*)
fitSourceType // ClearAll;
fitSourceType[ n_Integer ] := Lookup[ $fitSourceType, n, Missing[ "NotAvailable" ] ];
fitSourceType[ ___ ] := Missing[ "NotAvailable" ];

$fitSourceType0 = <|
    0 -> "FIT_SOURCE_TYPE_ANT",
    1 -> "FIT_SOURCE_TYPE_ANTPLUS",
    2 -> "FIT_SOURCE_TYPE_BLUETOOTH",
    3 -> "FIT_SOURCE_TYPE_BLUETOOTH_LOW_ENERGY",
    4 -> "FIT_SOURCE_TYPE_WIFI",
    5 -> "FIT_SOURCE_TYPE_LOCAL"
|>;

$fitSourceType = toNiceCamelCase /@ removePrefix[ $fitSourceType0, "FIT_SOURCE_TYPE_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitFile*)
fitFile // ClearAll;
fitFile[ n_Integer ] := Lookup[ $fitFile, n, Missing[ "NotAvailable" ] ];
fitFile[ ___ ] := Missing[ "NotAvailable" ];

$fitFile0 = <|
    1  -> "FIT_FILE_DEVICE",
    2  -> "FIT_FILE_SETTINGS",
    3  -> "FIT_FILE_SPORT",
    4  -> "FIT_FILE_ACTIVITY",
    5  -> "FIT_FILE_WORKOUT",
    6  -> "FIT_FILE_COURSE",
    7  -> "FIT_FILE_SCHEDULES",
    9  -> "FIT_FILE_WEIGHT",
    10 -> "FIT_FILE_TOTALS",
    11 -> "FIT_FILE_GOALS",
    14 -> "FIT_FILE_BLOOD_PRESSURE",
    15 -> "FIT_FILE_MONITORING_A",
    20 -> "FIT_FILE_ACTIVITY_SUMMARY",
    28 -> "FIT_FILE_MONITORING_DAILY",
    32 -> "FIT_FILE_MONITORING_B",
    34 -> "FIT_FILE_SEGMENT",
    35 -> "FIT_FILE_SEGMENT_LIST",
    40 -> "FIT_FILE_EXD_CONFIGURATION"
|>;

$fitFile = toNiceCamelCase /@ removePrefix[ $fitFile0, "FIT_FILE_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitSport*)
fitSport // ClearAll;
fitSport[ n_Integer ] := Lookup[ $fitSport, n, Missing[ "NotAvailable" ] ];
fitSport[ ___ ] := Missing[ "NotAvailable" ];

$fitSport0 = <|
    0   -> "FIT_SPORT_GENERIC",
    1   -> "FIT_SPORT_RUNNING",
    2   -> "FIT_SPORT_CYCLING",
    3   -> "FIT_SPORT_TRANSITION",
    4   -> "FIT_SPORT_FITNESS_EQUIPMENT",
    5   -> "FIT_SPORT_SWIMMING",
    6   -> "FIT_SPORT_BASKETBALL",
    7   -> "FIT_SPORT_SOCCER",
    8   -> "FIT_SPORT_TENNIS",
    9   -> "FIT_SPORT_AMERICAN_FOOTBALL",
    10  -> "FIT_SPORT_TRAINING",
    11  -> "FIT_SPORT_WALKING",
    12  -> "FIT_SPORT_CROSS_COUNTRY_SKIING",
    13  -> "FIT_SPORT_ALPINE_SKIING",
    14  -> "FIT_SPORT_SNOWBOARDING",
    15  -> "FIT_SPORT_ROWING",
    16  -> "FIT_SPORT_MOUNTAINEERING",
    17  -> "FIT_SPORT_HIKING",
    18  -> "FIT_SPORT_MULTISPORT",
    19  -> "FIT_SPORT_PADDLING",
    20  -> "FIT_SPORT_FLYING",
    21  -> "FIT_SPORT_E_BIKING",
    22  -> "FIT_SPORT_MOTORCYCLING",
    23  -> "FIT_SPORT_BOATING",
    24  -> "FIT_SPORT_DRIVING",
    25  -> "FIT_SPORT_GOLF",
    26  -> "FIT_SPORT_HANG_GLIDING",
    27  -> "FIT_SPORT_HORSEBACK_RIDING",
    28  -> "FIT_SPORT_HUNTING",
    29  -> "FIT_SPORT_FISHING",
    30  -> "FIT_SPORT_INLINE_SKATING",
    31  -> "FIT_SPORT_ROCK_CLIMBING",
    32  -> "FIT_SPORT_SAILING",
    33  -> "FIT_SPORT_ICE_SKATING",
    34  -> "FIT_SPORT_SKY_DIVING",
    35  -> "FIT_SPORT_SNOWSHOEING",
    36  -> "FIT_SPORT_SNOWMOBILING",
    37  -> "FIT_SPORT_STAND_UP_PADDLEBOARDING",
    38  -> "FIT_SPORT_SURFING",
    39  -> "FIT_SPORT_WAKEBOARDING",
    40  -> "FIT_SPORT_WATER_SKIING",
    41  -> "FIT_SPORT_KAYAKING",
    42  -> "FIT_SPORT_RAFTING",
    43  -> "FIT_SPORT_WINDSURFING",
    44  -> "FIT_SPORT_KITESURFING",
    45  -> "FIT_SPORT_TACTICAL",
    46  -> "FIT_SPORT_JUMPMASTER",
    47  -> "FIT_SPORT_BOXING",
    48  -> "FIT_SPORT_FLOOR_CLIMBING",
    53  -> "FIT_SPORT_DIVING",
    254 -> "FIT_SPORT_ALL"
|>;

$fitSport = toNiceCamelCase /@ removePrefix[ $fitSport0, "FIT_SPORT_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitSubSport*)
fitSubSport // ClearAll;
fitSubSport[ n_Integer ] := Lookup[ $fitSubSport, n, Missing[ "NotAvailable" ] ];
fitSubSport[ ___ ] := Missing[ "NotAvailable" ];

$fitSubSport0 = <|
    0   -> "FIT_SUB_SPORT_GENERIC",
    1   -> "FIT_SUB_SPORT_TREADMILL",
    2   -> "FIT_SUB_SPORT_STREET",
    3   -> "FIT_SUB_SPORT_TRAIL",
    4   -> "FIT_SUB_SPORT_TRACK",
    5   -> "FIT_SUB_SPORT_SPIN",
    6   -> "FIT_SUB_SPORT_INDOOR_CYCLING",
    7   -> "FIT_SUB_SPORT_ROAD",
    8   -> "FIT_SUB_SPORT_MOUNTAIN",
    9   -> "FIT_SUB_SPORT_DOWNHILL",
    10  -> "FIT_SUB_SPORT_RECUMBENT",
    11  -> "FIT_SUB_SPORT_CYCLOCROSS",
    12  -> "FIT_SUB_SPORT_HAND_CYCLING",
    13  -> "FIT_SUB_SPORT_TRACK_CYCLING",
    14  -> "FIT_SUB_SPORT_INDOOR_ROWING",
    15  -> "FIT_SUB_SPORT_ELLIPTICAL",
    16  -> "FIT_SUB_SPORT_STAIR_CLIMBING",
    17  -> "FIT_SUB_SPORT_LAP_SWIMMING",
    18  -> "FIT_SUB_SPORT_OPEN_WATER",
    19  -> "FIT_SUB_SPORT_FLEXIBILITY_TRAINING",
    20  -> "FIT_SUB_SPORT_STRENGTH_TRAINING",
    21  -> "FIT_SUB_SPORT_WARM_UP",
    22  -> "FIT_SUB_SPORT_MATCH",
    23  -> "FIT_SUB_SPORT_EXERCISE",
    24  -> "FIT_SUB_SPORT_CHALLENGE",
    25  -> "FIT_SUB_SPORT_INDOOR_SKIING",
    26  -> "FIT_SUB_SPORT_CARDIO_TRAINING",
    27  -> "FIT_SUB_SPORT_INDOOR_WALKING",
    28  -> "FIT_SUB_SPORT_E_BIKE_FITNESS",
    29  -> "FIT_SUB_SPORT_BMX",
    30  -> "FIT_SUB_SPORT_CASUAL_WALKING",
    31  -> "FIT_SUB_SPORT_SPEED_WALKING",
    32  -> "FIT_SUB_SPORT_BIKE_TO_RUN_TRANSITION",
    33  -> "FIT_SUB_SPORT_RUN_TO_BIKE_TRANSITION",
    34  -> "FIT_SUB_SPORT_SWIM_TO_BIKE_TRANSITION",
    35  -> "FIT_SUB_SPORT_ATV",
    36  -> "FIT_SUB_SPORT_MOTOCROSS",
    37  -> "FIT_SUB_SPORT_BACKCOUNTRY",
    38  -> "FIT_SUB_SPORT_RESORT",
    39  -> "FIT_SUB_SPORT_RC_DRONE",
    40  -> "FIT_SUB_SPORT_WINGSUIT",
    41  -> "FIT_SUB_SPORT_WHITEWATER",
    42  -> "FIT_SUB_SPORT_SKATE_SKIING",
    43  -> "FIT_SUB_SPORT_YOGA",
    44  -> "FIT_SUB_SPORT_PILATES",
    45  -> "FIT_SUB_SPORT_INDOOR_RUNNING",
    46  -> "FIT_SUB_SPORT_GRAVEL_CYCLING",
    47  -> "FIT_SUB_SPORT_E_BIKE_MOUNTAIN",
    48  -> "FIT_SUB_SPORT_COMMUTING",
    49  -> "FIT_SUB_SPORT_MIXED_SURFACE",
    50  -> "FIT_SUB_SPORT_NAVIGATE",
    51  -> "FIT_SUB_SPORT_TRACK_ME",
    52  -> "FIT_SUB_SPORT_MAP",
    53  -> "FIT_SUB_SPORT_SINGLE_GAS_DIVING",
    54  -> "FIT_SUB_SPORT_MULTI_GAS_DIVING",
    55  -> "FIT_SUB_SPORT_GAUGE_DIVING",
    56  -> "FIT_SUB_SPORT_APNEA_DIVING",
    57  -> "FIT_SUB_SPORT_APNEA_HUNTING",
    58  -> "FIT_SUB_SPORT_VIRTUAL_ACTIVITY",
    59  -> "FIT_SUB_SPORT_OBSTACLE",
    62  -> "FIT_SUB_SPORT_BREATHING",
    65  -> "FIT_SUB_SPORT_SAIL_RACE",
    67  -> "FIT_SUB_SPORT_ULTRA",
    68  -> "FIT_SUB_SPORT_INDOOR_CLIMBING",
    69  -> "FIT_SUB_SPORT_BOULDERING",
    254 -> "FIT_SUB_SPORT_ALL"
|>;

$fitSubSport = toNiceCamelCase /@ removePrefix[ $fitSubSport0, "FIT_SUB_SPORT_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitGarminProduct*)
fitGarminProduct // ClearAll;
fitGarminProduct[ n_Integer ] := Lookup[ $fitGarminProduct, n, Missing[ "NotAvailable" ] ];
fitGarminProduct[ ___ ] := Missing[ "NotAvailable" ];

$fitGarminProduct0 = <|
    1     -> "FIT_GARMIN_PRODUCT_HRM1",
    2     -> "FIT_GARMIN_PRODUCT_AXH01",
    3     -> "FIT_GARMIN_PRODUCT_AXB01",
    4     -> "FIT_GARMIN_PRODUCT_AXB02",
    5     -> "FIT_GARMIN_PRODUCT_HRM2SS",
    6     -> "FIT_GARMIN_PRODUCT_DSI_ALF02",
    7     -> "FIT_GARMIN_PRODUCT_HRM3SS",
    8     -> "FIT_GARMIN_PRODUCT_HRM_RUN_SINGLE_BYTE_PRODUCT_ID",
    9     -> "FIT_GARMIN_PRODUCT_BSM",
    10    -> "FIT_GARMIN_PRODUCT_BCM",
    11    -> "FIT_GARMIN_PRODUCT_AXS01",
    12    -> "FIT_GARMIN_PRODUCT_HRM_TRI_SINGLE_BYTE_PRODUCT_ID",
    13    -> "FIT_GARMIN_PRODUCT_HRM4_RUN_SINGLE_BYTE_PRODUCT_ID",
    14    -> "FIT_GARMIN_PRODUCT_FR225_SINGLE_BYTE_PRODUCT_ID",
    15    -> "FIT_GARMIN_PRODUCT_GEN3_BSM_SINGLE_BYTE_PRODUCT_ID",
    16    -> "FIT_GARMIN_PRODUCT_GEN3_BCM_SINGLE_BYTE_PRODUCT_ID",
    255   -> "FIT_GARMIN_PRODUCT_OHR",
    473   -> "FIT_GARMIN_PRODUCT_FR301_CHINA",
    474   -> "FIT_GARMIN_PRODUCT_FR301_JAPAN",
    475   -> "FIT_GARMIN_PRODUCT_FR301_KOREA",
    494   -> "FIT_GARMIN_PRODUCT_FR301_TAIWAN",
    717   -> "FIT_GARMIN_PRODUCT_FR405",
    782   -> "FIT_GARMIN_PRODUCT_FR50",
    987   -> "FIT_GARMIN_PRODUCT_FR405_JAPAN",
    988   -> "FIT_GARMIN_PRODUCT_FR60",
    1011  -> "FIT_GARMIN_PRODUCT_DSI_ALF01",
    1018  -> "FIT_GARMIN_PRODUCT_FR310XT",
    1036  -> "FIT_GARMIN_PRODUCT_EDGE500",
    1124  -> "FIT_GARMIN_PRODUCT_FR110",
    1169  -> "FIT_GARMIN_PRODUCT_EDGE800",
    1199  -> "FIT_GARMIN_PRODUCT_EDGE500_TAIWAN",
    1213  -> "FIT_GARMIN_PRODUCT_EDGE500_JAPAN",
    1253  -> "FIT_GARMIN_PRODUCT_CHIRP",
    1274  -> "FIT_GARMIN_PRODUCT_FR110_JAPAN",
    1325  -> "FIT_GARMIN_PRODUCT_EDGE200",
    1328  -> "FIT_GARMIN_PRODUCT_FR910XT",
    1333  -> "FIT_GARMIN_PRODUCT_EDGE800_TAIWAN",
    1334  -> "FIT_GARMIN_PRODUCT_EDGE800_JAPAN",
    1341  -> "FIT_GARMIN_PRODUCT_ALF04",
    1345  -> "FIT_GARMIN_PRODUCT_FR610",
    1360  -> "FIT_GARMIN_PRODUCT_FR210_JAPAN",
    1380  -> "FIT_GARMIN_PRODUCT_VECTOR_SS",
    1381  -> "FIT_GARMIN_PRODUCT_VECTOR_CP",
    1386  -> "FIT_GARMIN_PRODUCT_EDGE800_CHINA",
    1387  -> "FIT_GARMIN_PRODUCT_EDGE500_CHINA",
    1405  -> "FIT_GARMIN_PRODUCT_APPROACH_G10",
    1410  -> "FIT_GARMIN_PRODUCT_FR610_JAPAN",
    1422  -> "FIT_GARMIN_PRODUCT_EDGE500_KOREA",
    1436  -> "FIT_GARMIN_PRODUCT_FR70",
    1446  -> "FIT_GARMIN_PRODUCT_FR310XT_4T",
    1461  -> "FIT_GARMIN_PRODUCT_AMX",
    1482  -> "FIT_GARMIN_PRODUCT_FR10",
    1497  -> "FIT_GARMIN_PRODUCT_EDGE800_KOREA",
    1499  -> "FIT_GARMIN_PRODUCT_SWIM",
    1537  -> "FIT_GARMIN_PRODUCT_FR910XT_CHINA",
    1551  -> "FIT_GARMIN_PRODUCT_FENIX",
    1555  -> "FIT_GARMIN_PRODUCT_EDGE200_TAIWAN",
    1561  -> "FIT_GARMIN_PRODUCT_EDGE510",
    1567  -> "FIT_GARMIN_PRODUCT_EDGE810",
    1570  -> "FIT_GARMIN_PRODUCT_TEMPE",
    1600  -> "FIT_GARMIN_PRODUCT_FR910XT_JAPAN",
    1623  -> "FIT_GARMIN_PRODUCT_FR620",
    1632  -> "FIT_GARMIN_PRODUCT_FR220",
    1664  -> "FIT_GARMIN_PRODUCT_FR910XT_KOREA",
    1688  -> "FIT_GARMIN_PRODUCT_FR10_JAPAN",
    1721  -> "FIT_GARMIN_PRODUCT_EDGE810_JAPAN",
    1735  -> "FIT_GARMIN_PRODUCT_VIRB_ELITE",
    1736  -> "FIT_GARMIN_PRODUCT_EDGE_TOURING",
    1742  -> "FIT_GARMIN_PRODUCT_EDGE510_JAPAN",
    1743  -> "FIT_GARMIN_PRODUCT_HRM_TRI",
    1752  -> "FIT_GARMIN_PRODUCT_HRM_RUN",
    1765  -> "FIT_GARMIN_PRODUCT_FR920XT",
    1821  -> "FIT_GARMIN_PRODUCT_EDGE510_ASIA",
    1822  -> "FIT_GARMIN_PRODUCT_EDGE810_CHINA",
    1823  -> "FIT_GARMIN_PRODUCT_EDGE810_TAIWAN",
    1836  -> "FIT_GARMIN_PRODUCT_EDGE1000",
    1837  -> "FIT_GARMIN_PRODUCT_VIVO_FIT",
    1853  -> "FIT_GARMIN_PRODUCT_VIRB_REMOTE",
    1885  -> "FIT_GARMIN_PRODUCT_VIVO_KI",
    1903  -> "FIT_GARMIN_PRODUCT_FR15",
    1907  -> "FIT_GARMIN_PRODUCT_VIVO_ACTIVE",
    1918  -> "FIT_GARMIN_PRODUCT_EDGE510_KOREA",
    1928  -> "FIT_GARMIN_PRODUCT_FR620_JAPAN",
    1929  -> "FIT_GARMIN_PRODUCT_FR620_CHINA",
    1930  -> "FIT_GARMIN_PRODUCT_FR220_JAPAN",
    1931  -> "FIT_GARMIN_PRODUCT_FR220_CHINA",
    1936  -> "FIT_GARMIN_PRODUCT_APPROACH_S6",
    1956  -> "FIT_GARMIN_PRODUCT_VIVO_SMART",
    1967  -> "FIT_GARMIN_PRODUCT_FENIX2",
    1988  -> "FIT_GARMIN_PRODUCT_EPIX",
    2050  -> "FIT_GARMIN_PRODUCT_FENIX3",
    2052  -> "FIT_GARMIN_PRODUCT_EDGE1000_TAIWAN",
    2053  -> "FIT_GARMIN_PRODUCT_EDGE1000_JAPAN",
    2061  -> "FIT_GARMIN_PRODUCT_FR15_JAPAN",
    2067  -> "FIT_GARMIN_PRODUCT_EDGE520",
    2070  -> "FIT_GARMIN_PRODUCT_EDGE1000_CHINA",
    2072  -> "FIT_GARMIN_PRODUCT_FR620_RUSSIA",
    2073  -> "FIT_GARMIN_PRODUCT_FR220_RUSSIA",
    2079  -> "FIT_GARMIN_PRODUCT_VECTOR_S",
    2100  -> "FIT_GARMIN_PRODUCT_EDGE1000_KOREA",
    2130  -> "FIT_GARMIN_PRODUCT_FR920XT_TAIWAN",
    2131  -> "FIT_GARMIN_PRODUCT_FR920XT_CHINA",
    2132  -> "FIT_GARMIN_PRODUCT_FR920XT_JAPAN",
    2134  -> "FIT_GARMIN_PRODUCT_VIRBX",
    2135  -> "FIT_GARMIN_PRODUCT_VIVO_SMART_APAC",
    2140  -> "FIT_GARMIN_PRODUCT_ETREX_TOUCH",
    2147  -> "FIT_GARMIN_PRODUCT_EDGE25",
    2148  -> "FIT_GARMIN_PRODUCT_FR25",
    2150  -> "FIT_GARMIN_PRODUCT_VIVO_FIT2",
    2153  -> "FIT_GARMIN_PRODUCT_FR225",
    2156  -> "FIT_GARMIN_PRODUCT_FR630",
    2157  -> "FIT_GARMIN_PRODUCT_FR230",
    2158  -> "FIT_GARMIN_PRODUCT_FR735XT",
    2160  -> "FIT_GARMIN_PRODUCT_VIVO_ACTIVE_APAC",
    2161  -> "FIT_GARMIN_PRODUCT_VECTOR_2",
    2162  -> "FIT_GARMIN_PRODUCT_VECTOR_2S",
    2172  -> "FIT_GARMIN_PRODUCT_VIRBXE",
    2173  -> "FIT_GARMIN_PRODUCT_FR620_TAIWAN",
    2174  -> "FIT_GARMIN_PRODUCT_FR220_TAIWAN",
    2175  -> "FIT_GARMIN_PRODUCT_TRUSWING",
    2187  -> "FIT_GARMIN_PRODUCT_D2AIRVENU",
    2188  -> "FIT_GARMIN_PRODUCT_FENIX3_CHINA",
    2189  -> "FIT_GARMIN_PRODUCT_FENIX3_TWN",
    2192  -> "FIT_GARMIN_PRODUCT_VARIA_HEADLIGHT",
    2193  -> "FIT_GARMIN_PRODUCT_VARIA_TAILLIGHT_OLD",
    2204  -> "FIT_GARMIN_PRODUCT_EDGE_EXPLORE_1000",
    2219  -> "FIT_GARMIN_PRODUCT_FR225_ASIA",
    2225  -> "FIT_GARMIN_PRODUCT_VARIA_RADAR_TAILLIGHT",
    2226  -> "FIT_GARMIN_PRODUCT_VARIA_RADAR_DISPLAY",
    2238  -> "FIT_GARMIN_PRODUCT_EDGE20",
    2260  -> "FIT_GARMIN_PRODUCT_EDGE520_ASIA",
    2261  -> "FIT_GARMIN_PRODUCT_EDGE520_JAPAN",
    2262  -> "FIT_GARMIN_PRODUCT_D2_BRAVO",
    2266  -> "FIT_GARMIN_PRODUCT_APPROACH_S20",
    2271  -> "FIT_GARMIN_PRODUCT_VIVO_SMART2",
    2274  -> "FIT_GARMIN_PRODUCT_EDGE1000_THAI",
    2276  -> "FIT_GARMIN_PRODUCT_VARIA_REMOTE",
    2288  -> "FIT_GARMIN_PRODUCT_EDGE25_ASIA",
    2289  -> "FIT_GARMIN_PRODUCT_EDGE25_JPN",
    2290  -> "FIT_GARMIN_PRODUCT_EDGE20_ASIA",
    2292  -> "FIT_GARMIN_PRODUCT_APPROACH_X40",
    2293  -> "FIT_GARMIN_PRODUCT_FENIX3_JAPAN",
    2294  -> "FIT_GARMIN_PRODUCT_VIVO_SMART_EMEA",
    2310  -> "FIT_GARMIN_PRODUCT_FR630_ASIA",
    2311  -> "FIT_GARMIN_PRODUCT_FR630_JPN",
    2313  -> "FIT_GARMIN_PRODUCT_FR230_JPN",
    2327  -> "FIT_GARMIN_PRODUCT_HRM4_RUN",
    2332  -> "FIT_GARMIN_PRODUCT_EPIX_JAPAN",
    2337  -> "FIT_GARMIN_PRODUCT_VIVO_ACTIVE_HR",
    2347  -> "FIT_GARMIN_PRODUCT_VIVO_SMART_GPS_HR",
    2348  -> "FIT_GARMIN_PRODUCT_VIVO_SMART_HR",
    2361  -> "FIT_GARMIN_PRODUCT_VIVO_SMART_HR_ASIA",
    2362  -> "FIT_GARMIN_PRODUCT_VIVO_SMART_GPS_HR_ASIA",
    2368  -> "FIT_GARMIN_PRODUCT_VIVO_MOVE",
    2379  -> "FIT_GARMIN_PRODUCT_VARIA_TAILLIGHT",
    2396  -> "FIT_GARMIN_PRODUCT_FR235_ASIA",
    2397  -> "FIT_GARMIN_PRODUCT_FR235_JAPAN",
    2398  -> "FIT_GARMIN_PRODUCT_VARIA_VISION",
    2406  -> "FIT_GARMIN_PRODUCT_VIVO_FIT3",
    2407  -> "FIT_GARMIN_PRODUCT_FENIX3_KOREA",
    2408  -> "FIT_GARMIN_PRODUCT_FENIX3_SEA",
    2413  -> "FIT_GARMIN_PRODUCT_FENIX3_HR",
    2417  -> "FIT_GARMIN_PRODUCT_VIRB_ULTRA_30",
    2429  -> "FIT_GARMIN_PRODUCT_INDEX_SMART_SCALE",
    2431  -> "FIT_GARMIN_PRODUCT_FR235",
    2432  -> "FIT_GARMIN_PRODUCT_FENIX3_CHRONOS",
    2441  -> "FIT_GARMIN_PRODUCT_OREGON7XX",
    2444  -> "FIT_GARMIN_PRODUCT_RINO7XX",
    2457  -> "FIT_GARMIN_PRODUCT_EPIX_KOREA",
    2473  -> "FIT_GARMIN_PRODUCT_FENIX3_HR_CHN",
    2474  -> "FIT_GARMIN_PRODUCT_FENIX3_HR_TWN",
    2475  -> "FIT_GARMIN_PRODUCT_FENIX3_HR_JPN",
    2476  -> "FIT_GARMIN_PRODUCT_FENIX3_HR_SEA",
    2477  -> "FIT_GARMIN_PRODUCT_FENIX3_HR_KOR",
    2496  -> "FIT_GARMIN_PRODUCT_NAUTIX",
    2497  -> "FIT_GARMIN_PRODUCT_VIVO_ACTIVE_HR_APAC",
    2512  -> "FIT_GARMIN_PRODUCT_OREGON7XX_WW",
    2530  -> "FIT_GARMIN_PRODUCT_EDGE_820",
    2531  -> "FIT_GARMIN_PRODUCT_EDGE_EXPLORE_820",
    2533  -> "FIT_GARMIN_PRODUCT_FR735XT_APAC",
    2534  -> "FIT_GARMIN_PRODUCT_FR735XT_JAPAN",
    2544  -> "FIT_GARMIN_PRODUCT_FENIX5S",
    2547  -> "FIT_GARMIN_PRODUCT_D2_BRAVO_TITANIUM",
    2567  -> "FIT_GARMIN_PRODUCT_VARIA_UT800",
    2593  -> "FIT_GARMIN_PRODUCT_RUNNING_DYNAMICS_POD",
    2599  -> "FIT_GARMIN_PRODUCT_EDGE_820_CHINA",
    2600  -> "FIT_GARMIN_PRODUCT_EDGE_820_JAPAN",
    2604  -> "FIT_GARMIN_PRODUCT_FENIX5X",
    2606  -> "FIT_GARMIN_PRODUCT_VIVO_FIT_JR",
    2622  -> "FIT_GARMIN_PRODUCT_VIVO_SMART3",
    2623  -> "FIT_GARMIN_PRODUCT_VIVO_SPORT",
    2628  -> "FIT_GARMIN_PRODUCT_EDGE_820_TAIWAN",
    2629  -> "FIT_GARMIN_PRODUCT_EDGE_820_KOREA",
    2630  -> "FIT_GARMIN_PRODUCT_EDGE_820_SEA",
    2650  -> "FIT_GARMIN_PRODUCT_FR35_HEBREW",
    2656  -> "FIT_GARMIN_PRODUCT_APPROACH_S60",
    2667  -> "FIT_GARMIN_PRODUCT_FR35_APAC",
    2668  -> "FIT_GARMIN_PRODUCT_FR35_JAPAN",
    2675  -> "FIT_GARMIN_PRODUCT_FENIX3_CHRONOS_ASIA",
    2687  -> "FIT_GARMIN_PRODUCT_VIRB_360",
    2691  -> "FIT_GARMIN_PRODUCT_FR935",
    2697  -> "FIT_GARMIN_PRODUCT_FENIX5",
    2700  -> "FIT_GARMIN_PRODUCT_VIVOACTIVE3",
    2733  -> "FIT_GARMIN_PRODUCT_FR235_CHINA_NFC",
    2769  -> "FIT_GARMIN_PRODUCT_FORETREX_601_701",
    2772  -> "FIT_GARMIN_PRODUCT_VIVO_MOVE_HR",
    2713  -> "FIT_GARMIN_PRODUCT_EDGE_1030",
    2727  -> "FIT_GARMIN_PRODUCT_FR35_SEA",
    2787  -> "FIT_GARMIN_PRODUCT_VECTOR_3",
    2796  -> "FIT_GARMIN_PRODUCT_FENIX5_ASIA",
    2797  -> "FIT_GARMIN_PRODUCT_FENIX5S_ASIA",
    2798  -> "FIT_GARMIN_PRODUCT_FENIX5X_ASIA",
    2806  -> "FIT_GARMIN_PRODUCT_APPROACH_Z80",
    2814  -> "FIT_GARMIN_PRODUCT_FR35_KOREA",
    2819  -> "FIT_GARMIN_PRODUCT_D2CHARLIE",
    2831  -> "FIT_GARMIN_PRODUCT_VIVO_SMART3_APAC",
    2832  -> "FIT_GARMIN_PRODUCT_VIVO_SPORT_APAC",
    2833  -> "FIT_GARMIN_PRODUCT_FR935_ASIA",
    2859  -> "FIT_GARMIN_PRODUCT_DESCENT",
    2878  -> "FIT_GARMIN_PRODUCT_VIVO_FIT4",
    2886  -> "FIT_GARMIN_PRODUCT_FR645",
    2888  -> "FIT_GARMIN_PRODUCT_FR645M",
    2891  -> "FIT_GARMIN_PRODUCT_FR30",
    2900  -> "FIT_GARMIN_PRODUCT_FENIX5S_PLUS",
    2909  -> "FIT_GARMIN_PRODUCT_EDGE_130",
    2924  -> "FIT_GARMIN_PRODUCT_EDGE_1030_ASIA",
    2927  -> "FIT_GARMIN_PRODUCT_VIVOSMART_4",
    2945  -> "FIT_GARMIN_PRODUCT_VIVO_MOVE_HR_ASIA",
    2962  -> "FIT_GARMIN_PRODUCT_APPROACH_X10",
    2977  -> "FIT_GARMIN_PRODUCT_FR30_ASIA",
    2988  -> "FIT_GARMIN_PRODUCT_VIVOACTIVE3M_W",
    3003  -> "FIT_GARMIN_PRODUCT_FR645_ASIA",
    3004  -> "FIT_GARMIN_PRODUCT_FR645M_ASIA",
    3011  -> "FIT_GARMIN_PRODUCT_EDGE_EXPLORE",
    3028  -> "FIT_GARMIN_PRODUCT_GPSMAP66",
    3049  -> "FIT_GARMIN_PRODUCT_APPROACH_S10",
    3066  -> "FIT_GARMIN_PRODUCT_VIVOACTIVE3M_L",
    3085  -> "FIT_GARMIN_PRODUCT_APPROACH_G80",
    3092  -> "FIT_GARMIN_PRODUCT_EDGE_130_ASIA",
    3095  -> "FIT_GARMIN_PRODUCT_EDGE_1030_BONTRAGER",
    3110  -> "FIT_GARMIN_PRODUCT_FENIX5_PLUS",
    3111  -> "FIT_GARMIN_PRODUCT_FENIX5X_PLUS",
    3112  -> "FIT_GARMIN_PRODUCT_EDGE_520_PLUS",
    3113  -> "FIT_GARMIN_PRODUCT_FR945",
    3121  -> "FIT_GARMIN_PRODUCT_EDGE_530",
    3122  -> "FIT_GARMIN_PRODUCT_EDGE_830",
    3126  -> "FIT_GARMIN_PRODUCT_INSTINCT_ESPORTS",
    3134  -> "FIT_GARMIN_PRODUCT_FENIX5S_PLUS_APAC",
    3135  -> "FIT_GARMIN_PRODUCT_FENIX5X_PLUS_APAC",
    3142  -> "FIT_GARMIN_PRODUCT_EDGE_520_PLUS_APAC",
    3144  -> "FIT_GARMIN_PRODUCT_FR235L_ASIA",
    3145  -> "FIT_GARMIN_PRODUCT_FR245_ASIA",
    3163  -> "FIT_GARMIN_PRODUCT_VIVO_ACTIVE3M_APAC",
    3192  -> "FIT_GARMIN_PRODUCT_GEN3_BSM",
    3193  -> "FIT_GARMIN_PRODUCT_GEN3_BCM",
    3218  -> "FIT_GARMIN_PRODUCT_VIVO_SMART4_ASIA",
    3224  -> "FIT_GARMIN_PRODUCT_VIVOACTIVE4_SMALL",
    3225  -> "FIT_GARMIN_PRODUCT_VIVOACTIVE4_LARGE",
    3226  -> "FIT_GARMIN_PRODUCT_VENU",
    3246  -> "FIT_GARMIN_PRODUCT_MARQ_DRIVER",
    3247  -> "FIT_GARMIN_PRODUCT_MARQ_AVIATOR",
    3248  -> "FIT_GARMIN_PRODUCT_MARQ_CAPTAIN",
    3249  -> "FIT_GARMIN_PRODUCT_MARQ_COMMANDER",
    3250  -> "FIT_GARMIN_PRODUCT_MARQ_EXPEDITION",
    3251  -> "FIT_GARMIN_PRODUCT_MARQ_ATHLETE",
    3258  -> "FIT_GARMIN_PRODUCT_DESCENT_MK2",
    3284  -> "FIT_GARMIN_PRODUCT_GPSMAP66I",
    3287  -> "FIT_GARMIN_PRODUCT_FENIX6S_SPORT",
    3288  -> "FIT_GARMIN_PRODUCT_FENIX6S",
    3289  -> "FIT_GARMIN_PRODUCT_FENIX6_SPORT",
    3290  -> "FIT_GARMIN_PRODUCT_FENIX6",
    3291  -> "FIT_GARMIN_PRODUCT_FENIX6X",
    3299  -> "FIT_GARMIN_PRODUCT_HRM_DUAL",
    3300  -> "FIT_GARMIN_PRODUCT_HRM_PRO",
    3308  -> "FIT_GARMIN_PRODUCT_VIVO_MOVE3_PREMIUM",
    3314  -> "FIT_GARMIN_PRODUCT_APPROACH_S40",
    3321  -> "FIT_GARMIN_PRODUCT_FR245M_ASIA",
    3349  -> "FIT_GARMIN_PRODUCT_EDGE_530_APAC",
    3350  -> "FIT_GARMIN_PRODUCT_EDGE_830_APAC",
    3378  -> "FIT_GARMIN_PRODUCT_VIVO_MOVE3",
    3387  -> "FIT_GARMIN_PRODUCT_VIVO_ACTIVE4_SMALL_ASIA",
    3388  -> "FIT_GARMIN_PRODUCT_VIVO_ACTIVE4_LARGE_ASIA",
    3389  -> "FIT_GARMIN_PRODUCT_VIVO_ACTIVE4_OLED_ASIA",
    3405  -> "FIT_GARMIN_PRODUCT_SWIM2",
    3420  -> "FIT_GARMIN_PRODUCT_MARQ_DRIVER_ASIA",
    3421  -> "FIT_GARMIN_PRODUCT_MARQ_AVIATOR_ASIA",
    3422  -> "FIT_GARMIN_PRODUCT_VIVO_MOVE3_ASIA",
    3441  -> "FIT_GARMIN_PRODUCT_FR945_ASIA",
    3446  -> "FIT_GARMIN_PRODUCT_VIVO_ACTIVE3T_CHN",
    3448  -> "FIT_GARMIN_PRODUCT_MARQ_CAPTAIN_ASIA",
    3449  -> "FIT_GARMIN_PRODUCT_MARQ_COMMANDER_ASIA",
    3450  -> "FIT_GARMIN_PRODUCT_MARQ_EXPEDITION_ASIA",
    3451  -> "FIT_GARMIN_PRODUCT_MARQ_ATHLETE_ASIA",
    3466  -> "FIT_GARMIN_PRODUCT_INSTINCT_SOLAR",
    3469  -> "FIT_GARMIN_PRODUCT_FR45_ASIA",
    3473  -> "FIT_GARMIN_PRODUCT_VIVOACTIVE3_DAIMLER",
    3498  -> "FIT_GARMIN_PRODUCT_LEGACY_REY",
    3499  -> "FIT_GARMIN_PRODUCT_LEGACY_DARTH_VADER",
    3500  -> "FIT_GARMIN_PRODUCT_LEGACY_CAPTAIN_MARVEL",
    3501  -> "FIT_GARMIN_PRODUCT_LEGACY_FIRST_AVENGER",
    3512  -> "FIT_GARMIN_PRODUCT_FENIX6S_SPORT_ASIA",
    3513  -> "FIT_GARMIN_PRODUCT_FENIX6S_ASIA",
    3514  -> "FIT_GARMIN_PRODUCT_FENIX6_SPORT_ASIA",
    3515  -> "FIT_GARMIN_PRODUCT_FENIX6_ASIA",
    3516  -> "FIT_GARMIN_PRODUCT_FENIX6X_ASIA",
    3535  -> "FIT_GARMIN_PRODUCT_LEGACY_CAPTAIN_MARVEL_ASIA",
    3536  -> "FIT_GARMIN_PRODUCT_LEGACY_FIRST_AVENGER_ASIA",
    3537  -> "FIT_GARMIN_PRODUCT_LEGACY_REY_ASIA",
    3538  -> "FIT_GARMIN_PRODUCT_LEGACY_DARTH_VADER_ASIA",
    3542  -> "FIT_GARMIN_PRODUCT_DESCENT_MK2S",
    3558  -> "FIT_GARMIN_PRODUCT_EDGE_130_PLUS",
    3570  -> "FIT_GARMIN_PRODUCT_EDGE_1030_PLUS",
    3578  -> "FIT_GARMIN_PRODUCT_RALLY_200",
    3589  -> "FIT_GARMIN_PRODUCT_FR745",
    3600  -> "FIT_GARMIN_PRODUCT_VENUSQ",
    3615  -> "FIT_GARMIN_PRODUCT_LILY",
    3624  -> "FIT_GARMIN_PRODUCT_MARQ_ADVENTURER",
    3638  -> "FIT_GARMIN_PRODUCT_ENDURO",
    3639  -> "FIT_GARMIN_PRODUCT_SWIM2_APAC",
    3648  -> "FIT_GARMIN_PRODUCT_MARQ_ADVENTURER_ASIA",
    3652  -> "FIT_GARMIN_PRODUCT_FR945_LTE",
    3702  -> "FIT_GARMIN_PRODUCT_DESCENT_MK2_ASIA",
    3703  -> "FIT_GARMIN_PRODUCT_VENU2",
    3704  -> "FIT_GARMIN_PRODUCT_VENU2S",
    3737  -> "FIT_GARMIN_PRODUCT_VENU_DAIMLER_ASIA",
    3739  -> "FIT_GARMIN_PRODUCT_MARQ_GOLFER",
    3740  -> "FIT_GARMIN_PRODUCT_VENU_DAIMLER",
    3794  -> "FIT_GARMIN_PRODUCT_FR745_ASIA",
    3809  -> "FIT_GARMIN_PRODUCT_LILY_ASIA",
    3812  -> "FIT_GARMIN_PRODUCT_EDGE_1030_PLUS_ASIA",
    3813  -> "FIT_GARMIN_PRODUCT_EDGE_130_PLUS_ASIA",
    3823  -> "FIT_GARMIN_PRODUCT_APPROACH_S12",
    3872  -> "FIT_GARMIN_PRODUCT_ENDURO_ASIA",
    3837  -> "FIT_GARMIN_PRODUCT_VENUSQ_ASIA",
    3843  -> "FIT_GARMIN_PRODUCT_EDGE_1040",
    3850  -> "FIT_GARMIN_PRODUCT_MARQ_GOLFER_ASIA",
    3851  -> "FIT_GARMIN_PRODUCT_VENU2_PLUS",
    3869  -> "FIT_GARMIN_PRODUCT_FR55",
    3888  -> "FIT_GARMIN_PRODUCT_INSTINCT_2",
    3905  -> "FIT_GARMIN_PRODUCT_FENIX7S",
    3906  -> "FIT_GARMIN_PRODUCT_FENIX7",
    3907  -> "FIT_GARMIN_PRODUCT_FENIX7X",
    3908  -> "FIT_GARMIN_PRODUCT_FENIX7S_APAC",
    3909  -> "FIT_GARMIN_PRODUCT_FENIX7_APAC",
    3910  -> "FIT_GARMIN_PRODUCT_FENIX7X_APAC",
    3930  -> "FIT_GARMIN_PRODUCT_DESCENT_MK2S_ASIA",
    3934  -> "FIT_GARMIN_PRODUCT_APPROACH_S42",
    3943  -> "FIT_GARMIN_PRODUCT_EPIX_GEN2",
    3944  -> "FIT_GARMIN_PRODUCT_EPIX_GEN2_APAC",
    3949  -> "FIT_GARMIN_PRODUCT_VENU2S_ASIA",
    3950  -> "FIT_GARMIN_PRODUCT_VENU2_ASIA",
    3978  -> "FIT_GARMIN_PRODUCT_FR945_LTE_ASIA",
    3982  -> "FIT_GARMIN_PRODUCT_VIVO_MOVE_SPORT",
    3986  -> "FIT_GARMIN_PRODUCT_APPROACH_S12_ASIA",
    3990  -> "FIT_GARMIN_PRODUCT_FR255_MUSIC",
    3991  -> "FIT_GARMIN_PRODUCT_FR255_SMALL_MUSIC",
    3992  -> "FIT_GARMIN_PRODUCT_FR255",
    3993  -> "FIT_GARMIN_PRODUCT_FR255_SMALL",
    4002  -> "FIT_GARMIN_PRODUCT_APPROACH_S42_ASIA",
    4005  -> "FIT_GARMIN_PRODUCT_DESCENT_G1",
    4017  -> "FIT_GARMIN_PRODUCT_VENU2_PLUS_ASIA",
    4024  -> "FIT_GARMIN_PRODUCT_FR955",
    4033  -> "FIT_GARMIN_PRODUCT_FR55_ASIA",
    4063  -> "FIT_GARMIN_PRODUCT_VIVOSMART_5",
    4071  -> "FIT_GARMIN_PRODUCT_INSTINCT_2_ASIA",
    4115  -> "FIT_GARMIN_PRODUCT_VENUSQ2",
    4116  -> "FIT_GARMIN_PRODUCT_VENUSQ2MUSIC",
    4125  -> "FIT_GARMIN_PRODUCT_D2_AIR_X10",
    4130  -> "FIT_GARMIN_PRODUCT_HRM_PRO_PLUS",
    4132  -> "FIT_GARMIN_PRODUCT_DESCENT_G1_ASIA",
    4135  -> "FIT_GARMIN_PRODUCT_TACTIX7",
    4169  -> "FIT_GARMIN_PRODUCT_EDGE_EXPLORE2",
    4265  -> "FIT_GARMIN_PRODUCT_TACX_NEO_SMART",
    4266  -> "FIT_GARMIN_PRODUCT_TACX_NEO2_SMART",
    4267  -> "FIT_GARMIN_PRODUCT_TACX_NEO2_T_SMART",
    4268  -> "FIT_GARMIN_PRODUCT_TACX_NEO_SMART_BIKE",
    4269  -> "FIT_GARMIN_PRODUCT_TACX_SATORI_SMART",
    4270  -> "FIT_GARMIN_PRODUCT_TACX_FLOW_SMART",
    4271  -> "FIT_GARMIN_PRODUCT_TACX_VORTEX_SMART",
    4272  -> "FIT_GARMIN_PRODUCT_TACX_BUSHIDO_SMART",
    4273  -> "FIT_GARMIN_PRODUCT_TACX_GENIUS_SMART",
    4274  -> "FIT_GARMIN_PRODUCT_TACX_FLUX_FLUX_S_SMART",
    4275  -> "FIT_GARMIN_PRODUCT_TACX_FLUX2_SMART",
    4276  -> "FIT_GARMIN_PRODUCT_TACX_MAGNUM",
    4305  -> "FIT_GARMIN_PRODUCT_EDGE_1040_ASIA",
    4341  -> "FIT_GARMIN_PRODUCT_ENDURO2",
    10007 -> "FIT_GARMIN_PRODUCT_SDM4",
    10014 -> "FIT_GARMIN_PRODUCT_EDGE_REMOTE",
    20533 -> "FIT_GARMIN_PRODUCT_TACX_TRAINING_APP_WIN",
    20534 -> "FIT_GARMIN_PRODUCT_TACX_TRAINING_APP_MAC",
    20565 -> "FIT_GARMIN_PRODUCT_TACX_TRAINING_APP_MAC_CATALYST",
    20119 -> "FIT_GARMIN_PRODUCT_TRAINING_CENTER",
    30045 -> "FIT_GARMIN_PRODUCT_TACX_TRAINING_APP_ANDROID",
    30046 -> "FIT_GARMIN_PRODUCT_TACX_TRAINING_APP_IOS",
    30047 -> "FIT_GARMIN_PRODUCT_TACX_TRAINING_APP_LEGACY",
    65531 -> "FIT_GARMIN_PRODUCT_CONNECTIQ_SIMULATOR",
    65532 -> "FIT_GARMIN_PRODUCT_ANDROID_ANTPLUS_PLUGIN",
    65534 -> "FIT_GARMIN_PRODUCT_CONNECT"
|>;

$fitGarminProduct = toNiceCamelCase /@ removePrefix[ $fitGarminProduct0, "FIT_GARMIN_PRODUCT_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitHeartRateZoneCalc*)
fitHeartRateZoneCalc // ClearAll;
fitHeartRateZoneCalc[ n_Integer ] := Lookup[ $fitHeartRateZoneCalc, n, Missing[ "NotAvailable" ] ];
fitHeartRateZoneCalc[ ___ ] := Missing[ "NotAvailable" ];

$fitHeartRateZoneCalc0 = <|
    0 -> "FIT_HR_ZONE_CALC_CUSTOM",
    1 -> "FIT_HR_ZONE_CALC_PERCENT_MAX_HR",
    2 -> "FIT_HR_ZONE_CALC_PERCENT_HRR"
|>;

$fitHeartRateZoneCalc = toNiceCamelCase /@ removePrefix[ $fitHeartRateZoneCalc0, "FIT_HR_ZONE_CALC_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitPowerZoneCalc*)
fitPowerZoneCalc // ClearAll;
fitPowerZoneCalc[ n_Integer ] := Lookup[ $fitPowerZoneCalc, n, Missing[ "NotAvailable" ] ];
fitPowerZoneCalc[ ___ ] := Missing[ "NotAvailable" ];

$fitPowerZoneCalc0 = <|
    0 -> "FIT_PWR_ZONE_CALC_CUSTOM",
    1 -> "FIT_PWR_ZONE_CALC_PERCENT_FTP"
|>;

$fitPowerZoneCalc = toNiceCamelCase /@ removePrefix[ $fitPowerZoneCalc0, "FIT_PWR_ZONE_CALC_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitRadarThreatLevelType*)
fitRadarThreatLevelType // ClearAll;
fitRadarThreatLevelType[ n_Integer ] := Lookup[ $fitRadarThreatLevelType, n, Missing[ "NotAvailable" ] ];
fitRadarThreatLevelType[ ___ ] := Missing[ "NotAvailable" ];

$fitRadarThreatLevelType0 = <|
    0 -> "FIT_RADAR_THREAT_LEVEL_TYPE_THREAT_UNKNOWN",
    1 -> "FIT_RADAR_THREAT_LEVEL_TYPE_THREAT_NONE",
    2 -> "FIT_RADAR_THREAT_LEVEL_TYPE_THREAT_APPROACHING",
    3 -> "FIT_RADAR_THREAT_LEVEL_TYPE_THREAT_APPROACHING_FAST"
|>;

$fitRadarThreatLevelType = toNiceCamelCase /@ removePrefix[ $fitRadarThreatLevelType0, "FIT_RADAR_THREAT_LEVEL_TYPE_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitFitBaseUnit*)
fitFitBaseUnit // ClearAll;
fitFitBaseUnit[ n_Integer ] := Lookup[ $fitFitBaseUnit, n, Missing[ "NotAvailable" ] ];
fitFitBaseUnit[ ___ ] := Missing[ "NotAvailable" ];

$fitFitBaseUnit0 = <|
    0 -> "FIT_FIT_BASE_UNIT_OTHER",
    1 -> "FIT_FIT_BASE_UNIT_KILOGRAM",
    2 -> "FIT_FIT_BASE_UNIT_POUND"
|>;

$fitFitBaseUnit = toNiceCamelCase /@ removePrefix[ $fitFitBaseUnit0, "FIT_FIT_BASE_UNIT_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitFitBaseType*)
fitFitBaseType // ClearAll;
fitFitBaseType[ n_Integer ] := Lookup[ $fitFitBaseType, n, Missing[ "NotAvailable" ] ];
fitFitBaseType[ ___ ] := Missing[ "NotAvailable" ];

$fitFitBaseType0 = <|
    0   -> "FIT_FIT_BASE_TYPE_ENUM",
    1   -> "FIT_FIT_BASE_TYPE_SINT8",
    2   -> "FIT_FIT_BASE_TYPE_UINT8",
    131 -> "FIT_FIT_BASE_TYPE_SINT16",
    132 -> "FIT_FIT_BASE_TYPE_UINT16",
    133 -> "FIT_FIT_BASE_TYPE_SINT32",
    134 -> "FIT_FIT_BASE_TYPE_UINT32",
    7   -> "FIT_FIT_BASE_TYPE_STRING",
    136 -> "FIT_FIT_BASE_TYPE_FLOAT32",
    137 -> "FIT_FIT_BASE_TYPE_FLOAT64",
    10  -> "FIT_FIT_BASE_TYPE_UINT8Z",
    139 -> "FIT_FIT_BASE_TYPE_UINT16Z",
    140 -> "FIT_FIT_BASE_TYPE_UINT32Z",
    13  -> "FIT_FIT_BASE_TYPE_BYTE",
    142 -> "FIT_FIT_BASE_TYPE_SINT64",
    143 -> "FIT_FIT_BASE_TYPE_UINT64",
    144 -> "FIT_FIT_BASE_TYPE_UINT64Z"
|>;

$fitFitBaseType = removePrefix[ $fitFitBaseType0, "FIT_FIT_BASE_TYPE_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitFaveroProduct*)
fitFaveroProduct // ClearAll;
fitFaveroProduct[ n_Integer ] := Lookup[ $fitFaveroProduct, n, Missing[ "NotAvailable" ] ];
fitFaveroProduct[ ___ ] := Missing[ "NotAvailable" ];

$fitFaveroProduct0 = <|
    10 -> "FIT_FAVERO_PRODUCT_ASSIOMA_UNO",
    12 -> "FIT_FAVERO_PRODUCT_ASSIOMA_DUO"
|>;

$fitFaveroProduct = toNiceCamelCase /@ removePrefix[ $fitFaveroProduct0, "FIT_FAVERO_PRODUCT_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitExerciseCategory*)
fitExerciseCategory // ClearAll;
fitExerciseCategory[ n_Integer ] := Lookup[ $fitExerciseCategory, n, Missing[ "NotAvailable" ] ];
fitExerciseCategory[ ___ ] := Missing[ "NotAvailable" ];

$fitExerciseCategory0 = <|
    0     -> "FIT_EXERCISE_CATEGORY_BENCH_PRESS",
    1     -> "FIT_EXERCISE_CATEGORY_CALF_RAISE",
    2     -> "FIT_EXERCISE_CATEGORY_CARDIO",
    3     -> "FIT_EXERCISE_CATEGORY_CARRY",
    4     -> "FIT_EXERCISE_CATEGORY_CHOP",
    5     -> "FIT_EXERCISE_CATEGORY_CORE",
    6     -> "FIT_EXERCISE_CATEGORY_CRUNCH",
    7     -> "FIT_EXERCISE_CATEGORY_CURL",
    8     -> "FIT_EXERCISE_CATEGORY_DEADLIFT",
    9     -> "FIT_EXERCISE_CATEGORY_FLYE",
    10    -> "FIT_EXERCISE_CATEGORY_HIP_RAISE",
    11    -> "FIT_EXERCISE_CATEGORY_HIP_STABILITY",
    12    -> "FIT_EXERCISE_CATEGORY_HIP_SWING",
    13    -> "FIT_EXERCISE_CATEGORY_HYPEREXTENSION",
    14    -> "FIT_EXERCISE_CATEGORY_LATERAL_RAISE",
    15    -> "FIT_EXERCISE_CATEGORY_LEG_CURL",
    16    -> "FIT_EXERCISE_CATEGORY_LEG_RAISE",
    17    -> "FIT_EXERCISE_CATEGORY_LUNGE",
    18    -> "FIT_EXERCISE_CATEGORY_OLYMPIC_LIFT",
    19    -> "FIT_EXERCISE_CATEGORY_PLANK",
    20    -> "FIT_EXERCISE_CATEGORY_PLYO",
    21    -> "FIT_EXERCISE_CATEGORY_PULL_UP",
    22    -> "FIT_EXERCISE_CATEGORY_PUSH_UP",
    23    -> "FIT_EXERCISE_CATEGORY_ROW",
    24    -> "FIT_EXERCISE_CATEGORY_SHOULDER_PRESS",
    25    -> "FIT_EXERCISE_CATEGORY_SHOULDER_STABILITY",
    26    -> "FIT_EXERCISE_CATEGORY_SHRUG",
    27    -> "FIT_EXERCISE_CATEGORY_SIT_UP",
    28    -> "FIT_EXERCISE_CATEGORY_SQUAT",
    29    -> "FIT_EXERCISE_CATEGORY_TOTAL_BODY",
    30    -> "FIT_EXERCISE_CATEGORY_TRICEPS_EXTENSION",
    31    -> "FIT_EXERCISE_CATEGORY_WARM_UP",
    32    -> "FIT_EXERCISE_CATEGORY_RUN",
    65534 -> "FIT_EXERCISE_CATEGORY_UNKNOWN"
|>;

$fitExerciseCategory = toNiceCamelCase /@ removePrefix[ $fitExerciseCategory0, "FIT_EXERCISE_CATEGORY_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitWorkoutStepDuration*)
fitWorkoutStepDuration // ClearAll;
fitWorkoutStepDuration[ n_Integer ] := Lookup[ $fitWorkoutStepDuration, n, Missing[ "NotAvailable" ] ];
fitWorkoutStepDuration[ ___ ] := Missing[ "NotAvailable" ];

$fitWorkoutStepDuration0 = <|
    0  -> "FIT_WKT_STEP_DURATION_TIME",
    1  -> "FIT_WKT_STEP_DURATION_DISTANCE",
    2  -> "FIT_WKT_STEP_DURATION_HR_LESS_THAN",
    3  -> "FIT_WKT_STEP_DURATION_HR_GREATER_THAN",
    4  -> "FIT_WKT_STEP_DURATION_CALORIES",
    5  -> "FIT_WKT_STEP_DURATION_OPEN",
    6  -> "FIT_WKT_STEP_DURATION_REPEAT_UNTIL_STEPS_CMPLT",
    7  -> "FIT_WKT_STEP_DURATION_REPEAT_UNTIL_TIME",
    8  -> "FIT_WKT_STEP_DURATION_REPEAT_UNTIL_DISTANCE",
    9  -> "FIT_WKT_STEP_DURATION_REPEAT_UNTIL_CALORIES",
    10 -> "FIT_WKT_STEP_DURATION_REPEAT_UNTIL_HR_LESS_THAN",
    11 -> "FIT_WKT_STEP_DURATION_REPEAT_UNTIL_HR_GREATER_THAN",
    12 -> "FIT_WKT_STEP_DURATION_REPEAT_UNTIL_POWER_LESS_THAN",
    13 -> "FIT_WKT_STEP_DURATION_REPEAT_UNTIL_POWER_GREATER_THAN",
    14 -> "FIT_WKT_STEP_DURATION_POWER_LESS_THAN",
    15 -> "FIT_WKT_STEP_DURATION_POWER_GREATER_THAN",
    16 -> "FIT_WKT_STEP_DURATION_TRAINING_PEAKS_TSS",
    17 -> "FIT_WKT_STEP_DURATION_REPEAT_UNTIL_POWER_LAST_LAP_LESS_THAN",
    18 -> "FIT_WKT_STEP_DURATION_REPEAT_UNTIL_MAX_POWER_LAST_LAP_LESS_THAN",
    19 -> "FIT_WKT_STEP_DURATION_POWER_3S_LESS_THAN",
    20 -> "FIT_WKT_STEP_DURATION_POWER_10S_LESS_THAN",
    21 -> "FIT_WKT_STEP_DURATION_POWER_30S_LESS_THAN",
    22 -> "FIT_WKT_STEP_DURATION_POWER_3S_GREATER_THAN",
    23 -> "FIT_WKT_STEP_DURATION_POWER_10S_GREATER_THAN",
    24 -> "FIT_WKT_STEP_DURATION_POWER_30S_GREATER_THAN",
    25 -> "FIT_WKT_STEP_DURATION_POWER_LAP_LESS_THAN",
    26 -> "FIT_WKT_STEP_DURATION_POWER_LAP_GREATER_THAN",
    27 -> "FIT_WKT_STEP_DURATION_REPEAT_UNTIL_TRAINING_PEAKS_TSS",
    28 -> "FIT_WKT_STEP_DURATION_REPETITION_TIME",
    29 -> "FIT_WKT_STEP_DURATION_REPS",
    31 -> "FIT_WKT_STEP_DURATION_TIME_ONLY"
|>;

$fitWorkoutStepDuration = toNiceCamelCase /@ removePrefix[ $fitWorkoutStepDuration0, "FIT_WKT_STEP_DURATION_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitWorkoutStepTarget*)
fitWorkoutStepTarget // ClearAll;
fitWorkoutStepTarget[ n_Integer ] := Lookup[ $fitWorkoutStepTarget, n, Missing[ "NotAvailable" ] ];
fitWorkoutStepTarget[ ___ ] := Missing[ "NotAvailable" ];

$fitWorkoutStepTarget0 = <|
    0  -> "FIT_WKT_STEP_TARGET_SPEED",
    1  -> "FIT_WKT_STEP_TARGET_HEART_RATE",
    2  -> "FIT_WKT_STEP_TARGET_OPEN",
    3  -> "FIT_WKT_STEP_TARGET_CADENCE",
    4  -> "FIT_WKT_STEP_TARGET_POWER",
    5  -> "FIT_WKT_STEP_TARGET_GRADE",
    6  -> "FIT_WKT_STEP_TARGET_RESISTANCE",
    7  -> "FIT_WKT_STEP_TARGET_POWER_3S",
    8  -> "FIT_WKT_STEP_TARGET_POWER_10S",
    9  -> "FIT_WKT_STEP_TARGET_POWER_30S",
    10 -> "FIT_WKT_STEP_TARGET_POWER_LAP",
    11 -> "FIT_WKT_STEP_TARGET_SWIM_STROKE",
    12 -> "FIT_WKT_STEP_TARGET_SPEED_LAP",
    13 -> "FIT_WKT_STEP_TARGET_HEART_RATE_LAP"
|>;

$fitWorkoutStepTarget = toNiceCamelCase /@ removePrefix[ $fitWorkoutStepTarget0, "FIT_WKT_STEP_TARGET_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitWorkoutEquipment*)
fitWorkoutEquipment // ClearAll;
fitWorkoutEquipment[ n_Integer ] := Lookup[ $fitWorkoutEquipment, n, Missing[ "NotAvailable" ] ];
fitWorkoutEquipment[ ___ ] := Missing[ "NotAvailable" ];

$fitWorkoutEquipment0 = <|
    0 -> "FIT_WORKOUT_EQUIPMENT_NONE",
    1 -> "FIT_WORKOUT_EQUIPMENT_SWIM_FINS",
    2 -> "FIT_WORKOUT_EQUIPMENT_SWIM_KICKBOARD",
    3 -> "FIT_WORKOUT_EQUIPMENT_SWIM_PADDLES",
    4 -> "FIT_WORKOUT_EQUIPMENT_SWIM_PULL_BUOY",
    5 -> "FIT_WORKOUT_EQUIPMENT_SWIM_SNORKEL"
|>;

$fitWorkoutEquipment = toNiceCamelCase /@ removePrefix[ $fitWorkoutEquipment0, "FIT_WORKOUT_EQUIPMENT_" ];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Footer*)
End[ ];
EndPackage[ ];

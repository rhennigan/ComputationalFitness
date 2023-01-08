(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "RH`ComputationalFitness`FIT`" ];
Needs[ "RH`ComputationalFitness`" ];
Needs[ "RH`ComputationalFitness`Package`" ];
Begin[ "`Private`" ];

(* ::**************************************************************************************************************:: *)
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
"File `1` not found.";

FITImport::CopyTemporaryFailed =
"Failed to copy source to a temporary file.";

FITImport::ArgumentCount =
"FITImport called with `1` arguments; between 1 and 2 arguments are expected.";

FITImport::InvalidMaxHR =
"The value `1` is not a valid value for maximum heart rate.";

FITImport::InvalidWeight =
"The value `1` is not a valid value for weight.";

FITImport::InvalidUnitSystem =
"The value `1` is not a valid value for UnitSystem.";

FITImport::NoRecordsAvailable =
"No records available in the specified FIT file.";

FITImport::InvalidMessageInformation =
"The stored MessageInformation is corrupt and cannot be used.";

(* ::**************************************************************************************************************:: *)
(* ::Section:: *)
(*Options*)
FITImport // Options = {
    FunctionalThresholdPower :> $FunctionalThresholdPower,
    MaximumHeartRate         :> $MaximumHeartRate,
    Sport                    :> $Sport,
    UnitSystem               :> $UnitSystem,
    Weight                   :> $Weight
};

(* ::**************************************************************************************************************:: *)
(* ::Section:: *)
(*Main definition*)

(* TODO: clean this up a bit more *)

(* Automatic as default second argument: *)
FITImport[ file_, opts: OptionsPattern[ ] ] :=
    catchMine @ FITImport[ file, Automatic, opts ];

(* Interpret Automatic as "FitnessData": *)
FITImport[ file_, Automatic, opts: OptionsPattern[ ] ] :=
    (* TODO: import based on FITFileType *)
    catchMine @ FITImport[ file, "FitnessData", opts ];

FITImport[ file_, "RawData", opts: OptionsPattern[ ] ] :=
    fitImportOptionsBlock[ fitImport @ file, opts ];

FITImport[ file_, "Data", opts: OptionsPattern[ ] ] :=
    fitImportOptionsBlock[
        Module[ { data, messages },
            data     = FITImport[ file, "RawData", opts ];
            messages = selectMessageType[ data, "Record" ];
            formatFitData @ messages
        ],
        opts
    ];

FITImport[ file_, type: $$messageTypes, opts: OptionsPattern[ ] ] :=
    fitImportOptionsBlock[
        Module[ { data },
            data = FITImport[ file, "RawData", opts ];
            makeMessageTypeData[ data, type ]
        ],
        opts
    ];

FITImport[ file_, "Dataset", opts: OptionsPattern[ ] ] :=
    catchMine @ Module[ { data },
        data = FITImport[ file, "Data", opts ];
        If[ MatchQ[ data, { __Association } ],\
            Dataset @ KeyDrop[ data, "MessageType" ],
            throwFailure[ FITImport::NoRecordsAvailable ]
        ]
    ];

FITImport[ file_, type: $$pluralMessage, opts: OptionsPattern[ ] ] :=
    catchMine @ FITImport[ file, StringDelete[ type, "s"~~EndOfString ], opts ];

FITImport[ file: $$file|$$string, prop_, opts: OptionsPattern[ ] ] /; ! FileExistsQ @ file :=
    With[ { found = findFile @ file },
        FITImport[ found, prop, opts ] /; FileExistsQ @ found
    ];

FITImport[ file_, "MessageInformation", opts: OptionsPattern[ ] ] :=
    fitImportOptionsBlock[
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
    fitImportOptionsBlock[
        Module[ { data },
            data = fitMessageTypes @ file;
            Counts[ fitMessageType /@ data[[ All, 2 ]] ]
        ],
        opts
    ];

FITImport[ file_, "Messages", opts: OptionsPattern[ ] ] :=
    fitImportOptionsBlock[
        DeleteMissing /@ formatFitData @ FITImport[ file, "RawData", opts ],
        opts
    ];

FITImport[ file_, "MessageData", opts: OptionsPattern[ ] ] :=
    fitImportOptionsBlock[
        Dataset @ GroupBy[
            FITImport[ file, "Messages", opts ],
            #MessageType &
        ],
        opts
    ];

FITImport[ file_, "FitnessData", opts: OptionsPattern[ ] ] :=
    fitImportOptionsBlock[
        makeFitnessDataObject[
            FITImport[ file, "RawData", opts ],
            fitMessageTypes @ file,
            FITFileType @ file,
            opts
        ],
        opts
    ];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Special Properties*)
FITImport[ _, "Elements", OptionsPattern[ ] ] :=
    catchTopAs[ FITImport ] @ Union[ $fitElements, $supportedMessageTypes ];

FITImport[ file_, "FileType", OptionsPattern[ ] ] :=
    catchTopAs[ FITImport ] @ fitFileType @ file;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*TimeSeries Data*)
FITImport[ file_, "TimeSeries", opts: OptionsPattern[ ] ] :=
    catchTopAs[ FITImport ] @ FITImport[ file, { "TimeSeries", $timeSeriesKeys }, opts ];

FITImport[ file_, key: $$fitRecordKeys, opts: OptionsPattern[ ] ] :=
    catchTopAs[ FITImport ] @ FITImport[ file, { "TimeSeries", key }, opts ];

FITImport[ file_, { "TimeSeries", key: $$fitRecordKeys }, opts: OptionsPattern[ ] ] :=
    fitImportOptionsBlock[
        Module[ { data, records },
            data = FITImport[ file, "RawData", opts ];
            records = selectMessageType[ data, "Record" ];
            makeTimeSeriesData[ "Record", records, key ]
        ],
        opts
    ];

FITImport[ file_, All, opts: OptionsPattern[ ] ] :=
    catchTopAs[ FITImport ] @ FITImport[ file, { "TimeSeries", All }, opts ];

FITImport[ file_, { "TimeSeries", All }, opts: OptionsPattern[ ] ] :=
    catchTopAs[ FITImport ] @ Module[ { data, records },
        data  = FITImport[ file, "RawData", opts ];
        records = selectMessageType[ data, "Record" ];
        DeleteMissing @ makeTimeSeriesData[
            "Record",
            records,
            $timeSeriesKeys
        ]
    ];


$timeSeriesKeys := DeleteCases[ fitKeys[ "Record" ], "MessageType"|"Timestamp" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Mixed Elements*)
FITImport[ file_, props: $$propList, opts: OptionsPattern[ ] ] :=
    catchTopAs[ FITImport ] @ Module[ { data, fitKeys, elements, ts, as, joined },
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

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Graphics*)
FITImport[ file_, "PowerZonePlot", opts: OptionsPattern[ ] ] :=
    fitImportOptionsBlock[
        powerZonePlot @ FITImport[ file, "Power", opts ],
        opts
    ];

FITImport[ file_, "AveragePowerPhasePlot", opts: OptionsPattern[ ] ] :=
    fitImportOptionsBlock[
        averagePowerPhasePlot @ FITImport[ file, "Session", opts ],
        opts
    ];

FITImport[ file_, "CriticalPowerCurvePlot", opts: OptionsPattern[ ] ] :=
    fitImportOptionsBlock[
        criticalPowerCurve @ FITImport[ file, "Power", opts ],
        opts
    ];

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Error cases*)
FITImport[ $$source, { ___, e: Except[ $$props ], ___ }, OptionsPattern[ ] ] :=
    catchTopAs[ FITImport ][
        If[ StringQ @ e,
            throwFailure[ FITImport::InvalidElement         , e ],
            throwFailure[ FITImport::BadElementSpecification, e ]
        ]
    ];


FITImport[ $$source, e: Except[ $$props ], OptionsPattern[ ] ] :=
    catchTopAs[ FITImport ][
        If[ StringQ @ e,
            throwFailure[ FITImport::InvalidElement         , e ],
            throwFailure[ FITImport::BadElementSpecification, e ]
        ]
    ];

FITImport[ source: $$source, _, opts: OptionsPattern[ ] ] :=
    catchTopAs[ FITImport ] @ throwFailure[ FITImport::FileNotFound, source ];

FITImport[ source: Except @ $$source, _, opts: OptionsPattern[ ] ] :=
    catchTopAs[ FITImport ] @ throwFailure[ FITImport::InvalidFile, source ];

FITImport[ source: $$source, elem_String, opts: OptionsPattern[ ] ] /;
    ! elementQ @ elem :=
        catchTopAs[ FITImport ] @ throwFailure[ FITImport::InvalidElement, elem ];

FITImport[ args___ ] :=
    catchTopAs[ FITImport ] @ With[ { len = Length @ HoldComplete @ args },
        throwFailure[ FITImport::ArgumentCount, len ]
    ];

(* ::**************************************************************************************************************:: *)
(* ::Section:: *)
(*Dependencies*)

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*fitImportOptionsBlock*)
fitImportOptionsBlock // beginDefinition;
fitImportOptionsBlock // Attributes = { HoldFirst };

fitImportOptionsBlock[ eval_, opts: OptionsPattern[ FITImport ] ] :=
    catchTopAs[ FITImport ] @ Block[
        {
            $UnitSystem           = setUnitSystem @ OptionValue @ UnitSystem, (* FIXME: fix it! *)
            $ftp                  = setFTP @ OptionValue @ FunctionalThresholdPower,
            $maxHR                = setMaxHR @ OptionValue @ MaximumHeartRate,
            $weight               = setWeight @ OptionValue @ Weight,
            $sport                = setSport @ OptionValue @ Sport,
            $fileType             = None,
            $failedTimeOffset     = False,
            $timeOffset           = 0,
            $fileByteCount        = 0,
            $lastHRV              = None,
            fitImportOptionsBlock = # &
        },
        eval
    ];

fitImportOptionsBlock // endDefinition;

(* ::**************************************************************************************************************:: *)
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
    Module[ { reverse, file, profile, activity, session, sport },

        reverse  = Reverse @ data;
        file     = selectFirstMessageType[ data   , "FileID"      ];
        profile  = selectFirstMessageType[ data   , "UserProfile" ];
        activity = selectFirstMessageType[ reverse, "Activity"    ];
        session  = selectFirstMessageType[ reverse, "Session"     ];
        sport    = selectFirstMessageType[ data   , "Sport"       ];

        setPreferences0 @ DeleteMissing @ <|
            "FileID"      -> file,
            "UserProfile" -> profile,
            "Activity"    -> activity,
            "Session"     -> session,
            "Sport"       -> sport
        |>
    ];

setPreferences // endDefinition;

setPreferences0 // beginDefinition;
setPreferences0[ config_ ] := (
    setFileType   @ config;
    setSportPref  @ config;
    setUnitPrefs  @ config;
    setTimeOffset @ config;
    setWeightPref @ config;
    setFTPPref    @ config;
    setMaxHRPref  @ config;
);
setPreferences0 // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*setFileType*)
setFileType // beginDefinition;
setFileType[ config_ ] := setFileType[ config, Lookup[ config, "FileID" ] ];
setFileType[ config_, v_List ] := $fileType = fitValue[ "FileID", "Type", v ];
setFileType[ config_, _Missing ] := $fileType = None;
setFileType // endDefinition;

(* ::**************************************************************************************************************:: *)
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
            $sport = setSport @ PersistentSymbol[ "ComputationalFitness/Sport" ]
        ]
    ];

setSportPref[ as_Association, sport_ ] :=
    $sport = setSport @ sport;

setSportPref // endDefinition;

(* ::**************************************************************************************************************:: *)
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
    $unitSystem = setUnitSystem @ PersistentSymbol[ "ComputationalFitness/UnitSystem" ];

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

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*setProfileUnits*)
setProfileUnits // beginDefinition;
setProfileUnits // Attributes = { HoldFirst };

setProfileUnits[ s_Symbol, key_String, v_List ] :=
    s = setUnitSystem @ fitValue[ "UserProfile", key, v ];

setProfileUnits // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*setAltitudePrefs*)
setAltitudePrefs // beginDefinition;

setAltitudePrefs[ Automatic, v_List ] :=
    setProfileUnits[ $altitudeUnits, "ElevationSetting", v ];

setAltitudePrefs[ setting_, _ ] :=
    $altitudeUnits = setUnitSystem @ setting;

setAltitudePrefs // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*setTimeOffset*)
setTimeOffset // beginDefinition;
setTimeOffset[ config_Association ] := $timeOffset = getTimeOffset @ config;
setTimeOffset // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*getTimeOffset*)
getTimeOffset // ClearAll;

(* getTimeOffset[ config_Association ] :=
    getTimeOffset[ config, config[ "Activity" ] ];

getTimeOffset[ config_, v_List ] :=
    Module[ { t1, t2 },
        t1 = fitValue[ "Activity", "Timestamp"     , v ];
        t2 = fitValue[ "Activity", "LocalTimestamp", v ];
        getTimeOffset[ config, v, { t1, t2 } ]
    ];

getTimeOffset[ config_, _Missing ] := 0;

getTimeOffset[ config_, v_, { t1_DateObject, t2_DateObject } ] :=
    Module[ { offset },
        offset = AbsoluteTime @ t1 - AbsoluteTime @ t2;
        If[ Abs @ offset < 86400,
            offset,
            $failedTimeOffset = True;
            0
        ]
    ];

getTimeOffset[ config_, v_, { t1_, t2_ } ] := ($failedTimeOffset = True; 0); *)

getTimeOffset[ ___ ] := 0;

(* getTimeOffset // endDefinition; *)

(* ::**************************************************************************************************************:: *)
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
            $ftp = setFTP @ PersistentSymbol[ "ComputationalFitness/FunctionalThresholdPower" ]
        ]
    ];

setFTPPref[ config_, Automatic, _ ] :=
    $ftp = setFTP @ PersistentSymbol[ "ComputationalFitness/FunctionalThresholdPower" ];

setFTPPref // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*setMaxHRPref*)
setMaxHRPref // beginDefinition;

setMaxHRPref[ config_ ] := setMaxHRPref[ config, $maxHR ];

setMaxHRPref[ config_Association, Automatic ] :=
    setMaxHRPref[ config, Automatic, config[ "UserProfile" ] ];

setMaxHRPref[ config_, _ ] := Null;

setMaxHRPref[ config_, Automatic, v_List ] :=
    Module[ { maxHR },
        maxHR = fitValue[ "UserProfile", "DefaultMaximumHeartRate", v ];
        If[ TrueQ @ Positive @ maxHR,
            $maxHR = setMaxHR @ maxHR,
            $maxHR = setMaxHR @ PersistentSymbol[ "ComputationalFitness/MaximumHeartRate" ]
        ]
    ];

setMaxHRPref[ config_, Automatic, _ ] :=
    $maxHR = setMaxHR @ PersistentSymbol[ "ComputationalFitness/MaximumHeartRate" ];

setMaxHRPref // endDefinition;

(* ::**************************************************************************************************************:: *)
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
            $weight = setWeight @ PersistentSymbol[ "ComputationalFitness/Weight" ]
        ]
    ];

setWeightPref[ config_, Automatic, _ ] :=
    $weight = setWeight @ PersistentSymbol[ "ComputationalFitness/Weight" ];

setFTPPref // endDefinition;

(* ::**************************************************************************************************************:: *)
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

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*setFTP*)
setFTP // beginDefinition;
setFTP[ Automatic     ] := Automatic;
setFTP[ None|_Missing ] := None;
setFTP[ ftp_Integer   ] := N @ ftp;
setFTP[ ftp_Real      ] := ftp;
setFTP[ Quantity[ ftp_, "Watts" ] ] := setFTP @ ftp;
setFTP[ ftp_Quantity ] := setFTP @ UnitConvert[ ftp, "Watts" ];
setFTP[ ftp_ ] := throwFailure[ "InvalidFTP", ftp ];
setFTP // endDefinition;

(* ::**************************************************************************************************************:: *)
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

(* ::**************************************************************************************************************:: *)
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

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*setSport*)
setSport // beginDefinition;
setSport[ Automatic     ] := Automatic;
setSport[ None|_Missing ] := None;
setSport[ s_String      ] := s;
setSport[ s_            ] := throwFailure[ FITImport::InvalidSport, s ];
setSport // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*fitImport*)
fitImport // beginDefinition;
fitImport[ data_? rawDataQ  ] := data;
fitImport[ compact_? compactFitFitnessDataQ ] := fromCompactRawData @ compact;
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

(* ::**************************************************************************************************************:: *)
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

fitMessageTypes[ FitnessData[ KeyValuePattern[ "MessageInformation" -> info_ ] ] ] := Enclose[
    ConfirmBy[ Developer`ToPackedArray @ info, rawDataQ ],
    throwFailure[ "InvalidMessageInformation", info ] &
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

fitMessageTypes // endDefinition;

(* ::**************************************************************************************************************:: *)
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

(* ::**************************************************************************************************************:: *)
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

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*makeElementData*)
makeElementData // beginDefinition;

makeElementData[ file_, data_, elements_List, opts: OptionsPattern[ ] ] :=
    AssociationMap[ FITImport[ file, #, opts ] &, elements ];

makeElementData[ file_, data_, element_, opts: OptionsPattern[ ] ] :=
    FITImport[ file, element, opts ];

makeElementData // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*toFileString*)
toFileString // beginDefinition;

toFileString[ file_ ] :=
    With[ { str = toFileString0 @ file },
        If[ StringQ @ str,
            If[ $setFileByteCount,
                $fileByteCount = Quiet @ FileByteCount @ file
            ];
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

(* ::**************************************************************************************************************:: *)
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

(* ::**************************************************************************************************************:: *)
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

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*$tempFile*)
$tempFile // ClearAll;
$tempFile := FileNameJoin @ {
    GeneralUtilities`EnsureDirectory @ { $TemporaryDirectory, "FITImport" },
    CreateUUID[ ] <> ".fit"
};

(* ::**************************************************************************************************************:: *)
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
                 If[ TrueQ @ $parallelization,
                     ParallelMap[ makeFitAssociation, data ],
                     Map[ makeFitAssociation, data ]
                ]
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

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*allMissingOrZeroQ*)
allMissingOrZeroQ // ClearAll;
allMissingOrZeroQ[ { _ } ] := False;
allMissingOrZeroQ[ a_List ] := AllTrue[ a, missingOrZeroQ ];
allMissingOrZeroQ[ ___ ] := False;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*missingOrZeroQ*)
missingOrZeroQ // ClearAll;
missingOrZeroQ[ _Missing ] := True;
missingOrZeroQ[ 0 | 0.0 ] := True;
missingOrZeroQ[ r_Real ] := Chop @ r === 0;
missingOrZeroQ[ Quantity[ _? missingOrZeroQ, _ ] ] := True;
missingOrZeroQ[ Interval[ { _? missingOrZeroQ, _? missingOrZeroQ } ] ] := True;
missingOrZeroQ[ ___ ] := False;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*computeGradeQ*)
computeGradeQ // ClearAll;
computeGradeQ[ data_ ] := MatchQ[ data[[ All, 13 ]], { $invalidSINT16 .. } ];
computeGradeQ[ ___   ] := False;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*makeFitAssociation*)
makeFitAssociation // beginDefinition;

makeFitAssociation[ values_ ] :=
    With[ { msgType = fitMessageType @ values },
        AssociationMap[ fitValue[ msgType, #1, values ] &, fitKeys @ msgType ]
    ];

makeFitAssociation // endDefinition;

(* ::**************************************************************************************************************:: *)
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

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitValueTimed*)
fitValueTimed // ClearAll;
fitValueTimed[ type_, name_, v_ ] :=
    Module[ { time, res },
        { time, res } = AbsoluteTiming @ fitValue[ type, name, v ];
        Internal`StuffBag[ $fitValueTimings, { type, name } -> time ];
        res
    ];

$fitValueTimings := $fitValueTimings = Internal`Bag[ ];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*makeFitnessDataObject*)
makeFitnessDataObject // beginDefinition;

makeFitnessDataObject[ data_FitnessData? compactFitFitnessDataQ, ___ ] := data;

makeFitnessDataObject[
    data_? rawDataQ,
    messageInformation_? rawDataQ,
    type: _String | Missing[ "UnknownType", _Integer ],
    opts: OptionsPattern @ FITImport
] :=
    Module[ { compact, options },
        compact = toCompactRawData @ data;
        options = optionsAssociation[ FITImport, opts ];
        FitnessData @ <|
            "Format"             -> "FIT",
            "DataFormat"         -> "FITCompact",
            "Data"               -> compact,
            "Type"               -> type,
            "Count"              -> Length @ data,
            "SummaryData"        -> makeFitnessSummaryData[ type, compact ],
            "Options"            -> options,
            "MessageInformation" -> messageInformation
        |>
    ];

makeFitnessDataObject // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*makeFitnessSummaryData*)
makeFitnessSummaryData // beginDefinition;
makeFitnessSummaryData[ "Activity", as_ ] := makeActivitySummaryData @ as;
makeFitnessSummaryData[ "Workout" , as_ ] := makeWorkoutSummaryData @ as;
makeFitnessSummaryData[ "Course"  , as_ ] := makeCourseSummaryData @ as;
makeFitnessSummaryData[ type_, as_Association ] := <| |>;
makeFitnessSummaryData // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*firstSummaryValue*)
firstSummaryValue // beginDefinition;
firstSummaryValue[ type_, field_, KeyValuePattern[ "Data" -> data_ ] ] := firstSummaryValue[ type, field, data ];
firstSummaryValue[ type_, field_, as_Association ] := firstSummaryValue[ type, field, as[ type ] ];
firstSummaryValue[ type_, field_, { v_List, ___ } ] := fitValue[ type, field, v ];
firstSummaryValue[ type_, field_, _Missing ] := Missing[ "NotAvailable" ];
firstSummaryValue // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*makeActivitySummaryData*)
makeActivitySummaryData // beginDefinition;

makeActivitySummaryData[ as_Association ] :=
    makeActivitySummaryData[ as, as[ "Session", "Data" ] ];

makeActivitySummaryData[ as_, v_ ] :=
    DeleteMissing @ <|
        "Sport"    -> firstSummaryValue[ "Session", "Sport"              , v ],
        "SubSport" -> firstSummaryValue[ "Session", "SubSport"           , v ],
        "Date"     -> firstSummaryValue[ "Session", "StartTime"          , v ],
        "Duration" -> firstSummaryValue[ "Session", "TotalElapsedTime"   , v ],
        "Distance" -> firstSummaryValue[ "Session", "TotalDistance"      , v ],
        "Ascent"   -> firstSummaryValue[ "Session", "TotalAscent"        , v ],
        "Calories" -> firstSummaryValue[ "Session", "TotalCalories"      , v ],
        "TSS"      -> firstSummaryValue[ "Session", "TrainingStressScore", v ],
        "IF"       -> firstSummaryValue[ "Session", "IntensityFactor"    , v ],
        "NP"       -> firstSummaryValue[ "Session", "NormalizedPower"    , v ]
    |>;

makeActivitySummaryData[ _Association, _Missing ] := <| |>;

makeActivitySummaryData // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*makeWorkoutSummaryData*)
makeWorkoutSummaryData // beginDefinition;

makeWorkoutSummaryData[ as_Association ] :=
    DeleteMissing @ <|
        "Name"         -> firstSummaryValue[ "Workout", "WorkoutName", as ],
        "Sport"        -> firstSummaryValue[ "Workout", "Sport", as ],
        "Duration"     -> workoutSummaryDuration @ as[ "WorkoutStep", "Data" ],
        "WorkoutSteps" -> firstSummaryValue[ "Workout", "NumberOfValidSteps", as ],
        "DateCreated"  -> firstSummaryValue[ "FileID" , "TimeCreated", as ]
    |>;

makeWorkoutSummaryData // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*workoutSummaryDuration*)
workoutSummaryDuration // beginDefinition;

workoutSummaryDuration[ _Missing ] := Missing[ "NotAvailable" ];

workoutSummaryDuration[ steps_List? rawDataQ ] :=
    Module[ { durationData, durations },
        durationData = (fitValue[ "WorkoutStep", "Duration", #1 ] &) /@ steps;
        durations    = DeleteMissing @ durationData;
        Which[
            Length @ durations === 0,
                Missing[ "NotAvailable" ]
            ,
            TrueQ @ AllTrue[ durations, CompatibleUnitQ[ #1, "Seconds" ] & ],
                secondsToQuantity @ Total @ durations
            ,
            TrueQ @ AllTrue[ durations, CompatibleUnitQ[ #1, "Meters" ] & ],
                Total @ durations
            ,
            True,
                Missing[ "NotAvailable" ]
        ]
    ];

workoutSummaryDuration // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*makeCourseSummaryData*)
makeCourseSummaryData // beginDefinition;

makeCourseSummaryData[ as_Association ] :=
    DeleteMissing @ <|
        "Name"          -> firstSummaryValue[ "Course", "Name", as ],
        "Sport"         -> firstSummaryValue[ "Course", "Sport", as ],
        "DateCreated"   -> firstSummaryValue[ "FileID" , "TimeCreated", as ],
        "Distance"      -> firstSummaryValue[ "Lap", "TotalDistance", as ],
        "StartPosition" -> firstSummaryValue[ "Lap", "StartPosition", as ],
        "EndPosition"   -> firstSummaryValue[ "Lap", "EndPosition", as ],
        "Course"        -> courseSummary @ as[ "Record", "Data" ]
    |>;

makeCourseSummaryData // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*courseSummary*)
courseSummary // beginDefinition;

courseSummary[ _Missing ] := Missing[ "NotAvailable" ];

courseSummary[ records_List? rawDataQ ] :=
    Module[ { delta, course },
        delta  = Max[ 1, Floor[ Length @ records / 100 ] ];
        course = Map[ fitValue[ "Record", "GeoPosition", #1 ] &, records[[ ;; ;; delta ]] ];
        If[ MatchQ[ course, { __GeoPosition } ],
            GeoPosition @ course[[ All, 1 ]],
            Missing[ "NotAvailable" ]
        ]
    ];

courseSummary // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*toCompactRawData*)
toCompactRawData // beginDefinition;

toCompactRawData[ data_? rawDataQ ] :=
    Module[ { compact },
        compact = toCompactRawDataValues @ data;
        Association @ KeyValueMap[
            Function[ #1 -> compactFieldData[ #1, #2 ] ],
            compact
        ]
    ];

toCompactRawData // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*compactFieldData*)
compactFieldData // beginDefinition;
compactFieldData[ type_, data_ ] := <|
    "Fields" -> usableFields[ type, usableFITColumnsLibFunction @ data ],
    "Data"   -> data
|>;
compactFieldData // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*usableFields*)
usableFields // beginDefinition;

usableFields[ type_, data_ ] :=
    Keys @ Select[
        Map[ fieldIndexMemberQ @ data,
             $FITMessageDefinitions[[ type, "Fields", All, "Index" ]]
        ],
        TrueQ
    ];

usableFields // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*toCompactRawDataValues*)
toCompactRawDataValues // beginDefinition;

toCompactRawDataValues[ data_ ] :=
    Module[ { types, keys, sizes, cPos, containers, idx, mesg, type, j, k },

        types      = KeyMap[ fitMessageType, Counts @ data[[ All, 1 ]] ];
        keys       = Keys @ types;
        sizes      = AssociationMap[ $FITMessageDefinitions[ #1, "Size" ] &, keys ];
        cPos       = Association @ MapIndexed[ #1 -> First[ #2 ] &, Keys @ types ];
        containers = KeyValueMap[ ConstantArray[ 0, { #2, sizes[ #1 ] } ] &, types ];
        idx        = AssociationMap[ 1 &, keys ];

        Do[ mesg = data[[ i ]];
            type = fitMessageType @ mesg[[ 1 ]];
            j    = cPos @ type;
            k    = idx[ type ]++;
            containers[[ j, k ]] = mesg[[ 1;;sizes[[ type ]] ]],
            { i, Length @ data }
        ];

        AssociationThread[ keys -> containers ]
    ];

toCompactRawDataValues // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fieldIndexMemberQ*)
fieldIndexMemberQ // ClearAll;
fieldIndexMemberQ[ p_List, i_Integer ] := MemberQ[ p, i ];
fieldIndexMemberQ[ p_List, a_Integer;;b_Integer ] := IntegerQ @ SelectFirst[ p, a <= # <= b & ];
fieldIndexMemberQ[ p_ ][ i_ ] := fieldIndexMemberQ[ p, i ];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*fromCompactRawData*)
fromCompactRawData // beginDefinition;

fromCompactRawData[ HoldPattern @ FitnessData[ as_Association, ___ ] ] :=
    fromCompactRawData @ as;

fromCompactRawData[ KeyValuePattern @ {
    "Format"     -> "FIT",
    "DataFormat" -> "FITCompact",
    "Data"       -> compact_Association
} ] := fromCompactRawData @ compact;

fromCompactRawData[ compact_Association ] :=
    Module[ { width, flat, pad, square, data },
        width  = $fitConfig[ "MessageTensorRowWidth" ];
        flat   = Flatten[ Values @ compact[[ All, "Data" ]], 1 ];
        pad    = Developer`ToPackedArray @ PadRight[ #1, width ] &;
        square = Developer`ToPackedArray[ pad /@ flat ];
        data   = SortBy[ square, #[[ 2 ]] & ];
        setPreferences @ data;
        data
    ];

fromCompactRawData // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*compactFitFitnessDataQ*)
compactFitFitnessDataQ // ClearAll;

compactFitFitnessDataQ[ HoldPattern @ FitnessData[ as_Association, ___ ] ] :=
    compactFitFitnessDataQ @ as;

compactFitFitnessDataQ[ KeyValuePattern @ {
    "Format"     -> "FIT",
    "DataFormat" -> "FITCompact",
    "Data"       -> _Association
} ] := True;

compactFitFitnessDataQ[ ___ ] := False;

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Footer*)
End[ ];
EndPackage[ ];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "RH`ComputationalFitness`FIT`" ];
Needs[ "RH`ComputationalFitness`" ];
Needs[ "RH`ComputationalFitness`Package`" ];
Begin[ "`Private`" ];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Global Values*)
setIfUndefined[ $FunctionalThresholdPower, Automatic ];
setIfUndefined[ $MaximumHeartRate        , Automatic ];
setIfUndefined[ $Sport                   , Automatic ];
setIfUndefined[ $Weight                  , Automatic ];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Config*)
$timeOffset               = 0;
$ftp                      = Automatic;
$maxHR                    = Automatic;
$weight                   = Automatic;
$sport                    = Automatic;
$fileByteCount            = 0;
$pzPlotWidth              = 650;
$invalidSINT16            = $fitInitValues[ "SignedInteger16"    ];
$invalidSINT32            = $fitInitValues[ "SignedInteger32"    ];
$invalidSINT8             = $fitInitValues[ "SignedInteger8"     ];
$invalidUINT16            = $fitInitValues[ "UnsignedInteger16"  ];
$invalidUINT16Z           = $fitInitValues[ "UnsignedInteger16z" ];
$invalidUINT32            = $fitInitValues[ "UnsignedInteger32"  ];
$invalidUINT32Z           = $fitInitValues[ "UnsignedInteger32z" ];
$invalidUINT8             = $fitInitValues[ "UnsignedInteger8"   ];
$invalidUINT8Z            = $fitInitValues[ "UnsignedInteger8z"  ];
$invalidFLOAT32           = -9223372036854775808;
$invalidFLOAT64           = -9223372036854775808;
$invalidBool              = 255;
$invalidEnum              = 255;
$invalidTimestamp         = 2840036399|2840036400|7135003695;
$fitTerm                  = 1685024357;
$powerZoneThresholds      = { 0.05, 0.55, 0.75, 0.9, 1.05, 1.2, 1.5 };
$fitMessageTensorRowWidth = $fitConfig[ "MessageTensorRowWidth" ];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Option Settings*)
$ftp := Automatic;

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
$units            := <| |>;

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Argument patterns*)
$$string        = _String? StringQ;
$$bytes         = _ByteArray? ByteArrayQ;
$$assoc         = _Association? AssociationQ;
$$file          = File[ $$string ];
$$url           = URL[ $$string ];
$$co            = HoldPattern[ CloudObject ][ $$string, OptionsPattern[ ] ];
$$lo            = HoldPattern[ LocalObject ][ $$string, OptionsPattern[ ] ];
$$resp          = HoldPattern[ HTTPResponse ][ $$bytes, $$assoc, OptionsPattern[ ] ];
$$source        = $$string | $$file | $$url | $$co | $$lo | $$resp;
$$fitRecordKeys = _? fitRecordKeyQ  | { ___? fitRecordKeyQ  };
$$fitEventKeys  = _? fitEventKeyQ | { ___? fitEventKeyQ };
$$elements      = _? elementQ | { ___? elementQ };
$$prop          = _? fitEventKeyQ | _? fitRecordKeyQ | _? elementQ;
$$propList      = { $$prop... };
$$props         = $$prop | $$propList;
$$messageType   = _? messageTypeQ;
$$messageTypes  = $$messageType | { $$messageType... };
$$pluralMessage = "Events"|"Records"|"Laps"|"WorkoutSteps";
$$powerZone     = 1|2|3|4|5|6|7;

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Properties*)

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Import Elements*)
$fitElements // ClearAll;
$fitElements = {
    "Data",
    "Dataset",
    "Elements",
    "Events",
    "RawData",
    "Records",
    "MessageInformation",
    "FileType",
    "MessageData",
    "Messages",
    "PowerZonePlot",
    "AveragePowerPhasePlot",
    "CriticalPowerCurvePlot"
};

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*FIT Message Types*)
$messageTypes // ClearAll;
$messageTypes := $messageTypes = Keys @ $FITMessageDefinitions;

$supportedMessageTypes // ClearAll;
$supportedMessageTypes = {
    "AccelerometerData",
    "Activity",
    "DeveloperDataID",
    "DeviceInformation",
    "DeviceSettings",
    "Event",
    "FieldDescription",
    "FileCreator",
    "FileID",
    "HeartRateVariability",
    "Lap",
    "Record",
    "Session",
    "Sport",
    "TrainingFile",
    "UserProfile",
    "Workout",
    "WorkoutStep",
    "ZonesTarget",
    Nothing
};

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*FIT Message Keys*)
fitKeys // beginDefinition;
fitKeys[ "MessageInformation" ] := $fitMessageInformationKeys;
fitKeys[ name_                ] := makeFitKeys @ name;
fitKeys // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Key Customization*)
$preferredKeyOrder = <| |>;
$ignoredKeys       = <| |>;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Lap*)
$preferredKeyOrder[ "Lap" ] = {
    "Timestamp",
    "StartTime",
    "StartPosition",
    "EndPosition",
    Inherited
};

$ignoredKeys[ "Lap" ] = {
    "AverageFractionalCadence",
    "EndPositionLatitude",
    "EndPositionLongitude",
    "EnhancedAverageAltitude",
    "EnhancedAverageSpeed",
    "EnhancedMaximumAltitude",
    "EnhancedMaximumSpeed",
    "EnhancedMinimumAltitude",
    "MaximumFractionalCadence",
    "StartPositionLatitude",
    "StartPositionLongitude",
    "TotalFractionalCycles",
    Nothing
};

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Record*)
$preferredKeyOrder[ "Record" ] = {
    "Timestamp",
    "GeoPosition",
    "Distance",
    "Altitude",
    "Speed",
    "Cadence",
    "Power",
    "PowerZone",
    "HeartRate",
    "HeartRateZone",
    Inherited,
    "LeftPowerPhaseStart",
    "LeftPowerPhaseEnd",
    "LeftPowerPhasePeakStart",
    "LeftPowerPhasePeakEnd",
    "RightPowerPhaseStart",
    "RightPowerPhaseEnd",
    "RightPowerPhasePeakStart",
    "RightPowerPhasePeakEnd",
    "CompressedAccumulatedPower",
    "CompressedSpeedDistance",
    "Cadence256",
    "Time128",
    "Speed1S",
    Nothing
};

$ignoredKeys[ "Record" ] = {
    "AverageFractionalCadence",
    "EndPositionLatitude",
    "EndPositionLongitude",
    "EnhancedAltitude",
    "EnhancedAverageAltitude",
    "EnhancedAverageSpeed",
    "EnhancedMaximumAltitude",
    "EnhancedMaximumSpeed",
    "EnhancedMinimumAltitude",
    "EnhancedSpeed",
    "FractionalCadence",
    "LeftPowerPhase",
    "LeftPowerPhasePeak",
    "MaximumFractionalCadence",
    "PositionLatitude",
    "PositionLongitude",
    "RightPowerPhase",
    "RightPowerPhasePeak",
    "StartPositionLatitude",
    "StartPositionLongitude",
    "TotalFractionalCycles",
    Nothing
};

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Session*)
$preferredKeyOrder[ "Session" ] = {
    "Sport",
    "SubSport",
    "Timestamp",
    "StartTime",
    "StartPosition",
    "GeoBoundingBox",
    Inherited,
    "TotalAerobicTrainingEffect",
    "TotalAerobicTrainingEffectDescription",
    "TotalAnaerobicTrainingEffect",
    "TotalAnaerobicTrainingEffectDescription",
    "AverageLeftPowerPhaseStart",
    "AverageLeftPowerPhaseEnd",
    "AverageLeftPowerPhasePeakStart",
    "AverageLeftPowerPhasePeakEnd",
    "AverageRightPowerPhaseStart",
    "AverageRightPowerPhaseEnd",
    "AverageRightPowerPhasePeakStart",
    "AverageRightPowerPhasePeakEnd",
    Nothing
};

$ignoredKeys[ "Session" ] = {
    "EnhancedAverageAltitude",
    "AverageFractionalCadence",
    "AverageLeftPowerPhase",
    "AverageLeftPowerPhasePeak",
    "AverageRightPowerPhase",
    "AverageRightPowerPhasePeak",
    "EnhancedAverageSpeed",
    "NorthEastCornerLatitude",
    "NorthEastCornerLongitude",
    "SouthWestCornerLatitude",
    "SouthWestCornerLongitude",
    "EnhancedMaximumAltitude",
    "MaximumFractionalCadence",
    "EnhancedMaximumSpeed",
    "EnhancedMinimumAltitude",
    "StartPositionLatitude",
    "StartPositionLongitude",
    "TotalTrainingEffect",
    "TotalFractionalAscent",
    "TotalFractionalDescent",
    "TotalFractionalCycles",
    Nothing
};

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*TrainingFile*)
$preferredKeyOrder[ "TrainingFile" ] = {
    "Type",
    "Timestamp",
    "TimeCreated",
    "Manufacturer",
    "ProductName",
    "Product",
    Inherited,
    Nothing
};

$ignoredKeys[ "TrainingFile" ] = {
    Nothing
};

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*WorkoutStep*)
$preferredKeyOrder[ "WorkoutStep" ] = {
    "WorkoutStepName",
    "Duration",
    "Target",
    "Intensity",
    "DurationType",
    "TargetType",
    "Notes",
    "MessageIndex",
    Inherited,
    "CustomTargetValueLow",
    "CustomTargetValueHigh",
    Nothing
};

$ignoredKeys[ "WorkoutStep" ] = {
    "DurationValue",
    "TargetValue",
    Nothing
};

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*$fitDefaultKeys*)
$fitDefaultKeys // ClearAll;
$fitDefaultKeys = {
    "MessageType",
    "RawData",
    Nothing
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
    "Supported",
    Nothing
};

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*makeFitKeys*)
makeFitKeys // beginDefinition;

makeFitKeys[ name_String ] :=
    With[ { keys = makeFitKeys0 @ name },
        (makeFitKeys[ name ] = keys) /; MatchQ[ keys, { __String } ]
    ];

makeFitKeys // endDefinition;


makeFitKeys0 // beginDefinition;

makeFitKeys0[ name_String ] :=
    Enclose @ Module[ { ignore, default, preferred, expanded, flat },
        ignore    = ConfirmMatch[ Lookup[ $ignoredKeys, name, { } ], { ___String } ];
        default   = ConfirmMatch[ DeleteCases[ defaultFitKeys @ name, Alternatives @@ ignore ],
                                  { __String }
                    ];
        preferred = ConfirmMatch[ Lookup[ $preferredKeyOrder, name, { Inherited } ],
                                  { (_String|Inherited)... }
                    ];
        expanded  = ReplaceAll[ preferred, Inherited -> default ];
        flat      = Flatten @ { "MessageType", expanded, default };
        DeleteCases[ DeleteDuplicates @ flat, Alternatives @@ ignore ]
    ];

makeFitKeys0 // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*defaultFitKeys*)
defaultFitKeys // ClearAll;
defaultFitKeys[ a___ ] := defaultFitKeys[ a ] = defaultFitKeys0 @ a;

defaultFitKeys0 // beginDefinition;
defaultFitKeys0[ name_String ] := defaultFitKeys[ name, $fitIndex[ name ] ];
defaultFitKeys0[ name_, as_Association ] := Prepend[ Keys @ as, "MessageType" ];
defaultFitKeys0[ name_, _Missing ] := $fitDefaultKeys;
defaultFitKeys0 // endDefinition;

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Argument Validation*)

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
(*supportedMessageTypeQ*)
supportedMessageTypeQ[ type_String ] := MemberQ[ $supportedMessageTypes, type ];
supportedMessageTypeQ[ ___         ] := False;

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Footer*)
End[ ];
EndPackage[ ];

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
(* cSpell:ignore ifit *)
BeginPackage[ "RickHennigan`ComputationalFitness`FIT`" ];
Needs[ "RickHennigan`ComputationalFitness`" ];
Needs[ "RickHennigan`ComputationalFitness`Package`" ];
Begin[ "`Private`" ];

$ContextAliases[ "dev`" ] = "Developer`";
$ContextAliases[ "int`" ] = "Internal`";

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*FITInterpreter*)
FITInterpreter // beginDefinition;

FITInterpreter[ spec_ ] := FITInterpreter[ spec ] =
    Block[ { $Context = $fitContext, $ContextPath = { $fitContext, "System`" } },
        makeInterpreter @ spec
    ];

FITInterpreter // endExportedDefinition;

$fitContext = $Context;

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Definition Utilities*)

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*indexTranslate*)
indexTranslate // beginDefinition;

indexTranslate[ name_String, sym_Symbol ] :=
    catchTop @ Block[ { $usedIndices = Internal`Bag[ ] },

        DownValues[ sym ] =
            ReplaceAll[
                DownValues @ sym,
                HoldPattern[ part_Part ] :>
                    With[ { replaced = indexTranslatePart[ name, part ] },
                        RuleCondition[ replaced, True ]
                    ]
            ];

        If[ $debug && ! MemberQ[ Internal`BagPart[ $generatedDefinitions, All ], HoldComplete @ sym ],
            Replace[
                Complement[
                    Keys @ $fitIndex @ name,
                    Internal`BagPart[ $usedIndices, All ]
                ],
                { keys__ } :>
                    messageFailure[
                        "UnusedIndices",
                        name,
                        HoldForm @ { keys }
                    ]
            ];
            checkKeyCoverage[ name, sym ]
        ]
    ];

indexTranslate // endDefinition;
indexTranslate // excludeFromMX;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*indexTranslatePart*)
indexTranslatePart // beginDefinition;
indexTranslatePart // Attributes = { HoldRest };

indexTranslatePart[ name_, expr_ ] :=
    ReplaceAll[
        $ConditionHold @ expr,
        s_String :>
            With[ { i = $fitIndex[ name, s ] },
                i /; If[ MissingQ @ i,

                         If[ $debug,
                             messageFailure[
                                 "IndexTranslation",
                                 name,
                                 s,
                                 HoldForm @ expr
                             ]
                         ];

                         False,

                         Internal`StuffBag[ $usedIndices, s ];
                         True
                     ]
            ]
    ];

indexTranslatePart // endDefinition;
indexTranslatePart // excludeFromMX;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*checkKeyCoverage*)
checkKeyCoverage // beginDefinition;

checkKeyCoverage[ keysName_, sym_ ] :=
    Module[ { keys, dv, used, keysMissingDef, defMissingKeys },
        keys = fitKeys @ keysName;
        dv = DownValues @ sym;

        used =
            Cases[
                dv,
                HoldPattern[ Verbatim[
                    HoldPattern
                ][ sym[ k_String, _ ] ] :> _ ] :> k
            ];

        keysMissingDef = DeleteCases[
            DeleteCases[ keys, Alternatives @@ used ],
            "MessageType"
        ];

        defMissingKeys = DeleteCases[ used, Alternatives @@ keys ];

        If[ MatchQ[ keysMissingDef, { __ } ],
            messagePrint[
                "KeysMissingDefinitions",
                keysName,
                sym,
                HoldForm @ Evaluate @ keysMissingDef
            ]
        ];

        If[ MatchQ[ defMissingKeys, { __ } ],
            messagePrint[
                "DefinitionsMissingKeys",
                keysName,
                sym,
                HoldForm @ Evaluate @ defMissingKeys
            ]
        ];
    ];

checkKeyCoverage // endDefinition;
checkKeyCoverage // excludeFromMX;

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Values*)

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Definition Generation*)

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Unsupported Messages*)
$generatedDefinitions = Internal`Bag[ ];
$generatedDefinitions // excludeFromMX;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsubsection::Closed:: *)
(*makeInterpreter*)
makeInterpreter // beginDefinition;
makeInterpreter[ { s_String, a_String } ] := Symbol[ s ][ a ];
makeInterpreter[ { "fitQuantity", s_String, units_, a___ } ] := fitQuantity[ Symbol @ s, units, a ];
makeInterpreter[ s_String ] := Symbol @ s;
makeInterpreter // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsubsection::Closed:: *)
(*makeInverter*)
makeInverter // beginDefinition;
makeInverter[ { s_String, a_String } ] := Symbol[ "i" <> s ][ a ];
makeInverter[ { "fitQuantity", s_String, units_, a___ } ] := ifitQuantity[ Symbol[ "i" <> s ], units, a ];
makeInverter[ s_String ] := Symbol[ "i" <> s ];
makeInverter // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsubsection::Closed:: *)
(*setFieldDefinitions*)
setFieldDefinitions // beginDefinition;

setFieldDefinitions[ name_String ] :=
    setFieldDefinitions[ Symbol[ "fit$" <> name <> "$Value" ], name ];

setFieldDefinitions[ valueSym_Symbol, name_String ] :=
    setFieldDefinitions[ valueSym, Symbol[ "ifit$" <> name <> "$Value" ], name ];

setFieldDefinitions[ valueSym_Symbol, inverterSym_Symbol, name_String ] :=
    setFieldDefinitions[ valueSym, inverterSym, name, $FITMessageDefinitions[ name, "Fields" ] ];

setFieldDefinitions[ valueSym_Symbol, inverterSym_Symbol, name_String, defs_Association ] := (
    fitValue[ name, field_, value_ ] :=
        valueSym[ field, value ];

    ifitValue[ name, field_, dimensions_, message_ ] :=
        inverterSym[ field, dimensions, message ];

    valueSym // ClearAll;
    Scan[
        Function @ With[
            {
                int = makeInterpreter @ #Interpreter,
                idx = #Index
            },
            valueSym[ #FieldName, vv_ ] := int @ vv[[ idx ]]
        ],
        defs
    ];
    valueSym[ ___ ] := Missing[ "NotAvailable" ];

    inverterSym // ClearAll;

    inverterSym[ field_, dimensions_, message_Association ] :=
        inverterSym[ field, dimensions, message @ field ];

    Scan[
        Function @ With[
            {
                inverter   = makeInverter @ #Interpreter,
                dimensions = #Dimensions
            },
            If[ dimensions === { },
                inverterSym[ #FieldName, { }, xx_ ] := inverter @ xx,
                inverterSym[ #FieldName, { nn_ }, xx_ ] := inverter[ xx, nn ]
            ]
        ],
        defs
    ];
    inverterSym[ ___ ] := $Failed;

    Internal`StuffBag[ $generatedDefinitions, HoldComplete @ valueSym    ];
    Internal`StuffBag[ $generatedDefinitions, HoldComplete @ inverterSym ];
);

setFieldDefinitions // endDefinition;
setFieldDefinitions // excludeFromMX;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*fitValue*)
fitValue // ClearAll;
fitValue[ type_, "MessageType", v_ ] := type;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*ifitValue*)
ifitValue // ClearAll;
ifitValue[ type_, "MessageType", { }, v_ ] := fitMessageTypeNumber @ type;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Generate Definitions*)
setFieldDefinitions /@ Complement[ Keys @ $FITMessageDefinitions, $supportedMessageTypes ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*FileID*)
setFieldDefinitions[ fitFileIDValue, ifitFileIDValue, "FileID" ];
fitFileIDValue[ "ProductName", v_ ] := fitProductName[ v[[ { "Manufacturer", "Product" } ]], v[[ "ProductName" ]] ];
indexTranslate[ "FileID", fitFileIDValue ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*UserProfile*)
setFieldDefinitions[ fitUserProfileValue, ifitUserProfileValue, "UserProfile" ];

fitUserProfileValue[ "GlobalID"             , v_ ] := fitGlobalID @ v[[ "GlobalID" ]];
fitUserProfileValue[ "Height"               , v_ ] := fitHeight @ v[[ "Height" ]];
fitUserProfileValue[ "UserRunningStepLength", v_ ] := fitStepLength @ v[[ "UserRunningStepLength" ]];
fitUserProfileValue[ "UserWalkingStepLength", v_ ] := fitStepLength @ v[[ "UserWalkingStepLength" ]];

ifitUserProfileValue[ "GlobalID"             , { n_ }, v_ ] := ifitGlobalID[ v, n ];
ifitUserProfileValue[ "Height"               , {    }, v_ ] := ifitHeight @ v;
ifitUserProfileValue[ "UserRunningStepLength", {    }, v_ ] := ifitStepLength @ v;
ifitUserProfileValue[ "UserWalkingStepLength", {    }, v_ ] := ifitStepLength @ v;

indexTranslate[ "UserProfile", fitUserProfileValue ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Activity*)
setFieldDefinitions[ fitActivityValue, ifitActivityValue, "Activity" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Lap*)
setFieldDefinitions[ fitLapValue, ifitLapValue, "Lap" ];

fitLapValue[ "StartPosition"   , v_ ] := fitGeoPosition @ v[[ { "StartPositionLatitude", "StartPositionLongitude" } ]];
fitLapValue[ "EndPosition"     , v_ ] := fitGeoPosition @ v[[ { "EndPositionLatitude", "EndPositionLongitude" } ]];
fitLapValue[ "TotalCycles"     , v_ ] := fitCycles32[ v[[ "TotalCycles" ]], v[[ "TotalFractionalCycles" ]] ];
fitLapValue[ "AverageSpeed"    , v_ ] := fitSpeedSelect[ v[[ "EnhancedAverageSpeed" ]], v[[ "AverageSpeed" ]] ];
fitLapValue[ "MaximumSpeed"    , v_ ] := fitSpeedSelect[ v[[ "EnhancedMaximumSpeed" ]], v[[ "MaximumSpeed" ]] ];
fitLapValue[ "LeftRightBalance", v_ ] := fitLeftRightBalance100 @ v[[ "LeftRightBalance" ]];
fitLapValue[ "AverageAltitude" , v_ ] := fitAltitudeSelect[ v[[ "EnhancedAverageAltitude" ]], v[[ "AverageAltitude" ]] ];
fitLapValue[ "MaximumAltitude" , v_ ] := fitAltitudeSelect[ v[[ "EnhancedMaximumAltitude" ]], v[[ "MaximumAltitude" ]] ];
fitLapValue[ "MinimumAltitude" , v_ ] := fitAltitudeSelect[ v[[ "EnhancedMinimumAltitude" ]], v[[ "MinimumAltitude" ]] ];
fitLapValue[ "StrokeCount"     , v_ ] := fitStrokeCount @ v[[ "StrokeCount" ]];
fitLapValue[ "AverageCadence"  , v_ ] := fitCadence[ v[[ "AverageCadence" ]], v[[ "AverageFractionalCadence" ]] ];
fitLapValue[ "MaximumCadence"  , v_ ] := fitCadence[ v[[ "MaximumCadence" ]], v[[ "MaximumFractionalCadence" ]] ];

ifitLapValue[ "StartPositionLatitude"   , { }, as_Association ] := ifitPositionLatitude @ as[ "GeoPosition" ];
ifitLapValue[ "StartPositionLongitude"  , { }, as_Association ] := ifitPositionLongitude @ as[ "GeoPosition" ];
ifitLapValue[ "EndPositionLatitude"     , { }, as_Association ] := ifitPositionLatitude @ as[ "GeoPosition" ];
ifitLapValue[ "EndPositionLongitude"    , { }, as_Association ] := ifitPositionLongitude @ as[ "GeoPosition" ];
ifitLapValue[ "TotalFractionalCycles"   , { }, as_Association ] := ifitFractionalCycles @ as[ "TotalCycles" ];
ifitLapValue[ "EnhancedAverageSpeed"    , { }, as_Association ] := ifitQuantity[ fitUINT32, "MetersPerSecond", 1000, 0 ] @ as[ "AverageSpeed" ];
ifitLapValue[ "EnhancedMaximumSpeed"    , { }, as_Association ] := ifitQuantity[ fitUINT32, "MetersPerSecond", 1000, 0 ] @ as[ "MaximumSpeed" ];
ifitLapValue[ "LeftRightBalance"        , { }, as_Association ] := ifitLeftRightBalance @ as[ "LeftRightBalance" ];
ifitLapValue[ "EnhancedAverageAltitude" , { }, as_Association ] := ifitQuantity[ fitUINT32, "Meters", 5, 500 ] @ as[ "AverageAltitude" ];
ifitLapValue[ "EnhancedMaximumAltitude" , { }, as_Association ] := ifitQuantity[ fitUINT32, "Meters", 5, 500 ] @ as[ "MaximumAltitude" ];
ifitLapValue[ "EnhancedMinimumAltitude" , { }, as_Association ] := ifitQuantity[ fitUINT32, "Meters", 5, 500 ] @ as[ "MinimumAltitude" ];
ifitLapValue[ "StrokeCount"             , { }, as_Association ] := ifitStrokeCount @ as[ "StrokeCount" ];
ifitLapValue[ "AverageFractionalCadence", { }, as_Association ] := ifitFractionalCadence @ as[ "AverageCadence" ];
ifitLapValue[ "MaximumFractionalCadence", { }, as_Association ] := ifitFractionalCadence @ as[ "MaximumCadence" ];

indexTranslate[ "Lap", fitLapValue ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*DeviceSettings*)
setFieldDefinitions[ fitDeviceSettingsValue, ifitDeviceSettingsValue, "DeviceSettings" ];
fitDeviceSettingsValue[ "TimeOffset", v_ ] := fitTimeOffset @ v[[ "TimeOffset" ]];
ifitDeviceSettingsValue[ "TimeOffset", { n_ }, v_ ] := ifitTimeOffset[ v, n ];
indexTranslate[ "DeviceSettings", fitDeviceSettingsValue ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Record*)
setFieldDefinitions[ fitRecordValue, ifitRecordValue, "Record" ];

fitRecordValue[ "AccumulatedPower"          , v_ ] := fitQuantity[ fitUINT32, "Joules", 1, 0 ] @ v[[ "AccumulatedPower" ]];
fitRecordValue[ "Altitude"                  , v_ ] := fitAltitudeSelect[ v[[ "EnhancedAltitude" ]], v[[ "Altitude" ]] ];
fitRecordValue[ "Cadence"                   , v_ ] := fitCadence[ v[[ "Cadence" ]], v[[ "FractionalCadence" ]] ];
fitRecordValue[ "CompressedAccumulatedPower", v_ ] := fitQuantity[ fitUINT16, "Joules", 1, 0 ] @ v[[ "CompressedAccumulatedPower" ]];
fitRecordValue[ "GeoPosition"               , v_ ] := fitGeoPosition @ v[[ { "PositionLatitude", "PositionLongitude" } ]];
fitRecordValue[ "HeartRateZone"             , v_ ] := fitHeartRateZone @ v[[ "HeartRate" ]];
fitRecordValue[ "LeftPowerPhaseEnd"         , v_ ] := fitPowerPhase @ v[[ "LeftPowerPhase" ]][[ -1 ]];
fitRecordValue[ "LeftPowerPhasePeakEnd"     , v_ ] := fitPowerPhase @ v[[ "LeftPowerPhasePeak" ]][[ -1 ]];
fitRecordValue[ "LeftPowerPhasePeakStart"   , v_ ] := fitPowerPhase @ v[[ "LeftPowerPhasePeak" ]][[ 1 ]];
fitRecordValue[ "LeftPowerPhaseStart"       , v_ ] := fitPowerPhase @ v[[ "LeftPowerPhase" ]][[ 1 ]];
fitRecordValue[ "LeftRightBalance"          , v_ ] := fitLeftRightBalance @ v[[ "LeftRightBalance" ]];
fitRecordValue[ "PowerZone"                 , v_ ] := fitPowerZone @ v[[ "Power" ]];
fitRecordValue[ "Resistance"                , v_ ] := fitResistance @ v[[ "Resistance" ]];
fitRecordValue[ "RightPowerPhaseEnd"        , v_ ] := fitPowerPhase @ v[[ "RightPowerPhase" ]][[ -1 ]];
fitRecordValue[ "RightPowerPhasePeakEnd"    , v_ ] := fitPowerPhase @ v[[ "RightPowerPhasePeak" ]][[ -1 ]];
fitRecordValue[ "RightPowerPhasePeakStart"  , v_ ] := fitPowerPhase @ v[[ "RightPowerPhasePeak" ]][[ 1 ]];
fitRecordValue[ "RightPowerPhaseStart"      , v_ ] := fitPowerPhase @ v[[ "RightPowerPhase" ]][[ 1 ]];
fitRecordValue[ "Speed"                     , v_ ] := fitSpeedSelect[ v[[ "EnhancedSpeed" ]], v[[ "Speed" ]] ];


ifitRecordValue[ "AccumulatedPower"          , { }, v_ ] := ifitQuantity[ fitUINT32, "Joules", 1, 0 ] @ v;
ifitRecordValue[ "Altitude"                  , { }, v_ ] := ifitAltitude @ v;
ifitRecordValue[ "Cadence"                   , { }, v_ ] := ifitCadence @ v;
ifitRecordValue[ "CompressedAccumulatedPower", { }, v_ ] := ifitQuantity[ fitUINT16, "Joules", 1, 0 ] @ v;
ifitRecordValue[ "LeftRightBalance"          , { }, v_ ] := ifitLeftRightBalance @ v;
ifitRecordValue[ "Resistance"                , { }, v_ ] := ifitResistance @ v;

ifitRecordValue[ "EnhancedAltitude"   , { }, as_Association ] := ifitQuantity[ fitUINT32, "Meters", 5, 500 ] @ as[ "Altitude" ];
ifitRecordValue[ "EnhancedSpeed"      , { }, as_Association ] := ifitQuantity[ fitUINT32, "MetersPerSecond", 1000, 0 ] @ as[ "Speed" ];
ifitRecordValue[ "FractionalCadence"  , { }, as_Association ] := ifitFractionalCadence @ as[ "Cadence" ];
ifitRecordValue[ "PositionLatitude"   , { }, as_Association ] := ifitPositionLatitude @ as[ "GeoPosition" ];
ifitRecordValue[ "PositionLongitude"  , { }, as_Association ] := ifitPositionLongitude @ as[ "GeoPosition" ];
ifitRecordValue[ "LeftPowerPhase"     , { }, as_Association ] := ifitPowerPhase[ as[ "LeftPowerPhaseStart"      ], as[ "LeftPowerPhaseEnd"      ] ];
ifitRecordValue[ "LeftPowerPhasePeak" , { }, as_Association ] := ifitPowerPhase[ as[ "LeftPowerPhasePeakStart"  ], as[ "LeftPowerPhasePeakEnd"  ] ];
ifitRecordValue[ "RightPowerPhase"    , { }, as_Association ] := ifitPowerPhase[ as[ "RightPowerPhaseStart"     ], as[ "RightPowerPhaseEnd"     ] ];
ifitRecordValue[ "RightPowerPhasePeak", { }, as_Association ] := ifitPowerPhase[ as[ "RightPowerPhasePeakStart" ], as[ "RightPowerPhasePeakEnd" ] ];

(* FIXME: define
    ifitLeftRightBalance
    ifitResistance
    ifitPowerPhase
    ifitCycles
*)

indexTranslate[ "Record", fitRecordValue ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Event*)
setFieldDefinitions[ fitEventValue, ifitEventValue, "Event" ];

(* TODO: convert stance events using the "RiderPositionType" enum *)

fitEventValue[ "RadarThreatLevelMaximum", v_ ] := fitRadarThreatLevelType @ v[[ "RadarThreatLevelMaximum" ]];

(* FIXME: define ifitEventValue *)

indexTranslate[ "Event", fitEventValue ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*DeviceInformation*)
setFieldDefinitions[ fitDeviceInformationValue, ifitDeviceInformationValue, "DeviceInformation" ];

fitDeviceInformationValue[ "DeviceType" , v_ ] := fitEnum[ "ANTPlusDeviceType" ][ v[[ "DeviceType" ]] ];
fitDeviceInformationValue[ "ProductName", v_ ] := fitProductName[ v[[ { "Manufacturer", "Product" } ]], v[[ "ProductName" ]] ];

ifitDeviceInformationValue[ "DeviceType", { }, x_ ] := ifitEnum[ "ANTPlusDeviceType" ][ x ];

indexTranslate[ "DeviceInformation", fitDeviceInformationValue ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Session*)
setFieldDefinitions[ fitSessionValue, ifitSessionValue, "Session" ];

fitSessionValue[ "AverageAltitude"                        , v_ ] := fitAltitudeSelect[ v[[ "EnhancedAverageAltitude" ]], v[[ "AverageAltitude" ]] ];
fitSessionValue[ "AverageCadence"                         , v_ ] := fitCadence[ v[[ "AverageCadence" ]], v[[ "AverageFractionalCadence" ]] ];
fitSessionValue[ "AverageLeftPowerPhaseEnd"               , v_ ] := fitPowerPhase @ v[[ "AverageLeftPowerPhase" ]][[ -1 ]];
fitSessionValue[ "AverageLeftPowerPhasePeakEnd"           , v_ ] := fitPowerPhase @ v[[ "AverageLeftPowerPhasePeak" ]][[ -1 ]];
fitSessionValue[ "AverageLeftPowerPhasePeakStart"         , v_ ] := fitPowerPhase @ v[[ "AverageLeftPowerPhasePeak" ]][[ 1 ]];
fitSessionValue[ "AverageLeftPowerPhaseStart"             , v_ ] := fitPowerPhase @ v[[ "AverageLeftPowerPhase" ]][[ 1 ]];
fitSessionValue[ "AverageRightPowerPhaseEnd"              , v_ ] := fitPowerPhase @ v[[ "AverageRightPowerPhase" ]][[ -1 ]];
fitSessionValue[ "AverageRightPowerPhasePeakEnd"          , v_ ] := fitPowerPhase @ v[[ "AverageRightPowerPhasePeak" ]][[ -1 ]];
fitSessionValue[ "AverageRightPowerPhasePeakStart"        , v_ ] := fitPowerPhase @ v[[ "AverageRightPowerPhasePeak" ]][[ 1 ]];
fitSessionValue[ "AverageRightPowerPhaseStart"            , v_ ] := fitPowerPhase @ v[[ "AverageRightPowerPhase" ]][[ 1 ]];
fitSessionValue[ "AverageSpeed"                           , v_ ] := fitSpeedSelect[ v[[ "EnhancedAverageSpeed" ]], v[[ "AverageSpeed" ]] ];
fitSessionValue[ "GeoBoundingBox"                         , v_ ] := fitGeoBoundingBox @ v[[ { "NorthEastCornerLatitude", "NorthEastCornerLongitude", "SouthWestCornerLatitude", "SouthWestCornerLongitude" } ]];
fitSessionValue[ "IntensityFactor"                        , v_ ] := fitIntensityFactor @ v[[ "IntensityFactor" ]];
fitSessionValue[ "LeftRightBalance"                       , v_ ] := fitLeftRightBalance100 @ v[[ "LeftRightBalance" ]];
fitSessionValue[ "MaximumAltitude"                        , v_ ] := fitAltitudeSelect[ v[[ "EnhancedMaximumAltitude" ]], v[[ "MaximumAltitude" ]] ];
fitSessionValue[ "MaximumCadence"                         , v_ ] := fitCadence[ v[[ "MaximumCadence" ]], v[[ "MaximumFractionalCadence" ]] ];
fitSessionValue[ "MaximumSpeed"                           , v_ ] := fitSpeedSelect[ v[[ "EnhancedMaximumSpeed" ]], v[[ "MaximumSpeed" ]] ];
fitSessionValue[ "MessageIndex"                           , v_ ] := fitMessageIndex @ v[[ "MessageIndex" ]];
fitSessionValue[ "MinimumAltitude"                        , v_ ] := fitAltitudeSelect[ v[[ "EnhancedMinimumAltitude" ]], v[[ "MinimumAltitude" ]] ];
fitSessionValue[ "StartPosition"                          , v_ ] := fitGeoPosition @ v[[ { "StartPositionLatitude", "StartPositionLongitude" } ]];
fitSessionValue[ "StrokeCount"                            , v_ ] := fitStrokeCount @ v[[ "StrokeCount" ]];
fitSessionValue[ "TotalAerobicTrainingEffect"             , v_ ] := fitTrainingEffect @ v[[ "TotalTrainingEffect" ]];
fitSessionValue[ "TotalAerobicTrainingEffectDescription"  , v_ ] := fitTrainingEffectDescription @ v[[ "TotalTrainingEffect" ]];
fitSessionValue[ "TotalAnaerobicTrainingEffect"           , v_ ] := fitTrainingEffect @ v[[ "TotalAnaerobicTrainingEffect" ]];
fitSessionValue[ "TotalAnaerobicTrainingEffectDescription", v_ ] := fitTrainingEffectDescription @ v[[ "TotalAnaerobicTrainingEffect" ]];
fitSessionValue[ "TotalAscent"                            , v_ ] := fitAscent[ v[[ "TotalAscent" ]], v[[ "TotalFractionalAscent" ]] ];
fitSessionValue[ "TotalCycles"                            , v_ ] := fitCycles32[ v[[ "TotalCycles" ]], v[[ "TotalFractionalCycles" ]] ];
fitSessionValue[ "TotalDescent"                           , v_ ] := fitAscent[ v[[ "TotalDescent" ]], v[[ "TotalFractionalDescent" ]] ];
fitSessionValue[ "TrainingStressScore"                    , v_ ] := fitTrainingStressScore @ v[[ "TrainingStressScore" ]];

(* FIXME: define ifitSessionValue *)

indexTranslate[ "Session", fitSessionValue ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*ZonesTarget*)
setFieldDefinitions[ fitZonesTargetValue, ifitZonesTargetValue, "ZonesTarget" ];

fitZonesTargetValue[ "FunctionalThresholdPower", v_ ] := fitFTPSetting @ v[[ "FunctionalThresholdPower" ]];
fitZonesTargetValue[ "MaximumHeartRate"        , v_ ] := fitMaxHRSetting @ v[[ "MaximumHeartRate" ]];

ifitZonesTargetValue[ "FunctionalThresholdPower", { }, v_ ] := ifitFTPSetting @ v;
ifitZonesTargetValue[ "MaximumHeartRate"        , { }, v_ ] := ifitMaxHRSetting @ v;

indexTranslate[ "ZonesTarget", fitZonesTargetValue ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*FileCreator*)
setFieldDefinitions[ fitFileCreatorValue, ifitFileCreatorValue, "FileCreator" ];
indexTranslate[ "FileCreator", fitFileCreatorValue ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Sport*)
setFieldDefinitions[ fitSportValue, ifitSportValue, "Sport" ];
indexTranslate[ "Sport", fitSportValue ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*DeveloperDataID*)
setFieldDefinitions[ fitDeveloperDataIDValue, ifitDeveloperDataIDValue, "DeveloperDataID" ];
indexTranslate[ "DeveloperDataID", fitDeveloperDataIDValue ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*FieldDescription*)
setFieldDefinitions[ fitFieldDescriptionValue, ifitFieldDescriptionValue, "FieldDescription" ];
indexTranslate[ "FieldDescription", fitFieldDescriptionValue ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*TrainingFile*)
setFieldDefinitions[ fitTrainingFileValue, ifitTrainingFileValue, "TrainingFile" ];

fitTrainingFileValue[ "ProductName", v_ ] := fitProductName @ v[[ { "Manufacturer", "Product" } ]];

(* FIXME: define ifitTrainingFileValue (maybe?) *)

indexTranslate[ "TrainingFile", fitTrainingFileValue ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*WorkoutStep*)
setFieldDefinitions[ fitWorkoutStepValue, ifitWorkoutStepValue, "WorkoutStep" ];

(* TODO: check against spec defined here https://developer.garmin.com/fit/file-types/workout/ *)

fitWorkoutStepValue[ "CustomTargetValueHigh"         , v_ ] := fitWktTargetValue[ v[[ "CustomTargetValueHigh" ]], v[[ "TargetType" ]] ];
fitWorkoutStepValue[ "CustomTargetValueLow"          , v_ ] := fitWktTargetValue[ v[[ "CustomTargetValueLow" ]], v[[ "TargetType" ]] ];
fitWorkoutStepValue[ "Duration"                      , v_ ] := fitWktDuration[ v[[ "DurationValue" ]], v[[ "DurationType" ]] ];
fitWorkoutStepValue[ "SecondaryCustomTargetValueHigh", v_ ] := fitWktTargetValue[ v[[ "SecondaryCustomTargetValueHigh" ]], v[[ "SecondaryTargetType" ]] ];
fitWorkoutStepValue[ "SecondaryCustomTargetValueLow" , v_ ] := fitWktTargetValue[ v[[ "SecondaryCustomTargetValueLow" ]], v[[ "SecondaryTargetType" ]] ];
fitWorkoutStepValue[ "SecondaryTargetValue"          , v_ ] := fitWktTargetValue[ v[[ "SecondaryTargetValue" ]], v[[ "SecondaryTargetType" ]] ];
fitWorkoutStepValue[ "Target"                        , v_ ] := fitWktTarget[ v[[ "TargetValue" ]], v[[ "CustomTargetValueLow" ]], v[[ "CustomTargetValueHigh" ]], v[[ "TargetType" ]] ];
fitWorkoutStepValue[ "TargetValue"                   , v_ ] := fitWktTargetValue[ v[[ "TargetValue" ]], v[[ "TargetType" ]] ];

(* FIXME: define ifitWorkoutStepValue *)

indexTranslate[ "WorkoutStep", fitWorkoutStepValue ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Workout*)
setFieldDefinitions[ fitWorkoutValue, ifitWorkoutValue, "Workout" ];
indexTranslate[ "Workout", fitWorkoutValue ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*HeartRateVariability*)
setFieldDefinitions[ fitHeartRateVariabilityValue, ifitHeartRateVariabilityValue, "HeartRateVariability" ];
indexTranslate[ "HeartRateVariability", fitHeartRateVariabilityValue ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*AccelerometerData*)
setFieldDefinitions[ fitAccelerometerDataValue, ifitAccelerometerDataValue, "AccelerometerData" ];
indexTranslate[ "AccelerometerData", fitAccelerometerDataValue ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*MessageInformation*)
fitValue[ "MessageInformation", name_, value_ ] := fitMessageInformationValue[ name, value ];

fitMessageInformationValue // ClearAll;
fitMessageInformationValue[ "MessageTypeName", v_ ] := fitMessageType @ v[[ 2 ]];
fitMessageInformationValue[ "MessageIDNumber", v_ ] := v[[ 2 ]];
fitMessageInformationValue[ "MessageSize"    , v_ ] := v[[ 3 ]];
fitMessageInformationValue[ "Supported"      , v_ ] := supportedMessageTypeQ @ fitMessageType @ v[[ 2 ]];
fitMessageInformationValue[ "ByteOrdering"   , v_ ] := fitByteOrder @ v[[ 4 ]];
fitMessageInformationValue[ "FieldCount"     , v_ ] := v[[ 5 ]];
(* fitMessageInformationValue[ "FileOffset"     , v_ ] := fitFileOffset @ v[[ 6 ]]; *)
fitMessageInformationValue[ "MessageIndex"   , v_ ] := v[[ 6 ]];
fitMessageInformationValue[ _                , _  ] := Missing[ "NotAvailable" ];

(* Do not translate index for fitMessageInformationValue *)

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Defaults*)
fitValue[ _, "RawData", v_ ] := fitRawData @ v[[ 2;; ]];
fitValue[ __ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitEnum*)
fitEnum // ClearAll;
fitEnum[ name_ ][ value_ ] := fitEnum0 @ $enumTypeData[ name, value ];
fitEnum[ ___ ][ ___ ] := Missing[ "NotAvailable" ];

fitEnum0[ _Missing ] := Missing[ "NotAvailable" ];
fitEnum0[ v_ ] := v;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*ifitEnum*)
ifitEnum // ClearAll;
ifitEnum[ name_ ][ value_ ] := ifitEnum0[ name, $iEnumTypeData[ name, value ] ];
ifitEnum[ name_ ][ value_, { n_ } ] := ifitEnum1[ name, $iEnumTypeData[ name, value ], n ];

ifitEnum0 // ClearAll;
ifitEnum0[ name_, v_Integer ] := v;
ifitEnum0[ name_, _ ] := Lookup[ $iEnumTypeData @ name, Missing[ "Invalid" ], $invalidEnum ];
ifitEnum0[ ___ ] := $invalidEnum;

ifitEnum1 // ClearAll;
ifitEnum1[ name_, v_Integer, n_Integer ] := ConstantArray[ v, n ];
ifitEnum1[ name_, list_List, n_Integer ] /; Length @ list === n := ifitEnum[ name ] /@ list;
ifitEnum1[ name_, _, n_Integer ] := ConstantArray[ Lookup[ $iEnumTypeData @ name, Missing[ "Invalid" ], $invalidEnum ], n ];
ifitEnum1[ ___ ] := $Failed;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitMissing*)
fitMissing // ClearAll;
fitMissing[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitQuantity*)
fitQuantity // ClearAll;
fitQuantity[ fitMissing, ___ ] := fitMissing;
fitQuantity[ valFunc_, units_ ] := fitQuantity[ valFunc, units, 1 ];
fitQuantity[ valFunc_, units_, scale_ ] := fitQuantity[ valFunc, units, scale, 0 ];
fitQuantity[ valFunc_, units_, scale_, offset_ ][ value_ ] := fitQuantity0[ valFunc @ value, units, scale, offset ];
fitQuantity[ ___ ][ ___ ] := Missing[ "NotAvailable" ];

fitQuantity0 // ClearAll;
fitQuantity0[ m_Missing , _     , _     , _       ] := m;
fitQuantity0[ value_List, units_, 1     , 0       ] := fitQuantity1[ #, units ] & /@ DeleteMissing @ value;
fitQuantity0[ value_List, units_, scale_, offset_ ] := fitQuantity1[ #, units ] & /@ ((1.0 * DeleteMissing @ value - offset) / scale);
fitQuantity0[ value_    , units_, 1     , 0       ] := fitQuantity1[ value, units ];
fitQuantity0[ value_    , units_, scale_, offset_ ] := fitQuantity1[ (1.0 * value - offset) / scale, units ];
fitQuantity0[ ___                                 ] := Missing[ "NotAvailable" ];

fitQuantity1 // ClearAll;
fitQuantity1[ _Missing, _                      ] := Missing[ "NotAvailable" ];
fitQuantity1[ value_  , "Joules"               ] := joulesToQuantity @ value;
fitQuantity1[ value_  , "Grams"                ] := gramsToQuantity @ value;
fitQuantity1[ value_  , "Meters"               ] := metersToQuantity @ value;
fitQuantity1[ value_  , "Pascals"              ] := pascalsToQuantity @ value;
fitQuantity1[ value_  , "MetersPerSecond"      ] := speedQuantity @ value;
fitQuantity1[ value_  , "DegreesCelsius"       ] := temperatureQuantity @ value;
fitQuantity1[ value_  , "Cycles"               ] := cycleQuantity @ value;
fitQuantity1[ value_  , "RevolutionsPerMinute" ] := cadenceQuantity @ value;
fitQuantity1[ value_  , "Seconds"              ] := secondsToQuantity[ 1.0 * value ];
fitQuantity1[ value_  , units_                 ] := Quantity[ value, units ];
fitQuantity1[ ___                              ] := Missing[ "NotAvailable" ];


ifitQuantity // ClearAll;
ifitQuantity[ iFunc_, units_ ] := ifitQuantity[ iFunc, units, 1, 0 ];
ifitQuantity[ iFunc_, units_, scale_ ] := ifitQuantity[ iFunc, units, scale, 0 ];
ifitQuantity[ iFunc_, units_, scale_, offset_ ][ value_ ] := ifitQuantity0[ iFunc, value, units, scale, offset ];
ifitQuantity[ iFunc_, units_, scale_, offset_ ][ value_, dims_ ] := ifitQuantity1[ iFunc, value, units, scale, offset, dims ];
ifitQuantity[ ___ ][ ___ ] := $Failed;


$$workUnit = "Megajoules"|"Kilojoules"|"Joules";
$$cycleUnit = IndependentUnit[ "Cycles" ] | "Strokes";


ifitQuantity0 // ClearAll;

ifitQuantity0[ iFunc_, Quantity[ value_, units_ ], units_, 1, 0 ] :=
    iFunc @ value;

ifitQuantity0[ iFunc_, Quantity[ value_, units_ ], units_, scale_, offset_ ] :=
    iFunc @ (scale * value + offset);

(* FIXME: define fast conversions for fitValue generated units (like fitQuantity1) and refactor all this Steps/Cycles stuff *)
ifitQuantity0[ iFunc_, Quantity[ value_, units: $$workUnit ], "Watts", scale_, offset_ ] :=
    ifitQuantity0[ iFunc, Quantity[ value, units ], "Joules", scale, offset ];

ifitQuantity0[ iFunc_, Quantity[ value_, units_ ], "RevolutionsPerMinute", scale_, offset_ ] :=
    With[ { new = units /. $$cycleUnit -> "Revolutions" },
        ifitQuantity0[ iFunc, Quantity[ value, new ], "Revolutions"/"Minutes", scale, offset ]
    ];

ifitQuantity0[ iFunc_, Quantity[ value_, units_ ], "Cycles", scale_, offset_ ] :=
    With[ { new = units /. "Revolutions"|$$cycleUnit -> "Revolutions" },
        ifitQuantity0[ iFunc, Quantity[ value, new ], "Revolutions", scale, offset ] /; new =!= units
    ];

ifitQuantity0[ iFunc_, Quantity[ value_, "Steps" / t1_ ], "Revolutions" / t2_, scale_, offset_ ] :=
    ifitQuantity0[ iFunc, Quantity[ value / 2, "Revolutions" / t1 ], "Revolutions" / t2, scale, offset ];

ifitQuantity0[ iFunc_, Quantity[ value_, "Steps" ], "Revolutions", scale_, offset_ ] :=
    ifitQuantity0[ iFunc, Quantity[ value / 2, "Revolutions" ], "Revolutions", scale, offset ];

ifitQuantity0[ iFunc_, Quantity[ value_, "Steps" ], "Cycles", scale_, offset_ ] :=
    ifitQuantity0[ iFunc, Quantity[ value / 2, "Revolutions" ], "Revolutions", scale, offset ];

ifitQuantity0[ iFunc_, Quantity[ value_, units_ ], "MetersPerSecond", scale_, offset_ ] :=
    ifitQuantity0[ iFunc, Quantity[ value, units ], "Meters"/"Seconds", scale, offset ];

ifitQuantity0[ iFunc_, q_Quantity, units_, scale_, offset_ ] :=
    With[ { converted = UnitConvert[ q, units ] },
        ifitQuantity0[ iFunc, converted, units, scale, offset ] /;
            MatchQ[ converted, Quantity[ _, units ] ]
    ];



ifitQuantity1 // ClearAll;

ifitQuantity1[ iFunc_, values_List, units_, scale_, offset_, length_ ] :=
    iFunc[
        Replace[
            Quiet @ UnitConvert[ values, units ],
            {
                Quantity[ value_, units ] :> (scale * value + offset),
                _ :> $Failed
            },
            { 1 }
        ],
        { length }
    ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitBool*)
fitBool // ClearAll;
fitBool[ 0 ] := False;
fitBool[ 1 ] := True;
fitBool[ ___ ] := Missing[ "NotAvailable" ];

fitBoolA // ClearAll;
fitBoolA[ b: { (0|1).. } ] := fitBool /@ b;
fitBoolA[ ___ ] := Missing[ "NotAvailable" ];

ifitBool // ClearAll;
ifitBool[ False ] := 0;
ifitBool[ True  ] := 1;
ifitBool[ ___   ] := $invalidBool;

ifitBoolA // ClearAll;
ifitBoolA[ False, { n_Integer } ] := ConstantArray[ 0, n ];
ifitBoolA[ True , { n_Integer } ] := ConstantArray[ 1, n ];
ifitBoolA[ list_List, { n_Integer } ] := PadRight[ ifitBool /@ list, n, $invalidBool ];
ifitBoolA[ _, { n_Integer } ] := ConstantArray[ $invalidBool, n ];
ifitBoolA[ ___ ] := $Failed;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitByte*)
fitByte // ClearAll;
fitByte[ $invalidUINT8 ] := Missing[ "NotAvailable" ];
fitByte[ n_Integer ] := n;
fitByte[ ___ ] := Missing[ "NotAvailable" ];

fitByteA // ClearAll;
fitByteA[ { $invalidUINT8... } ] := Missing[ "NotAvailable" ];
fitByteA[ list_List ] := ByteArray @ list;
fitByteA[ ___ ] := Missing[ "NotAvailable" ];

ifitByte // ClearAll;
ifitByte[ v_Integer ] := v;
ifitByte[ ___ ] := $Failed;

ifitByteA // ClearAll;
ifitByteA[ b_ByteArray, { n_Integer } ] := PadRight[ Normal @ b, n, $invalidUINT8 ];
ifitByteA[ ___ ] := $Failed;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitSINT8*)
fitSINT8 // ClearAll;
fitSINT8[ $invalidSINT8 ] := Missing[ "NotAvailable" ];
fitSINT8[ n_Integer ] := n;
fitSINT8[ ___ ] := Missing[ "NotAvailable" ];

fitSINT8A // ClearAll;
fitSINT8A[ { $invalidSINT8... } ] := Missing[ "NotAvailable" ];
fitSINT8A[ list_List ] := fitSINT8 /@ list;
fitSINT8A[ ___ ] := Missing[ "NotAvailable" ];

ifitSINT8 // ClearAll;
ifitSINT8[ v_Integer ] := v;
ifitSINT8[ v_Real ] := Round @ v;
ifitSINT8[ ___ ] := $invalidSINT8;

ifitSINT8A // ClearAll;
ifitSINT8A[ v_Integer, { n_Integer } ] := ConstantArray[ v, n ];
ifitSINT8A[ v_Real, { n_Integer } ] := ConstantArray[ Round @ v, n ];
ifitSINT8A[ list_List, { n_Integer } ] := PadRight[ ifitSINT8 /@ list, n, $invalidSINT8 ];
ifitSINT8A[ _, { n_Integer } ] := ConstantArray[ $invalidSINT8, n ];
ifitSINT8A[ ___ ] := $Failed;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitUINT8*)
fitUINT8 // ClearAll;
fitUINT8[ $invalidUINT8 ] := Missing[ "NotAvailable" ];
fitUINT8[ n_Integer ] := n;
fitUINT8[ ___ ] := Missing[ "NotAvailable" ];

fitUINT8A // ClearAll;
fitUINT8A[ { $invalidUINT8... } ] := Missing[ "NotAvailable" ];
fitUINT8A[ list_List ] := fitUINT8 /@ list;
fitUINT8A[ ___ ] := Missing[ "NotAvailable" ];

ifitUINT8 // ClearAll;
ifitUINT8[ v_Integer ] := v;
ifitUINT8[ v_Real ] := Round @ v;
ifitUINT8[ ___ ] := $invalidUINT8;

ifitUINT8A // ClearAll;
ifitUINT8A[ v_Integer, { n_Integer } ] := ConstantArray[ v, n ];
ifitUINT8A[ v_Real, { n_Integer } ] := ConstantArray[ Round @ v, n ];
ifitUINT8A[ list_List, { n_Integer } ] := PadRight[ ifitUINT8 /@ list, n, $invalidUINT8 ];
ifitUINT8A[ _, { n_Integer } ] := ConstantArray[ $invalidUINT8, n ];
ifitUINT8A[ ___ ] := $Failed;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitUINT8Z*)
fitUINT8Z // ClearAll;
fitUINT8Z[ $invalidUINT8Z ] := Missing[ "NotAvailable" ];
fitUINT8Z[ n_Integer ] := n;
fitUINT8Z[ ___ ] := Missing[ "NotAvailable" ];

fitUINT8ZA // ClearAll;
fitUINT8ZA[ { $invalidUINT8Z... } ] := Missing[ "NotAvailable" ];
fitUINT8ZA[ list_List ] := fitUINT8Z /@ list;
fitUINT8ZA[ ___ ] := Missing[ "NotAvailable" ];

ifitUINT8Z // ClearAll;
ifitUINT8Z[ v_Integer ] := v;
ifitUINT8Z[ v_Real ] := Round @ v;
ifitUINT8Z[ ___ ] := $invalidUINT8Z;

ifitUINT8ZA // ClearAll;
ifitUINT8ZA[ v_Integer, { n_Integer } ] := ConstantArray[ v, n ];
ifitUINT8ZA[ v_Real, { n_Integer } ] := ConstantArray[ Round @ v, n ];
ifitUINT8ZA[ list_List, { n_Integer } ] := PadRight[ ifitUINT8Z /@ list, n, $invalidUINT8Z ];
ifitUINT8ZA[ _, { n_Integer } ] := ConstantArray[ $invalidUINT8Z, n ];
ifitUINT8ZA[ ___ ] := $Failed;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitUINT16*)
fitUINT16 // ClearAll;
fitUINT16[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitUINT16[ n_Integer ] := n;
fitUINT16[ ___ ] := Missing[ "NotAvailable" ];

fitUINT16A // ClearAll;
fitUINT16A[ { $invalidUINT16... } ] := Missing[ "NotAvailable" ];
fitUINT16A[ list_List ] := fitUINT16 /@ list;
fitUINT16A[ ___ ] := Missing[ "NotAvailable" ];

ifitUINT16 // ClearAll;
ifitUINT16[ v_Integer ] := v;
ifitUINT16[ v_Real ] := Round @ v;
ifitUINT16[ ___ ] := $invalidUINT16;

ifitUINT16A // ClearAll;
ifitUINT16A[ v_Integer, { n_Integer } ] := ConstantArray[ v, n ];
ifitUINT16A[ v_Real, { n_Integer } ] := ConstantArray[ Round @ v, n ];
ifitUINT16A[ list_List, { n_Integer } ] := PadRight[ ifitUINT16 /@ list, n, $invalidUINT16 ];
ifitUINT16A[ _, { n_Integer } ] := ConstantArray[ $invalidUINT16, n ];
ifitUINT16A[ ___ ] := $Failed;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitUINT16Z*)
fitUINT16Z // ClearAll;
fitUINT16Z[ $invalidUINT16Z ] := Missing[ "NotAvailable" ];
fitUINT16Z[ n_Integer ] := n;
fitUINT16Z[ ___ ] := Missing[ "NotAvailable" ];

fitUINT16ZA // ClearAll;
fitUINT16ZA[ { $invalidUINT16Z... } ] := Missing[ "NotAvailable" ];
fitUINT16ZA[ list_List ] := fitUINT16Z /@ list;
fitUINT16ZA[ ___ ] := Missing[ "NotAvailable" ];

ifitUINT16Z // ClearAll;
ifitUINT16Z[ v_Integer ] := v;
ifitUINT16Z[ v_Real ] := Round @ v;
ifitUINT16Z[ ___ ] := $invalidUINT16Z;

ifitUINT16ZA // ClearAll;
ifitUINT16ZA[ v_Integer, { n_Integer } ] := ConstantArray[ v, n ];
ifitUINT16ZA[ v_Real, { n_Integer } ] := ConstantArray[ Round @ v, n ];
ifitUINT16ZA[ list_List, { n_Integer } ] := PadRight[ ifitUINT16Z /@ list, n, $invalidUINT16Z ];
ifitUINT16ZA[ _, { n_Integer } ] := ConstantArray[ $invalidUINT16Z, n ];
ifitUINT16ZA[ ___ ] := $Failed;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitSINT16*)
fitSINT16 // ClearAll;
fitSINT16[ $invalidSINT16 ] := Missing[ "NotAvailable" ];
fitSINT16[ n_Integer ] := n;
fitSINT16[ ___ ] := Missing[ "NotAvailable" ];

fitSINT16A // ClearAll;
fitSINT16A[ { $invalidSINT16... } ] := Missing[ "NotAvailable" ];
fitSINT16A[ list_List ] := fitSINT16 /@ list;
fitSINT16A[ ___ ] := Missing[ "NotAvailable" ];

ifitSINT16 // ClearAll;
ifitSINT16[ v_Integer ] := v;
ifitSINT16[ v_Real ] := Round @ v;
ifitSINT16[ ___ ] := $invalidSINT16;

ifitSINT16A // ClearAll;
ifitSINT16A[ v_Integer, { n_Integer } ] := ConstantArray[ v, n ];
ifitSINT16A[ v_Real, { n_Integer } ] := ConstantArray[ Round @ v, n ];
ifitSINT16A[ list_List, { n_Integer } ] := PadRight[ ifitSINT16 /@ list, n, $invalidSINT16 ];
ifitSINT16A[ _, { n_Integer } ] := ConstantArray[ $invalidSINT16, n ];
ifitSINT16A[ ___ ] := $Failed;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitUINT32*)
fitUINT32 // ClearAll;
fitUINT32[ $invalidUINT32 ] := Missing[ "NotAvailable" ];
fitUINT32[ n_Integer ] := n;
fitUINT32[ ___ ] := Missing[ "NotAvailable" ];

fitUINT32A // ClearAll;
fitUINT32A[ { $invalidUINT32... } ] := Missing[ "NotAvailable" ];
fitUINT32A[ list_List ] := fitUINT32 /@ list;
fitUINT32A[ ___ ] := Missing[ "NotAvailable" ];

ifitUINT32 // ClearAll;
ifitUINT32[ v_Integer ] := v;
ifitUINT32[ v_Real ] := Round @ v;
ifitUINT32[ ___ ] := $invalidUINT32;

ifitUINT32A // ClearAll;
ifitUINT32A[ v_Integer, { n_Integer } ] := ConstantArray[ v, n ];
ifitUINT32A[ v_Real, { n_Integer } ] := ConstantArray[ Round @ v, n ];
ifitUINT32A[ list_List, { n_Integer } ] := PadRight[ ifitUINT32 /@ list, n, $invalidUINT32 ];
ifitUINT32A[ _, { n_Integer } ] := ConstantArray[ $invalidUINT32, n ];
ifitUINT32A[ ___ ] := $Failed;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitUINT32Z*)
fitUINT32Z // ClearAll;
fitUINT32Z[ $invalidUINT32Z ] := Missing[ "NotAvailable" ];
fitUINT32Z[ n_Integer ] := n;
fitUINT32Z[ ___ ] := Missing[ "NotAvailable" ];

fitUINT32ZA // ClearAll;
fitUINT32ZA[ { $invalidUINT32Z... } ] := Missing[ "NotAvailable" ];
fitUINT32ZA[ list_List ] := fitUINT32Z /@ list;
fitUINT32ZA[ ___ ] := Missing[ "NotAvailable" ];

ifitUINT32Z // ClearAll;
ifitUINT32Z[ v_Integer ] := v;
ifitUINT32Z[ v_Real ] := Round @ v;
ifitUINT32Z[ ___ ] := $invalidUINT32Z;

ifitUINT32ZA // ClearAll;
ifitUINT32ZA[ v_Integer, { n_Integer } ] := ConstantArray[ v, n ];
ifitUINT32ZA[ v_Real, { n_Integer } ] := ConstantArray[ Round @ v, n ];
ifitUINT32ZA[ list_List, { n_Integer } ] := PadRight[ ifitUINT32Z /@ list, n, $invalidUINT32Z ];
ifitUINT32ZA[ _, { n_Integer } ] := ConstantArray[ $invalidUINT32Z, n ];
ifitUINT32ZA[ ___ ] := $Failed;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitSINT32*)
fitSINT32 // ClearAll;
fitSINT32[ $invalidSINT32 ] := Missing[ "NotAvailable" ];
fitSINT32[ n_Integer ] := n;
fitSINT32[ ___ ] := Missing[ "NotAvailable" ];

fitSINT32A // ClearAll;
fitSINT32A[ { $invalidSINT32... } ] := Missing[ "NotAvailable" ];
fitSINT32A[ list_List ] := fitSINT32 /@ list;
fitSINT32A[ ___ ] := Missing[ "NotAvailable" ];

ifitSINT32 // ClearAll;
ifitSINT32[ v_Integer ] := v;
ifitSINT32[ v_Real ] := Round @ v;
ifitSINT32[ ___ ] := $invalidSINT32;

ifitSINT32A // ClearAll;
ifitSINT32A[ v_Integer, { n_Integer } ] := ConstantArray[ v, n ];
ifitSINT32A[ v_Real, { n_Integer } ] := ConstantArray[ Round @ v, n ];
ifitSINT32A[ list_List, { n_Integer } ] := PadRight[ ifitSINT32 /@ list, n, $invalidSINT32 ];
ifitSINT32A[ _, { n_Integer } ] := ConstantArray[ $invalidSINT32, n ];
ifitSINT32A[ ___ ] := $Failed;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitFloat32*)
fitFloat32 // ClearAll;
fitFloat32[ $invalidFLOAT32 ] := Missing[ "NotAvailable" ];
fitFloat32[ n_Integer ] := n / 65535.0;
fitFloat32[ ___ ] := Missing[ "NotAvailable" ];

fitFloat32A // ClearAll;
fitFloat32A[ { $invalidFLOAT32... } ] := Missing[ "NotAvailable" ];
fitFloat32A[ list_List ] := list / 65535.0;
fitFloat32A[ ___ ] := Missing[ "NotAvailable" ];



(* FIXME: Define this! *)
ifitFloat32 // ClearAll;
ifitFloat32[ ___ ] := $Failed;

(* FIXME: Define this! *)
ifitFloat32A // ClearAll;
ifitFloat32A[ ___ ] := $Failed;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitFloat64*)
fitFloat64 // ClearAll;
fitFloat64[ $invalidFLOAT64 ] := Missing[ "NotAvailable" ];
fitFloat64[ n_Integer ] := n / 65535.0;
fitFloat64[ ___ ] := Missing[ "NotAvailable" ];

fitFloat64A // ClearAll;
fitFloat64A[ { $invalidFLOAT64... } ] := Missing[ "NotAvailable" ];
fitFloat64A[ list_List ] := list / 65535.0;
fitFloat64A[ ___ ] := Missing[ "NotAvailable" ];

ifitFloat64 // ClearAll;
ifitFloat64[ v_Real ] := Floor[ v * 65535.0 ];
ifitFloat64[ ___ ] := $Failed;

ifitFloat64A // ClearAll;
ifitFloat64A[ v_Real, { n_Integer } ] := ConstantArray[ Floor[ v * 65535.0 ], n ];
ifitFloat64A[ list_List, { n_Integer } ] := PadRight[ fitFloat64A /@ list, n, $invalidFLOAT64 ];
ifitFloat64A[ ___ ] := $Failed;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitByteArray*)
fitByteArray // ClearAll;
fitByteArray[ { $invalidUINT8... } ] := Missing[ "NotAvailable" ];
fitByteArray[ bytes: { __Integer } ] := ByteArray @ bytes;
fitByteArray[ ___ ] := Missing[ "NotAvailable" ];

ifitByteArray // ClearAll;
ifitByteArray[ bytes_ByteArray, n_ ] := PadRight[ Normal @ bytes, n, $invalidUINT8 ];
ifitByteArray[ ___ ] := $Failed;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitUUID*)
fitUUID // ClearAll;
fitUUID[ { $invalidUINT32.. } ] := Missing[ "NotAvailable" ];
fitUUID[ uuid: { _Integer, _Integer, _Integer, _Integer } ] := StringInsert[ IntegerString[ FromDigits[ uuid, 2^32 ], 16 ], "-", { 9, 13, 17, 21 } ];
fitUUID[ ___ ] := Missing[ "NotAvailable" ];

ifitUUID // ClearAll;
ifitUUID[ uuid_String? uuidStringQ, 4 ] := IntegerDigits[ FromDigits[ StringDelete[ uuid, "-" ], 16 ], 2^32, 4 ];
ifitUUID[ ___ ] := $Failed;


uuidStringQ // ClearAll;

uuidStringQ[ uuid_String? StringQ ] := StringMatchQ[
    uuid,
    StringExpression[
        Repeated[ HexadecimalCharacter, { 8 } ], "-",
        Repeated[ HexadecimalCharacter, { 4 } ], "-",
        Repeated[ HexadecimalCharacter, { 4 } ], "-",
        Repeated[ HexadecimalCharacter, { 4 } ], "-",
        Repeated[ HexadecimalCharacter, { 12 } ]
    ]
];

uuidStringQ[ ___ ] := False;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitString*)
fitString // ClearAll;
fitString[ { 0, ___ } ] := Missing[ "NotAvailable" ];
fitString[ bytes: { __Integer } ] := FromCharacterCode[ TakeWhile[ bytes, Positive ], "UTF-8" ];
fitString[ ___ ] := Missing[ "NotAvailable" ];

ifitString // ClearAll;
ifitString[ s_, { n_Integer } ] := ifitString[ s, n ];
ifitString[ s_String, n_Integer ] := PadRight[ ToCharacterCode[ s, "UTF-8" ], n ];
ifitString[ _, n_Integer ] := ConstantArray[ 0, n ];
ifitString[ ___ ] := $Failed;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitUINT16BF*)
fitUINT16BF // ClearAll;
fitUINT16BF[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitUINT16BF[ n_Integer ] := With[ { d = Reverse @ IntegerDigits[ n, 2, 16 ] }, Pick[ Range @ Length @ d, d, 1 ] ];
fitUINT16BF[ ___ ] := Missing[ "NotAvailable" ];

ifitUINT16BF // ClearAll;
ifitUINT16BF[ bf: { __Integer }, _ ] := Total[ 2^(bf - 1) ];
ifitUINT16BF[ ___ ] := $Failed;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitByteOrder*)
fitByteOrder // ClearAll;
fitByteOrder[ 0 ] := -1;
fitByteOrder[ 1 ] :=  1;
fitByteOrder[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitFileOffset*)
fitFileOffset // ClearAll;
fitFileOffset[ n_Integer ] := fitFileOffset[ n, $fileByteCount ];
fitFileOffset[ n_Integer, size_Integer? Positive ] := size - n;
fitFileOffset[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitHexString*)
fitHexString // ClearAll;
fitHexString[ { $invalidUINT8... } ] := Missing[ "NotAvailable" ];
fitHexString[ v_List ] := StringJoin[ (IntegerString[ #, 16 ] &) /@ v ];
fitHexString[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitRawData*)
fitRawData // ClearAll;
fitRawData[ { a___, $fitTerm, ___ } ] := { a };
fitRawData[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitGlobalID*)
fitGlobalID // ClearAll;
fitGlobalID[ { 255 .. } ] := Missing[ "NotAvailable" ];
fitGlobalID[ bytes: { __Integer } ] := FromDigits[ bytes, 256 ];
fitGlobalID[ ___ ] := Missing[ "NotAvailable" ];

ifitGlobalID // ClearAll;
ifitGlobalID[ id_Integer, n_Integer ] := IntegerDigits[ id, 256, n ];
ifitGlobalID[ ___ ] := $Failed;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitDateTime*)
fitDateTime // ClearAll;
fitDateTime[ $invalidTimestamp ] := Missing[ "NotAvailable" ];
fitDateTime[ n_Integer ] /; $failedTimeOffset := DateObject @ n;
fitDateTime[ n_Integer ] := TimeZoneConvert @ DateObject[ n + $timeOffset, TimeZone -> 0 ];
fitDateTime[ ___ ] := Missing[ "NotAvailable" ];

ifitDateTime // ClearAll;
ifitDateTime[ v_Integer ] := v - $timeOffset;
ifitDateTime[ date_DateObject ] := ifitDateTime @ AbsoluteTime[ date, TimeZone -> 0 ];
ifitDateTime[ date_Real ] := ifitDateTime @ Round @ date;
ifitDateTime[ ___ ] := $invalidFitDateTime;

(* $invalidFitDateTime = Mod[ $fitInitValues[ "DateTime" ], 2^32 ]; *)
$invalidFitDateTime = $fitInitValues[ "DateTime" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitLocalTimestamp*)
fitLocalTimestamp // ClearAll;
fitLocalTimestamp[ $invalidTimestamp ] := Missing[ "NotAvailable" ];
fitLocalTimestamp[ n_Integer ] := TimeZoneConvert @ DateObject[ n, TimeZone -> 0 ];
fitLocalTimestamp[ ___ ] := Missing[ "NotAvailable" ];


ifitLocalTimestamp // ClearAll;
ifitLocalTimestamp[ v_Integer ] := v;
ifitLocalTimestamp[ date_DateObject ] := ifitLocalTimestamp @ AbsoluteTime[ date, TimeZone -> 0 ];
ifitLocalTimestamp[ date_Real ] := ifitLocalTimestamp @ Round @ date;
ifitLocalTimestamp[ ___ ] := $invalidFitDateTime;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitLanguage*)
fitLanguage // ClearAll;
fitLanguage[ n_Integer ] := fitLanguage[ n, $enumTypeData[ "Language", n ] ];
fitLanguage[ _, _Missing ] := Missing[ "NotAvailable" ];
fitLanguage[ _, lang_ ] := lang;
fitLanguage[ ___ ] := Missing[ "NotAvailable" ];


ifitLanguage // ClearAll;
ifitLanguage[ language_ ] := With[ { n = $iEnumTypeData[ "Language", language ] }, n /; IntegerQ @ n ];
ifitLanguage[ language_Entity ] := Quiet @ ifitLanguage0 @ standardizeEntityName @ language;
ifitLanguage[ language_String ] := Quiet @ ifitLanguage0 @ languageData @ language;
ifitLanguage[ Automatic       ] := With[ { lang = $Language }, ifitLanguage @ lang /; lang =!= Automatic ];
ifitLanguage[ ___             ] := $Failed;

ifitLanguage0 // ClearAll;
ifitLanguage0[ language_Entity ] := Lookup[ $iEnumTypeData[ "Language" ], language, $Failed ];
ifitLanguage0[ ___ ] := $Failed;


languageData // ClearAll;
languageData[ name_String ] := languageData[ name ] = Quiet @ standardizeEntityName @ LanguageData @ name;
languageData[ ___ ] := $Failed;


standardizeEntityName // ClearAll;

standardizeEntityName[ e: Entity[ type_, name_String ] ] :=
    With[ { entity = Entity[ type, First @ StringSplit[ name, "::" ] ] },
        (standardizeEntityName[ e ] = entity) /; entityQ @ entity
    ];

standardizeEntityName[ other_ ] := other;

entityQ[ entity_Entity ] := ListQ @ entity[ "Properties" ];
entityQ[ ___ ] := False;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitSeconds32*)
fitSeconds32 // ClearAll;
fitSeconds32[ $invalidUINT32 ] := Missing[ "NotAvailable" ];
fitSeconds32[ n_Integer ] := secondsToQuantity @ n;
fitSeconds32[ ___ ] := Missing[ "NotAvailable" ];

fitSeconds32A // ClearAll;
fitSeconds32A[ { $invalidUINT32... } ] := Missing[ "NotAvailable" ];
fitSeconds32A[ list_List ] := fitSeconds32 /@ list;
fitSeconds32A[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitKiloSeconds16*)
fitKiloSeconds16 // ClearAll;
fitKiloSeconds16[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitKiloSeconds16[ n___ ] := fitKiloSeconds @ n;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitKiloSeconds32*)
fitKiloSeconds32 // ClearAll;
fitKiloSeconds32[ $invalidUINT32 ] := Missing[ "NotAvailable" ];
fitKiloSeconds32[ n___ ] := fitKiloSeconds @ n;

fitKiloSeconds32A // ClearAll;
fitKiloSeconds32A[ { $invalidUINT32... } ] := Missing[ "NotAvailable" ];
fitKiloSeconds32A[ list_List ] := fitKiloSeconds32 /@ list;
fitKiloSeconds32A[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitKiloSeconds*)
fitKiloSeconds // ClearAll;
fitKiloSeconds[ n_Integer ] := secondsToQuantity[ n/1000.0 ];
fitKiloSeconds[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTimeOfDay*)
fitTimeOfDay // ClearAll;
fitTimeOfDay[ $invalidUINT32 ] := Missing[ "NotAvailable" ];
fitTimeOfDay[ n_Integer ] := secondsToTimeObject @ n;
fitTimeOfDay[ ___ ] := Missing[ "NotAvailable" ];

ifitTimeOfDay // ClearAll;
ifitTimeOfDay[ v_Integer ] := v;
ifitTimeOfDay[ v_Real ] := Round @ v;
ifitTimeOfDay[ t: TimeObject[ { h_, m_, s_ }, __ ] ] := ifitTimeOfDay[ h*3600 + m*60 + s ];
ifitTimeOfDay[ ___ ] := $Failed;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitMinutes*)
fitMinutes // ClearAll;
fitMinutes[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitMinutes[ n_Integer ] := secondsToQuantity[ n*60 ];
fitMinutes[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitGeoPosition*)
fitGeoPosition // ClearAll;
fitGeoPosition[ { $invalidSINT32|0, _ } ] := Missing[ "NotAvailable" ];
fitGeoPosition[ { _, $invalidSINT32|0 } ] := Missing[ "NotAvailable" ];
fitGeoPosition[ { a_, b_ } ] := GeoPosition[ 8.381903175442434*^-8*{ a, b } ];
fitGeoPosition[ ___ ] := Missing[ "NotAvailable" ];

(* cSpell: ignore ITRF00 *)
ifitPositionLatitude // ClearAll;
ifitPositionLatitude[ GeoPosition[ { lat_, __ } ] ] := geoPartToInteger @ lat;
ifitPositionLatitude[ GeoPosition[ { lat_, __ }, "ITRF00" ] ] := geoPartToInteger @ lat;
ifitPositionLatitude[ pos_GeoPosition ] := GeoPosition[ pos, "ITRF00" ][ "Latitude" ];
ifitPositionLatitude[ ___ ] := $Failed;

ifitPositionLongitude // ClearAll;
ifitPositionLongitude[ GeoPosition[ { _, lon_, ___ } ] ] := geoPartToInteger @ lon;
ifitPositionLongitude[ GeoPosition[ { _, lon_, ___ }, "ITRF00" ] ] := geoPartToInteger @ lon;
ifitPositionLongitude[ pos_GeoPosition ] := GeoPosition[ pos, "ITRF00" ][ "Longitude" ];
ifitPositionLongitude[ ___ ] := $Failed;

geoPartToInteger // ClearAll;
geoPartToInteger[ v_Real    ] := Round[ 1.19305*10^7 * v ];
geoPartToInteger[ v_Integer ] := Round[ 1.19305*10^7 * v ];
geoPartToInteger[ ___ ] := $Failed;

(* ::**************************************************************************************************************:: *)
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

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitWeight*)
fitWeight // ClearAll;
fitWeight[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitWeight[ n_Integer ] := fitWeight[ n, $weightUnits ];
fitWeight[ n_Integer, "Imperial" ] := Quantity[ 0.220462 * n, "Pounds" ];
fitWeight[ n_Integer, _ ] := Quantity[ n/10.0, "Kilograms" ];
fitWeight[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitAge*)
fitAge // ClearAll;
fitAge[ $invalidUINT8 ] := Missing[ "NotAvailable" ];
fitAge[ n_Integer ] := Quantity[ n, "Years" ];
fitAge[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitHeight*)
fitHeight // ClearAll;
fitHeight[ $invalidUINT8 ] := Missing[ "NotAvailable" ];
fitHeight[ n_Integer ] := fitHeight[ n, $heightUnits ];
fitHeight[ n_Integer, "Imperial" ] := Quantity[ With[ { x = 0.0328 * n }, MixedMagnitude @ { IntegerPart @ x, 12 * FractionalPart @ x } ], MixedUnit @ { "Feet", "Inches" } ];
fitHeight[ n_Integer, _ ] := Quantity[ n/100.0, "Meters" ];
fitHeight[ ___ ] := Missing[ "NotAvailable" ];

ifitHeight // ClearAll;
ifitHeight[ v_Integer ] := 100 * v;
ifitHeight[ v_Real ] := Round[ 100 * v ];
ifitHeight[ Quantity[ m_, "Meters" ] ] := ifitHeight @ m;
ifitHeight[ q: Quantity[ { ft_, in_ }, MixedUnit[ { "Feet", "Inches" } ] ] ] := ifitHeight[ 0.3048*ft + 0.3048*in ];
ifitHeight[ q_Quantity ] := With[ { m = QuantityMagnitude @ UnitConvert[ q, "Meters" ] }, ifitHeight @ m ];
ifitHeight[ ___ ] := $Failed;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitDistance*)
fitDistance // ClearAll;
fitDistance[ $invalidUINT32 ] := Missing[ "NotAvailable" ];
fitDistance[ n_Integer ] := fitDistance[ n, $distanceUnits ];
fitDistance[ n_, "Imperial" ] := Quantity[ 6.213711922373339*^-6*n, "Miles" ];
fitDistance[ n_, _ ] := Quantity[ n/100.0, "Meters" ];
fitDistance[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitLength10mm*)
fitLength10mm // ClearAll;
fitLength10mm[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitLength10mm[ n_Integer ] := fitLength10mm[ n, $distanceUnits ];
fitLength10mm[ n_Integer, "Imperial" ] := Quantity[ 3.93701 * n, "Inches" ];
fitLength10mm[ n_Integer, _ ] := Quantity[ 10.0 * n, "Centimeters" ];
fitLength10mm[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTravelRange*)
fitTravelRange // ClearAll;
fitTravelRange[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitTravelRange[ n_Integer ] := fitTravelRange[ n, $distanceUnits ];
fitTravelRange[ n_Integer, "Imperial" ] := Quantity[ 0.62137 * n, "Miles" ];
fitTravelRange[ n_Integer, _ ] := Quantity[ 1.0 * n, "Kilometers" ];
fitTravelRange[ ___ ] := Missing[ "NotAvailable" ];\

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitMM8*)
fitMM8 // ClearAll;
fitMM8[ $invalidUINT8 ] := Missing[ "NotAvailable" ];
fitMM8[ n_Integer ] := fitMM8[ n, $distanceUnits ];
fitMM8[ n_Integer, "Imperial" ] := Quantity[ 0.03937 * n, "Inches" ];
fitMM8[ n_Integer, _ ] := Quantity[ 1.0 * n, "Millimeters" ];
fitMM8[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitWork*)
fitWork // ClearAll;
fitWork[ $invalidUINT32 ] := Missing[ "NotAvailable" ];
fitWork[ n_Integer ] := Quantity[ n/1000.0, "Kilojoules" ];
fitWork[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitPercent8*)
fitPercent8 // ClearAll;
fitPercent8[ $invalidUINT8 ] := Missing[ "NotAvailable" ];
fitPercent8[ n_Integer ] := fitPercent @ n;
fitPercent8[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitPercent16*)
fitPercent16 // ClearAll;
fitPercent16[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitPercent16[ n_Integer ] := fitPercent[ n / 100.0 ];
fitPercent16[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fit2Percent*)
fit2Percent // ClearAll;
fit2Percent[ $invalidUINT8 ] := Missing[ "NotAvailable" ];
fit2Percent[ n_Integer ] := fitPercent[ n / 2.0 ];
fit2Percent[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitPercent*)
fitPercent // ClearAll;
fitPercent[ n_ ] := Quantity[ n, "Percent" ];
fitPercent[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitPressure16*)
fitPressure16 // ClearAll;
fitPressure16[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitPressure16[ n___ ] := fitPressure @ n;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitPressure32*)
fitPressure32 // ClearAll;
fitPressure32[ $invalidUINT32 ] := Missing[ "NotAvailable" ];
fitPressure32[ n___ ] := fitPressure @ n;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitPressure*)
fitPressure[ n_Integer ] := fitPressure[ n, $pressureUnits ];
fitPressure[ n_Integer, "Imperial" ] := Quantity[ 0.00014504 * n, "PoundsForce"/"Inches"^2 ];
fitPressure[ n_Integer, _ ] := Quantity[ 1.0 * n, "Pascals" ];
fitPressure[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTimeFromCourse*)
fitTimeFromCourse // ClearAll;
fitTimeFromCourse[ $invalidSINT32 ] := Missing[ "NotAvailable" ];
fitTimeFromCourse[ n_Integer ] := secondsToQuantity[ n/1000.0 ];
fitTimeFromCourse[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitCycles32*)
fitCycles32 // ClearAll;
fitCycles32[ $invalidUINT32|0 ] := Missing[ "NotAvailable" ];
fitCycles32[ $invalidUINT32|0, n_ ] := fitFractionalCycles @ n;
fitCycles32[ c_Integer, $invalidUINT32|0 ] := cycleQuantity @ c;
fitCycles32[ c_Integer, f_Integer ] := cycleQuantity[ c + f / 128.0 ];
fitCycles32[ c_Integer ] := cycleQuantity @ c;
fitCycles32[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitCycles8*)
fitCycles8 // ClearAll;
fitCycles8[ $invalidUINT8|0 ] := Missing[ "NotAvailable" ];
fitCycles8[ $invalidUINT8|0, n_ ] := fitFractionalCycles @ n;
fitCycles8[ c_Integer, $invalidUINT8|0 ] := cycleQuantity @ c;
fitCycles8[ c_Integer, f_Integer ] := cycleQuantity[ c + f / 128.0 ];
fitCycles8[ c_Integer ] := cycleQuantity @ c;
fitCycles8[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitFractionalCycles*)
fitFractionalCycles // ClearAll;
fitFractionalCycles[ $invalidUINT8|0 ] := Missing[ "NotAvailable" ];
fitFractionalCycles[ n_Integer ] := cycleQuantity[ n/128.0 ];
fitFractionalCycles[ ___ ] := Missing[ "NotAvailable" ];

ifitFractionalCycles // ClearAll;
ifitFractionalCycles[ Quantity[ n_, "Revolutions"|IndependentUnit[ "Cycles" ] ] ] := ifitFractionalCycles @ n;
ifitFractionalCycles[ Quantity[ n_, "Steps"|"Strokes" ] ] := ifitFractionalCycles[ n/2 ];
ifitFractionalCycles[ n_Integer   ] := 128 * n;
ifitFractionalCycles[ n_? NumberQ ] := Round[ 128.0 * n ];
ifitFractionalCycles[ ___ ] := $Failed;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTimeInZone*)
fitTimeInZone // ClearAll;
fitTimeInZone[ $invalidUINT32 ] := Missing[ "NotAvailable" ];
fitTimeInZone[ n_Integer ] := secondsToQuantity[ n/1000.0 ];
fitTimeInZone[ { n_ } ] := fitTimeInZone @ n;
fitTimeInZone[ { $invalidUINT32... } ] := Missing[ "NotAvailable" ];
fitTimeInZone[ list_List ] := fitTimeInZone /@ list;
fitTimeInZone[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitAccumulatedPower*)
fitAccumulatedPower // ClearAll;
fitAccumulatedPower[ { $invalidUINT32, _ } ] := Missing[ "NotAvailable" ];
fitAccumulatedPower[ { _, $invalidUINT32 } ] := Quantity[ 0.0, "Kilojoules" ];
fitAccumulatedPower[ a_ ] := fitAccumulatedPower[ $start, a ];
fitAccumulatedPower[ t0_Integer, { t_Integer, n_Integer } ] := Quantity[ 0.001 * n * (t - t0), "Kilojoules" ];
fitAccumulatedPower[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitAltitudeSelect*)
fitAltitudeSelect // ClearAll;
fitAltitudeSelect[ a32_, a16_ ] := fitAltitudeSelect[ a32, a16, fitAltitude32 @ a32 ];
fitAltitudeSelect[ a32_, a16_, a_Quantity ] := a;
fitAltitudeSelect[ a32_, a16_, _ ] := fitAltitude16 @ a16;
fitAltitudeSelect[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitAltitude32*)
fitAltitude32 // ClearAll;
fitAltitude32[ $invalidUINT32 ] := Missing[ "NotAvailable" ];
fitAltitude32[ n___ ] := fitAltitude @ n;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitAltitude16*)
fitAltitude16 // ClearAll;
fitAltitude16[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitAltitude16[ n___ ] := fitAltitude @ n;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitAltitude*)
fitAltitude[ n_Integer ] := fitAltitude[ n, $altitudeUnits ];
fitAltitude[ n_, "Imperial" ] := Quantity[ 0.656168 n - 1640.42, "Feet" ];
fitAltitude[ n_, _ ] := Quantity[ 0.2 n - 500.0, "Meters" ];
fitAltitude[ ___ ] := Missing[ "NotAvailable" ];

ifitAltitude // ClearAll;
ifitAltitude[ n_Integer ] := n;
ifitAltitude[ n_Real ] := Round @ n;
ifitAltitude[ Quantity[ ft_, "Feet" ] ] := Round[ 2500 + 1.524 ft ];
ifitAltitude[ Quantity[ m_, "Meters" ] ] := Round[ 2500 + 5 * m ];
ifitAltitude[ q_Quantity ] := ifitAltitude @ UnitConvert[ q, "Meters" ];
ifitAltitude[ ___ ] := $Failed;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitAscent*)
fitAscent // ClearAll;
fitAscent[ $invalidUINT16|0 ] := Missing[ "NotAvailable" ];
fitAscent[ $invalidUINT16|0, n_ ] := fitFractionalAscent @ n;
fitAscent[ n_Integer, $invalidUINT8|0 ] := ascentQuantity @ n;
fitAscent[ n_Integer, f_Integer ] := ascentQuantity[ n + f / 100.0 ];
fitAscent[ n_Integer ] := ascentQuantity @ n;
fitAscent[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitFractionalAscent*)
fitFractionalAscent // ClearAll;
fitFractionalAscent[ $invalidUINT8|0 ] := Missing[ "NotAvailable" ];
fitFractionalAscent[ n_Integer ] := ascentQuantity[ n/100.0 ];
fitFractionalAscent[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitSpeedSelect*)
fitSpeedSelect // ClearAll;
fitSpeedSelect[ s32_, s16_ ] := fitSpeedSelect[ s32, s16, fitSpeed32 @ s32 ];
fitSpeedSelect[ s32_, s16_, s_Quantity ] := s;
fitSpeedSelect[ s32_, s16_, _ ] := fitSpeed16 @ s16;
fitSpeedSelect[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitSpeed16*)
fitSpeed16 // ClearAll;
fitSpeed16[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitSpeed16[ n___ ] := fitSpeed @ n;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitSpeed32*)
fitSpeed32 // ClearAll;
fitSpeed32[ $invalidUINT32 ] := Missing[ "NotAvailable" ];
fitSpeed32[ n___ ] := fitSpeed @ n;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitSpeed*)
fitSpeed // ClearAll;
fitSpeed[ 0 ] := Missing[ "NotAvailable" ];
fitSpeed[ n_Integer ] := fitSpeed[ n, $speedUnits ];
fitSpeed[ n_, "Imperial" ] := Quantity[ 0.0022369362920544025*n, "Miles"/"Hours" ];
fitSpeed[ n_, _ ] := Quantity[ n/1000.0, "Meters"/"Seconds" ];
fitSpeed[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitPower8*)
fitPower8 // ClearAll;
fitPower8[ $invalidUINT8 ] := Quantity[ 0.0, "Watts" ];
fitPower8[ n___ ] := fitPower @ n;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitPower16*)
fitPower16 // ClearAll;
fitPower16[ $invalidUINT16 ] := Quantity[ 0.0, "Watts" ];
fitPower16[ n___ ] := fitPower @ n;

fitPower16A // ClearAll;
fitPower16A[ { $invalidUINT16... } ] := Missing[ "NotAvailable" ];
fitPower16A[ list_List ] := fitPower16 /@ list;
fitPower16A[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitPower*)
fitPower // ClearAll;
fitPower[ n_ ] := Quantity[ 1.0 * n, "Watts" ];
fitPower[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitFTPSetting*)
fitFTPSetting // ClearAll;
fitFTPSetting[ n_ ] := fitFTPSetting[ fitPower16 @ n, $ftp ];
fitFTPSetting[ watts_Quantity, Automatic ] := ($ftp = setFTP @ watts; watts);
fitFTPSetting[ watts_Quantity, _ ] := watts;
fitFTPSetting[ ___ ] := Missing[ "NotAvailable" ];

ifitFTPSetting // ClearAll;
ifitFTPSetting[ watts_Integer ] := watts;
ifitFTPSetting[ watts_Real ] := Round @ watts;
ifitFTPSetting[ Quantity[ watts_, "Watts" ] ] := ifitFTPSetting @ watts;
ifitFTPSetting[ ___ ] := $Failed;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitGrade*)
fitGrade // ClearAll;
fitGrade[ $invalidSINT16 ] := Missing[ "NotAvailable" ];
fitGrade[ n_Integer ] := Quantity[ 0.01 * n, "Percent" ];
fitGrade[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitCompressedAccumulatedPower*)
fitCompressedAccumulatedPower // ClearAll;
fitCompressedAccumulatedPower[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitCompressedAccumulatedPower[ n_Integer ] := Quantity[ 0.001 * n, "Kilojoules" ];
fitCompressedAccumulatedPower[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitVerticalSpeed*)
fitVerticalSpeed // ClearAll;
fitVerticalSpeed[ $invalidSINT16 ] := Missing[ "NotAvailable" ];
fitVerticalSpeed[ n_Integer ] := fitVerticalSpeed[ n, $speedUnits ];
fitVerticalSpeed[ n_, "Imperial" ] := Quantity[ 0.00328084 * n, "Feet"/"Seconds" ];
fitVerticalSpeed[ n_, _ ] := Quantity[ n / 1000.0, "Meters"/"Seconds" ];
fitVerticalSpeed[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitVAM*)
fitVAM // ClearAll;
fitVAM[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitVAM[ n_Integer ] := fitVAM[ n, $speedUnits ];
fitVAM[ n_, "Imperial" ] := Quantity[ 0.00328084 * n, "Feet"/"Seconds" ];
fitVAM[ n_, _ ] := Quantity[ n / 1000.0, "Meters"/"Seconds" ];
fitVAM[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitCalories*)
fitCalories // ClearAll;
fitCalories[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitCalories[ n_Integer ] := Quantity[ n, "DietaryCalories" ];
fitCalories[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitRespirationRate*)
fitRespirationRate // ClearAll;
(* Undocumented field, so this probably isn't 100% correct *)
fitRespirationRate[ $invalidUINT8|$invalidUINT16|0 ] := Missing[ "NotAvailable" ];
fitRespirationRate[ n_Integer ] := Quantity[ 2.4 * Mod[ n, 64 ] + 3.6, IndependentUnit[ "Breaths" ] / "Minutes" ];
fitRespirationRate[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitVerticalOscillation*)
fitVerticalOscillation // ClearAll;
fitVerticalOscillation[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitVerticalOscillation[ n_Integer ] := fitVerticalOscillation[ n, $distanceUnits ];
fitVerticalOscillation[ n_, "Imperial" ] := Quantity[ 0.003937 * n, "Inches" ];
fitVerticalOscillation[ n_, _ ] := Quantity[ n / 10.0, "Millimeters" ];
fitVerticalOscillation[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitStanceTimePercent*)
fitStanceTimePercent // ClearAll;
fitStanceTimePercent[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitStanceTimePercent[ n_Integer ] := Quantity[ 0.01 * n, "Percent" ];
fitStanceTimePercent[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitStanceTime*)
fitStanceTime // ClearAll;
fitStanceTime[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitStanceTime[ n_Integer ] := Quantity[ n/10.0, "Milliseconds" ];
fitStanceTime[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitBallSpeed*)
fitBallSpeed // ClearAll;
fitBallSpeed[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitBallSpeed[ n_Integer ] := fitBallSpeed[ n, $speedUnits ];
fitBallSpeed[ n_, "Imperial" ] := Quantity[ 0.032808 * n, "Feet"/"Seconds" ];
fitBallSpeed[ n_, _ ] := Quantity[ n / 100.0, "Meters"/"Seconds" ];
fitBallSpeed[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitCadence256*)
fitCadence256 // ClearAll;
fitCadence256[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitCadence256[ n_Integer ] := Quantity[ n/256.0, "Revolutions"/"Minutes" ];
fitCadence256[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitHemoglobin*)
fitHemoglobin // ClearAll;
fitHemoglobin[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitHemoglobin[ n_Integer ] := Quantity[ n/100.0, "Grams"/"Deciliters" ];
fitHemoglobin[ { $invalidUINT16... } ] := Missing[ "NotAvailable" ];
fitHemoglobin[ { n_ } ] := fitHemoglobin @ n;
fitHemoglobin[ list_List ] := fitHemoglobin /@ list;
fitHemoglobin[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitHemoglobinPercent*)
fitHemoglobinPercent // ClearAll;
fitHemoglobinPercent[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitHemoglobinPercent[ n_Integer ] := Quantity[ n / 10.0, "Percent" ];
fitHemoglobinPercent[ { $invalidUINT16... } ] := Missing[ "NotAvailable" ];
fitHemoglobinPercent[ { n_ } ] := fitHemoglobinPercent @ n;
fitHemoglobinPercent[ list_List ] := fitHemoglobinPercent /@ list;
fitHemoglobinPercent[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitHeartRate*)
fitHeartRate // ClearAll;
fitHeartRate[ $invalidUINT8 | 0 ] := Missing[ "NotAvailable" ];
fitHeartRate[ n_Integer ] := Quantity[ n, "Beats"/"Minutes" ];
fitHeartRate[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitMaxHRSetting*)
fitMaxHRSetting // ClearAll;
fitMaxHRSetting[ n_ ] := fitMaxHRSetting[ fitHeartRate @ n, $maxHR ];
fitMaxHRSetting[ hr_Quantity, Automatic ] := ($maxHR = setMaxHR @ hr; hr);
fitMaxHRSetting[ hr_Quantity, _ ] := hr;
fitMaxHRSetting[ ___ ] := Missing[ "NotAvailable" ];

ifitMaxHRSetting // ClearAll;
ifitMaxHRSetting[ bpm_Integer ] := bpm;
ifitMaxHRSetting[ bpm_Real ] := Round @ bpm;
ifitMaxHRSetting[ Quantity[ bpm_, "Beats"/"Minutes" ] ] := ifitMaxHRSetting @ bpm;
ifitMaxHRSetting[ ___ ] := $Failed;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitCadence*)
fitCadence // ClearAll;
fitCadence[ $invalidUINT8|0 ] := Missing[ "NotAvailable" ];
fitCadence[ $invalidUINT8|0, n_ ] := fitFractionalCadence @ n;
fitCadence[ c_Integer, $invalidUINT8|0 ] := cadenceQuantity @ c;
fitCadence[ c_Integer, f_Integer ] := cadenceQuantity[ c + f / 128.0 ];
fitCadence[ c_Integer ] := cadenceQuantity @ c;
fitCadence[ ___ ] := Missing[ "NotAvailable" ];

ifitCadence // ClearAll;
ifitCadence[ n_Integer ] := n;
ifitCadence[ n_Real ] := Round @ n;
ifitCadence[ Quantity[ n_, "Revolutions" / "Minutes" ] ] := Round @ n;
ifitCadence[ Quantity[ n_, IndependentUnit[ "Cycles" ] / "Minutes" ] ] := Round @ n;
ifitCadence[ Quantity[ n_, ("Steps"|"Strokes") / "Minutes" ] ] := Round[ n / 2 ];
ifitCadence[ ___ ] := $Failed;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitFractionalCadence*)
fitFractionalCadence // ClearAll;
fitFractionalCadence[ $invalidUINT8|0 ] := Missing[ "NotAvailable" ];
fitFractionalCadence[ n_Integer ] := cadenceQuantity[ n / 128.0 ];
fitFractionalCadence[ ___ ] := Missing[ "NotAvailable" ];

ifitFractionalCadence // ClearAll;
ifitFractionalCadence[ n_Integer ] := n * 128;
ifitFractionalCadence[ n_Real ] := Round[ n * 128 ];
ifitFractionalCadence[ Quantity[ n_, "Revolutions" / "Minutes" ] ] := Round[ n * 128 ];
ifitFractionalCadence[ Quantity[ n_, IndependentUnit[ "Cycles" ] / "Minutes" ] ] := Round[ n * 128 ];
ifitFractionalCadence[ Quantity[ n_, ("Steps"|"Strokes") / "Minutes" ] ] := Round[ n * 64 ];
ifitFractionalCadence[ ___ ] := $Failed;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitResistance*)
fitResistance // ClearAll;
fitResistance[ $invalidUINT8 ] := Missing[ "NotAvailable" ];
fitResistance[ n_Integer ] := Quantity[ n / 254.0, "Percent" ];
fitResistance[ ___ ] := Missing[ "NotAvailable" ];

ifitResistance // ClearAll;
ifitResistance[ n_Integer ] := 254 * n;
ifitResistance[ n_Real ] := Round[ 254 * n ];
ifitResistance[ Quantity[ n_, "Percent" ] ] := ifitResistance[ n / 100.0 ];
ifitResistance[ ___ ] := $Failed;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitCycleLength*)
fitCycleLength // ClearAll;
fitCycleLength[ $invalidUINT8 ] := Missing[ "NotAvailable" ];
fitCycleLength[ n_Integer ] := fitCycleLength[ n, $distanceUnits ];
fitCycleLength[ n_, "Imperial" ] := Quantity[ 0.032808 * n, "Feet" ];
fitCycleLength[ n_, _ ] := Quantity[ n / 100.0, "Meters" ];
fitCycleLength[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTemperature100C*)
fitTemperature100C // ClearAll;
fitTemperature100C[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitTemperature100C[ n_Integer ] := fitTemperature[ n / 100.0 ];
fitTemperature100C[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTemperature8*)
fitTemperature8 // ClearAll;
fitTemperature8[ $invalidSINT8|$invalidUINT8 ] := Missing[ "NotAvailable" ];
fitTemperature8[ n___ ] := fitTemperature @ n;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTemperature16*)
fitTemperature16 // ClearAll;
fitTemperature16[ $invalidSINT16|$invalidUINT16 ] := Missing[ "NotAvailable" ];
fitTemperature16[ n___ ] := fitTemperature @ n;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTemperature*)
fitTemperature // ClearAll;
fitTemperature[ n_ ] := fitTemperature[ n, $temperatureUnits ];
fitTemperature[ n_, "Imperial" ] := Quantity[ 32.0 + 1.8 n, "DegreesFahrenheit" ];
fitTemperature[ n_, _ ] := Quantity[ 1.0 * n, "DegreesCelsius" ];
fitTemperature[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitDepth*)
fitDepth // ClearAll;
fitDepth[ $invalidUINT32 ] := Missing[ "NotAvailable" ];
fitDepth[ n_Integer ] := fitDepth[ n, $distanceUnits ];
fitDepth[ n_Integer, "Imperial" ] := Quantity[ 0.0032808 * n, "Feet" ];
fitDepth[ n_Integer, _ ] := Quantity[ 0.001 * n, "Meters" ];
fitDepth[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitSteps*)
fitSteps // ClearAll;
fitSteps[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitSteps[ n_Integer ] := Quantity[ n, "Steps" ];
fitSteps[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitStepLength*)
fitStepLength // ClearAll;
fitStepLength[ 0 ] := Automatic;
fitStepLength[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitStepLength[ n_Integer ] := fitStepLength[ n, $distanceUnits ];
fitStepLength[ n_Integer, "Imperial" ] := Quantity[ 0.00328084 * n, "Feet" ];
fitStepLength[ n_Integer, _ ] := Quantity[ 0.001 * n, "Meters" ];
fitStepLength[ ___ ] := Missing[ "NotAvailable" ];


ifitStepLength // ClearAll;
ifitStepLength[ Automatic ] := 0;
ifitStepLength[ n_Integer ] := 1000 * n;
ifitStepLength[ n_Real ] := Round[ 1000 * n ];
ifitStepLength[ Quantity[ m_, "Meters" ] ] := ifitStepLength @ m;
ifitStepLength[ q_Quantity ] := ifitStepLength @ QuantityMagnitude @ UnitConvert[ q, "Meters" ];
ifitStepLength[ ___ ] := $Failed;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitLeftRightBalance*)
fitLeftRightBalance // ClearAll;
fitLeftRightBalance[ $invalidUINT8 ] := Missing[ "NotAvailable" ];

fitLeftRightBalance[ n_Integer ] /; n >= 128 :=
    With[ { bal = 1.0 * BitAnd[ n, 127 ] },
        {
            Quantity[ 100 - bal, "Percent" ],
            Quantity[ bal      , "Percent" ]
        }
    ];

fitLeftRightBalance[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitLeftRightBalance100*)
fitLeftRightBalance100 // ClearAll;
fitLeftRightBalance100[ $invalidUINT16 ] := Missing[ "NotAvailable" ];

fitLeftRightBalance100[ n_Integer ] /; n >= 32768 :=
    With[ { bal = BitAnd[ n, 16383 ] / 100.0 },
        {
            Quantity[ 100 - bal, "Percent" ],
            Quantity[ bal      , "Percent" ]
        }
    ];

fitLeftRightBalance100[ ___ ] := Missing[ "NotAvailable" ];


ifitLeftRightBalance // ClearAll;
ifitLeftRightBalance[ { Quantity[ l_, "Percent" ], Quantity[ r_, "Percent" ] } ] := 32768 + Round[ 100 * r ];
ifitLeftRightBalance[ ___ ] := $Failed;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitGPSAccuracy*)
fitGPSAccuracy // ClearAll;
fitGPSAccuracy[ $invalidUINT8 ] := Missing[ "NotAvailable" ];
fitGPSAccuracy[ n_Integer ] := Quantity[ n, "Meters" ];
fitGPSAccuracy[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTorqueEffectiveness*)
fitTorqueEffectiveness // ClearAll;
fitTorqueEffectiveness[ $invalidUINT8 ] := Missing[ "NotAvailable" ];
fitTorqueEffectiveness[ n_Integer ] := Quantity[ n / 2.0, "Percent" ];
fitTorqueEffectiveness[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitPedalSmoothness*)
fitPedalSmoothness // ClearAll;
fitPedalSmoothness[ $invalidUINT8 ] := Missing[ "NotAvailable" ];
fitPedalSmoothness[ n_Integer ] := Quantity[ n / 2.0, "Percent" ];
fitPedalSmoothness[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitCadencePosition*)
fitCadencePosition // ClearAll;
fitCadencePosition[ { $invalidUINT8... } ] := Missing[ "NotAvailable" ];
fitCadencePosition[ list_List ] := fitCadence /@ list;
fitCadencePosition[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitPowerPosition*)
fitPowerPosition // ClearAll;
fitPowerPosition[ { $invalidUINT16... } ] := Missing[ "NotAvailable" ];
fitPowerPosition[ list_List ] := fitPower /@ list;
fitPowerPosition[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitPCO*)
fitPCO // ClearAll;
fitPCO[ $invalidSINT8|0 ] := Missing[ "NotAvailable" ];
fitPCO[ n_Integer ] := Quantity[ n, "Millimeters" ];
fitPCO[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitPowerPhase*)
fitPowerPhase // ClearAll;
fitPowerPhase[ { $invalidUINT8, _ } ] := Missing[ "NotAvailable" ];
fitPowerPhase[ { _, $invalidUINT8 } ] := Missing[ "NotAvailable" ];
fitPowerPhase[ $invalidUINT8 ] := Missing[ "NotAvailable" ];
fitPowerPhase[ { n_Integer, m_Integer } ] := Interval[ fitPowerPhase /@ { n, m } ];
fitPowerPhase[ n_Integer ] := Quantity[ n / 0.7111111, "AngularDegrees" ];
fitPowerPhase[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTime128*)
fitTime128 // ClearAll;
fitTime128[ $invalidUINT8 ] := Missing[ "NotAvailable" ];
fitTime128[ n_Integer ] := secondsToQuantity[ n / 128.0 ];
fitTime128[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitZone*)
fitZone // ClearAll;
fitZone[ $invalidUINT8 ] := Missing[ "NotAvailable" ];
fitZone[ n_Integer ] := n;
fitZone[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
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

(* ::**************************************************************************************************************:: *)
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

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitMessageIndex*)
fitMessageIndex // ClearAll;
fitMessageIndex[ 32768 ] := "Selected";
fitMessageIndex[ 28672 ] := "Reserved";
fitMessageIndex[ 4095  ] := "Mask";
fitMessageIndex[ ___   ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitEventGroup*)
fitEventGroup // ClearAll;
fitEventGroup[ $invalidUINT8 ] := Missing[ "NotAvailable" ];
fitEventGroup[ n_Integer ] := n;
fitEventGroup[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitFrontGearNum*)
fitFrontGearNum // ClearAll;
fitFrontGearNum[ $invalidUINT8Z ] := Missing[ "NotAvailable" ];
fitFrontGearNum[ n_Integer ] := n;
fitFrontGearNum[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitFrontGear*)
fitFrontGear // ClearAll;
fitFrontGear[ $invalidUINT8Z ] := Missing[ "NotAvailable" ];
fitFrontGear[ n_Integer ] := n;
fitFrontGear[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitRearGearNum*)
fitRearGearNum // ClearAll;
fitRearGearNum[ $invalidUINT8Z ] := Missing[ "NotAvailable" ];
fitRearGearNum[ n_Integer ] := n;
fitRearGearNum[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitRearGear*)
fitRearGear // ClearAll;
fitRearGear[ $invalidUINT8Z ] := Missing[ "NotAvailable" ];
fitRearGear[ n_Integer ] := n;
fitRearGear[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitRadarThreatCount*)
fitRadarThreatCount // ClearAll;
fitRadarThreatCount[ $invalidUINT8 ] := Missing[ "NotAvailable" ];
fitRadarThreatCount[ n_Integer ] := n;
fitRadarThreatCount[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitSerialNumber*)
fitSerialNumber // ClearAll;
fitSerialNumber[ $invalidUINT32Z ] := Missing[ "NotAvailable" ];
fitSerialNumber[ n_Integer ] := n;
fitSerialNumber[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitCumulativeOperatingTime*)
fitCumulativeOperatingTime // ClearAll;
fitCumulativeOperatingTime[ $invalidUINT32 ] := Missing[ "NotAvailable" ];
fitCumulativeOperatingTime[ n_Integer ] := Quantity[ n, "Seconds" ];
fitCumulativeOperatingTime[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTimeOffset*)
fitTimeOffset // ClearAll;
fitTimeOffset[ { $invalidUINT32 } ] := Missing[ "NotAvailable" ];
fitTimeOffset[ { a_Integer } ] := secondsToQuantity @ Mod[ a - 1, $invalidUINT32, -$invalidSINT32 ];
fitTimeOffset[ ___ ] := Missing[ "NotAvailable" ];

ifitTimeOffset // ClearAll;
ifitTimeOffset[ q_, n_         ] := ifitTimeOffset @ q;
ifitTimeOffset[ q_Quantity     ] := ifitTimeOffset @ QuantityMagnitude @ UnitConvert[ q, "Seconds" ];
ifitTimeOffset[ offset_Real    ] := ifitTimeOffset @ Round @ offset;
ifitTimeOffset[ offset_Integer ] := { Mod[ offset, $invalidUINT32 ] + 1 };
ifitTimeOffset[ ___ ] := $Failed;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTimeModeArr*)
fitTimeModeArr // ClearAll;
fitTimeModeArr[ list_List ] := fitTimeModeArr0[ fitTimeMode /@ list ];
fitTimeModeArr[ ___ ] := Missing[ "NotAvailable" ];

fitTimeModeArr0 // ClearAll;
fitTimeModeArr0[ { } ] := Missing[ "NotAvailable" ];
fitTimeModeArr0[ { mode_ } ] := mode;
fitTimeModeArr0[ modes_List ] := modes;
fitTimeModeArr0[ ___ ] := Missing[ "NotAvailable" ];

ifitTimeModeArr // ClearAll;
ifitTimeModeArr[ mode_String, 1 ] := { ifitEnum[ "TimeMode" ][ mode ] };
ifitTimeModeArr[ ___ ] := $Failed;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTimeZoneOffset*)
fitTimeZoneOffset // ClearAll;
fitTimeZoneOffset[ { $invalidUINT32, $invalidUINT32 } ] := Missing[ "NotAvailable" ];
fitTimeZoneOffset[ { a_Integer, b_Integer } ] := { a, b };
fitTimeZoneOffset[ ___ ] := Missing[ "NotAvailable" ];

ifitTimeZoneOffset // ClearAll;
ifitTimeZoneOffset[ list:{ __Integer }, n_ ] := list;
ifitTimeZoneOffset[ ___ ] := $Failed;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitProduct*)
fitProduct // ClearAll;
fitProduct[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitProduct[ n_Integer ] := n;
fitProduct[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitSoftwareVersion*)
fitSoftwareVersion // ClearAll;
fitSoftwareVersion[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitSoftwareVersion[ n_Integer ] := n;
fitSoftwareVersion[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitBatteryVoltage*)
fitBatteryVoltage // ClearAll;
fitBatteryVoltage[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitBatteryVoltage[ n_Integer ] := Quantity[ n / 256.0, "Volts" ];
fitBatteryVoltage[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitANTDeviceNumber*)
fitANTDeviceNumber // ClearAll;
fitANTDeviceNumber[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitANTDeviceNumber[ n_Integer ] := n;
fitANTDeviceNumber[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitHardwareVersion*)
fitHardwareVersion // ClearAll;
fitHardwareVersion[ $invalidUINT8 ] := Missing[ "NotAvailable" ];
fitHardwareVersion[ n_Integer ] := n;
fitHardwareVersion[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitANTTransmissionType*)
fitANTTransmissionType // ClearAll;
fitANTTransmissionType[ $invalidUINT8Z ] := Missing[ "NotAvailable" ];
fitANTTransmissionType[ n_Integer ] := n;
fitANTTransmissionType[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitProductName*)
(* cSpell: ignore Tacx *)
fitProductName // ClearAll;
fitProductName[ mp_, { 0, ___ } ] := fitProductName @ mp;
fitProductName[ _, bytes: { __Integer } ] := FromCharacterCode[ TakeWhile[ bytes, Positive ], "UTF-8" ];
fitProductName[ { 1  , id_Integer } ] := fitGarminProduct @ id;
fitProductName[ { 89 , id_Integer } ] := fitTacxProduct @ id;
fitProductName[ { 263, id_Integer } ] := fitFaveroProduct @ id;
fitProductName[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitStrokeCount*)
fitStrokeCount // ClearAll;
fitStrokeCount[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitStrokeCount[ n_Integer ] := Quantity[ n, "Strokes" ];
fitStrokeCount[ { n_ } ] := fitStrokeCount @ n;
fitStrokeCount[ { $invalidUINT16... } ] := Missing[ "NotAvailable" ];
fitStrokeCount[ list_List ] := fitStrokeCount /@ list;
fitStrokeCount[ ___ ] := Missing[ "NotAvailable" ];

ifitStrokeCount // ClearAll;
ifitStrokeCount[ Quantity[ n_, "Strokes" ] ] := ifitStrokeCount @ n;
ifitStrokeCount[ n_Integer ] := n;
ifitStrokeCount[ n_? NumberQ ] := ifitStrokeCount @ Round @ n;
ifitStrokeCount[ ___ ] := $Failed;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitZoneCount*)
fitZoneCount // ClearAll;
fitZoneCount[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitZoneCount[ n_Integer ] := n;
fitZoneCount[ { n_ } ] := fitZoneCount @ n;
fitZoneCount[ { $invalidUINT16... } ] := Missing[ "NotAvailable" ];
fitZoneCount[ list_List ] := fitZoneCount /@ list;
fitZoneCount[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitAverageStrokeCount*)
fitAverageStrokeCount // ClearAll;
fitAverageStrokeCount[ $invalidUINT32 ] := Missing[ "NotAvailable" ];
fitAverageStrokeCount[ n_Integer ] := Quantity[ n / 10.0, "Strokes" ];
fitAverageStrokeCount[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitLaps*)
fitLaps // ClearAll;
fitLaps[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitLaps[ n_Integer ] := Quantity[ n, "Laps" ];
fitLaps[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitLengths*)
fitLengths // ClearAll;
fitLengths[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitLengths[ n_Integer ] := Quantity[ n, IndependentUnit[ "PoolLengths" ] ];
fitLengths[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTrainingStressScore*)
fitTrainingStressScore // ClearAll;
fitTrainingStressScore[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitTrainingStressScore[ n_Integer ] := n / 10.0;
fitTrainingStressScore[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitIntensityFactor*)
fitIntensityFactor // ClearAll;
fitIntensityFactor[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitIntensityFactor[ n_Integer ] := n / 1000.0;
fitIntensityFactor[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitMeters100*)
fitMeters100 // ClearAll;
fitMeters100[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitMeters100[ n_Integer ] := fitMeters100[ n, $distanceUnits ];
fitMeters100[ n_Integer, "Metric" ] := Quantity[ n / 100.0, "Meters" ];
fitMeters100[ n_Integer, "Imperial" ] := Quantity[ 0.0328084 * n, "Feet" ];
fitMeters100[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTrainingEffect*)
fitTrainingEffect // ClearAll;
fitTrainingEffect[ $invalidUINT8|0 ] := Missing[ "NotAvailable" ];
fitTrainingEffect[ n_Integer ] := n/10.0;
fitTrainingEffect[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTrainingEffectDescription*)
fitTrainingEffectDescription // ClearAll;
fitTrainingEffectDescription[ $invalidUINT8|0 ] := Missing[ "NotAvailable" ];
fitTrainingEffectDescription[ n_Integer ] :=
    Which[ n >= 50, "Overreaching",
           n >= 40, "Highly Impacting",
           n >= 30, "Impacting",
           n >= 20, "Maintaining",
           n >= 10, "Some Benefit",
           True   , "No Benefit"
    ];

fitTrainingEffectDescription[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitHRV*)
fitHRV // ClearAll;
fitHRV[ { n_ } ] := fitHRV @ n;
fitHRV[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitHRV[ n_Integer ] := fitHRV[ 1.0*n, $lastHRV ];
fitHRV[ a_Real, b_Real ] /; a/b > 1.75 := Missing[ "NotAvailable" ];
fitHRV[ a_Real, _ ] := ($lastHRV = a; Quantity[ a, "Milliseconds" ]);
fitHRV[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
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

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitWktDuration*)
fitWktDuration // ClearAll;
fitWktDuration[ v_, t_ ] := fitWktDuration0[ fitUINT32 @ v, fitWorkoutStepDuration @ t ];
fitWktDuration[ ___ ] := Missing[ "NotAvailable" ];

fitWktDuration0 // ClearAll;
fitWktDuration0[ _Missing, _        ] := Missing[ "NotAvailable" ];
fitWktDuration0[ _       , _Missing ] := Missing[ "NotAvailable" ];

fitWktDuration0[ w_, "Time"                 ] := fitKiloSeconds @ w;
fitWktDuration0[ w_, "Distance"             ] := fitDistance @ w;
fitWktDuration0[ w_, "HeartRateLessThan"    ] := fitHeartRate @ w;
fitWktDuration0[ w_, "HeartRateGreaterThan" ] := fitHeartRate @ w;
fitWktDuration0[ w_, "Calories"             ] := fitCalories @ w;
fitWktDuration0[ w_, "PowerLessThan"        ] := fitPower16 @ w;
fitWktDuration0[ w_, "PowerGreaterThan"     ] := fitPower16 @ w;

fitWktDuration0[ v_, t_ ] := v;
fitWktDuration0[ ___    ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitWktTarget*)
fitWktTarget // ClearAll;
fitWktTarget[ tVal_, tLow_, tHigh_, type_ ] :=
    fitWktTarget0[
        fitUINT32 @ tVal,
        fitUINT32 @ tLow,
        fitUINT32 @ tHigh,
        fitWorkoutStepTarget @ type
    ];

fitWktTarget[ ___ ] := Missing[ "NotAvailable" ];


$$wktStepPowerType = "Power" | "Power3S" | "Power10S" | "Power30S" | "PowerLap";
$$wktStepHRType    = "HeartRate" | "HeartRate3S" | "HeartRate10S" | "HeartRate30S" | "HeartRateLap";

fitWktTarget0 // ClearAll;
fitWktTarget0[ w_, _Missing, _Missing, $$wktStepPowerType ] := fitWktTargetPower @ w;
fitWktTarget0[ _, low_Integer, high_Integer, $$wktStepPowerType ] := fitPowerInterval[ low, high ];
fitWktTarget0[ _, low_Integer, high_Integer, $$wktStepHRType ] := fitHRInterval[ low, high ];
fitWktTarget0[ w_Integer, _Missing|0, _Missing|0, _Missing ] := w;
fitWktTarget0[ w_Integer, _Missing|0, _Missing|0, "Open" ] := w;
fitWktTarget0[ _Missing, _Missing|0, _Missing|0, _ ] := Missing[ "NotAvailable" ];

(* https://developer.garmin.com/fit/file-types/workout/ *)

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitWktTargetValue*)
fitWktTargetValue // ClearAll;
fitWktTargetValue[ v_, t_ ] := fitWktTargetValue0[ fitUINT32 @ v, fitWorkoutStepTarget @ t ];
fitWktTargetValue[ ___ ] := Missing[ "NotAvailable" ];

fitWktTargetValue0 // ClearAll;
fitWktTargetValue0[ _Missing, _        ] := Missing[ "NotAvailable" ];
fitWktTargetValue0[ _       , _Missing ] := Missing[ "NotAvailable" ];

fitWktTargetValue0[ w_, "Power"      ] := fitWktTargetPower @ w;
fitWktTargetValue0[ w_, "Power3S"    ] := fitWktTargetPower @ w;
fitWktTargetValue0[ w_, "PowerLap"   ] := fitWktTargetPower @ w;
fitWktTargetValue0[ w_, "HeartRate"  ] := fitHeartRate @ w;
fitWktTargetValue0[ w_, "Cadence"    ] := fitCadence @ w;
fitWktTargetValue0[ w_, "Speed"      ] := fitSpeed @ w;
fitWktTargetValue0[ w_, "Grade"      ] := fitGrade @ w;
fitWktTargetValue0[ w_, "Resistance" ] := fitResistance @ w;
fitWktTargetValue0[ 0 , "Open"       ] := Missing[ "NotAvailable" ];

fitWktTargetValue0[ v_, t_ ] := v;
fitWktTargetValue0[ ___    ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitPowerInterval*)
fitPowerInterval // ClearAll;
fitPowerInterval[ a_, b_ ] := fitPowerInterval0[ fitWktTargetPower @ a, fitWktTargetPower @ b ];
fitPowerInterval[ ___ ] := Missing[ "NotAvailable" ];

fitPowerInterval0 // ClearAll;
fitPowerInterval0[ a_Quantity, b_Quantity ] := fitPowerInterval1 @ Interval[ { a, b } ];
fitPowerInterval0[ a_Interval, b_Interval ] := fitPowerInterval1 @ IntervalUnion[ a, b ];

fitPowerInterval1 // ClearAll;
fitPowerInterval1[ q: Quantity[ _Interval, "Watts" ] ] := q;
fitPowerInterval1[ q: Quantity[ _Interval, _ ] ] := UnitConvert[ q, "Watts" ];
fitPowerInterval1[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitHRInterval*)
fitHRInterval // ClearAll;
fitHRInterval[ a_, b_ ] := fitHRInterval0[ fitHeartRate @ a, fitHeartRate @ b ];
fitHRInterval[ ___ ] := Missing[ "NotAvailable" ];

fitHRInterval0 // ClearAll;
fitHRInterval0[ a_Quantity, b_Quantity ] := fitHRInterval1 @ Interval[ { a, b } ];
fitHRInterval0[ a_Interval, b_Interval ] := fitHRInterval1 @ IntervalUnion[ a, b ];

fitHRInterval1 // ClearAll;
fitHRInterval1[ q: Quantity[ _Interval, "Beats"/"Minutes" ] ] := q;
fitHRInterval1[ q: Quantity[ _Interval, _ ] ] := UnitConvert[ q, "Beats"/"Minutes" ];
fitHRInterval1[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitWktTargetPower*)
fitWktTargetPower // ClearAll;
fitWktTargetPower[ w_ ] := fitWktTargetPower[ w, $fileType ];
fitWktTargetPower[ w_, "Activity" ] := fitPower16 @ w;
fitWktTargetPower[ w_, _ ] := If[ TrueQ[ w > 1000 ], fitPower16[ w - 1000 ], fitPZRange[ w ] ];
fitWktTargetPower[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitPZRange*)
fitPZRange // ClearAll;
fitPZRange[ w_Integer ] := fitPZRange[ w, $ftp ];
fitPZRange[ w: $$powerZone, ftp_? NumberQ ] := Quantity[ Interval[ $pzBuckets[[ w ]]*ftp ], "Watts" ];
fitPZRange[ w: $$powerZone, ftp_ ] := Interval[ $pzBuckets[[ w ]] * QuantityVariable[ "FTP", "Power" ] ];
fitPZRange[ w_, _ ] := w;
fitPZRange[ ___ ] := Missing[ "NotAvailable" ];

$pzBuckets := cached @ Append[
    Partition[ $powerZoneThresholds, 2, 1 ],
    { 1.5, Infinity }
];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitWktTargetType*)

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Fit Value Units*)

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*gramsToQuantity*)
gramsToQuantity // ClearAll;
gramsToQuantity[ n_ ] := gramsToQuantity[ n, $weightUnits ];
gramsToQuantity[ n_, "Imperial" ] := Quantity[ 0.00220462 * n, "Pounds" ];

gramsToQuantity[ n_, _ ] :=
    Which[ n > 1000, Quantity[  0.001 * n, "Kilograms"   ],
           n > 1   , Quantity[  1.000 * n, "Grams"       ],
           True    , Quantity[ 1000.0 * n, "Milligrams"  ]
    ];

gramsToQuantity[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*joulesToQuantity*)
joulesToQuantity // ClearAll;

joulesToQuantity[ n_ ] :=
    Which[ n > 1000000, Quantity[ 0.000001 * n, "Megajoules"  ],
           n > 1000   , Quantity[ 0.001 * n   , "Kilojoules"  ],
           True       , Quantity[ 1.0 * n     , "Joules"      ]
    ];

joulesToQuantity[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*pascalsToQuantity*)
pascalsToQuantity // ClearAll;
pascalsToQuantity[ n_ ] := pressureQuantity[ n, $pressureUnits ];
pascalsToQuantity[ n_, "Imperial" ] := Quantity[ 0.00014504 * n, "PoundsForce"/"Inches"^2 ];
pascalsToQuantity[ n_, _ ] := Quantity[ 1.0 * n, "Pascals" ];
pascalsToQuantity[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*metersToQuantity*)
metersToQuantity // ClearAll;
metersToQuantity[ n_ ] := metersToQuantity[ n, $distanceUnits ];
metersToQuantity[ n_, "Imperial" ] := imperialDistance @ n;
metersToQuantity[ n_, _ ] := metricDistance @ n;
metersToQuantity[ ___ ] := Missing[ "NotAvailable" ];

imperialDistance // ClearAll;
imperialDistance[ n_ ] :=
    Which[ n > 1609.34, Quantity[ 0.000621371 * n, "Miles"  ],
           n > 0.3048 , Quantity[ 3.28084 * n    , "Feet"   ],
           True       , Quantity[ 39.3701 * n    , "Inches" ]
    ];

metricDistance // ClearAll;
metricDistance[ n_ ] :=
    Which[ n > 1000, Quantity[  0.001 * n, "Kilometers"  ],
           n > 1   , Quantity[  1.000 * n, "Meters"      ],
           n > 0.05, Quantity[  100.0 * n, "Centimeters" ],
           True    , Quantity[ 1000.0 * n, "Millimeters" ]
    ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*speedQuantity*)
speedQuantity // ClearAll;
speedQuantity[ n_ ] := speedQuantity[ n, $speedUnits ];
speedQuantity[ n_, "Imperial" ] := Quantity[ 2.23694 * n, "Miles"/"Hours" ];
speedQuantity[ n_, _ ] := Quantity[ 1.0 * n, "Meters"/"Seconds" ];
speedQuantity[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*temperatureQuantity*)
temperatureQuantity // ClearAll;
temperatureQuantity[ n_ ] := temperatureQuantity[ n, $temperatureUnits ];
temperatureQuantity[ n_, "Imperial" ] := Quantity[ 32.0 + 1.8 n, "DegreesFahrenheit" ];
temperatureQuantity[ n_, _ ] := Quantity[ 1.0 * n, "DegreesCelsius" ];
temperatureQuantity[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*cadenceQuantity*)
cadenceQuantity // ClearAll;
cadenceQuantity[ n_ ] := cadenceQuantity[ n, $sport ]; (* TODO: set this up in prefs *)
cadenceQuantity[ n_, "Cycling" ] := Quantity[ 1.0*n, "Revolutions"/"Minutes" ];
cadenceQuantity[ n_, "Walking"|"Running"|"Hiking" ] := Quantity[ 2.0*n, "Steps"/"Minutes" ];
cadenceQuantity[ n_, "Swimming" ] := Quantity[ 2.0*n, "Strokes"/"Minutes" ];
cadenceQuantity[ n_, _ ] := Quantity[ 1.0 * n, IndependentUnit[ "Cycles" ]/"Minutes" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*cycleQuantity*)
cycleQuantity // ClearAll;
cycleQuantity[ n_ ] := cycleQuantity[ n, $sport ];
cycleQuantity[ n_, "Cycling" ] := Quantity[ 1.0*n, "Revolutions" ];
cycleQuantity[ n_, "Walking"|"Running"|"Hiking" ] := Quantity[ 2.0*n, "Steps" ];
cycleQuantity[ n_, "Swimming" ] := Quantity[ 2.0*n, "Strokes" ];
cycleQuantity[ n_, _ ] := Quantity[ 1.0*n, IndependentUnit[ "Cycles" ] ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*ascentQuantity*)
ascentQuantity // ClearAll;
ascentQuantity[ n_ ] := ascentQuantity[ n, $altitudeUnits ];
ascentQuantity[ n_, "Imperial" ] := Quantity[ 3.28084 * n, "Feet" ];
ascentQuantity[ n_, _ ] := Quantity[ 1.0 * n, "Meters" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*secondsToTimeObject*)
secondsToTimeObject // ClearAll;
secondsToTimeObject[ s_ ] := secondsToTimeObject[ s, QuotientRemainder[ s, 3600 ] ];
secondsToTimeObject[ _, { h_, s_ } ] := TimeObject @ Prepend[ QuotientRemainder[ s, 60 ], h ];
secondsToTimeObject[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*secondsToQuantity*)
secondsToQuantity[ n_ ] := secondsToQuantity0[ 1.0 * n ];

secondsToQuantity0 := secondsToQuantity0 =
    Block[ { PrintTemporary },
        ResourceFunction[ "SecondsToQuantity", "Function" ]
    ];

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Optimize Definitions*)

optimizeValueDefinition // beginDefinition;

optimizeValueDefinition[ HoldComplete[ sym_Symbol ] ] := (
    DownValues[ sym ] =
        ReplaceAll[
            ReplaceRepeated[
                DownValues @ sym,
                Join[
                    DownValues @ fitMissing,
                    DownValues @ fitQuantity,
                    SubValues @ fitQuantity,
                    SubValues @ fitEnum,
                    {
                        HoldPattern @ fitQuantity0[ value_, units_, 1, 0 ] :>
                            fitQuantity1[ value, units ]
                    }
                ]
            ],
            HoldPattern @ $enumTypeData[ name_String, v_ ] :>
                With[ { enum = $enumTypeData @ name },
                    enum @ v /; AssociationQ @ enum
                ]
        ]
);

optimizeValueDefinition // endDefinition;
optimizeValueDefinition // excludeFromMX;

Scan[ optimizeValueDefinition, Internal`BagPart[ $generatedDefinitions, All ] ];

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Footer*)
End[ ];
EndPackage[ ];

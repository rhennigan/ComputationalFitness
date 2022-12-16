(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "RH`ComputationalFitness`FIT`" ];
Needs[ "RH`ComputationalFitness`" ];
Needs[ "RH`ComputationalFitness`Package`" ];
Begin[ "`Private`" ];


(* TODO: generate dumb value functions for unknown defs in the SDK *)


(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Definition Utilities*)

(* ::**********************************************************************:: *)
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

(* ::**********************************************************************:: *)
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

(* ::**********************************************************************:: *)
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

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Values*)

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Definition Generation*)

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Unsupported Messages*)
$generatedDefinitions = Internal`Bag[ ];

(* ::**********************************************************************:: *)
(* ::Subsubsubsection::Closed:: *)
(*makeInterpreter*)
makeInterpreter // beginDefinition;
makeInterpreter[ { s_String, a_String } ] := Symbol[ s ][ a ];
makeInterpreter[ { "fitQuantity", s_String, units_, a___ } ] := fitQuantity[ Symbol @ s, units, a ];
makeInterpreter[ s_String ] := Symbol @ s;
makeInterpreter // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsubsubsection::Closed:: *)
(*setFieldDefinitions*)
setFieldDefinitions // beginDefinition;

setFieldDefinitions[ name_String ] :=
    setFieldDefinitions[ Symbol[ "fit" <> name <> "Value$G" ], name ];

setFieldDefinitions[ sym_Symbol, name_String ] :=
    setFieldDefinitions[ sym, name, $messageDefs @ name ];

setFieldDefinitions[ valueSym_Symbol, name_String, defs_Association ] := (
    fitValue[ name, field_, value_ ] := valueSym[ field, value ];

    valueSym // ClearAll;
    KeyValueMap[
        Function @ With[
            {
                int = makeInterpreter @ #2[ "Interpreter" ],
                idx = #2[ "Index" ]
            },
            valueSym[ #1, v_ ] := int @ v[[ idx ]]
        ],
        defs
    ];
    valueSym[ _, _ ] := Missing[ "NotAvailable" ];

    Internal`StuffBag[ $generatedDefinitions, HoldComplete @ valueSym ]
);

setFieldDefinitions // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsubsubsection::Closed:: *)
(*Generate Definitions*)
setFieldDefinitions /@ Complement[ Keys @ $messageDefs, $supportedMessageTypes ];

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*fitValue*)
fitValue // ClearAll;
fitValue[ type_, "MessageType", v_ ] := type;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*FileID*)
setFieldDefinitions[ fitFileIDValue, "FileID" ];

fitFileIDValue[ "ProductName", v_ ] := fitProductName[ v[[ { "Manufacturer", "Product" } ]], v[[ "ProductName" ]] ];
fitFileIDValue[ _            , _  ] := Missing[ "NotAvailable" ];

indexTranslate[ "FileID", fitFileIDValue ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*UserProfile*)
setFieldDefinitions[ fitUserProfileValue, "UserProfile" ];

fitUserProfileValue[ "GlobalID"             , v_ ] := fitGlobalID @ v[[ "GlobalID" ]];
fitUserProfileValue[ "Height"               , v_ ] := fitHeight @ v[[ "Height" ]];
fitUserProfileValue[ "UserRunningStepLength", v_ ] := fitStepLength @ v[[ "UserRunningStepLength" ]];
fitUserProfileValue[ "UserWalkingStepLength", v_ ] := fitStepLength @ v[[ "UserWalkingStepLength" ]];
fitUserProfileValue[ _                      , _  ] := Missing[ "NotAvailable" ];

indexTranslate[ "UserProfile", fitUserProfileValue ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Activity*)
setFieldDefinitions[ fitActivityValue, "Activity" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Lap*)
setFieldDefinitions[ fitLapValue, "Lap" ];

fitLapValue[ "StartPosition"        , v_ ] := fitGeoPosition @ v[[ { "StartPositionLatitude", "StartPositionLongitude" } ]];
fitLapValue[ "EndPosition"          , v_ ] := fitGeoPosition @ v[[ { "EndPositionLatitude", "EndPositionLongitude" } ]];
fitLapValue[ "TotalCycles"          , v_ ] := fitCycles32[ v[[ "TotalCycles" ]], v[[ "TotalFractionalCycles" ]] ];
fitLapValue[ "AverageSpeed"         , v_ ] := fitSpeedSelect[ v[[ "EnhancedAverageSpeed" ]], v[[ "AverageSpeed" ]] ];
fitLapValue[ "MaximumSpeed"         , v_ ] := fitSpeedSelect[ v[[ "EnhancedMaximumSpeed" ]], v[[ "MaximumSpeed" ]] ];
fitLapValue[ "NumberOfLengths"      , v_ ] := fitLengths @ v[[ "NumberOfLengths" ]];
fitLapValue[ "LeftRightBalance"     , v_ ] := fitLeftRightBalance100 @ v[[ "LeftRightBalance" ]];
fitLapValue[ "NumberOfActiveLengths", v_ ] := fitLengths @ v[[ "NumberActiveLengths" ]];
fitLapValue[ "AverageAltitude"      , v_ ] := fitAltitudeSelect[ v[[ "EnhancedAverageAltitude" ]], v[[ "AverageAltitude" ]] ];
fitLapValue[ "MaximumAltitude"      , v_ ] := fitAltitudeSelect[ v[[ "EnhancedMaximumAltitude" ]], v[[ "MaximumAltitude" ]] ];
fitLapValue[ "MinimumAltitude"      , v_ ] := fitAltitudeSelect[ v[[ "EnhancedMinimumAltitude" ]], v[[ "MinimumAltitude" ]] ];
fitLapValue[ "StrokeCount"          , v_ ] := fitStrokeCount @ v[[ "StrokeCount" ]];
fitLapValue[ "AverageCadence"       , v_ ] := fitCadence[ v[[ "AverageCadence" ]], v[[ "AverageFractionalCadence" ]] ];
fitLapValue[ "MaximumCadence"       , v_ ] := fitCadence[ v[[ "MaximumCadence" ]], v[[ "MaximumFractionalCadence" ]] ];

indexTranslate[ "Lap", fitLapValue ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*DeviceSettings*)
fitValue[ "DeviceSettings", name_, value_ ] := fitDeviceSettingsValue[ name, value ];

fitDeviceSettingsValue // ClearAll;
fitDeviceSettingsValue[ "UTCOffset"             , v_ ] := fitUINT32 @ v[[ "UTCOffset" ]];
fitDeviceSettingsValue[ "TimeOffset"            , v_ ] := fitTimeOffset @ v[[ "TimeOffset" ]];
fitDeviceSettingsValue[ "ClockTime"             , v_ ] := fitDateTime @ v[[ "ClockTime" ]];
fitDeviceSettingsValue[ "PagesEnabled"          , v_ ] := fitUINT16BF @ v[[ "PagesEnabled" ]];
fitDeviceSettingsValue[ "DefaultPage"           , v_ ] := fitUINT16BF @ v[[ "DefaultPage" ]];
fitDeviceSettingsValue[ "AutoSyncMinSteps"      , v_ ] := fitSteps @ v[[ "AutoSyncMinimumSteps" ]];
fitDeviceSettingsValue[ "AutoSyncMinTime"       , v_ ] := fitMinutes @ v[[ "AutoSyncMinimumTime" ]];
fitDeviceSettingsValue[ "ActiveTimeZone"        , v_ ] := fitUINT8 @ v[[ "ActiveTimeZone" ]];
fitDeviceSettingsValue[ "TimeMode"              , v_ ] := fitTimeModeArr @ v[[ "TimeMode" ]];
fitDeviceSettingsValue[ "TimeZoneOffset"        , v_ ] := fitTimeZoneOffset @ v[[ "TimeZoneOffset" ]];
fitDeviceSettingsValue[ "BacklightMode"         , v_ ] := fitBacklightMode @ v[[ "BacklightMode" ]];
fitDeviceSettingsValue[ "ActivityTrackerEnabled", v_ ] := fitBool @ v[[ "ActivityTrackerEnabled" ]];
fitDeviceSettingsValue[ "MoveAlertEnabled"      , v_ ] := fitBool @ v[[ "MoveAlertEnabled" ]];
fitDeviceSettingsValue[ "DateMode"              , v_ ] := fitDateMode @ v[[ "DateMode" ]];
fitDeviceSettingsValue[ "DisplayOrientation"    , v_ ] := fitDisplayOrientation @ v[[ "DisplayOrientation" ]];
fitDeviceSettingsValue[ "MountingSide"          , v_ ] := fitSide @ v[[ "MountingSide" ]];
fitDeviceSettingsValue[ "TapSensitivity"        , v_ ] := fitTapSensitivity @ v[[ "TapSensitivity" ]];
fitDeviceSettingsValue[ _                       , _  ] := Missing[ "NotAvailable" ];

indexTranslate[ "DeviceSettings", fitDeviceSettingsValue ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Record*)
fitValue[ "Record", name_, value_ ] := fitRecordValue[ name, value ];

fitRecordValue // ClearAll;
fitRecordValue[ "Timestamp"                      , v_ ] := fitDateTime @ v[[ "Timestamp" ]];
fitRecordValue[ "GeoPosition"                    , v_ ] := fitGeoPosition @ v[[ { "PositionLatitude", "PositionLongitude" } ]];
fitRecordValue[ "Distance"                       , v_ ] := fitDistance @ v[[ "Distance" ]];
fitRecordValue[ "TimeFromCourse"                 , v_ ] := fitTimeFromCourse @ v[[ "TimeFromCourse" ]];
fitRecordValue[ "TotalCycles"                    , v_ ] := fitCycles32 @ v[[ "TotalCycles" ]];
fitRecordValue[ "AccumulatedPower"               , v_ ] := fitAccumulatedPower @ v[[ { "Timestamp", "AccumulatedPower" } ]];
fitRecordValue[ "Altitude"                       , v_ ] := fitAltitudeSelect[ v[[ "EnhancedAltitude" ]], v[[ "Altitude" ]] ];
fitRecordValue[ "Speed"                          , v_ ] := fitSpeedSelect[ v[[ "EnhancedSpeed" ]], v[[ "Speed" ]] ];
fitRecordValue[ "Power"                          , v_ ] := fitPower16 @ v[[ "Power" ]];
fitRecordValue[ "Grade"                          , v_ ] := fitGrade @ v[[ "Grade" ]];
fitRecordValue[ "CompressedAccumulatedPower"     , v_ ] := fitCompressedAccumulatedPower @ v[[ "CompressedAccumulatedPower" ]];
fitRecordValue[ "VerticalSpeed"                  , v_ ] := fitVerticalSpeed @ v[[ "VerticalSpeed" ]];
fitRecordValue[ "Calories"                       , v_ ] := fitCalories @ v[[ "Calories" ]];
fitRecordValue[ "VerticalOscillation"            , v_ ] := fitVerticalOscillation @ v[[ "VerticalOscillation" ]];
fitRecordValue[ "StanceTimePercent"              , v_ ] := fitStanceTimePercent @ v[[ "StanceTimePercent" ]];
fitRecordValue[ "StanceTime"                     , v_ ] := fitStanceTime @ v[[ "StanceTime" ]];
fitRecordValue[ "BallSpeed"                      , v_ ] := fitBallSpeed @ v[[ "BallSpeed" ]];
fitRecordValue[ "Cadence256"                     , v_ ] := fitCadence256 @ v[[ "Cadence256" ]];
fitRecordValue[ "TotalHemoglobinConcentration"   , v_ ] := fitHemoglobin @ v[[ "TotalHemoglobinConcentration" ]];
fitRecordValue[ "TotalHemoglobinConcentrationMin", v_ ] := fitHemoglobin @ v[[ "TotalHemoglobinConcentrationMinimum" ]];
fitRecordValue[ "TotalHemoglobinConcentrationMax", v_ ] := fitHemoglobin @ v[[ "TotalHemoglobinConcentrationMaximum" ]];
fitRecordValue[ "SaturatedHemoglobinPercent"     , v_ ] := fitHemoglobinPercent @ v[[ "SaturatedHemoglobinPercent" ]];
fitRecordValue[ "SaturatedHemoglobinPercentMin"  , v_ ] := fitHemoglobinPercent @ v[[ "SaturatedHemoglobinPercentMinimum" ]];
fitRecordValue[ "SaturatedHemoglobinPercentMax"  , v_ ] := fitHemoglobinPercent @ v[[ "SaturatedHemoglobinPercentMaximum" ]];
fitRecordValue[ "HeartRate"                      , v_ ] := fitHeartRate @ v[[ "HeartRate" ]];
fitRecordValue[ "Cadence"                        , v_ ] := fitCadence[ v[[ "Cadence" ]], v[[ "FractionalCadence" ]] ];
fitRecordValue[ "Resistance"                     , v_ ] := fitResistance @ v[[ "Resistance" ]];
fitRecordValue[ "CycleLength"                    , v_ ] := fitCycleLength @ v[[ "CycleLength" ]];
fitRecordValue[ "Temperature"                    , v_ ] := fitTemperature8 @ v[[ "Temperature" ]];
fitRecordValue[ "Cycles"                         , v_ ] := fitCycles8 @ v[[ "Cycles" ]];
fitRecordValue[ "LeftRightBalance"               , v_ ] := fitLeftRightBalance @ v[[ "LeftRightBalance" ]];
fitRecordValue[ "GPSAccuracy"                    , v_ ] := fitGPSAccuracy @ v[[ "GPSAccuracy" ]];
fitRecordValue[ "ActivityType"                   , v_ ] := fitActivityType @ v[[ "ActivityType" ]];
fitRecordValue[ "LeftTorqueEffectiveness"        , v_ ] := fitTorqueEffectiveness @ v[[ "LeftTorqueEffectiveness" ]];
fitRecordValue[ "RightTorqueEffectiveness"       , v_ ] := fitTorqueEffectiveness @ v[[ "RightTorqueEffectiveness" ]];
fitRecordValue[ "LeftPedalSmoothness"            , v_ ] := fitPedalSmoothness @ v[[ "LeftPedalSmoothness" ]];
fitRecordValue[ "RightPedalSmoothness"           , v_ ] := fitPedalSmoothness @ v[[ "RightPedalSmoothness" ]];
fitRecordValue[ "CombinedPedalSmoothness"        , v_ ] := fitPedalSmoothness @ v[[ "CombinedPedalSmoothness" ]];
fitRecordValue[ "Time128"                        , v_ ] := fitTime128 @ v[[ "Time128" ]];
fitRecordValue[ "StrokeType"                     , v_ ] := fitStrokeType @ v[[ "StrokeType" ]];
fitRecordValue[ "Zone"                           , v_ ] := fitZone @ v[[ "Zone" ]];
fitRecordValue[ "DeviceIndex"                    , v_ ] := fitDeviceIndex @ v[[ "DeviceIndex" ]];
fitRecordValue[ "LeftPlatformCenterOffset"       , v_ ] := fitPCO @ v[[ "LeftPlatformCenterOffset" ]];
fitRecordValue[ "RightPlatformCenterOffset"      , v_ ] := fitPCO @ v[[ "RightPlatformCenterOffset" ]];
fitRecordValue[ "LeftPowerPhaseStart"            , v_ ] := fitPowerPhase @ v[[ "LeftPowerPhase" ]][[  1 ]];
fitRecordValue[ "LeftPowerPhaseEnd"              , v_ ] := fitPowerPhase @ v[[ "LeftPowerPhase" ]][[ -1 ]];
fitRecordValue[ "LeftPowerPhasePeakStart"        , v_ ] := fitPowerPhase @ v[[ "LeftPowerPhasePeak" ]][[  1 ]];
fitRecordValue[ "LeftPowerPhasePeakEnd"          , v_ ] := fitPowerPhase @ v[[ "LeftPowerPhasePeak" ]][[ -1 ]];
fitRecordValue[ "RightPowerPhaseStart"           , v_ ] := fitPowerPhase @ v[[ "RightPowerPhase" ]][[  1 ]];
fitRecordValue[ "RightPowerPhaseEnd"             , v_ ] := fitPowerPhase @ v[[ "RightPowerPhase" ]][[ -1 ]];
fitRecordValue[ "RightPowerPhasePeakStart"       , v_ ] := fitPowerPhase @ v[[ "RightPowerPhasePeak" ]][[  1 ]];
fitRecordValue[ "RightPowerPhasePeakEnd"         , v_ ] := fitPowerPhase @ v[[ "RightPowerPhasePeak" ]][[ -1 ]];
fitRecordValue[ "BatterySOC"                     , v_ ] := fit2Percent @ v[[ "BatteryStateOfCharge" ]];
fitRecordValue[ "MotorPower"                     , v_ ] := fitPower16 @ v[[ "MotorPower" ]];
fitRecordValue[ "VerticalRatio"                  , v_ ] := fitPercent16 @ v[[ "VerticalRatio" ]];
fitRecordValue[ "StanceTimeBalance"              , v_ ] := fitPercent16 @ v[[ "StanceTimeBalance" ]];
fitRecordValue[ "StepLength"                     , v_ ] := fitLength10mm @ v[[ "StepLength" ]];
fitRecordValue[ "AbsolutePressure"               , v_ ] := fitPressure32 @ v[[ "AbsolutePressure" ]];
fitRecordValue[ "CNSLoad"                        , v_ ] := fitPercent8 @ v[[ "CentralNervousSystemLoading" ]];
fitRecordValue[ "CompressedSpeedDistance"        , v_ ] := fitUINT8 @ v[[ "CompressedSpeedDistance" ]];
fitRecordValue[ "CoreTemperature"                , v_ ] := fitTemperature100C @ v[[ "CoreTemperature" ]];
fitRecordValue[ "Depth"                          , v_ ] := fitDepth @ v[[ "Depth" ]];
fitRecordValue[ "EBikeAssistLevel"               , v_ ] := fitPercent8 @ v[[ "ElectricBikeAssistLevelPercent" ]];
fitRecordValue[ "EBikeAssistMode"                , v_ ] := fitUINT8 @ v[[ "ElectricBikeAssistMode" ]];
fitRecordValue[ "EBikeBatteryLevel"              , v_ ] := fitPercent8 @ v[[ "ElectricBikeBatteryLevel" ]];
fitRecordValue[ "EBikeTravelRange"               , v_ ] := fitTravelRange @ v[[ "ElectricBikeTravelRange" ]];
fitRecordValue[ "Flow"                           , v_ ] := fitFloat32 @ v[[ "Flow" ]];
fitRecordValue[ "Grit"                           , v_ ] := fitFloat32 @ v[[ "Grit" ]];
fitRecordValue[ "N2Load"                         , v_ ] := fitUINT16 @ v[[ "NitrogenLoad" ]];
fitRecordValue[ "NDLTime"                        , v_ ] := fitUINT32 @ v[[ "NoDecompressionLimitTime" ]];
fitRecordValue[ "NextStopDepth"                  , v_ ] := fitDepth @ v[[ "NextStopDepth" ]];
fitRecordValue[ "NextStopTime"                   , v_ ] := fitSeconds32 @ v[[ "NextStopTime" ]];
fitRecordValue[ "Speed1S"                        , v_ ] := fitUINT8 @ v[[ "Speed1S" ]];
fitRecordValue[ "TimeToSurface"                  , v_ ] := fitSeconds32 @ v[[ "TimeToSurface" ]];
(* fitRecordValue[ "Unknown61"                      , v_ ] := fitUINT16 @ v[[ 64 ]];
fitRecordValue[ "PerformanceCondition"           , v_ ] := fitSINT8 @ v[[ 65 ]];
fitRecordValue[ "Unknown90"                      , v_ ] := fitSINT8 @ v[[ 66 ]];
fitRecordValue[ "RespirationRate"                , v_ ] := fitRespirationRate @ v[[ 67 ]]; *)
(* fitRecordValue[ "HeartRateVariability"           , v_ ] := fitHRV @ v[[ 64 ]]; *)
fitRecordValue[ "PowerZone"                      , v_ ] := fitPowerZone @ v[[ "Power" ]];
fitRecordValue[ "HeartRateZone"                  , v_ ] := fitHeartRateZone @ v[[ "HeartRate" ]];
fitRecordValue[ _                                , _  ] := Missing[ "NotAvailable" ];

indexTranslate[ "Record", fitRecordValue ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Event*)
fitValue[ "Event", name_, value_ ] := fitEventValue[ name, value ];

fitEventValue // ClearAll;
fitEventValue[ "Timestamp"           , v_ ] := fitDateTime @ v[[ "Timestamp" ]];
fitEventValue[ "Data"                , v_ ] := fitUINT32 @ v[[ "Data" ]];
fitEventValue[ "Data16"              , v_ ] := fitUINT16 @ v[[ "Data16" ]];
fitEventValue[ "Score"               , v_ ] := fitUINT16 @ v[[ "Score" ]];
fitEventValue[ "OpponentScore"       , v_ ] := fitUINT16 @ v[[ "OpponentScore" ]];
fitEventValue[ "Event"               , v_ ] := fitEvent @ v[[ "Event" ]];
fitEventValue[ "EventType"           , v_ ] := fitEventType @ v[[ "EventType" ]];
fitEventValue[ "EventGroup"          , v_ ] := fitEventGroup @ v[[ "EventGroup" ]];
fitEventValue[ "FrontGearNum"        , v_ ] := fitFrontGearNum @ v[[ "FrontGearNumber" ]];
fitEventValue[ "FrontGear"           , v_ ] := fitFrontGear @ v[[ "FrontGear" ]];
fitEventValue[ "RearGearNum"         , v_ ] := fitRearGearNum @ v[[ "RearGearNumber" ]];
fitEventValue[ "RearGear"            , v_ ] := fitRearGear @ v[[ "RearGear" ]];
fitEventValue[ "RadarThreatLevelType", v_ ] := fitRadarThreatLevelType @ v[[ "RadarThreatLevelMaximum" ]];
fitEventValue[ "RadarThreatCount"    , v_ ] := fitRadarThreatCount @ v[[ "RadarThreatCount" ]];
fitEventValue[ _                     , _  ] := Missing[ "NotAvailable" ];

indexTranslate[ "Event", fitEventValue ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*DeviceInformation*)
fitValue[ "DeviceInformation", name_, value_ ] := fitDeviceInformationValue[ name, value ];

fitDeviceInformationValue // ClearAll;
fitDeviceInformationValue[ "Timestamp"              , v_ ] := fitDateTime @ v[[ "Timestamp" ]];
fitDeviceInformationValue[ "SerialNumber"           , v_ ] := fitSerialNumber @ v[[ "SerialNumber" ]];
fitDeviceInformationValue[ "CumulativeOperatingTime", v_ ] := fitCumulativeOperatingTime @ v[[ "CumulativeOperatingTime" ]];
fitDeviceInformationValue[ "Manufacturer"           , v_ ] := fitManufacturer @ v[[ "Manufacturer" ]];
fitDeviceInformationValue[ "Product"                , v_ ] := fitProduct @ v[[ "Product" ]];
fitDeviceInformationValue[ "SoftwareVersion"        , v_ ] := fitSoftwareVersion @ v[[ "SoftwareVersion" ]];
fitDeviceInformationValue[ "BatteryVoltage"         , v_ ] := fitBatteryVoltage @ v[[ "BatteryVoltage" ]];
fitDeviceInformationValue[ "ANTDeviceNumber"        , v_ ] := fitANTDeviceNumber @ v[[ "ANTDeviceNumber" ]];
fitDeviceInformationValue[ "DeviceIndex"            , v_ ] := fitDeviceIndex @ v[[ "DeviceIndex" ]];
fitDeviceInformationValue[ "DeviceType"             , v_ ] := fitANTPlusDeviceType @ v[[ "DeviceType" ]];
fitDeviceInformationValue[ "HardwareVersion"        , v_ ] := fitHardwareVersion @ v[[ "HardwareVersion" ]];
fitDeviceInformationValue[ "BatteryStatus"          , v_ ] := fitBatteryStatus @ v[[ "BatteryStatus" ]];
fitDeviceInformationValue[ "SensorPosition"         , v_ ] := fitBodyLocation @ v[[ "SensorPosition" ]];
fitDeviceInformationValue[ "ANTTransmissionType"    , v_ ] := fitANTTransmissionType @ v[[ "ANTTransmissionType" ]];
fitDeviceInformationValue[ "ANTNetwork"             , v_ ] := fitANTNetwork @ v[[ "ANTNetwork" ]];
fitDeviceInformationValue[ "SourceType"             , v_ ] := fitSourceType @ v[[ "SourceType" ]];
fitDeviceInformationValue[ "ProductName"            , v_ ] := fitProductName[ v[[ { "Manufacturer", "Product" } ]], v[[ "ProductName" ]] ];
fitDeviceInformationValue[ "Descriptor"             , v_ ] := fitString @ v[[ "Descriptor" ]];
fitDeviceInformationValue[ _                        , _  ] := Missing[ "NotAvailable" ];

indexTranslate[ "DeviceInformation", fitDeviceInformationValue ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Session*)
fitValue[ "Session", name_, value_ ] := fitSessionValue[ name, value ];

fitSessionValue // ClearAll;
fitSessionValue[ "Timestamp"                              , v_ ] := fitDateTime @ v[[ "Timestamp" ]];
fitSessionValue[ "StartTime"                              , v_ ] := fitDateTime @ v[[ "StartTime" ]];
fitSessionValue[ "StartPosition"                          , v_ ] := fitGeoPosition @ v[[ { "StartPositionLatitude", "StartPositionLongitude" } ]];
fitSessionValue[ "TotalElapsedTime"                       , v_ ] := fitKiloSeconds32 @ v[[ "TotalElapsedTime" ]];
fitSessionValue[ "TotalTimerTime"                         , v_ ] := fitKiloSeconds32 @ v[[ "TotalTimerTime" ]];
fitSessionValue[ "TotalDistance"                          , v_ ] := fitDistance @ v[[ "TotalDistance" ]];
fitSessionValue[ "TotalCycles"                            , v_ ] := fitCycles32[ v[[ "TotalCycles" ]], v[[ "TotalFractionalCycles" ]] ];
fitSessionValue[ "GeoBoundingBox"                         , v_ ] := fitGeoBoundingBox @ v[[ { "NorthEastCornerLatitude", "NorthEastCornerLongitude", "SouthWestCornerLatitude", "SouthWestCornerLongitude" } ]];
fitSessionValue[ "AverageStrokeCount"                     , v_ ] := fitAverageStrokeCount @ v[[ "AverageStrokeCount" ]];
fitSessionValue[ "TotalWork"                              , v_ ] := fitWork @ v[[ "TotalWork" ]];
fitSessionValue[ "TotalMovingTime"                        , v_ ] := fitKiloSeconds32 @ v[[ "TotalMovingTime" ]];
fitSessionValue[ "TimeInHeartRateZone"                    , v_ ] := fitTimeInZone @ v[[ "TimeInHeartRateZone" ]];
fitSessionValue[ "TimeInSpeedZone"                        , v_ ] := fitTimeInZone @ v[[ "TimeInSpeedZone" ]];
fitSessionValue[ "TimeInCadenceZone"                      , v_ ] := fitTimeInZone @ v[[ "TimeInCadenceZone" ]];
fitSessionValue[ "TimeInPowerZone"                        , v_ ] := fitTimeInZone @ v[[ "TimeInPowerZone" ]];
fitSessionValue[ "AverageLapTime"                         , v_ ] := fitKiloSeconds32 @ v[[ "AverageLapTime" ]];
fitSessionValue[ "MessageIndex"                           , v_ ] := fitMessageIndex @ v[[ "MessageIndex" ]];
fitSessionValue[ "TotalCalories"                          , v_ ] := fitCalories @ v[[ "TotalCalories" ]];
fitSessionValue[ "TotalFatCalories"                       , v_ ] := fitCalories @ v[[ "TotalFatCalories" ]];
fitSessionValue[ "AverageSpeed"                           , v_ ] := fitSpeedSelect[ v[[ "EnhancedAverageSpeed" ]], v[[ "AverageSpeed" ]] ];
fitSessionValue[ "MaxSpeed"                               , v_ ] := fitSpeedSelect[ v[[ "EnhancedMaximumSpeed" ]], v[[ "MaximumSpeed" ]] ];
fitSessionValue[ "AveragePower"                           , v_ ] := fitPower16 @ v[[ "AveragePower" ]];
fitSessionValue[ "MaxPower"                               , v_ ] := fitPower16 @ v[[ "MaximumPower" ]];
fitSessionValue[ "TotalAscent"                            , v_ ] := fitAscent[ v[[ "TotalAscent" ]], v[[ "TotalFractionalAscent" ]] ];
fitSessionValue[ "TotalDescent"                           , v_ ] := fitAscent[ v[[ "TotalDescent" ]], v[[ "TotalFractionalDescent" ]] ];
fitSessionValue[ "FirstLapIndex"                          , v_ ] := fitUINT16 @ v[[ "FirstLapIndex" ]];
fitSessionValue[ "NumberOfLaps"                           , v_ ] := fitLaps @ v[[ "NumberLaps" ]];
fitSessionValue[ "NumberOfLengths"                        , v_ ] := fitLengths @ v[[ "NumberOfLengths" ]];
fitSessionValue[ "NormalizedPower"                        , v_ ] := fitPower16 @ v[[ "NormalizedPower" ]];
fitSessionValue[ "TrainingStressScore"                    , v_ ] := fitTrainingStressScore @ v[[ "TrainingStressScore" ]];
fitSessionValue[ "IntensityFactor"                        , v_ ] := fitIntensityFactor @ v[[ "IntensityFactor" ]];
fitSessionValue[ "LeftRightBalance"                       , v_ ] := fitLeftRightBalance100 @ v[[ "LeftRightBalance" ]];
fitSessionValue[ "AverageStrokeDistance"                  , v_ ] := fitMeters100 @ v[[ "AverageStrokeDistance" ]];
fitSessionValue[ "PoolLength"                             , v_ ] := fitMeters100 @ v[[ "PoolLength" ]];
fitSessionValue[ "ThresholdPower"                         , v_ ] := fitPower16 @ v[[ "ThresholdPower" ]];
fitSessionValue[ "NumberOfActiveLengths"                  , v_ ] := fitLengths @ v[[ "NumberActiveLengths" ]];
fitSessionValue[ "AverageAltitude"                        , v_ ] := fitAltitudeSelect[ v[[ "EnhancedAverageAltitude" ]], v[[ "AverageAltitude" ]] ];
fitSessionValue[ "MaxAltitude"                            , v_ ] := fitAltitudeSelect[ v[[ "EnhancedMaximumAltitude" ]], v[[ "MaximumAltitude" ]] ];
fitSessionValue[ "AverageGrade"                           , v_ ] := fitGrade @ v[[ "AverageGrade" ]];
fitSessionValue[ "AveragePositiveGrade"                   , v_ ] := fitGrade @ v[[ "AveragePositiveGrade" ]];
fitSessionValue[ "AverageNegativeGrade"                   , v_ ] := fitGrade @ v[[ "AverageNegativeGrade" ]];
fitSessionValue[ "MaxPositiveGrade"                       , v_ ] := fitGrade @ v[[ "MaximumPositiveGrade" ]];
fitSessionValue[ "MaxNegativeGrade"                       , v_ ] := fitGrade @ v[[ "MaximumNegativeGrade" ]];
fitSessionValue[ "AveragePositiveVerticalSpeed"           , v_ ] := fitVerticalSpeed @ v[[ "AveragePositiveVerticalSpeed" ]];
fitSessionValue[ "AverageNegativeVerticalSpeed"           , v_ ] := fitVerticalSpeed @ v[[ "AverageNegativeVerticalSpeed" ]];
fitSessionValue[ "MaxPositiveVerticalSpeed"               , v_ ] := fitVerticalSpeed @ v[[ "MaximumPositiveVerticalSpeed" ]];
fitSessionValue[ "MaxNegativeVerticalSpeed"               , v_ ] := fitVerticalSpeed @ v[[ "MaximumNegativeVerticalSpeed" ]];
fitSessionValue[ "BestLapIndex"                           , v_ ] := fitUINT16 @ v[[ "BestLapIndex" ]];
fitSessionValue[ "MinAltitude"                            , v_ ] := fitAltitudeSelect[ v[[ "EnhancedMinimumAltitude" ]], v[[ "MinimumAltitude" ]] ];
fitSessionValue[ "PlayerScore"                            , v_ ] := fitUINT16 @ v[[ "PlayerScore" ]];
fitSessionValue[ "OpponentScore"                          , v_ ] := fitUINT16 @ v[[ "OpponentScore" ]];
fitSessionValue[ "StrokeCount"                            , v_ ] := fitStrokeCount @ v[[ "StrokeCount" ]];
fitSessionValue[ "ZoneCount"                              , v_ ] := fitZoneCount @ v[[ "ZoneCount" ]];
fitSessionValue[ "MaxBallSpeed"                           , v_ ] := fitBallSpeed @ v[[ "MaximumBallSpeed" ]];
fitSessionValue[ "AverageBallSpeed"                       , v_ ] := fitBallSpeed @ v[[ "AverageBallSpeed" ]];
fitSessionValue[ "AverageVerticalOscillation"             , v_ ] := fitVerticalOscillation @ v[[ "AverageVerticalOscillation" ]];
fitSessionValue[ "AverageStanceTimePercent"               , v_ ] := fitStanceTimePercent @ v[[ "AverageStanceTimePercent" ]];
fitSessionValue[ "AverageStanceTime"                      , v_ ] := fitStanceTime @ v[[ "AverageStanceTime" ]];
fitSessionValue[ "AverageStanceTimeBalance"               , v_ ] := fitPercent16 @ v[[ "AverageStanceTimeBalance" ]];
fitSessionValue[ "StandCount"                             , v_ ] := fitUINT16 @ v[[ "StandCount" ]];
fitSessionValue[ "TimeStanding"                           , v_ ] := fitKiloSeconds32 @ v[[ "TimeStanding" ]];
fitSessionValue[ "AverageStepLength"                      , v_ ] := fitStepLength @ v[[ "AverageStepLength" ]];
fitSessionValue[ "AverageVerticalRatio"                   , v_ ] := fitPercent16 @ v[[ "AverageVerticalRatio" ]];
fitSessionValue[ "AverageVAM"                             , v_ ] := fitVAM @ v[[ "AverageAverageAscentSpeed" ]];
fitSessionValue[ "Event"                                  , v_ ] := fitEvent @ v[[ "Event" ]];
fitSessionValue[ "EventType"                              , v_ ] := fitEventType @ v[[ "EventType" ]];
fitSessionValue[ "Sport"                                  , v_ ] := fitSport @ v[[ "Sport" ]];
fitSessionValue[ "SubSport"                               , v_ ] := fitSubSport @ v[[ "SubSport" ]];
fitSessionValue[ "AverageHeartRate"                       , v_ ] := fitHeartRate @ v[[ "AverageHeartRate" ]];
fitSessionValue[ "MaxHeartRate"                           , v_ ] := fitHeartRate @ v[[ "MaximumHeartRate" ]];
fitSessionValue[ "AverageCadence"                         , v_ ] := fitCadence[ v[[ "AverageCadence" ]], v[[ "AverageFractionalCadence" ]] ];
fitSessionValue[ "MaxCadence"                             , v_ ] := fitCadence[ v[[ "MaximumCadence" ]], v[[ "MaximumFractionalCadence" ]] ];
fitSessionValue[ "TotalAerobicTrainingEffect"             , v_ ] := fitTrainingEffect @ v[[ "TotalTrainingEffect" ]];
fitSessionValue[ "TotalAerobicTrainingEffectDescription"  , v_ ] := fitTrainingEffectDescription @ v[[ "TotalTrainingEffect" ]];
fitSessionValue[ "EventGroup"                             , v_ ] := fitEventGroup @ v[[ "EventGroup" ]];
fitSessionValue[ "Trigger"                                , v_ ] := fitSessionTrigger @ v[[ "Trigger" ]];
fitSessionValue[ "SwimStroke"                             , v_ ] := fitSwimStroke @ v[[ "SwimStroke" ]];
fitSessionValue[ "PoolLengthUnit"                         , v_ ] := fitDisplayMeasure @ v[[ "PoolLengthUnit" ]];
fitSessionValue[ "GPSAccuracy"                            , v_ ] := fitGPSAccuracy @ v[[ "GPSAccuracy" ]];
fitSessionValue[ "AverageTemperature"                     , v_ ] := fitTemperature8 @ v[[ "AverageTemperature" ]];
fitSessionValue[ "MaxTemperature"                         , v_ ] := fitTemperature8 @ v[[ "MaximumTemperature" ]];
fitSessionValue[ "MinHeartRate"                           , v_ ] := fitHeartRate @ v[[ "MinimumHeartRate" ]];
fitSessionValue[ "SportIndex"                             , v_ ] := fitUINT8 @ v[[ "SportIndex" ]];
fitSessionValue[ "TotalAnaerobicTrainingEffect"           , v_ ] := fitTrainingEffect @ v[[ "TotalAnaerobicTrainingEffect" ]];
fitSessionValue[ "TotalAnaerobicTrainingEffectDescription", v_ ] := fitTrainingEffectDescription @ v[[ "TotalAnaerobicTrainingEffect" ]];
fitSessionValue[ "AverageLeftPlatformCenterOffset"        , v_ ] := fitPCO @ v[[ "AverageLeftPlatformCenterOffset" ]];
fitSessionValue[ "AverageRightPlatformCenterOffset"       , v_ ] := fitPCO @ v[[ "AverageRightPlatformCenterOffset" ]];
fitSessionValue[ "AverageLeftPowerPhaseStart"             , v_ ] := fitPowerPhase @ v[[ "AverageLeftPowerPhase" ]][[  1 ]];
fitSessionValue[ "AverageLeftPowerPhaseEnd"               , v_ ] := fitPowerPhase @ v[[ "AverageLeftPowerPhase" ]][[ -1 ]];
fitSessionValue[ "AverageLeftPowerPhasePeakStart"         , v_ ] := fitPowerPhase @ v[[ "AverageLeftPowerPhasePeak" ]][[  1 ]];
fitSessionValue[ "AverageLeftPowerPhasePeakEnd"           , v_ ] := fitPowerPhase @ v[[ "AverageLeftPowerPhasePeak" ]][[ -1 ]];
fitSessionValue[ "AverageRightPowerPhaseStart"            , v_ ] := fitPowerPhase @ v[[ "AverageRightPowerPhase" ]][[  1 ]];
fitSessionValue[ "AverageRightPowerPhaseEnd"              , v_ ] := fitPowerPhase @ v[[ "AverageRightPowerPhase" ]][[ -1 ]];
fitSessionValue[ "AverageRightPowerPhasePeakStart"        , v_ ] := fitPowerPhase @ v[[ "AverageRightPowerPhasePeak" ]][[  1 ]];
fitSessionValue[ "AverageRightPowerPhasePeakEnd"          , v_ ] := fitPowerPhase @ v[[ "AverageRightPowerPhasePeak" ]][[ -1 ]];
fitSessionValue[ "AverageLeftPedalSmoothness"             , v_ ] := fitPedalSmoothness @ v[[ "AverageLeftPedalSmoothness" ]];
fitSessionValue[ "AverageRightPedalSmoothness"            , v_ ] := fitPedalSmoothness @ v[[ "AverageRightPedalSmoothness" ]];
fitSessionValue[ "AverageCombinedPedalSmoothness"         , v_ ] := fitPedalSmoothness @ v[[ "AverageCombinedPedalSmoothness" ]];
fitSessionValue[ "AverageCadencePosition"                 , v_ ] := fitCadencePosition @ v[[ "AverageCadencePosition" ]];
fitSessionValue[ "MaxCadencePosition"                     , v_ ] := fitCadencePosition @ v[[ "MaximumCadencePosition" ]];
fitSessionValue[ "AveragePowerPosition"                   , v_ ] := fitPowerPosition @ v[[ "AveragePowerPosition" ]];
fitSessionValue[ "MaxPowerPosition"                       , v_ ] := fitPowerPosition @ v[[ "MaximumPowerPosition" ]];
fitSessionValue[ "AverageCoreTemperature"                 , v_ ] := fitTemperature16 @ v[[ "AverageCoreTemperature" ]];
fitSessionValue[ "MinCoreTemperature"                     , v_ ] := fitTemperature16 @ v[[ "MinimumCoreTemperature" ]];
fitSessionValue[ "MaxCoreTemperature"                     , v_ ] := fitTemperature16 @ v[[ "MaximumCoreTemperature" ]];
fitSessionValue[ "AverageFlow"                            , v_ ] := fitFloat32 @ v[[ "AverageFlow" ]];
fitSessionValue[ "AverageGrit"                            , v_ ] := fitFloat32 @ v[[ "AverageGrit" ]];
fitSessionValue[ "TotalFlow"                              , v_ ] := fitFloat32 @ v[[ "TotalFlow" ]];
fitSessionValue[ "TotalGrit"                              , v_ ] := fitFloat32 @ v[[ "TotalGrit" ]];
fitSessionValue[ "JumpCount"                              , v_ ] := fitUINT16 @ v[[ "JumpCount" ]];
fitSessionValue[ "AverageLeftTorqueEffectiveness"         , v_ ] := fit2Percent @ v[[ "AverageLeftTorqueEffectiveness" ]];
fitSessionValue[ "AverageRightTorqueEffectiveness"        , v_ ] := fit2Percent @ v[[ "AverageRightTorqueEffectiveness" ]];
fitSessionValue[ "AverageLEVMotorPower"                   , v_ ] := fitPercent16 @ v[[ "AverageLightElectricalVehicleMotorPower" ]];
fitSessionValue[ "MaxLEVMotorPower"                       , v_ ] := fitPercent16 @ v[[ "MaximumLightElectricalVehicleMotorPower" ]];
fitSessionValue[ "LEVBatteryConsumption"                  , v_ ] := fit2Percent @ v[[ "LightElectricalVehicleBatteryConsumption" ]];
fitSessionValue[ "AverageTotalHemoglobinConcentration"    , v_ ] := fitHemoglobin @ v[[ "AverageTotalHemoglobinConcentration" ]];
fitSessionValue[ "MinTotalHemoglobinConcentration"        , v_ ] := fitHemoglobin @ v[[ "MinimumTotalHemoglobinConcentration" ]];
fitSessionValue[ "MaxTotalHemoglobinConcentration"        , v_ ] := fitHemoglobin @ v[[ "MaximumTotalHemoglobinConcentration" ]];
fitSessionValue[ "AverageSaturatedHemoglobinPercent"      , v_ ] := fitHemoglobinPercent @ v[[ "AverageSaturatedHemoglobinPercent" ]];
fitSessionValue[ "MinSaturatedHemoglobinPercent"          , v_ ] := fitHemoglobinPercent @ v[[ "MinimumSaturatedHemoglobinPercent" ]];
fitSessionValue[ "MaxSaturatedHemoglobinPercent"          , v_ ] := fitHemoglobinPercent @ v[[ "MaximumSaturatedHemoglobinPercent" ]];
fitSessionValue[ "OpponentName"                           , v_ ] := fitString @ v[[ "OpponentName" ]];
fitSessionValue[ "TrainingLoadPeak"                       , v_ ] := fitSINT32 @ v[[ "TrainingLoadPeak" ]];
fitSessionValue[ _                                        , _  ] := Missing[ "NotAvailable" ];

indexTranslate[ "Session", fitSessionValue ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*ZonesTarget*)
fitValue[ "ZonesTarget" , name_, value_ ] := fitZonesTargetValue[ name, value ];

fitZonesTargetValue // ClearAll;
fitZonesTargetValue[ "FunctionalThresholdPower", v_ ] := fitFTPSetting @ v[[ "FunctionalThresholdPower" ]];
fitZonesTargetValue[ "MaxHeartRate"            , v_ ] := fitMaxHRSetting @ v[[ "MaximumHeartRate" ]];
fitZonesTargetValue[ "ThresholdHeartRate"      , v_ ] := fitHeartRate @ v[[ "ThresholdHeartRate" ]];
fitZonesTargetValue[ "HeartRateCalculationType", v_ ] := fitHeartRateZoneCalc @ v[[ "HeartRateCalculationType" ]];
fitZonesTargetValue[ "PowerZoneCalculationType", v_ ] := fitPowerZoneCalc @ v[[ "PowerCalculationType" ]];
fitZonesTargetValue[ _                         , _  ] := Missing[ "NotAvailable" ];

indexTranslate[ "ZonesTarget", fitZonesTargetValue ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*FileCreator*)
fitValue[ "FileCreator", name_, value_ ] := fitFileCreatorValue[ name, value ];

fitFileCreatorValue // ClearAll;
fitFileCreatorValue[ "SoftwareVersion", v_ ] := fitUINT16 @ v[[ "SoftwareVersion" ]];
fitFileCreatorValue[ "HardwareVersion", v_ ] := fitUINT8 @ v[[ "HardwareVersion" ]];
fitFileCreatorValue[ _                , _  ] := Missing[ "NotAvailable" ];

indexTranslate[ "FileCreator", fitFileCreatorValue ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Sport*)
fitValue[ "Sport", name_, value_ ] := fitSportValue[ name, value ];

fitSportValue // ClearAll;
fitSportValue[ "Name"    , v_ ] := fitString @ v[[ "Name" ]];
fitSportValue[ "Sport"   , v_ ] := fitSport @ v[[ "Sport" ]];
fitSportValue[ "SubSport", v_ ] := fitSubSport @ v[[ "SubSport" ]];
fitSportValue[ _         , _  ] := Missing[ "NotAvailable" ];

indexTranslate[ "Sport", fitSportValue ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*DeveloperDataID*)
fitValue[ "DeveloperDataID", name_, value_ ] := fitDeveloperDataIDValue[ name, value ];

fitDeveloperDataIDValue // ClearAll;
fitDeveloperDataIDValue[ "DeveloperID"       , v_ ] := fitHexString @ v[[ "DeveloperID" ]];
fitDeveloperDataIDValue[ "ApplicationID"     , v_ ] := fitHexString @ v[[ "ApplicationID" ]];
fitDeveloperDataIDValue[ "ApplicationVersion", v_ ] := fitUINT32 @ v[[ "ApplicationVersion" ]];
fitDeveloperDataIDValue[ "ManufacturerID"    , v_ ] := fitManufacturer @ v[[ "ManufacturerID" ]];
fitDeveloperDataIDValue[ "DeveloperDataIndex", v_ ] := fitUINT8 @ v[[ "DeveloperDataIndex" ]];
fitDeveloperDataIDValue[ _                   , _  ] := Missing[ "NotAvailable" ];

indexTranslate[ "DeveloperDataID", fitDeveloperDataIDValue ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*FieldDescription*)
fitValue[ "FieldDescription", name_, value_ ] := fitFieldDescriptionValue[ name, value ];

fitFieldDescriptionValue // ClearAll;
fitFieldDescriptionValue[ "FieldName"            , v_ ] := fitString @ v[[ "FieldName" ]];
fitFieldDescriptionValue[ "Units"                , v_ ] := fitString @ v[[ "Units" ]];
fitFieldDescriptionValue[ "FitBaseUnitID"        , v_ ] := fitFitBaseUnit @ v[[ "FitBaseUnitID" ]];
fitFieldDescriptionValue[ "NativeMessageNumber"  , v_ ] := fitUINT16 @ v[[ "NativeMessageNumber" ]];
fitFieldDescriptionValue[ "DeveloperDataIndex"   , v_ ] := fitUINT8 @ v[[ "DeveloperDataIndex" ]];
fitFieldDescriptionValue[ "FieldDefinitionNumber", v_ ] := fitUINT8 @ v[[ "FieldDefinitionNumber" ]];
fitFieldDescriptionValue[ "FitBaseTypeID"        , v_ ] := fitFitBaseType @ v[[ "FitBaseTypeID" ]];
fitFieldDescriptionValue[ "Scale"                , v_ ] := fitUINT8 @ v[[ "Scale" ]];
fitFieldDescriptionValue[ "Offset"               , v_ ] := fitSINT8 @ v[[ "Offset" ]];
fitFieldDescriptionValue[ "NativeFieldNumber"    , v_ ] := fitUINT8 @ v[[ "NativeFieldNumber" ]];
fitFieldDescriptionValue[ _                      , _  ] := Missing[ "NotAvailable" ];

indexTranslate[ "FieldDescription", fitFieldDescriptionValue ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*TrainingFile*)
fitValue[ "TrainingFile", name_, value_ ] := fitTrainingFileValue[ name, value ];

fitTrainingFileValue // ClearAll;
fitTrainingFileValue[ "Timestamp"   , v_ ] := fitDateTime @ v[[ "Timestamp" ]];
fitTrainingFileValue[ "SerialNumber", v_ ] := fitUINT32Z @ v[[ "SerialNumber" ]];
fitTrainingFileValue[ "TimeCreated" , v_ ] := fitDateTime @ v[[ "TimeCreated" ]];
fitTrainingFileValue[ "Manufacturer", v_ ] := fitManufacturer @ v[[ "Manufacturer" ]];
fitTrainingFileValue[ "Product"     , v_ ] := fitProduct @ v[[ "Product" ]];
fitTrainingFileValue[ "Type"        , v_ ] := fitFile @ v[[ "Type" ]];
fitTrainingFileValue[ "ProductName" , v_ ] := fitProductName @ v[[ { "Manufacturer", "Product" } ]];
fitTrainingFileValue[ _             , _  ] := Missing[ "NotAvailable" ];

indexTranslate[ "TrainingFile", fitTrainingFileValue ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*WorkoutStep*)
fitValue[ "WorkoutStep", name_, value_ ] := fitWorkoutStepValue[ name, value ];

fitWorkoutStepValue // ClearAll;
fitWorkoutStepValue[ "WorkoutStepName"               , v_ ] := fitString @ v[[ "WorkoutStepName" ]];
fitWorkoutStepValue[ "Duration"                      , v_ ] := fitWktDuration[ v[[ "DurationValue" ]], v[[ "DurationType" ]] ];
fitWorkoutStepValue[ "DurationType"                  , v_ ] := fitWorkoutStepDuration @ v[[ "DurationType" ]];
fitWorkoutStepValue[ "TargetValue"                   , v_ ] := fitWktTargetValue[ v[[ "TargetValue" ]], v[[ "TargetType" ]] ];
fitWorkoutStepValue[ "TargetType"                    , v_ ] := fitWorkoutStepTarget @ v[[ "TargetType" ]];
fitWorkoutStepValue[ "CustomTargetValueLow"          , v_ ] := fitWktTargetValue[ v[[ "CustomTargetValueLow" ]], v[[ "TargetType" ]] ];
fitWorkoutStepValue[ "CustomTargetValueHigh"         , v_ ] := fitWktTargetValue[ v[[ "CustomTargetValueHigh" ]], v[[ "TargetType" ]] ];
fitWorkoutStepValue[ "Target"                        , v_ ] := fitWktTarget[ v[[ "TargetValue" ]], v[[ "CustomTargetValueLow" ]], v[[ "CustomTargetValueHigh" ]], v[[ "TargetType" ]] ];
fitWorkoutStepValue[ "SecondaryTargetValue"          , v_ ] := fitWktTargetValue[ v[[ "SecondaryTargetValue" ]], v[[ "SecondaryTargetType" ]] ];
fitWorkoutStepValue[ "SecondaryCustomTargetValueLow" , v_ ] := fitWktTargetValue[ v[[ "SecondaryCustomTargetValueLow" ]], v[[ "SecondaryTargetType" ]] ];
fitWorkoutStepValue[ "SecondaryCustomTargetValueHigh", v_ ] := fitWktTargetValue[ v[[ "SecondaryCustomTargetValueHigh" ]], v[[ "SecondaryTargetType" ]] ];
fitWorkoutStepValue[ "SecondaryTargetType"           , v_ ] := fitWorkoutStepTarget @ v[[ "SecondaryTargetType" ]];
fitWorkoutStepValue[ "MessageIndex"                  , v_ ] := fitUINT16 @ v[[ "MessageIndex" ]];
fitWorkoutStepValue[ "ExerciseCategory"              , v_ ] := fitExerciseCategory @ v[[ "ExerciseCategory" ]];
fitWorkoutStepValue[ "TargetType"                    , v_ ] := fitWorkoutStepTarget @ v[[ "TargetType" ]];
fitWorkoutStepValue[ "Intensity"                     , v_ ] := fitIntensity @ v[[ "Intensity" ]];
fitWorkoutStepValue[ "Notes"                         , v_ ] := fitString @ v[[ "Notes" ]];
fitWorkoutStepValue[ "Equipment"                     , v_ ] := fitWorkoutEquipment @ v[[ "Equipment" ]];
fitWorkoutStepValue[ _                               , _  ] := Missing[ "NotAvailable" ];

indexTranslate[ "WorkoutStep", fitWorkoutStepValue ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Workout*)
fitValue[ "Workout", name_, value_ ] := fitWorkoutValue[ name, value ];

fitWorkoutValue // ClearAll;
fitWorkoutValue[ "Capabilities"      , v_ ] := fitWorkoutCapabilities @ v[[ "Capabilities" ]];
fitWorkoutValue[ "WorkoutName"       , v_ ] := fitString @ v[[ "WorkoutName" ]];
fitWorkoutValue[ "NumberOfValidSteps", v_ ] := fitUINT16 @ v[[ "NumberOfValidSteps" ]];
fitWorkoutValue[ "PoolLength"        , v_ ] := fitMeters100 @ v[[ "PoolLength" ]];
fitWorkoutValue[ "Sport"             , v_ ] := fitSport @ v[[ "Sport" ]];
fitWorkoutValue[ "SubSport"          , v_ ] := fitSubSport @ v[[ "SubSport" ]];
fitWorkoutValue[ "PoolLengthUnit"    , v_ ] := fitDisplayMeasure @ v[[ "PoolLengthUnit" ]];

indexTranslate[ "Workout", fitWorkoutValue ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*HeartRateVariability*)
fitValue[ "HeartRateVariability", name_, value_ ] := fitHeartRateVariabilityValue[ name, value ];

fitHeartRateVariabilityValue // ClearAll;
fitHeartRateVariabilityValue[ "Time", v_ ] := fitHRV @ v[[ "Time" ]];
fitHeartRateVariabilityValue[ _     , _  ] := Missing[ "NotAvailable" ];

indexTranslate[ "HeartRateVariability", fitHeartRateVariabilityValue ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*AccelerometerData*)
fitValue[ "AccelerometerData", name_, value_ ] := fitAccelerometerDataValue[ name, value ];

fitAccelerometerDataValue // ClearAll;
fitAccelerometerDataValue[ "Timestamp"                        , v_ ] := fitDateTime @ v[[ "Timestamp" ]];
fitAccelerometerDataValue[ "CalibratedAccelerationX"          , v_ ] := fitFloat32A @ v[[ "CalibratedAccelerationX" ]];
fitAccelerometerDataValue[ "CalibratedAccelerationY"          , v_ ] := fitFloat32A @ v[[ "CalibratedAccelerationY" ]];
fitAccelerometerDataValue[ "CalibratedAccelerationZ"          , v_ ] := fitFloat32A @ v[[ "CalibratedAccelerationZ" ]];
fitAccelerometerDataValue[ "TimestampMilliseconds"            , v_ ] := fitUINT16 @ v[[ "TimestampMilliseconds" ]];
fitAccelerometerDataValue[ "SampleTimeOffset"                 , v_ ] := fitUINT16A @ v[[ "SampleTimeOffset" ]];
fitAccelerometerDataValue[ "AccelerationX"                    , v_ ] := fitUINT16A @ v[[ "AccelerationX" ]];
fitAccelerometerDataValue[ "AccelerationY"                    , v_ ] := fitUINT16A @ v[[ "AccelerationY" ]];
fitAccelerometerDataValue[ "AccelerationZ"                    , v_ ] := fitUINT16A @ v[[ "AccelerationZ" ]];
fitAccelerometerDataValue[ "CompressedCalibratedAccelerationX", v_ ] := fitSINT16A @ v[[ "CompressedCalibratedAccelerationX" ]];
fitAccelerometerDataValue[ "CompressedCalibratedAccelerationY", v_ ] := fitSINT16A @ v[[ "CompressedCalibratedAccelerationY" ]];
fitAccelerometerDataValue[ "CompressedCalibratedAccelerationZ", v_ ] := fitSINT16A @ v[[ "CompressedCalibratedAccelerationZ" ]];
fitAccelerometerDataValue[ _                                  , _  ] := Missing[ "NotAvailable" ];

indexTranslate[ "AccelerometerData", fitAccelerometerDataValue ];

(* ::**********************************************************************:: *)
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

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Defaults*)
fitValue[ _, "RawData", v_ ] := fitRawData @ v[[ 2;; ]];
fitValue[ __ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitEnum*)
fitEnum // ClearAll;
fitEnum[ name_ ][ value_ ] := fitEnum0 @ $enumTypeData[ name, value ];
fitEnum[ ___ ][ ___ ] := Missing[ "NotAvailable" ];

fitEnum0[ _Missing ] := Missing[ "NotAvailable" ];
fitEnum0[ v_ ] := v;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitMissing*)
fitMissing // ClearAll;
fitMissing[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitQuantity*)
(* TODO: hook this up! *)

fitQuantity // ClearAll;
fitQuantity[ fitMissing, ___ ] := fitMissing;
fitQuantity[ valFunc_, units_ ] := fitQuantity[ valFunc, units, 1.0 ];
fitQuantity[ valFunc_, units_, scale_ ] := fitQuantity[ valFunc, units, scale, 0.0 ];
fitQuantity[ valFunc_, units_, scale_, offset_ ][ value_ ] := fitQuantity0[ valFunc @ value, units, scale, offset ];
fitQuantity[ ___ ][ ___ ] := Missing[ "NotAvailable" ];

fitQuantity0 // ClearAll;
fitQuantity0[ m_Missing, _, _, _ ] := m;

fitQuantity0[ value_, "Joules"              , scale_, offset_ ] := joulesToQuantity[    (1.0 * value - offset) / scale ];
fitQuantity0[ value_, "Grams"               , scale_, offset_ ] := gramsToQuantity[     (1.0 * value - offset) / scale ];
fitQuantity0[ value_, "Meters"              , scale_, offset_ ] := metersToQuantity[    (1.0 * value - offset) / scale ];
fitQuantity0[ value_, "Pascals"             , scale_, offset_ ] := pascalsToQuantity[   (1.0 * value - offset) / scale ];
fitQuantity0[ value_, "MetersPerSecond"     , scale_, offset_ ] := speedQuantity[       (1.0 * value - offset) / scale ];
fitQuantity0[ value_, "DegreesCelsius"      , scale_, offset_ ] := temperatureQuantity[ (1.0 * value - offset) / scale ];
fitQuantity0[ value_, "Cycles"              , scale_, offset_ ] := cycleQuantity[       (1.0 * value - offset) / scale ];
fitQuantity0[ value_, "RevolutionsPerMinute", scale_, offset_ ] := cadenceQuantity[     (1.0 * value - offset) / scale ];
fitQuantity0[ value_, "Seconds"             , scale_, offset_ ] := secondsToQuantity[   (1.0 * value - offset) / scale ];

fitQuantity0[ value_, units_, scale_, offset_ ] := Quantity[ (1.0 * value - offset) / scale, units ];

fitQuantity0[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitBool*)
fitBool // ClearAll;
fitBool[ 0 ] := False;
fitBool[ 1 ] := True;
fitBool[ ___ ] := Missing[ "NotAvailable" ];

fitBoolA // ClearAll;
fitBoolA[ b: { (0|1).. } ] := fitBool /@ b;
fitBoolA[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitByte*)
fitByte // ClearAll;
fitByte[ $invalidUINT8 ] := Missing[ "NotAvailable" ];
fitByte[ n_Integer ] := n;
fitByte[ ___ ] := Missing[ "NotAvailable" ];

fitByteA // ClearAll;
fitByteA[ { $invalidUINT8... } ] := Missing[ "NotAvailable" ];
fitByteA[ list_List ] := ByteArray[ fitByte /@ list ];
fitByteA[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
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

(* ::**********************************************************************:: *)
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

(* ::**********************************************************************:: *)
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

(* ::**********************************************************************:: *)
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

(* ::**********************************************************************:: *)
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

(* ::**********************************************************************:: *)
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

(* ::**********************************************************************:: *)
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

(* ::**********************************************************************:: *)
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

(* ::**********************************************************************:: *)
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

(* ::**********************************************************************:: *)
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

(* ::**********************************************************************:: *)
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
fitHexString[ { $invalidUINT8... } ] := Missing[ "NotAvailable" ];
fitHexString[ v_List ] := StringJoin[ (IntegerString[ #, 16 ] &) /@ v ];
fitHexString[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitRawData*)
fitRawData // ClearAll;
fitRawData[ { a___, $fitTerm, ___ } ] := { a };
fitRawData[ ___ ] := Missing[ "NotAvailable" ];

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
fitDateTime[ n_Integer ] /; $failedTimeOffset := DateObject @ n;
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
(*fitSeconds32*)
fitSeconds32 // ClearAll;
fitSeconds32[ $invalidUINT32 ] := Missing[ "NotAvailable" ];
fitSeconds32[ n_Integer ] := secondsToQuantity @ n;
fitSeconds32[ ___ ] := Missing[ "NotAvailable" ];

fitSeconds32A // ClearAll;
fitSeconds32A[ { $invalidUINT32... } ] := Missing[ "NotAvailable" ];
fitSeconds32A[ list_List ] := fitSeconds32 /@ list;
fitSeconds32A[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitKiloSeconds16*)
fitKiloSeconds16 // ClearAll;
fitKiloSeconds16[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitKiloSeconds16[ n___ ] := fitKiloSeconds @ n;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitKiloSeconds32*)
fitKiloSeconds32 // ClearAll;
fitKiloSeconds32[ $invalidUINT32 ] := Missing[ "NotAvailable" ];
fitKiloSeconds32[ n___ ] := fitKiloSeconds @ n;

fitKiloSeconds32A // ClearAll;
fitKiloSeconds32A[ { $invalidUINT32... } ] := Missing[ "NotAvailable" ];
fitKiloSeconds32A[ list_List ] := fitKiloSeconds32 /@ list;
fitKiloSeconds32A[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitKiloSeconds*)
fitKiloSeconds // ClearAll;
fitKiloSeconds[ n_Integer ] := secondsToQuantity[ n/1000.0 ];
fitKiloSeconds[ ___ ] := Missing[ "NotAvailable" ];

secondsToQuantity := secondsToQuantity =
    Block[ { PrintTemporary },
        ResourceFunction[ "SecondsToQuantity", "Function" ]
    ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTimeOfDay*)
fitTimeOfDay // ClearAll;
fitTimeOfDay[ $invalidUINT32 ] := Missing[ "NotAvailable" ];
fitTimeOfDay[ n_Integer ] := secondsToTimeObject @ n;
fitTimeOfDay[ ___ ] := Missing[ "NotAvailable" ];

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
(*fitLength10mm*)
fitLength10mm // ClearAll;
fitLength10mm[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitLength10mm[ n_Integer ] := fitLength10mm[ n, $distanceUnits ];
fitLength10mm[ n_Integer, "Imperial" ] := Quantity[ 3.93701 * n, "Inches" ];
fitLength10mm[ n_Integer, _ ] := Quantity[ 10.0 * n, "Centimeters" ];
fitLength10mm[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTravelRange*)
fitTravelRange // ClearAll;
fitTravelRange[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitTravelRange[ n_Integer ] := fitTravelRange[ n, $distanceUnits ];
fitTravelRange[ n_Integer, "Imperial" ] := Quantity[ 0.62137 * n, "Miles" ];
fitTravelRange[ n_Integer, _ ] := Quantity[ 1.0 * n, "Kilometers" ];
fitTravelRange[ ___ ] := Missing[ "NotAvailable" ];\

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
(*fitPercent8*)
fitPercent8 // ClearAll;
fitPercent8[ $invalidUINT8 ] := Missing[ "NotAvailable" ];
fitPercent8[ n_Integer ] := fitPercent @ n;
fitPercent8[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitPercent16*)
fitPercent16 // ClearAll;
fitPercent16[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitPercent16[ n_Integer ] := fitPercent[ n / 100.0 ];
fitPercent16[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fit2Percent*)
fit2Percent // ClearAll;
fit2Percent[ $invalidUINT8 ] := Missing[ "NotAvailable" ];
fit2Percent[ n_Integer ] := fitPercent[ n / 2.0 ];
fit2Percent[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitPercent*)
fitPercent // ClearAll;
fitPercent[ n_ ] := Quantity[ n, "Percent" ];
fitPercent[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitPressure16*)
fitPressure16 // ClearAll;
fitPressure16[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitPressure16[ n___ ] := fitPressure @ n;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitPressure32*)
fitPressure32 // ClearAll;
fitPressure32[ $invalidUINT32 ] := Missing[ "NotAvailable" ];
fitPressure32[ n___ ] := fitPressure @ n;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitPressure*)
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
fitTimeInZone[ $invalidUINT32 ] := Missing[ "NotAvailable" ];
fitTimeInZone[ n_Integer ] := secondsToQuantity[ n/1000.0 ];
fitTimeInZone[ { n_ } ] := fitTimeInZone @ n;
fitTimeInZone[ { $invalidUINT32... } ] := Missing[ "NotAvailable" ];
fitTimeInZone[ list_List ] := fitTimeInZone /@ list;
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
fitAscent[ $invalidUINT16|0 ] := Missing[ "NotAvailable" ];
fitAscent[ $invalidUINT16|0, n_ ] := fitFractionalAscent @ n;
fitAscent[ n_Integer, $invalidUINT8|0 ] := ascentQuantity @ n;
fitAscent[ n_Integer, f_Integer ] := ascentQuantity[ n + f / 100.0 ];
fitAscent[ n_Integer ] := ascentQuantity @ n;
fitAscent[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitFractionalAscent*)
fitFractionalAscent // ClearAll;
fitFractionalAscent[ $invalidUINT8|0 ] := Missing[ "NotAvailable" ];
fitFractionalAscent[ n_Integer ] := ascentQuantity[ n/100.0 ];
fitFractionalAscent[ ___ ] := Missing[ "NotAvailable" ];

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
(*fitPower8*)
fitPower8 // ClearAll;
fitPower8[ $invalidUINT8 ] := Quantity[ 0.0, "Watts" ];
fitPower8[ n___ ] := fitPower @ n;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitPower16*)
fitPower16 // ClearAll;
fitPower16[ $invalidUINT16 ] := Quantity[ 0.0, "Watts" ];
fitPower16[ n___ ] := fitPower @ n;

fitPower16A // ClearAll;
fitPower16A[ { $invalidUINT16... } ] := Missing[ "NotAvailable" ];
fitPower16A[ list_List ] := fitPower16 /@ list;
fitPower16A[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitPower*)
fitPower // ClearAll;
fitPower[ n_ ] := Quantity[ 1.0 * n, "Watts" ];
fitPower[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitFTPSetting*)
fitFTPSetting // ClearAll;
fitFTPSetting[ n_ ] := fitFTPSetting[ fitPower16 @ n, $ftp ];
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
fitHemoglobin[ { $invalidUINT16... } ] := Missing[ "NotAvailable" ];
fitHemoglobin[ { n_ } ] := fitHemoglobin @ n;
fitHemoglobin[ list_List ] := fitHemoglobin /@ list;
fitHemoglobin[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitHemoglobinPercent*)
fitHemoglobinPercent // ClearAll;
fitHemoglobinPercent[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitHemoglobinPercent[ n_Integer ] := Quantity[ n / 10.0, "Percent" ];
fitHemoglobinPercent[ { $invalidUINT16... } ] := Missing[ "NotAvailable" ];
fitHemoglobinPercent[ { n_ } ] := fitHemoglobinPercent @ n;
fitHemoglobinPercent[ list_List ] := fitHemoglobinPercent /@ list;
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
(*fitTemperature100C*)
fitTemperature100C // ClearAll;
fitTemperature100C[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitTemperature100C[ n_Integer ] := fitTemperature[ n / 100.0 ];
fitTemperature100C[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTemperature8*)
fitTemperature8 // ClearAll;
fitTemperature8[ $invalidSINT8|$invalidUINT8 ] := Missing[ "NotAvailable" ];
fitTemperature8[ n___ ] := fitTemperature @ n;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTemperature16*)
fitTemperature16 // ClearAll;
fitTemperature16[ $invalidSINT16|$invalidUINT16 ] := Missing[ "NotAvailable" ];
fitTemperature16[ n___ ] := fitTemperature @ n;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTemperature*)
fitTemperature // ClearAll;
fitTemperature[ n_ ] := fitTemperature[ n, $temperatureUnits ];
fitTemperature[ n_, "Imperial" ] := Quantity[ 32.0 + 1.8 n, "DegreesFahrenheit" ];
fitTemperature[ n_, _ ] := Quantity[ 1.0 * n, "DegreesCelsius" ];
fitTemperature[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitDepth*)
fitDepth // ClearAll;
fitDepth[ $invalidUINT32 ] := Missing[ "NotAvailable" ];
fitDepth[ n_Integer ] := fitDepth[ n, $distanceUnits ];
fitDepth[ n_Integer, "Imperial" ] := Quantity[ 0.0032808 * n, "Feet" ];
fitDepth[ n_Integer, _ ] := Quantity[ 0.001 * n, "Meters" ];
fitDepth[ ___ ] := Missing[ "NotAvailable" ];

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
fitLeftRightBalance[ $invalidUINT8 ] := Missing[ "NotAvailable" ];

fitLeftRightBalance[ n_Integer ] /; n >= 128 :=
    With[ { bal = 1.0 * BitAnd[ n, 127 ] },
        {
            Quantity[ 100 - bal, "Percent" ],
            Quantity[ bal      , "Percent" ]
        }
    ];

fitLeftRightBalance[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
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
(*fitCadencePosition*)
fitCadencePosition // ClearAll;
fitCadencePosition[ { $invalidUINT8... } ] := Missing[ "NotAvailable" ];
fitCadencePosition[ list_List ] := fitCadence /@ list;
fitCadencePosition[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitPowerPosition*)
fitPowerPosition // ClearAll;
fitPowerPosition[ { $invalidUINT16... } ] := Missing[ "NotAvailable" ];
fitPowerPosition[ list_List ] := fitPower /@ list;
fitPowerPosition[ ___ ] := Missing[ "NotAvailable" ];

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
fitStrokeCount[ { n_ } ] := fitStrokeCount @ n;
fitStrokeCount[ { $invalidUINT16... } ] := Missing[ "NotAvailable" ];
fitStrokeCount[ list_List ] := fitStrokeCount /@ list;
fitStrokeCount[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitZoneCount*)
fitZoneCount // ClearAll;
fitZoneCount[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitZoneCount[ n_Integer ] := n;
fitZoneCount[ { n_ } ] := fitZoneCount @ n;
fitZoneCount[ { $invalidUINT16... } ] := Missing[ "NotAvailable" ];
fitZoneCount[ list_List ] := fitZoneCount /@ list;
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

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitHRV*)
fitHRV // ClearAll;
fitHRV[ { n_ } ] := fitHRV @ n;
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

(* ::**********************************************************************:: *)
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

(* ::**********************************************************************:: *)
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

(* ::**********************************************************************:: *)
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

(* ::**********************************************************************:: *)
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

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitWktTargetPower*)
fitWktTargetPower // ClearAll;
fitWktTargetPower[ w_ ] := If[ TrueQ[ w > 1000 ], fitPower16[ w - 1000 ], fitPZRange[ w ] ];
fitWktTargetPower[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitPZRange*)
fitPZRange // ClearAll;
fitPZRange[ w_Integer ] := fitPZRange[ w, $ftp ];
fitPZRange[ w: $$powerZone, ftp_? NumberQ ] := Quantity[ Interval[ $pzBuckets[[ w ]]*ftp ], "Watts" ];
fitPZRange[ w: $$powerZone, ftp_ ] := Quantity[ Interval[ $pzBuckets[[ w ]]*100 ], "Percent" ] * QuantityVariable[ "FTP", "Power" ];
fitPZRange[ w_, _ ] := w;
fitPZRange[ ___ ] := Missing[ "NotAvailable" ];

$pzBuckets := cached @ Append[
    Partition[ $powerZoneThresholds, 2, 1 ],
    { 1.5, Infinity }
];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitWktTargetType*)

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Fit Value Units*)

(* ::**********************************************************************:: *)
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

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*joulesToQuantity*)
joulesToQuantity // ClearAll;

joulesToQuantity[ n_ ] :=
    Which[ n > 1000000, Quantity[ 0.000001 * n, "Megajoules"  ],
           n > 1000   , Quantity[ 0.001 * n   , "Kilojoules"  ],
           True       , Quantity[ 1.0 * n     , "Joules"      ]
    ];

joulesToQuantity[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*pascalsToQuantity*)
pascalsToQuantity // ClearAll;
pascalsToQuantity[ n_ ] := pressureQuantity[ n, $pressureUnits ];
pascalsToQuantity[ n_, "Imperial" ] := Quantity[ 0.00014504 * n, "PoundsForce"/"Inches"^2 ];
pascalsToQuantity[ n_, _ ] := Quantity[ 1.0 * n, "Pascals" ];
pascalsToQuantity[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
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

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*speedQuantity*)
speedQuantity // ClearAll;
speedQuantity[ n_ ] := speedQuantity[ n, $speedUnits ];
speedQuantity[ n_, "Imperial" ] := Quantity[ 2.23694 * n, "Miles"/"Hours" ];
speedQuantity[ n_, _ ] := Quantity[ 1.0 * n, "Meters"/"Seconds" ];
speedQuantity[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*temperatureQuantity*)
temperatureQuantity // ClearAll;
temperatureQuantity[ n_ ] := temperatureQuantity[ n, $temperatureUnits ];
temperatureQuantity[ n_, "Imperial" ] := Quantity[ 32.0 + 1.8 n, "DegreesFahrenheit" ];
temperatureQuantity[ n_, _ ] := Quantity[ 1.0 * n, "DegreesCelsius" ];
temperatureQuantity[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*cadenceQuantity*)
cadenceQuantity // ClearAll;
cadenceQuantity[ n_ ] := cadenceQuantity[ n, $sport ]; (* TODO: set this up in prefs *)
cadenceQuantity[ n_, "Cycling" ] := Quantity[ 1.0*n, "Revolutions"/"Minutes" ];
cadenceQuantity[ n_, "Walking"|"Running"|"Hiking" ] := Quantity[ 2.0*n, "Steps"/"Minutes" ];
cadenceQuantity[ n_, "Swimming" ] := Quantity[ 2.0*n, "Strokes"/"Minutes" ];
cadenceQuantity[ n_, _ ] := Quantity[ 1.0 * n, IndependentUnit[ "Cycles" ]/"Minutes" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*cycleQuantity*)
cycleQuantity // ClearAll;
cycleQuantity[ n_ ] := cycleQuantity[ n, $sport ];
cycleQuantity[ n_, "Cycling" ] := Quantity[ 1.0*n, "Revolutions" ];
cycleQuantity[ n_, "Walking"|"Running"|"Hiking" ] := Quantity[ 2.0*n, "Steps" ];
cycleQuantity[ n_, "Swimming" ] := Quantity[ 2.0*n, "Strokes" ];
cycleQuantity[ n_, _ ] := Quantity[ 1.0*n, IndependentUnit[ "Cycles" ] ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*ascentQuantity*)
ascentQuantity // ClearAll;
ascentQuantity[ n_ ] := ascentQuantity[ n, $altitudeUnits ];
ascentQuantity[ n_, "Imperial" ] := Quantity[ 3.28084 * n, "Feet" ];
ascentQuantity[ n_, _ ] := Quantity[ 1.0 * n, "Meters" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*secondsToTimeObject*)
secondsToTimeObject // ClearAll;
secondsToTimeObject[ s_ ] := secondsToTimeObject[ s, QuotientRemainder[ s, 3600 ] ];
secondsToTimeObject[ _, { h_, s_ } ] := TimeObject @ Prepend[ QuotientRemainder[ s, 60 ], h ];
secondsToTimeObject[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Footer*)
End[ ];
EndPackage[ ];

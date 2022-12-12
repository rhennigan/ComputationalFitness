(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "RH`ComputationalFitness`FIT`" ];
Needs[ "RH`ComputationalFitness`" ];
Needs[ "RH`ComputationalFitness`Package`" ];
Begin[ "`Private`" ];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Definition Utilities*)

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*$fitIndex*)
$fitIndex = Get @ FileNameJoin @ {
    DirectoryName[ $InputFileName, 3 ],
    "Data",
    "FITStructIndex.wl"
};

If[ $debug,
    Module[ { names, unsupported },
        names       = Keys @ $fitIndex;
        unsupported = Complement[ names, $messageTypes ];
        If[ MatchQ[ unsupported, { __ } ],
            messagePrint[
                "UnsupportedMessageTypes",
                HoldForm @ Evaluate @ unsupported
            ]
        ]
    ]
];

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

        If[ $debug,
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
(*fitValue*)
fitValue // beginDefinition;
fitValue[ type_, "MessageType", v_ ] := type;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*FileID*)
fitValue[ "FileID", name_, value_ ] := fitFileIDValue[ name, value ];

fitFileIDValue // ClearAll;
fitFileIDValue[ "SerialNumber", v_ ] := fitSerialNumber @ v[[ "serial_number" ]];
fitFileIDValue[ "TimeCreated" , v_ ] := fitDateTime @ v[[ "time_created" ]];
fitFileIDValue[ "Manufacturer", v_ ] := fitManufacturer @ v[[ "manufacturer" ]];
fitFileIDValue[ "Product"     , v_ ] := fitProduct @ v[[ "product" ]];
fitFileIDValue[ "Number"      , v_ ] := fitUINT16 @ v[[ "number" ]];
fitFileIDValue[ "Type"        , v_ ] := fitFile @ v[[ "type" ]];
fitFileIDValue[ "ProductName" , v_ ] := fitProductName[ v[[ { "manufacturer", "product" } ]], v[[ "product_name" ]] ];
fitFileIDValue[ _             , _  ] := Missing[ "NotAvailable" ];

indexTranslate[ "FileID", fitFileIDValue ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*UserProfile*)
fitValue[ "UserProfile", name_, value_ ] := fitUserProfileValue[ name, value ];

fitUserProfileValue // ClearAll;
fitUserProfileValue[ "MessageIndex"              , v_ ] := fitUINT16 @ v[[ "message_index" ]];
fitUserProfileValue[ "Weight"                    , v_ ] := fitWeight @ v[[ "weight" ]];
fitUserProfileValue[ "LocalID"                   , v_ ] := fitUINT16 @ v[[ "local_id" ]];
fitUserProfileValue[ "UserRunningStepLength"     , v_ ] := fitStepLength @ v[[ "user_running_step_length" ]];
fitUserProfileValue[ "UserWalkingStepLength"     , v_ ] := fitStepLength @ v[[ "user_walking_step_length" ]];
fitUserProfileValue[ "Gender"                    , v_ ] := fitGender @ v[[ "gender" ]];
fitUserProfileValue[ "Age"                       , v_ ] := fitAge @ v[[ "age" ]];
fitUserProfileValue[ "Height"                    , v_ ] := fitHeight @ v[[ "height" ]];
fitUserProfileValue[ "Language"                  , v_ ] := fitLanguage @ v[[ "language" ]];
fitUserProfileValue[ "ElevationSetting"          , v_ ] := fitDisplayMeasure @ v[[ "elev_setting" ]];
fitUserProfileValue[ "WeightSetting"             , v_ ] := fitDisplayMeasure @ v[[ "weight_setting" ]];
fitUserProfileValue[ "RestingHeartRate"          , v_ ] := fitHeartRate @ v[[ "resting_heart_rate" ]];
fitUserProfileValue[ "DefaultMaxRunningHeartRate", v_ ] := fitHeartRate @ v[[ "default_max_running_heart_rate" ]];
fitUserProfileValue[ "DefaultMaxBikingHeartRate" , v_ ] := fitHeartRate @ v[[ "default_max_biking_heart_rate" ]];
fitUserProfileValue[ "DefaultMaxHeartRate"       , v_ ] := fitHeartRate @ v[[ "default_max_heart_rate" ]];
fitUserProfileValue[ "HeartRateSetting"          , v_ ] := fitDisplayHeart @ v[[ "hr_setting" ]];
fitUserProfileValue[ "SpeedSetting"              , v_ ] := fitDisplayMeasure @ v[[ "speed_setting" ]];
fitUserProfileValue[ "DistanceSetting"           , v_ ] := fitDisplayMeasure @ v[[ "dist_setting" ]];
fitUserProfileValue[ "PowerSetting"              , v_ ] := fitDisplayPower @ v[[ "power_setting" ]];
fitUserProfileValue[ "ActivityClass"             , v_ ] := fitActivityClass @ v[[ "activity_class" ]];
fitUserProfileValue[ "PositionSetting"           , v_ ] := fitDisplayPosition @ v[[ "position_setting" ]];
fitUserProfileValue[ "TemperatureSetting"        , v_ ] := fitDisplayMeasure @ v[[ "temperature_setting" ]];
fitUserProfileValue[ "HeightSetting"             , v_ ] := fitDisplayMeasure @ v[[ "height_setting" ]];
fitUserProfileValue[ "FriendlyName"              , v_ ] := fitString @ v[[ "friendly_name" ]];
fitUserProfileValue[ "GlobalID"                  , v_ ] := fitGlobalID @ v[[ "global_id" ]];
fitUserProfileValue[ "DepthSetting"              , v_ ] := fitDisplayMeasure @ v[[ "depth_setting" ]];
fitUserProfileValue[ "DiveCount"                 , v_ ] := fitUINT32 @ v[[ "dive_count" ]];
fitUserProfileValue[ "SleepTime"                 , v_ ] := fitTimeOfDay @ v[[ "sleep_time" ]];
fitUserProfileValue[ "WakeTime"                  , v_ ] := fitTimeOfDay @ v[[ "wake_time" ]];
fitUserProfileValue[ _                           , _  ] := Missing[ "NotAvailable" ];

indexTranslate[ "UserProfile", fitUserProfileValue ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Activity*)
fitValue[ "Activity", name_, value_ ] := fitActivityValue[ name, value ];

fitActivityValue // ClearAll;
fitActivityValue[ "Timestamp"       , v_ ] := fitDateTime @ v[[ "timestamp" ]];
fitActivityValue[ "TotalTimerTime"  , v_ ] := fitTime32 @ v[[ "total_timer_time" ]];
fitActivityValue[ "LocalTimestamp"  , v_ ] := fitLocalTimestamp @ v[[ "local_timestamp" ]];
fitActivityValue[ "NumberOfSessions", v_ ] := fitUINT16 @ v[[ "num_sessions" ]];
fitActivityValue[ "Type"            , v_ ] := fitActivity @ v[[ "type" ]];
fitActivityValue[ "Event"           , v_ ] := fitEvent @ v[[ "event" ]];
fitActivityValue[ "EventType"       , v_ ] := fitEventType @ v[[ "event_type" ]];
fitActivityValue[ "EventGroup"      , v_ ] := fitEventGroup @ v[[ "event_group" ]];
fitActivityValue[ _                 , _  ] := Missing[ "NotAvailable" ];

indexTranslate[ "Activity", fitActivityValue ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Lap*)
fitValue[ "Lap", name_, value_ ] := fitLapValue[ name, value ];

fitLapValue // ClearAll;
fitLapValue[ "Timestamp"                          , v_ ] := fitDateTime @ v[[ "timestamp" ]];
fitLapValue[ "StartTime"                          , v_ ] := fitDateTime @ v[[ "start_time" ]];
fitLapValue[ "StartPosition"                      , v_ ] := fitGeoPosition @ v[[ { "start_position_lat", "start_position_long" } ]];
fitLapValue[ "EndPosition"                        , v_ ] := fitGeoPosition @ v[[ { "end_position_lat", "end_position_long" } ]];
fitLapValue[ "TotalElapsedTime"                   , v_ ] := fitTime32 @ v[[ "total_elapsed_time" ]];
fitLapValue[ "TotalTimerTime"                     , v_ ] := fitTime32 @ v[[ "total_timer_time" ]];
fitLapValue[ "TotalDistance"                      , v_ ] := fitDistance @ v[[ "total_distance" ]];
fitLapValue[ "TotalCycles"                        , v_ ] := fitCycles32[ v[[ "total_cycles" ]], v[[ "total_fractional_cycles" ]] ];
fitLapValue[ "TotalWork"                          , v_ ] := fitWork @ v[[ "total_work" ]];
fitLapValue[ "TotalMovingTime"                    , v_ ] := fitTime32 @ v[[ "total_moving_time" ]];
fitLapValue[ "TimeInHeartRateZone"                , v_ ] := fitTimeInZone @ v[[ "time_in_hr_zone" ]];
fitLapValue[ "TimeInSpeedZone"                    , v_ ] := fitTimeInZone @ v[[ "time_in_speed_zone" ]];
fitLapValue[ "TimeInCadenceZone"                  , v_ ] := fitTimeInZone @ v[[ "time_in_cadence_zone" ]];
fitLapValue[ "TimeInPowerZone"                    , v_ ] := fitTimeInZone @ v[[ "time_in_power_zone" ]];
fitLapValue[ "MessageIndex"                       , v_ ] := fitMessageIndex @ v[[ "message_index" ]];
fitLapValue[ "TotalCalories"                      , v_ ] := fitCalories @ v[[ "total_calories" ]];
fitLapValue[ "TotalFatCalories"                   , v_ ] := fitCalories @ v[[ "total_fat_calories" ]];
fitLapValue[ "AverageSpeed"                       , v_ ] := fitSpeedSelect[ v[[ "enhanced_avg_speed" ]], v[[ "avg_speed" ]] ];
fitLapValue[ "MaxSpeed"                           , v_ ] := fitSpeedSelect[ v[[ "enhanced_max_speed" ]], v[[ "max_speed" ]] ];
fitLapValue[ "AveragePower"                       , v_ ] := fitPower16 @ v[[ "avg_power" ]];
fitLapValue[ "MaxPower"                           , v_ ] := fitPower16 @ v[[ "max_power" ]];
fitLapValue[ "TotalAscent"                        , v_ ] := fitAscent @ v[[ "total_ascent" ]];
fitLapValue[ "TotalDescent"                       , v_ ] := fitAscent @ v[[ "total_descent" ]];
fitLapValue[ "NumberOfLengths"                    , v_ ] := fitLengths @ v[[ "num_lengths" ]];
fitLapValue[ "NormalizedPower"                    , v_ ] := fitPower16 @ v[[ "normalized_power" ]];
fitLapValue[ "LeftRightBalance"                   , v_ ] := fitLeftRightBalance100 @ v[[ "left_right_balance" ]];
fitLapValue[ "FirstLengthIndex"                   , v_ ] := fitUINT16 @ v[[ "first_length_index" ]];
fitLapValue[ "AverageStrokeDistance"              , v_ ] := fitMeters100 @ v[[ "avg_stroke_distance" ]];
fitLapValue[ "NumberOfActiveLengths"              , v_ ] := fitLengths @ v[[ "num_active_lengths" ]];
fitLapValue[ "AverageAltitude"                    , v_ ] := fitAltitudeSelect[ v[[ "enhanced_avg_altitude" ]], v[[ "avg_altitude" ]] ];
fitLapValue[ "MaxAltitude"                        , v_ ] := fitAltitudeSelect[ v[[ "enhanced_max_altitude" ]], v[[ "max_altitude" ]] ];
fitLapValue[ "AverageGrade"                       , v_ ] := fitGrade @ v[[ "avg_grade" ]];
fitLapValue[ "AveragePositiveGrade"               , v_ ] := fitGrade @ v[[ "avg_pos_grade" ]];
fitLapValue[ "AverageNegativeGrade"               , v_ ] := fitGrade @ v[[ "avg_neg_grade" ]];
fitLapValue[ "MaxPositiveGrade"                   , v_ ] := fitGrade @ v[[ "max_pos_grade" ]];
fitLapValue[ "MaxNegativeGrade"                   , v_ ] := fitGrade @ v[[ "max_neg_grade" ]];
fitLapValue[ "AveragePositiveVerticalSpeed"       , v_ ] := fitVerticalSpeed @ v[[ "avg_pos_vertical_speed" ]];
fitLapValue[ "AverageNegativeVerticalSpeed"       , v_ ] := fitVerticalSpeed @ v[[ "avg_neg_vertical_speed" ]];
fitLapValue[ "MaxPositiveVerticalSpeed"           , v_ ] := fitVerticalSpeed @ v[[ "max_pos_vertical_speed" ]];
fitLapValue[ "MaxNegativeVerticalSpeed"           , v_ ] := fitVerticalSpeed @ v[[ "max_neg_vertical_speed" ]];
fitLapValue[ "RepetitionNumber"                   , v_ ] := fitUINT16 @ v[[ "repetition_num" ]];
fitLapValue[ "MinAltitude"                        , v_ ] := fitAltitudeSelect[ v[[ "enhanced_min_altitude" ]], v[[ "min_altitude" ]] ];
fitLapValue[ "WorkoutStepIndex"                   , v_ ] := fitUINT16 @ v[[ "wkt_step_index" ]];
fitLapValue[ "OpponentScore"                      , v_ ] := fitUINT16 @ v[[ "opponent_score" ]];
fitLapValue[ "StrokeCount"                        , v_ ] := fitStrokeCount @ v[[ "stroke_count" ]];
fitLapValue[ "ZoneCount"                          , v_ ] := fitZoneCount @ v[[ "zone_count" ]];
fitLapValue[ "AverageVerticalOscillation"         , v_ ] := fitVerticalOscillation @ v[[ "avg_vertical_oscillation" ]];
fitLapValue[ "AverageStanceTimePercent"           , v_ ] := fitStanceTimePercent @ v[[ "avg_stance_time_percent" ]];
fitLapValue[ "AverageStanceTime"                  , v_ ] := fitStanceTime @ v[[ "avg_stance_time" ]];
fitLapValue[ "PlayerScore"                        , v_ ] := fitUINT16 @ v[[ "player_score" ]];
fitLapValue[ "AverageTotalHemoglobinConcentration", v_ ] := fitHemoglobin @ v[[ "avg_total_hemoglobin_conc" ]];
fitLapValue[ "MinimumTotalHemoglobinConcentration", v_ ] := fitHemoglobin @ v[[ "min_total_hemoglobin_conc" ]];
fitLapValue[ "MaximumTotalHemoglobinConcentration", v_ ] := fitHemoglobin @ v[[ "max_total_hemoglobin_conc" ]];
fitLapValue[ "AverageSaturatedHemoglobinPercent"  , v_ ] := fitHemoglobinPercent @ v[[ "avg_saturated_hemoglobin_percent" ]];
fitLapValue[ "MinimumSaturatedHemoglobinPercent"  , v_ ] := fitHemoglobinPercent @ v[[ "min_saturated_hemoglobin_percent" ]];
fitLapValue[ "MaximumSaturatedHemoglobinPercent"  , v_ ] := fitHemoglobinPercent @ v[[ "max_saturated_hemoglobin_percent" ]];
fitLapValue[ "AverageVAM"                         , v_ ] := fitVAM @ v[[ "avg_vam" ]];
fitLapValue[ "Event"                              , v_ ] := fitEvent @ v[[ "event" ]];
fitLapValue[ "EventType"                          , v_ ] := fitEventType @ v[[ "event_type" ]];
fitLapValue[ "AverageHeartRate"                   , v_ ] := fitHeartRate @ v[[ "avg_heart_rate" ]];
fitLapValue[ "MaxHeartRate"                       , v_ ] := fitHeartRate @ v[[ "max_heart_rate" ]];
fitLapValue[ "AverageCadence"                     , v_ ] := fitCadence[ v[[ "avg_cadence" ]], v[[ "avg_fractional_cadence" ]] ];
fitLapValue[ "MaxCadence"                         , v_ ] := fitCadence[ v[[ "max_cadence" ]], v[[ "max_fractional_cadence" ]] ];
fitLapValue[ "Intensity"                          , v_ ] := fitIntensity @ v[[ "intensity" ]];
fitLapValue[ "LapTrigger"                         , v_ ] := fitLapTrigger @ v[[ "lap_trigger" ]];
fitLapValue[ "Sport"                              , v_ ] := fitSport @ v[[ "sport" ]];
fitLapValue[ "EventGroup"                         , v_ ] := fitUINT8 @ v[[ "event_group" ]];
fitLapValue[ "SwimStroke"                         , v_ ] := fitSwimStroke @ v[[ "swim_stroke" ]];
fitLapValue[ "SubSport"                           , v_ ] := fitSubSport @ v[[ "sub_sport" ]];
fitLapValue[ "GPSAccuracy"                        , v_ ] := fitGPSAccuracy @ v[[ "gps_accuracy" ]];
fitLapValue[ "AverageTemperature"                 , v_ ] := fitTemperature8 @ v[[ "avg_temperature" ]];
fitLapValue[ "MaxTemperature"                     , v_ ] := fitTemperature8 @ v[[ "max_temperature" ]];
fitLapValue[ "MinHeartRate"                       , v_ ] := fitHeartRate @ v[[ "min_heart_rate" ]];
fitLapValue[ _                                    , v_ ] := Missing[ "NotAvailable" ];

indexTranslate[ "Lap", fitLapValue ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*DeviceSettings*)
fitValue[ "DeviceSettings", name_, value_ ] := fitDeviceSettingsValue[ name, value ];

fitDeviceSettingsValue // ClearAll;
fitDeviceSettingsValue[ "UTCOffset"             , v_ ] := fitUINT32 @ v[[ "utc_offset" ]];
fitDeviceSettingsValue[ "TimeOffset"            , v_ ] := fitTimeOffset @ v[[ "time_offset" ]];
fitDeviceSettingsValue[ "ClockTime"             , v_ ] := fitDateTime @ v[[ "clock_time" ]];
fitDeviceSettingsValue[ "PagesEnabled"          , v_ ] := fitUINT16BF @ v[[ "pages_enabled" ]];
fitDeviceSettingsValue[ "DefaultPage"           , v_ ] := fitUINT16BF @ v[[ "default_page" ]];
fitDeviceSettingsValue[ "AutoSyncMinSteps"      , v_ ] := fitSteps @ v[[ "autosync_min_steps" ]];
fitDeviceSettingsValue[ "AutoSyncMinTime"       , v_ ] := fitMinutes @ v[[ "autosync_min_time" ]];
fitDeviceSettingsValue[ "ActiveTimeZone"        , v_ ] := fitUINT8 @ v[[ "active_time_zone" ]];
fitDeviceSettingsValue[ "TimeMode"              , v_ ] := fitTimeModeArr @ v[[ "time_mode" ]];
fitDeviceSettingsValue[ "TimeZoneOffset"        , v_ ] := fitTimeZoneOffset @ v[[ "time_zone_offset" ]];
fitDeviceSettingsValue[ "BacklightMode"         , v_ ] := fitBacklightMode @ v[[ "backlight_mode" ]];
fitDeviceSettingsValue[ "ActivityTrackerEnabled", v_ ] := fitBool @ v[[ "activity_tracker_enabled" ]];
fitDeviceSettingsValue[ "MoveAlertEnabled"      , v_ ] := fitBool @ v[[ "move_alert_enabled" ]];
fitDeviceSettingsValue[ "DateMode"              , v_ ] := fitDateMode @ v[[ "date_mode" ]];
fitDeviceSettingsValue[ "DisplayOrientation"    , v_ ] := fitDisplayOrientation @ v[[ "display_orientation" ]];
fitDeviceSettingsValue[ "MountingSide"          , v_ ] := fitSide @ v[[ "mounting_side" ]];
fitDeviceSettingsValue[ "TapSensitivity"        , v_ ] := fitTapSensitivity @ v[[ "tap_sensitivity" ]];
fitDeviceSettingsValue[ _                       , _  ] := Missing[ "NotAvailable" ];

indexTranslate[ "DeviceSettings", fitDeviceSettingsValue ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Record*)
fitValue[ "Record", name_, value_ ] := fitRecordValue[ name, value ];

fitRecordValue // ClearAll;
fitRecordValue[ "Timestamp"                      , v_ ] := fitDateTime @ v[[ "timestamp" ]];
fitRecordValue[ "GeoPosition"                    , v_ ] := fitGeoPosition @ v[[ { "position_lat", "position_long" } ]];
fitRecordValue[ "Distance"                       , v_ ] := fitDistance @ v[[ "distance" ]];
fitRecordValue[ "TimeFromCourse"                 , v_ ] := fitTimeFromCourse @ v[[ "time_from_course" ]];
fitRecordValue[ "TotalCycles"                    , v_ ] := fitCycles32 @ v[[ "total_cycles" ]];
fitRecordValue[ "AccumulatedPower"               , v_ ] := fitAccumulatedPower @ v[[ { "timestamp", "accumulated_power" } ]];
fitRecordValue[ "Altitude"                       , v_ ] := fitAltitudeSelect[ v[[ "enhanced_altitude" ]], v[[ "altitude" ]] ];
fitRecordValue[ "Speed"                          , v_ ] := fitSpeedSelect[ v[[ "enhanced_speed" ]], v[[ "speed" ]] ];
fitRecordValue[ "Power"                          , v_ ] := fitPower16 @ v[[ "power" ]];
fitRecordValue[ "Grade"                          , v_ ] := fitGrade @ v[[ "grade" ]];
fitRecordValue[ "CompressedAccumulatedPower"     , v_ ] := fitCompressedAccumulatedPower @ v[[ "compressed_accumulated_power" ]];
fitRecordValue[ "VerticalSpeed"                  , v_ ] := fitVerticalSpeed @ v[[ "vertical_speed" ]];
fitRecordValue[ "Calories"                       , v_ ] := fitCalories @ v[[ "calories" ]];
fitRecordValue[ "VerticalOscillation"            , v_ ] := fitVerticalOscillation @ v[[ "vertical_oscillation" ]];
fitRecordValue[ "StanceTimePercent"              , v_ ] := fitStanceTimePercent @ v[[ "stance_time_percent" ]];
fitRecordValue[ "StanceTime"                     , v_ ] := fitStanceTime @ v[[ "stance_time" ]];
fitRecordValue[ "BallSpeed"                      , v_ ] := fitBallSpeed @ v[[ "ball_speed" ]];
fitRecordValue[ "Cadence256"                     , v_ ] := fitCadence256 @ v[[ "cadence256" ]];
fitRecordValue[ "TotalHemoglobinConcentration"   , v_ ] := fitHemoglobin @ v[[ "total_hemoglobin_conc" ]];
fitRecordValue[ "TotalHemoglobinConcentrationMin", v_ ] := fitHemoglobin @ v[[ "total_hemoglobin_conc_min" ]];
fitRecordValue[ "TotalHemoglobinConcentrationMax", v_ ] := fitHemoglobin @ v[[ "total_hemoglobin_conc_max" ]];
fitRecordValue[ "SaturatedHemoglobinPercent"     , v_ ] := fitHemoglobinPercent @ v[[ "saturated_hemoglobin_percent" ]];
fitRecordValue[ "SaturatedHemoglobinPercentMin"  , v_ ] := fitHemoglobinPercent @ v[[ "saturated_hemoglobin_percent_min" ]];
fitRecordValue[ "SaturatedHemoglobinPercentMax"  , v_ ] := fitHemoglobinPercent @ v[[ "saturated_hemoglobin_percent_max" ]];
fitRecordValue[ "HeartRate"                      , v_ ] := fitHeartRate @ v[[ "heart_rate" ]];
fitRecordValue[ "Cadence"                        , v_ ] := fitCadence[ v[[ "cadence" ]], v[[ "fractional_cadence" ]] ];
fitRecordValue[ "Resistance"                     , v_ ] := fitResistance @ v[[ "resistance" ]];
fitRecordValue[ "CycleLength"                    , v_ ] := fitCycleLength @ v[[ "cycle_length" ]];
fitRecordValue[ "Temperature"                    , v_ ] := fitTemperature8 @ v[[ "temperature" ]];
fitRecordValue[ "Cycles"                         , v_ ] := fitCycles8 @ v[[ "cycles" ]];
fitRecordValue[ "LeftRightBalance"               , v_ ] := fitLeftRightBalance @ v[[ "left_right_balance" ]];
fitRecordValue[ "GPSAccuracy"                    , v_ ] := fitGPSAccuracy @ v[[ "gps_accuracy" ]];
fitRecordValue[ "ActivityType"                   , v_ ] := fitActivityType @ v[[ "activity_type" ]];
fitRecordValue[ "LeftTorqueEffectiveness"        , v_ ] := fitTorqueEffectiveness @ v[[ "left_torque_effectiveness" ]];
fitRecordValue[ "RightTorqueEffectiveness"       , v_ ] := fitTorqueEffectiveness @ v[[ "right_torque_effectiveness" ]];
fitRecordValue[ "LeftPedalSmoothness"            , v_ ] := fitPedalSmoothness @ v[[ "left_pedal_smoothness" ]];
fitRecordValue[ "RightPedalSmoothness"           , v_ ] := fitPedalSmoothness @ v[[ "right_pedal_smoothness" ]];
fitRecordValue[ "CombinedPedalSmoothness"        , v_ ] := fitPedalSmoothness @ v[[ "combined_pedal_smoothness" ]];
fitRecordValue[ "Time128"                        , v_ ] := fitTime128 @ v[[ "time128" ]];
fitRecordValue[ "StrokeType"                     , v_ ] := fitStrokeType @ v[[ "stroke_type" ]];
fitRecordValue[ "Zone"                           , v_ ] := fitZone @ v[[ "zone" ]];
fitRecordValue[ "DeviceIndex"                    , v_ ] := fitDeviceIndex @ v[[ "device_index" ]];
fitRecordValue[ "LeftPlatformCenterOffset"       , v_ ] := fitPCO @ v[[ "left_pco" ]];
fitRecordValue[ "RightPlatformCenterOffset"      , v_ ] := fitPCO @ v[[ "right_pco" ]];
fitRecordValue[ "LeftPowerPhaseStart"            , v_ ] := fitPowerPhase @ v[[ "left_power_phase" ]][[  1 ]];
fitRecordValue[ "LeftPowerPhaseEnd"              , v_ ] := fitPowerPhase @ v[[ "left_power_phase" ]][[ -1 ]];
fitRecordValue[ "LeftPowerPhasePeakStart"        , v_ ] := fitPowerPhase @ v[[ "left_power_phase_peak" ]][[  1 ]];
fitRecordValue[ "LeftPowerPhasePeakEnd"          , v_ ] := fitPowerPhase @ v[[ "left_power_phase_peak" ]][[ -1 ]];
fitRecordValue[ "RightPowerPhaseStart"           , v_ ] := fitPowerPhase @ v[[ "right_power_phase" ]][[  1 ]];
fitRecordValue[ "RightPowerPhaseEnd"             , v_ ] := fitPowerPhase @ v[[ "right_power_phase" ]][[ -1 ]];
fitRecordValue[ "RightPowerPhasePeakStart"       , v_ ] := fitPowerPhase @ v[[ "right_power_phase_peak" ]][[  1 ]];
fitRecordValue[ "RightPowerPhasePeakEnd"         , v_ ] := fitPowerPhase @ v[[ "right_power_phase_peak" ]][[ -1 ]];
fitRecordValue[ "BatterySOC"                     , v_ ] := fit2Percent @ v[[ "battery_soc" ]];
fitRecordValue[ "MotorPower"                     , v_ ] := fitPower16 @ v[[ "motor_power" ]];
fitRecordValue[ "VerticalRatio"                  , v_ ] := fitPercent16 @ v[[ "vertical_ratio" ]];
fitRecordValue[ "StanceTimeBalance"              , v_ ] := fitPercent16 @ v[[ "stance_time_balance" ]];
fitRecordValue[ "StepLength"                     , v_ ] := fitLength10mm @ v[[ "step_length" ]];
fitRecordValue[ "AbsolutePressure"               , v_ ] := fitPressure32 @ v[[ "absolute_pressure" ]];
fitRecordValue[ "CNSLoad"                        , v_ ] := fitPercent8 @ v[[ "cns_load" ]];
fitRecordValue[ "CompressedSpeedDistance"        , v_ ] := fitUINT8 @ v[[ "compressed_speed_distance" ]];
fitRecordValue[ "CoreTemperature"                , v_ ] := fitTemperature100C @ v[[ "core_temperature" ]];
fitRecordValue[ "Depth"                          , v_ ] := fitDepth @ v[[ "depth" ]];
fitRecordValue[ "EBikeAssistLevel"               , v_ ] := fitPercent8 @ v[[ "ebike_assist_level_percent" ]];
fitRecordValue[ "EBikeAssistMode"                , v_ ] := fitUINT8 @ v[[ "ebike_assist_mode" ]];
fitRecordValue[ "EBikeBatteryLevel"              , v_ ] := fitPercent8 @ v[[ "ebike_battery_level" ]];
fitRecordValue[ "EBikeTravelRange"               , v_ ] := fitTravelRange @ v[[ "ebike_travel_range" ]];
fitRecordValue[ "Flow"                           , v_ ] := fitFloat32 @ v[[ "flow" ]];
fitRecordValue[ "Grit"                           , v_ ] := fitFloat32 @ v[[ "grit" ]];
fitRecordValue[ "N2Load"                         , v_ ] := fitUINT16 @ v[[ "n2_load" ]];
fitRecordValue[ "NDLTime"                        , v_ ] := fitUINT32 @ v[[ "ndl_time" ]];
fitRecordValue[ "NextStopDepth"                  , v_ ] := fitDepth @ v[[ "next_stop_depth" ]];
fitRecordValue[ "NextStopTime"                   , v_ ] := fitSeconds @ v[[ "next_stop_time" ]];
fitRecordValue[ "Speed1S"                        , v_ ] := fitUINT8 @ v[[ "speed_1s" ]];
fitRecordValue[ "TimeToSurface"                  , v_ ] := fitSeconds @ v[[ "time_to_surface" ]];
(* fitRecordValue[ "Unknown61"                      , v_ ] := fitUINT16 @ v[[ 64 ]];
fitRecordValue[ "PerformanceCondition"           , v_ ] := fitSINT8 @ v[[ 65 ]];
fitRecordValue[ "Unknown90"                      , v_ ] := fitSINT8 @ v[[ 66 ]];
fitRecordValue[ "RespirationRate"                , v_ ] := fitRespirationRate @ v[[ 67 ]]; *)
(* fitRecordValue[ "HeartRateVariability"           , v_ ] := fitHRV @ v[[ 64 ]]; *)
fitRecordValue[ "PowerZone"                      , v_ ] := fitPowerZone @ v[[ "power" ]];
fitRecordValue[ "HeartRateZone"                  , v_ ] := fitHeartRateZone @ v[[ "heart_rate" ]];
fitRecordValue[ _                                , _  ] := Missing[ "NotAvailable" ];

indexTranslate[ "Record", fitRecordValue ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Event*)
fitValue[ "Event", name_, value_ ] := fitEventValue[ name, value ];

fitEventValue // ClearAll;
fitEventValue[ "Timestamp"           , v_ ] := fitDateTime @ v[[ "timestamp" ]];
fitEventValue[ "Data"                , v_ ] := fitUINT32 @ v[[ "data" ]];
fitEventValue[ "Data16"              , v_ ] := fitUINT16 @ v[[ "data16" ]];
fitEventValue[ "Score"               , v_ ] := fitUINT16 @ v[[ "score" ]];
fitEventValue[ "OpponentScore"       , v_ ] := fitUINT16 @ v[[ "opponent_score" ]];
fitEventValue[ "Event"               , v_ ] := fitEvent @ v[[ "event" ]];
fitEventValue[ "EventType"           , v_ ] := fitEventType @ v[[ "event_type" ]];
fitEventValue[ "EventGroup"          , v_ ] := fitEventGroup @ v[[ "event_group" ]];
fitEventValue[ "FrontGearNum"        , v_ ] := fitFrontGearNum @ v[[ "front_gear_num" ]];
fitEventValue[ "FrontGear"           , v_ ] := fitFrontGear @ v[[ "front_gear" ]];
fitEventValue[ "RearGearNum"         , v_ ] := fitRearGearNum @ v[[ "rear_gear_num" ]];
fitEventValue[ "RearGear"            , v_ ] := fitRearGear @ v[[ "rear_gear" ]];
fitEventValue[ "RadarThreatLevelType", v_ ] := fitRadarThreatLevelType @ v[[ "radar_threat_level_max" ]];
fitEventValue[ "RadarThreatCount"    , v_ ] := fitRadarThreatCount @ v[[ "radar_threat_count" ]];
fitEventValue[ _                     , _  ] := Missing[ "NotAvailable" ];

indexTranslate[ "Event", fitEventValue ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*DeviceInformation*)
fitValue[ "DeviceInformation", name_, value_ ] := fitDeviceInformationValue[ name, value ];

fitDeviceInformationValue // ClearAll;
fitDeviceInformationValue[ "Timestamp"              , v_ ] := fitDateTime @ v[[ "timestamp" ]];
fitDeviceInformationValue[ "SerialNumber"           , v_ ] := fitSerialNumber @ v[[ "serial_number" ]];
fitDeviceInformationValue[ "CumulativeOperatingTime", v_ ] := fitCumulativeOperatingTime @ v[[ "cum_operating_time" ]];
fitDeviceInformationValue[ "Manufacturer"           , v_ ] := fitManufacturer @ v[[ "manufacturer" ]];
fitDeviceInformationValue[ "Product"                , v_ ] := fitProduct @ v[[ "product" ]];
fitDeviceInformationValue[ "SoftwareVersion"        , v_ ] := fitSoftwareVersion @ v[[ "software_version" ]];
fitDeviceInformationValue[ "BatteryVoltage"         , v_ ] := fitBatteryVoltage @ v[[ "battery_voltage" ]];
fitDeviceInformationValue[ "ANTDeviceNumber"        , v_ ] := fitANTDeviceNumber @ v[[ "ant_device_number" ]];
fitDeviceInformationValue[ "DeviceIndex"            , v_ ] := fitDeviceIndex @ v[[ "device_index" ]];
fitDeviceInformationValue[ "DeviceType"             , v_ ] := fitANTPlusDeviceType @ v[[ "device_type" ]];
fitDeviceInformationValue[ "HardwareVersion"        , v_ ] := fitHardwareVersion @ v[[ "hardware_version" ]];
fitDeviceInformationValue[ "BatteryStatus"          , v_ ] := fitBatteryStatus @ v[[ "battery_status" ]];
fitDeviceInformationValue[ "SensorPosition"         , v_ ] := fitBodyLocation @ v[[ "sensor_position" ]];
fitDeviceInformationValue[ "ANTTransmissionType"    , v_ ] := fitANTTransmissionType @ v[[ "ant_transmission_type" ]];
fitDeviceInformationValue[ "ANTNetwork"             , v_ ] := fitANTNetwork @ v[[ "ant_network" ]];
fitDeviceInformationValue[ "SourceType"             , v_ ] := fitSourceType @ v[[ "source_type" ]];
fitDeviceInformationValue[ "ProductName"            , v_ ] := fitProductName[ v[[ { "manufacturer", "product" } ]], v[[ "product_name" ]] ];
fitDeviceInformationValue[ "Descriptor"             , v_ ] := fitString @ v[[ "descriptor" ]];
fitDeviceInformationValue[ _                        , _  ] := Missing[ "NotAvailable" ];

indexTranslate[ "DeviceInformation", fitDeviceInformationValue ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Session*)
fitValue[ "Session", name_, value_ ] := fitSessionValue[ name, value ];

fitSessionValue // ClearAll;
fitSessionValue[ "Timestamp"                              , v_ ] := fitDateTime @ v[[ "timestamp" ]];
fitSessionValue[ "StartTime"                              , v_ ] := fitDateTime @ v[[ "start_time" ]];
fitSessionValue[ "StartPosition"                          , v_ ] := fitGeoPosition @ v[[ { "start_position_lat", "start_position_long" } ]];
fitSessionValue[ "TotalElapsedTime"                       , v_ ] := fitTime32 @ v[[ "total_elapsed_time" ]];
fitSessionValue[ "TotalTimerTime"                         , v_ ] := fitTime32 @ v[[ "total_timer_time" ]];
fitSessionValue[ "TotalDistance"                          , v_ ] := fitDistance @ v[[ "total_distance" ]];
fitSessionValue[ "TotalCycles"                            , v_ ] := fitCycles32[ v[[ "total_cycles" ]], v[[ "total_fractional_cycles" ]] ];
fitSessionValue[ "GeoBoundingBox"                         , v_ ] := fitGeoBoundingBox @ v[[ { "nec_lat", "nec_long", "swc_lat", "swc_long" } ]];
fitSessionValue[ "AverageStrokeCount"                     , v_ ] := fitAverageStrokeCount @ v[[ "avg_stroke_count" ]];
fitSessionValue[ "TotalWork"                              , v_ ] := fitWork @ v[[ "total_work" ]];
fitSessionValue[ "TotalMovingTime"                        , v_ ] := fitTime32 @ v[[ "total_moving_time" ]];
fitSessionValue[ "TimeInHeartRateZone"                    , v_ ] := fitTimeInZone @ v[[ "time_in_hr_zone" ]];
fitSessionValue[ "TimeInSpeedZone"                        , v_ ] := fitTimeInZone @ v[[ "time_in_speed_zone" ]];
fitSessionValue[ "TimeInCadenceZone"                      , v_ ] := fitTimeInZone @ v[[ "time_in_cadence_zone" ]];
fitSessionValue[ "TimeInPowerZone"                        , v_ ] := fitTimeInZone @ v[[ "time_in_power_zone" ]];
fitSessionValue[ "AverageLapTime"                         , v_ ] := fitTime32 @ v[[ "avg_lap_time" ]];
fitSessionValue[ "MessageIndex"                           , v_ ] := fitMessageIndex @ v[[ "message_index" ]];
fitSessionValue[ "TotalCalories"                          , v_ ] := fitCalories @ v[[ "total_calories" ]];
fitSessionValue[ "TotalFatCalories"                       , v_ ] := fitCalories @ v[[ "total_fat_calories" ]];
fitSessionValue[ "AverageSpeed"                           , v_ ] := fitSpeedSelect[ v[[ "enhanced_avg_speed" ]], v[[ "avg_speed" ]] ];
fitSessionValue[ "MaxSpeed"                               , v_ ] := fitSpeedSelect[ v[[ "enhanced_max_speed" ]], v[[ "max_speed" ]] ];
fitSessionValue[ "AveragePower"                           , v_ ] := fitPower16 @ v[[ "avg_power" ]];
fitSessionValue[ "MaxPower"                               , v_ ] := fitPower16 @ v[[ "max_power" ]];
fitSessionValue[ "TotalAscent"                            , v_ ] := fitAscent[ v[[ "total_ascent" ]], v[[ "total_fractional_ascent" ]] ];
fitSessionValue[ "TotalDescent"                           , v_ ] := fitAscent[ v[[ "total_descent" ]], v[[ "total_fractional_descent" ]] ];
fitSessionValue[ "FirstLapIndex"                          , v_ ] := fitUINT16 @ v[[ "first_lap_index" ]];
fitSessionValue[ "NumberOfLaps"                           , v_ ] := fitLaps @ v[[ "num_laps" ]];
fitSessionValue[ "NumberOfLengths"                        , v_ ] := fitLengths @ v[[ "num_lengths" ]];
fitSessionValue[ "NormalizedPower"                        , v_ ] := fitPower16 @ v[[ "normalized_power" ]];
fitSessionValue[ "TrainingStressScore"                    , v_ ] := fitTrainingStressScore @ v[[ "training_stress_score" ]];
fitSessionValue[ "IntensityFactor"                        , v_ ] := fitIntensityFactor @ v[[ "intensity_factor" ]];
fitSessionValue[ "LeftRightBalance"                       , v_ ] := fitLeftRightBalance100 @ v[[ "left_right_balance" ]];
fitSessionValue[ "AverageStrokeDistance"                  , v_ ] := fitMeters100 @ v[[ "avg_stroke_distance" ]];
fitSessionValue[ "PoolLength"                             , v_ ] := fitMeters100 @ v[[ "pool_length" ]];
fitSessionValue[ "ThresholdPower"                         , v_ ] := fitPower16 @ v[[ "threshold_power" ]];
fitSessionValue[ "NumberOfActiveLengths"                  , v_ ] := fitLengths @ v[[ "num_active_lengths" ]];
fitSessionValue[ "AverageAltitude"                        , v_ ] := fitAltitudeSelect[ v[[ "enhanced_avg_altitude" ]], v[[ "avg_altitude" ]] ];
fitSessionValue[ "MaxAltitude"                            , v_ ] := fitAltitudeSelect[ v[[ "enhanced_max_altitude" ]], v[[ "max_altitude" ]] ];
fitSessionValue[ "AverageGrade"                           , v_ ] := fitGrade @ v[[ "avg_grade" ]];
fitSessionValue[ "AveragePositiveGrade"                   , v_ ] := fitGrade @ v[[ "avg_pos_grade" ]];
fitSessionValue[ "AverageNegativeGrade"                   , v_ ] := fitGrade @ v[[ "avg_neg_grade" ]];
fitSessionValue[ "MaxPositiveGrade"                       , v_ ] := fitGrade @ v[[ "max_pos_grade" ]];
fitSessionValue[ "MaxNegativeGrade"                       , v_ ] := fitGrade @ v[[ "max_neg_grade" ]];
fitSessionValue[ "AveragePositiveVerticalSpeed"           , v_ ] := fitVerticalSpeed @ v[[ "avg_pos_vertical_speed" ]];
fitSessionValue[ "AverageNegativeVerticalSpeed"           , v_ ] := fitVerticalSpeed @ v[[ "avg_neg_vertical_speed" ]];
fitSessionValue[ "MaxPositiveVerticalSpeed"               , v_ ] := fitVerticalSpeed @ v[[ "max_pos_vertical_speed" ]];
fitSessionValue[ "MaxNegativeVerticalSpeed"               , v_ ] := fitVerticalSpeed @ v[[ "max_neg_vertical_speed" ]];
fitSessionValue[ "BestLapIndex"                           , v_ ] := fitUINT16 @ v[[ "best_lap_index" ]];
fitSessionValue[ "MinAltitude"                            , v_ ] := fitAltitudeSelect[ v[[ "enhanced_min_altitude" ]], v[[ "min_altitude" ]] ];
fitSessionValue[ "PlayerScore"                            , v_ ] := fitUINT16 @ v[[ "player_score" ]];
fitSessionValue[ "OpponentScore"                          , v_ ] := fitUINT16 @ v[[ "opponent_score" ]];
fitSessionValue[ "StrokeCount"                            , v_ ] := fitStrokeCount @ v[[ "stroke_count" ]];
fitSessionValue[ "ZoneCount"                              , v_ ] := fitZoneCount @ v[[ "zone_count" ]];
fitSessionValue[ "MaxBallSpeed"                           , v_ ] := fitBallSpeed @ v[[ "max_ball_speed" ]];
fitSessionValue[ "AverageBallSpeed"                       , v_ ] := fitBallSpeed @ v[[ "avg_ball_speed" ]];
fitSessionValue[ "AverageVerticalOscillation"             , v_ ] := fitVerticalOscillation @ v[[ "avg_vertical_oscillation" ]];
fitSessionValue[ "AverageStanceTimePercent"               , v_ ] := fitStanceTimePercent @ v[[ "avg_stance_time_percent" ]];
fitSessionValue[ "AverageStanceTime"                      , v_ ] := fitStanceTime @ v[[ "avg_stance_time" ]];
fitSessionValue[ "AverageStanceTimeBalance"               , v_ ] := fitPercent16 @ v[[ "avg_stance_time_balance" ]];
fitSessionValue[ "StandCount"                             , v_ ] := fitUINT16 @ v[[ "stand_count" ]];
fitSessionValue[ "TimeStanding"                           , v_ ] := fitTime32 @ v[[ "time_standing" ]];
fitSessionValue[ "AverageStepLength"                      , v_ ] := fitStepLength @ v[[ "avg_step_length" ]];
fitSessionValue[ "AverageVerticalRatio"                   , v_ ] := fitPercent16 @ v[[ "avg_vertical_ratio" ]];
fitSessionValue[ "AverageVAM"                             , v_ ] := fitVAM @ v[[ "avg_vam" ]];
fitSessionValue[ "Event"                                  , v_ ] := fitEvent @ v[[ "event" ]];
fitSessionValue[ "EventType"                              , v_ ] := fitEventType @ v[[ "event_type" ]];
fitSessionValue[ "Sport"                                  , v_ ] := fitSport @ v[[ "sport" ]];
fitSessionValue[ "SubSport"                               , v_ ] := fitSubSport @ v[[ "sub_sport" ]];
fitSessionValue[ "AverageHeartRate"                       , v_ ] := fitHeartRate @ v[[ "avg_heart_rate" ]];
fitSessionValue[ "MaxHeartRate"                           , v_ ] := fitHeartRate @ v[[ "max_heart_rate" ]];
fitSessionValue[ "AverageCadence"                         , v_ ] := fitCadence[ v[[ "avg_cadence" ]], v[[ "avg_fractional_cadence" ]] ];
fitSessionValue[ "MaxCadence"                             , v_ ] := fitCadence[ v[[ "max_cadence" ]], v[[ "max_fractional_cadence" ]] ];
fitSessionValue[ "TotalAerobicTrainingEffect"             , v_ ] := fitTrainingEffect @ v[[ "total_training_effect" ]];
fitSessionValue[ "TotalAerobicTrainingEffectDescription"  , v_ ] := fitTrainingEffectDescription @ v[[ "total_training_effect" ]];
fitSessionValue[ "EventGroup"                             , v_ ] := fitEventGroup @ v[[ "event_group" ]];
fitSessionValue[ "Trigger"                                , v_ ] := fitSessionTrigger @ v[[ "trigger" ]];
fitSessionValue[ "SwimStroke"                             , v_ ] := fitSwimStroke @ v[[ "swim_stroke" ]];
fitSessionValue[ "PoolLengthUnit"                         , v_ ] := fitDisplayMeasure @ v[[ "pool_length_unit" ]];
fitSessionValue[ "GPSAccuracy"                            , v_ ] := fitGPSAccuracy @ v[[ "gps_accuracy" ]];
fitSessionValue[ "AverageTemperature"                     , v_ ] := fitTemperature8 @ v[[ "avg_temperature" ]];
fitSessionValue[ "MaxTemperature"                         , v_ ] := fitTemperature8 @ v[[ "max_temperature" ]];
fitSessionValue[ "MinHeartRate"                           , v_ ] := fitHeartRate @ v[[ "min_heart_rate" ]];
fitSessionValue[ "SportIndex"                             , v_ ] := fitUINT8 @ v[[ "sport_index" ]];
fitSessionValue[ "TotalAnaerobicTrainingEffect"           , v_ ] := fitTrainingEffect @ v[[ "total_anaerobic_training_effect" ]];
fitSessionValue[ "TotalAnaerobicTrainingEffectDescription", v_ ] := fitTrainingEffectDescription @ v[[ "total_anaerobic_training_effect" ]];
fitSessionValue[ "AverageLeftPlatformCenterOffset"        , v_ ] := fitPCO @ v[[ "avg_left_pco" ]];
fitSessionValue[ "AverageRightPlatformCenterOffset"       , v_ ] := fitPCO @ v[[ "avg_right_pco" ]];
fitSessionValue[ "AverageLeftPowerPhaseStart"             , v_ ] := fitPowerPhase @ v[[ "avg_left_power_phase" ]][[  1 ]];
fitSessionValue[ "AverageLeftPowerPhaseEnd"               , v_ ] := fitPowerPhase @ v[[ "avg_left_power_phase" ]][[ -1 ]];
fitSessionValue[ "AverageLeftPowerPhasePeakStart"         , v_ ] := fitPowerPhase @ v[[ "avg_left_power_phase_peak" ]][[  1 ]];
fitSessionValue[ "AverageLeftPowerPhasePeakEnd"           , v_ ] := fitPowerPhase @ v[[ "avg_left_power_phase_peak" ]][[ -1 ]];
fitSessionValue[ "AverageRightPowerPhaseStart"            , v_ ] := fitPowerPhase @ v[[ "avg_right_power_phase" ]][[  1 ]];
fitSessionValue[ "AverageRightPowerPhaseEnd"              , v_ ] := fitPowerPhase @ v[[ "avg_right_power_phase" ]][[ -1 ]];
fitSessionValue[ "AverageRightPowerPhasePeakStart"        , v_ ] := fitPowerPhase @ v[[ "avg_right_power_phase_peak" ]][[  1 ]];
fitSessionValue[ "AverageRightPowerPhasePeakEnd"          , v_ ] := fitPowerPhase @ v[[ "avg_right_power_phase_peak" ]][[ -1 ]];
fitSessionValue[ "AverageLeftPedalSmoothness"             , v_ ] := fitPedalSmoothness @ v[[ "avg_left_pedal_smoothness" ]];
fitSessionValue[ "AverageRightPedalSmoothness"            , v_ ] := fitPedalSmoothness @ v[[ "avg_right_pedal_smoothness" ]];
fitSessionValue[ "AverageCombinedPedalSmoothness"         , v_ ] := fitPedalSmoothness @ v[[ "avg_combined_pedal_smoothness" ]];
fitSessionValue[ "AverageCadencePosition"                 , v_ ] := fitCadencePosition @ v[[ "avg_cadence_position" ]];
fitSessionValue[ "MaxCadencePosition"                     , v_ ] := fitCadencePosition @ v[[ "max_cadence_position" ]];
fitSessionValue[ "AveragePowerPosition"                   , v_ ] := fitPowerPosition @ v[[ "avg_power_position" ]];
fitSessionValue[ "MaxPowerPosition"                       , v_ ] := fitPowerPosition @ v[[ "max_power_position" ]];
fitSessionValue[ "AverageCoreTemperature"                 , v_ ] := fitTemperature16 @ v[[ "avg_core_temperature" ]];
fitSessionValue[ "MinCoreTemperature"                     , v_ ] := fitTemperature16 @ v[[ "min_core_temperature" ]];
fitSessionValue[ "MaxCoreTemperature"                     , v_ ] := fitTemperature16 @ v[[ "max_core_temperature" ]];
fitSessionValue[ "AverageFlow"                            , v_ ] := fitFloat32 @ v[[ "avg_flow" ]];
fitSessionValue[ "AverageGrit"                            , v_ ] := fitFloat32 @ v[[ "avg_grit" ]];
fitSessionValue[ "TotalFlow"                              , v_ ] := fitFloat32 @ v[[ "total_flow" ]];
fitSessionValue[ "TotalGrit"                              , v_ ] := fitFloat32 @ v[[ "total_grit" ]];
fitSessionValue[ "JumpCount"                              , v_ ] := fitUINT16 @ v[[ "jump_count" ]];
fitSessionValue[ "AverageLeftTorqueEffectiveness"         , v_ ] := fit2Percent @ v[[ "avg_left_torque_effectiveness" ]];
fitSessionValue[ "AverageRightTorqueEffectiveness"        , v_ ] := fit2Percent @ v[[ "avg_right_torque_effectiveness" ]];
fitSessionValue[ "AverageLEVMotorPower"                   , v_ ] := fitPercent16 @ v[[ "avg_lev_motor_power" ]];
fitSessionValue[ "MaxLEVMotorPower"                       , v_ ] := fitPercent16 @ v[[ "max_lev_motor_power" ]];
fitSessionValue[ "LEVBatteryConsumption"                  , v_ ] := fit2Percent @ v[[ "lev_battery_consumption" ]];
fitSessionValue[ "AverageTotalHemoglobinConcentration"    , v_ ] := fitHemoglobin @ v[[ "avg_total_hemoglobin_conc" ]];
fitSessionValue[ "MinTotalHemoglobinConcentration"        , v_ ] := fitHemoglobin @ v[[ "min_total_hemoglobin_conc" ]];
fitSessionValue[ "MaxTotalHemoglobinConcentration"        , v_ ] := fitHemoglobin @ v[[ "max_total_hemoglobin_conc" ]];
fitSessionValue[ "AverageSaturatedHemoglobinPercent"      , v_ ] := fitHemoglobinPercent @ v[[ "avg_saturated_hemoglobin_percent" ]];
fitSessionValue[ "MinSaturatedHemoglobinPercent"          , v_ ] := fitHemoglobinPercent @ v[[ "min_saturated_hemoglobin_percent" ]];
fitSessionValue[ "MaxSaturatedHemoglobinPercent"          , v_ ] := fitHemoglobinPercent @ v[[ "max_saturated_hemoglobin_percent" ]];
fitSessionValue[ "OpponentName"                           , v_ ] := fitString @ v[[ "opponent_name" ]];
fitSessionValue[ "TrainingLoadPeak"                       , v_ ] := fitSINT32 @ v[[ "training_load_peak" ]];
fitSessionValue[ _                                        , _  ] := Missing[ "NotAvailable" ];

indexTranslate[ "Session", fitSessionValue ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*ZonesTarget*)
fitValue[ "ZonesTarget" , name_, value_ ] := fitZonesTargetValue[ name, value ];

fitZonesTargetValue // ClearAll;
fitZonesTargetValue[ "FunctionalThresholdPower", v_ ] := fitFTPSetting @ v[[ "functional_threshold_power" ]];
fitZonesTargetValue[ "MaxHeartRate"            , v_ ] := fitMaxHRSetting @ v[[ "max_heart_rate" ]];
fitZonesTargetValue[ "ThresholdHeartRate"      , v_ ] := fitHeartRate @ v[[ "threshold_heart_rate" ]];
fitZonesTargetValue[ "HeartRateCalculationType", v_ ] := fitHeartRateZoneCalc @ v[[ "hr_calc_type" ]];
fitZonesTargetValue[ "PowerZoneCalculationType", v_ ] := fitPowerZoneCalc @ v[[ "pwr_calc_type" ]];
fitZonesTargetValue[ _                         , _  ] := Missing[ "NotAvailable" ];

indexTranslate[ "ZonesTarget", fitZonesTargetValue ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*FileCreator*)
fitValue[ "FileCreator", name_, value_ ] := fitFileCreatorValue[ name, value ];

fitFileCreatorValue // ClearAll;
fitFileCreatorValue[ "SoftwareVersion", v_ ] := fitUINT16 @ v[[ "software_version" ]];
fitFileCreatorValue[ "HardwareVersion", v_ ] := fitUINT8 @ v[[ "hardware_version" ]];
fitFileCreatorValue[ _                , _  ] := Missing[ "NotAvailable" ];

indexTranslate[ "FileCreator", fitFileCreatorValue ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Sport*)
fitValue[ "Sport", name_, value_ ] := fitSportValue[ name, value ];

fitSportValue // ClearAll;
fitSportValue[ "Name"    , v_ ] := fitString @ v[[ "name" ]];
fitSportValue[ "Sport"   , v_ ] := fitSport @ v[[ "sport" ]];
fitSportValue[ "SubSport", v_ ] := fitSubSport @ v[[ "sub_sport" ]];
fitSportValue[ _         , _  ] := Missing[ "NotAvailable" ];

indexTranslate[ "Sport", fitSportValue ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*DeveloperDataID*)
fitValue[ "DeveloperDataID", name_, value_ ] := fitDeveloperDataIDValue[ name, value ];

fitDeveloperDataIDValue // ClearAll;
fitDeveloperDataIDValue[ "DeveloperID"       , v_ ] := fitHexString @ v[[ "developer_id" ]];
fitDeveloperDataIDValue[ "ApplicationID"     , v_ ] := fitHexString @ v[[ "application_id" ]];
fitDeveloperDataIDValue[ "ApplicationVersion", v_ ] := fitUINT32 @ v[[ "application_version" ]];
fitDeveloperDataIDValue[ "ManufacturerID"    , v_ ] := fitManufacturer @ v[[ "manufacturer_id" ]];
fitDeveloperDataIDValue[ "DeveloperDataIndex", v_ ] := fitUINT8 @ v[[ "developer_data_index" ]];
fitDeveloperDataIDValue[ _                   , _  ] := Missing[ "NotAvailable" ];

indexTranslate[ "DeveloperDataID", fitDeveloperDataIDValue ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*FieldDescription*)
fitValue[ "FieldDescription", name_, value_ ] := fitFieldDescriptionValue[ name, value ];

fitFieldDescriptionValue // ClearAll;
fitFieldDescriptionValue[ "FieldName"            , v_ ] := fitString @ v[[ "field_name" ]];
fitFieldDescriptionValue[ "Units"                , v_ ] := fitString @ v[[ "units" ]];
fitFieldDescriptionValue[ "FitBaseUnitID"        , v_ ] := fitFitBaseUnit @ v[[ "fit_base_unit_id" ]];
fitFieldDescriptionValue[ "NativeMessageNumber"  , v_ ] := fitUINT16 @ v[[ "native_mesg_num" ]];
fitFieldDescriptionValue[ "DeveloperDataIndex"   , v_ ] := fitUINT8 @ v[[ "developer_data_index" ]];
fitFieldDescriptionValue[ "FieldDefinitionNumber", v_ ] := fitUINT8 @ v[[ "field_definition_number" ]];
fitFieldDescriptionValue[ "FitBaseTypeID"        , v_ ] := fitFitBaseType @ v[[ "fit_base_type_id" ]];
fitFieldDescriptionValue[ "Scale"                , v_ ] := fitUINT8 @ v[[ "scale" ]];
fitFieldDescriptionValue[ "Offset"               , v_ ] := fitSINT8 @ v[[ "offset" ]];
fitFieldDescriptionValue[ "NativeFieldNumber"    , v_ ] := fitUINT8 @ v[[ "native_field_num" ]];
fitFieldDescriptionValue[ _                      , _  ] := Missing[ "NotAvailable" ];

indexTranslate[ "FieldDescription", fitFieldDescriptionValue ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*TrainingFile*)
fitValue[ "TrainingFile", name_, value_ ] := fitTrainingFileValue[ name, value ];

fitTrainingFileValue // ClearAll;
fitTrainingFileValue[ "Timestamp"   , v_ ] := fitDateTime @ v[[ "timestamp" ]];
fitTrainingFileValue[ "SerialNumber", v_ ] := fitUINT32Z @ v[[ "serial_number" ]];
fitTrainingFileValue[ "TimeCreated" , v_ ] := fitDateTime @ v[[ "time_created" ]];
fitTrainingFileValue[ "Manufacturer", v_ ] := fitManufacturer @ v[[ "manufacturer" ]];
fitTrainingFileValue[ "Product"     , v_ ] := fitProduct @ v[[ "product" ]];
fitTrainingFileValue[ "Type"        , v_ ] := fitFile @ v[[ "type" ]];
fitTrainingFileValue[ "ProductName" , v_ ] := fitProductName @ v[[ { "manufacturer", "product" } ]];
fitTrainingFileValue[ _             , _  ] := Missing[ "NotAvailable" ];

indexTranslate[ "TrainingFile", fitTrainingFileValue ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*WorkoutStep*)
fitValue[ "WorkoutStep", name_, value_ ] := fitWorkoutStepValue[ name, value ];

fitWorkoutStepValue // ClearAll;
fitWorkoutStepValue[ "WorkoutStepName"               , v_ ] := fitString @ v[[ "wkt_step_name" ]];
fitWorkoutStepValue[ "Duration"                      , v_ ] := fitWktDuration[ v[[ "duration_value" ]], v[[ "duration_type" ]] ];
fitWorkoutStepValue[ "DurationType"                  , v_ ] := fitWorkoutStepDuration @ v[[ "duration_type" ]];
fitWorkoutStepValue[ "TargetValue"                   , v_ ] := fitWktTargetValue[ v[[ "target_value" ]], v[[ "target_type" ]] ];
fitWorkoutStepValue[ "TargetType"                    , v_ ] := fitWorkoutStepTarget @ v[[ "target_type" ]];
fitWorkoutStepValue[ "CustomTargetValueLow"          , v_ ] := fitWktTargetValue[ v[[ "custom_target_value_low" ]], v[[ "target_type" ]] ];
fitWorkoutStepValue[ "CustomTargetValueHigh"         , v_ ] := fitWktTargetValue[ v[[ "custom_target_value_high" ]], v[[ "target_type" ]] ];
fitWorkoutStepValue[ "Target"                        , v_ ] := fitWktTarget[ v[[ "target_value" ]], v[[ "custom_target_value_low" ]], v[[ "custom_target_value_high" ]], v[[ "target_type" ]] ];
fitWorkoutStepValue[ "SecondaryTargetValue"          , v_ ] := fitWktTargetValue[ v[[ "secondary_target_value" ]], v[[ "secondary_target_type" ]] ];
fitWorkoutStepValue[ "SecondaryCustomTargetValueLow" , v_ ] := fitWktTargetValue[ v[[ "secondary_custom_target_value_low" ]], v[[ "secondary_target_type" ]] ];
fitWorkoutStepValue[ "SecondaryCustomTargetValueHigh", v_ ] := fitWktTargetValue[ v[[ "secondary_custom_target_value_high" ]], v[[ "secondary_target_type" ]] ];
fitWorkoutStepValue[ "SecondaryTargetType"           , v_ ] := fitWorkoutStepTarget @ v[[ "secondary_target_type" ]];
fitWorkoutStepValue[ "MessageIndex"                  , v_ ] := fitUINT16 @ v[[ "message_index" ]];
fitWorkoutStepValue[ "ExerciseCategory"              , v_ ] := fitExerciseCategory @ v[[ "exercise_category" ]];
fitWorkoutStepValue[ "TargetType"                    , v_ ] := fitWorkoutStepTarget @ v[[ "target_type" ]];
fitWorkoutStepValue[ "Intensity"                     , v_ ] := fitIntensity @ v[[ "intensity" ]];
fitWorkoutStepValue[ "Notes"                         , v_ ] := fitString @ v[[ "notes" ]];
fitWorkoutStepValue[ "Equipment"                     , v_ ] := fitWorkoutEquipment @ v[[ "equipment" ]];
fitWorkoutStepValue[ _                               , _  ] := Missing[ "NotAvailable" ];

indexTranslate[ "WorkoutStep", fitWorkoutStepValue ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Workout*)
fitValue[ "Workout", name_, value_ ] := fitWorkoutValue[ name, value ];

fitWorkoutValue // ClearAll;
fitWorkoutValue[ "Capabilities"      , v_ ] := fitWorkoutCapabilities @ v[[ "capabilities" ]];
fitWorkoutValue[ "WorkoutName"       , v_ ] := fitString @ v[[ "wkt_name" ]];
fitWorkoutValue[ "NumberOfValidSteps", v_ ] := fitUINT16 @ v[[ "num_valid_steps" ]];
fitWorkoutValue[ "PoolLength"        , v_ ] := fitMeters100 @ v[[ "pool_length" ]];
fitWorkoutValue[ "Sport"             , v_ ] := fitSport @ v[[ "sport" ]];
fitWorkoutValue[ "SubSport"          , v_ ] := fitSubSport @ v[[ "sub_sport" ]];
fitWorkoutValue[ "PoolLengthUnit"    , v_ ] := fitDisplayMeasure @ v[[ "pool_length_unit" ]];

indexTranslate[ "Workout", fitWorkoutValue ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*HeartRateVariability*)
fitValue[ "HeartRateVariability", name_, value_ ] := fitHeartRateVariabilityValue[ name, value ];

fitHeartRateVariabilityValue // ClearAll;
fitHeartRateVariabilityValue[ "Time", v_ ] := fitHRV @ v[[ "time" ]];
fitHeartRateVariabilityValue[ _     , _  ] := Missing[ "NotAvailable" ];

indexTranslate[ "HeartRateVariability", fitHeartRateVariabilityValue ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*MessageInformation*)
fitValue[ "MessageInformation", name_, value_ ] := fitMessageInformationValue[ name, value ];

fitMessageInformationValue // ClearAll;
fitMessageInformationValue[ "MessageTypeName", v_ ] := fitMessageType @ v[[ 2 ]];
fitMessageInformationValue[ "MessageIDNumber", v_ ] := v[[ 2 ]];
fitMessageInformationValue[ "MessageSize"    , v_ ] := v[[ 3 ]];
fitMessageInformationValue[ "Supported"      , v_ ] := messageTypeQ @ fitMessageType @ v[[ 2 ]];
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
fitHexString[ { $invalidUINT8... } ] := Missing[ "NotAvailable" ];
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
(*fitSINT32*)
fitSINT32 // ClearAll;
fitSINT32[ $invalidSINT32 ] := Missing[ "NotAvailable" ];
fitSINT32[ n_Integer ] := n;
fitSINT32[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitFloat32*)
fitFloat32 // ClearAll;
fitFloat32[ $invalidFloat32 ] := Missing[ "NotAvailable" ];
fitFloat32[ n_Integer ] := n; (* TODO *)
fitFloat32[ ___ ] := Missing[ "NotAvailable" ];

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
(*fitSeconds*)
fitSeconds // ClearAll;
fitSeconds[ $invalidUINT32 ] := Missing[ "NotAvailable" ];
fitSeconds[ n_Integer ] := secondsToQuantity @ n;
fitSeconds[ ___ ] := Missing[ "NotAvailable" ];

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

fitWktDuration0[ w_, "Time"                 ] := fitTime @ w;
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

fitWktTarget0 // ClearAll;
fitWktTarget0[ w_, _Missing, _Missing, $$wktStepPowerType ] := fitWktTargetPower @ w;
fitWktTarget0[ _, low_Integer, high_Integer, $$wktStepPowerType ] := fitPowerInterval[ low, high ];
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

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "RH`ComputationalFitness`FIT`" ];
Needs[ "RH`ComputationalFitness`" ];
Needs[ "RH`ComputationalFitness`Package`" ];
Begin[ "`Private`" ];

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

fitFileIDValue[ "SerialNumber", v_ ] := fitSerialNumber @ v[[ 2 ]];
fitFileIDValue[ "TimeCreated" , v_ ] := fitDateTime @ v[[ 3 ]];
fitFileIDValue[ "Manufacturer", v_ ] := fitManufacturer @ v[[ 4 ]];
fitFileIDValue[ "Product"     , v_ ] := fitProduct @ v[[ 5 ]];
fitFileIDValue[ "Number"      , v_ ] := fitUINT16 @ v[[ 6 ]];
fitFileIDValue[ "Type"        , v_ ] := fitFile @ v[[ 7 ]];
fitFileIDValue[ "ProductName" , v_ ] := fitProductName[ v[[ 4;;5 ]], v[[ 8;;27 ]] ];
fitFileIDValue[ _             , _  ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*UserProfile*)
fitValue[ "UserProfile", name_, value_ ] := fitUserProfileValue[ name, value ];

fitUserProfileValue[ "MessageIndex"              , v_ ] := fitUINT16 @ v[[ 2 ]];
fitUserProfileValue[ "Weight"                    , v_ ] := fitWeight @ v[[ 3 ]];
fitUserProfileValue[ "LocalID"                   , v_ ] := fitUINT16 @ v[[ 4 ]];
fitUserProfileValue[ "UserRunningStepLength"     , v_ ] := fitStepLength @ v[[ 5 ]];
fitUserProfileValue[ "UserWalkingStepLength"     , v_ ] := fitStepLength @ v[[ 6 ]];
fitUserProfileValue[ "Gender"                    , v_ ] := fitGender @ v[[ 7 ]];
fitUserProfileValue[ "Age"                       , v_ ] := fitAge @ v[[ 8 ]];
fitUserProfileValue[ "Height"                    , v_ ] := fitHeight @ v[[ 9 ]];
fitUserProfileValue[ "Language"                  , v_ ] := fitLanguage @ v[[ 10 ]];
fitUserProfileValue[ "ElevationSetting"          , v_ ] := fitDisplayMeasure @ v[[ 11 ]];
fitUserProfileValue[ "WeightSetting"             , v_ ] := fitDisplayMeasure @ v[[ 12 ]];
fitUserProfileValue[ "RestingHeartRate"          , v_ ] := fitHeartRate @ v[[ 13 ]];
fitUserProfileValue[ "DefaultMaxRunningHeartRate", v_ ] := fitHeartRate @ v[[ 14 ]];
fitUserProfileValue[ "DefaultMaxBikingHeartRate" , v_ ] := fitHeartRate @ v[[ 15 ]];
fitUserProfileValue[ "DefaultMaxHeartRate"       , v_ ] := fitHeartRate @ v[[ 16 ]];
fitUserProfileValue[ "HeartRateSetting"          , v_ ] := fitDisplayHeart @ v[[ 17 ]];
fitUserProfileValue[ "SpeedSetting"              , v_ ] := fitDisplayMeasure @ v[[ 18 ]];
fitUserProfileValue[ "DistanceSetting"           , v_ ] := fitDisplayMeasure @ v[[ 19 ]];
fitUserProfileValue[ "PowerSetting"              , v_ ] := fitDisplayPower @ v[[ 20 ]];
fitUserProfileValue[ "ActivityClass"             , v_ ] := fitActivityClass @ v[[ 21 ]];
fitUserProfileValue[ "PositionSetting"           , v_ ] := fitDisplayPosition @ v[[ 22 ]];
fitUserProfileValue[ "TemperatureSetting"        , v_ ] := fitDisplayMeasure @ v[[ 23 ]];
fitUserProfileValue[ "HeightSetting"             , v_ ] := fitDisplayMeasure @ v[[ 24 ]];
fitUserProfileValue[ "FriendlyName"              , v_ ] := fitString @ v[[ 25 ;; 40 ]];
fitUserProfileValue[ "GlobalID"                  , v_ ] := fitGlobalID @ v[[ 41 ;; 46 ]];
fitUserProfileValue[ _                           , _  ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Activity*)
fitValue[ "Activity", name_, value_ ] := fitActivityValue[ name, value ];

fitActivityValue[ "Timestamp"       , v_ ] := fitDateTime @ v[[ 2 ]];
fitActivityValue[ "TotalTimerTime"  , v_ ] := fitTime32 @ v[[ 3 ]];
fitActivityValue[ "LocalTimestamp"  , v_ ] := fitLocalTimestamp @ v[[ 4 ]];
fitActivityValue[ "NumberOfSessions", v_ ] := fitUINT16 @ v[[ 5 ]];
fitActivityValue[ "Type"            , v_ ] := fitActivity @ v[[ 6 ]];
fitActivityValue[ "Event"           , v_ ] := fitEvent @ v[[ 7 ]];
fitActivityValue[ "EventType"       , v_ ] := fitEventType @ v[[ 8 ]];
fitActivityValue[ "EventGroup"      , v_ ] := fitEventGroup @ v[[ 9 ]];
fitActivityValue[ _                 , _  ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Lap*)
fitValue[ "Lap", name_, value_ ] := fitLapValue[ name, value ];

fitLapValue[ "Timestamp"                          , v_ ] := fitDateTime @ v[[ 2 ]];
fitLapValue[ "StartTime"                          , v_ ] := fitDateTime @ v[[ 3 ]];
fitLapValue[ "StartPosition"                      , v_ ] := fitGeoPosition @ v[[ 4;;5 ]];
fitLapValue[ "EndPosition"                        , v_ ] := fitGeoPosition @ v[[ 6;;7 ]];
fitLapValue[ "TotalElapsedTime"                   , v_ ] := fitTime32 @ v[[ 8 ]];
fitLapValue[ "TotalTimerTime"                     , v_ ] := fitTime32 @ v[[ 9 ]];
fitLapValue[ "TotalDistance"                      , v_ ] := fitDistance @ v[[ 10 ]];
fitLapValue[ "TotalCycles"                        , v_ ] := fitCycles32[ v[[ 11 ]], v[[ 84 ]] ];
fitLapValue[ "TotalWork"                          , v_ ] := fitWork @ v[[ 12 ]];
fitLapValue[ "TotalMovingTime"                    , v_ ] := fitTime32 @ v[[ 13 ]];
fitLapValue[ "TimeInHeartRateZone"                , v_ ] := fitTime32 @ v[[ 14 ]];
fitLapValue[ "TimeInSpeedZone"                    , v_ ] := fitTime32 @ v[[ 15 ]];
fitLapValue[ "TimeInCadenceZone"                  , v_ ] := fitTime32 @ v[[ 16 ]];
fitLapValue[ "TimeInPowerZone"                    , v_ ] := fitTime32 @ v[[ 17 ]];
fitLapValue[ "MessageIndex"                       , v_ ] := fitMessageIndex @ v[[ 23 ]];
fitLapValue[ "TotalCalories"                      , v_ ] := fitCalories @ v[[ 24 ]];
fitLapValue[ "TotalFatCalories"                   , v_ ] := fitCalories @ v[[ 25 ]];
fitLapValue[ "AverageSpeed"                       , v_ ] := fitSpeedSelect[ v[[ 18 ]], v[[ 26 ]] ];
fitLapValue[ "MaxSpeed"                           , v_ ] := fitSpeedSelect[ v[[ 19 ]], v[[ 27 ]] ];
fitLapValue[ "AveragePower"                       , v_ ] := fitPower @ v[[ 28 ]];
fitLapValue[ "MaxPower"                           , v_ ] := fitPower @ v[[ 29 ]];
fitLapValue[ "TotalAscent"                        , v_ ] := fitAscent @ v[[ 30 ]];
fitLapValue[ "TotalDescent"                       , v_ ] := fitAscent @ v[[ 31 ]];
fitLapValue[ "NumberOfLengths"                    , v_ ] := fitLengths @ v[[ 32 ]];
fitLapValue[ "NormalizedPower"                    , v_ ] := fitPower @ v[[ 33 ]];
fitLapValue[ "LeftRightBalance"                   , v_ ] := fitLeftRightBalance @ v[[ 34 ]];
fitLapValue[ "FirstLengthIndex"                   , v_ ] := fitUINT16 @ v[[ 35 ]];
fitLapValue[ "AverageStrokeDistance"              , v_ ] := fitMeters100 @ v[[ 36 ]];
fitLapValue[ "NumberOfActiveLengths"              , v_ ] := fitLengths @ v[[ 37 ]];
fitLapValue[ "AverageAltitude"                    , v_ ] := fitAltitudeSelect[ v[[ 20 ]], v[[ 38 ]] ];
fitLapValue[ "MaxAltitude"                        , v_ ] := fitAltitudeSelect[ v[[ 22 ]], v[[ 39 ]] ];
fitLapValue[ "AverageGrade"                       , v_ ] := fitGrade @ v[[ 40 ]];
fitLapValue[ "AveragePositiveGrade"               , v_ ] := fitGrade @ v[[ 41 ]];
fitLapValue[ "AverageNegativeGrade"               , v_ ] := fitGrade @ v[[ 42 ]];
fitLapValue[ "MaxPositiveGrade"                   , v_ ] := fitGrade @ v[[ 43 ]];
fitLapValue[ "MaxNegativeGrade"                   , v_ ] := fitGrade @ v[[ 44 ]];
fitLapValue[ "AveragePositiveVerticalSpeed"       , v_ ] := fitVerticalSpeed @ v[[ 45 ]];
fitLapValue[ "AverageNegativeVerticalSpeed"       , v_ ] := fitVerticalSpeed @ v[[ 46 ]];
fitLapValue[ "MaxPositiveVerticalSpeed"           , v_ ] := fitVerticalSpeed @ v[[ 47 ]];
fitLapValue[ "MaxNegativeVerticalSpeed"           , v_ ] := fitVerticalSpeed @ v[[ 48 ]];
fitLapValue[ "RepetitionNumber"                   , v_ ] := fitUINT16 @ v[[ 49 ]];
fitLapValue[ "MinAltitude"                        , v_ ] := fitAltitudeSelect[ v[[ 21 ]], v[[ 50 ]] ];
fitLapValue[ "WorkoutStepIndex"                   , v_ ] := fitUINT16 @ v[[ 51 ]];
fitLapValue[ "OpponentScore"                      , v_ ] := fitUINT16 @ v[[ 52 ]];
fitLapValue[ "StrokeCount"                        , v_ ] := fitStrokeCount @ v[[ 53 ]];
fitLapValue[ "ZoneCount"                          , v_ ] := fitUINT16 @ v[[ 54 ]];
fitLapValue[ "AverageVerticalOscillation"         , v_ ] := fitVerticalOscillation @ v[[ 55 ]];
fitLapValue[ "AverageStanceTimePercent"           , v_ ] := fitStanceTimePercent @ v[[ 56 ]];
fitLapValue[ "AverageStanceTime"                  , v_ ] := fitStanceTime @ v[[ 57 ]];
fitLapValue[ "PlayerScore"                        , v_ ] := fitUINT16 @ v[[ 58 ]];
fitLapValue[ "AverageTotalHemoglobinConcentration", v_ ] := fitHemoglobin @ v[[ 59 ]];
fitLapValue[ "MinimumTotalHemoglobinConcentration", v_ ] := fitHemoglobin @ v[[ 60 ]];
fitLapValue[ "MaximumTotalHemoglobinConcentration", v_ ] := fitHemoglobin @ v[[ 61 ]];
fitLapValue[ "AverageSaturatedHemoglobinPercent"  , v_ ] := fitHemoglobinPercent @ v[[ 62 ]];
fitLapValue[ "MinimumSaturatedHemoglobinPercent"  , v_ ] := fitHemoglobinPercent @ v[[ 63 ]];
fitLapValue[ "MaximumSaturatedHemoglobinPercent"  , v_ ] := fitHemoglobinPercent @ v[[ 64 ]];
fitLapValue[ "AverageVAM"                         , v_ ] := fitVAM @ v[[ 65 ]];
fitLapValue[ "Event"                              , v_ ] := fitEvent @ v[[ 66 ]];
fitLapValue[ "EventType"                          , v_ ] := fitEventType @ v[[ 67 ]];
fitLapValue[ "AverageHeartRate"                   , v_ ] := fitHeartRate @ v[[ 68 ]];
fitLapValue[ "MaxHeartRate"                       , v_ ] := fitHeartRate @ v[[ 69 ]];
fitLapValue[ "AverageCadence"                     , v_ ] := fitCadence[ v[[ 70 ]], v[[ 82 ]] ];
fitLapValue[ "MaxCadence"                         , v_ ] := fitCadence[ v[[ 71 ]], v[[ 83 ]] ];
fitLapValue[ "Intensity"                          , v_ ] := fitIntensity @ v[[ 72 ]];
fitLapValue[ "LapTrigger"                         , v_ ] := fitLapTrigger @ v[[ 73 ]];
fitLapValue[ "Sport"                              , v_ ] := fitSport @ v[[ 74 ]];
fitLapValue[ "EventGroup"                         , v_ ] := fitUINT8 @ v[[ 75 ]];
fitLapValue[ "SwimStroke"                         , v_ ] := fitSwimStroke @ v[[ 76 ]];
fitLapValue[ "SubSport"                           , v_ ] := fitSubSport @ v[[ 77 ]];
fitLapValue[ "GPSAccuracy"                        , v_ ] := fitGPSAccuracy @ v[[ 78 ]];
fitLapValue[ "AverageTemperature"                 , v_ ] := fitTemperature @ v[[ 79 ]];
fitLapValue[ "MaxTemperature"                     , v_ ] := fitTemperature @ v[[ 80 ]];
fitLapValue[ "MinHeartRate"                       , v_ ] := fitHeartRate @ v[[ 81 ]];
fitLapValue[ _                                    , v_ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*DeviceSettings*)
fitValue[ "DeviceSettings", name_, value_ ] := fitDeviceSettingsValue[ name, value ];

fitDeviceSettingsValue[ "UTCOffset"             , v_ ] := fitUINT32 @ v[[ 2 ]];
fitDeviceSettingsValue[ "TimeOffset"            , v_ ] := fitTimeOffset @ v[[ 3;;4 ]];
fitDeviceSettingsValue[ "ClockTime"             , v_ ] := fitDateTime @ v[[ 5 ]];
fitDeviceSettingsValue[ "PagesEnabled"          , v_ ] := fitUINT16BF @ v[[ 6 ]];
fitDeviceSettingsValue[ "DefaultPage"           , v_ ] := fitUINT16BF @ v[[ 7 ]];
fitDeviceSettingsValue[ "AutosyncMinSteps"      , v_ ] := fitSteps @ v[[ 8 ]];
fitDeviceSettingsValue[ "AutosyncMinTime"       , v_ ] := fitMinutes @ v[[ 9 ]];
fitDeviceSettingsValue[ "ActiveTimeZone"        , v_ ] := fitUINT8 @ v[[ 10 ]];
fitDeviceSettingsValue[ "TimeMode"              , v_ ] := fitTimeModeArr @ v[[ 11;;12 ]];
fitDeviceSettingsValue[ "TimeZoneOffset"        , v_ ] := fitTimeZoneOffset @ v[[ 13;;14 ]];
fitDeviceSettingsValue[ "BacklightMode"         , v_ ] := fitBacklightMode @ v[[ 15 ]];
fitDeviceSettingsValue[ "ActivityTrackerEnabled", v_ ] := fitBool @ v[[ 16 ]];
fitDeviceSettingsValue[ "MoveAlertEnabled"      , v_ ] := fitBool @ v[[ 17 ]];
fitDeviceSettingsValue[ "DateMode"              , v_ ] := fitDateMode @ v[[ 18 ]];
fitDeviceSettingsValue[ "DisplayOrientation"    , v_ ] := fitDisplayOrientation @ v[[ 19 ]];
fitDeviceSettingsValue[ "MountingSide"          , v_ ] := fitSide @ v[[ 20 ]];
fitDeviceSettingsValue[ "TapSensitivity"        , v_ ] := fitTapSensitivity @ v[[ 21 ]];
fitDeviceSettingsValue[ _                       , _  ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Record*)
fitValue[ "Record", name_, value_ ] := fitRecordValue[ name, value ];

fitRecordValue[ "Timestamp"                      , v_ ] := fitDateTime @ v[[ 2 ]];
fitRecordValue[ "GeoPosition"                    , v_ ] := fitGeoPosition @ v[[ 3;;4 ]];
fitRecordValue[ "Distance"                       , v_ ] := fitDistance @ v[[ 5 ]];
fitRecordValue[ "TimeFromCourse"                 , v_ ] := fitTimeFromCourse @ v[[ 6 ]];
fitRecordValue[ "TotalCycles"                    , v_ ] := fitCycles32 @ v[[ 7 ]];
fitRecordValue[ "AccumulatedPower"               , v_ ] := fitAccumulatedPower @ v[[ { 2, 8 } ]];
fitRecordValue[ "Altitude"                       , v_ ] := fitAltitudeSelect[ v[[ 10 ]], v[[ 11 ]] ];
fitRecordValue[ "Speed"                          , v_ ] := fitSpeedSelect[ v[[ 9 ]], v[[ 12 ]] ];
fitRecordValue[ "Power"                          , v_ ] := fitPower @ v[[ 13 ]];
fitRecordValue[ "Grade"                          , v_ ] := fitGrade @ v[[ 14 ]];
fitRecordValue[ "CompressedAccumulatedPower"     , v_ ] := fitCompressedAccumulatedPower @ v[[ 15 ]];
fitRecordValue[ "VerticalSpeed"                  , v_ ] := fitVerticalSpeed @ v[[ 16 ]];
fitRecordValue[ "Calories"                       , v_ ] := fitCalories @ v[[ 17 ]];
fitRecordValue[ "VerticalOscillation"            , v_ ] := fitVerticalOscillation @ v[[ 18 ]];
fitRecordValue[ "StanceTimePercent"              , v_ ] := fitStanceTimePercent @ v[[ 19 ]];
fitRecordValue[ "StanceTime"                     , v_ ] := fitStanceTime @ v[[ 20 ]];
fitRecordValue[ "BallSpeed"                      , v_ ] := fitBallSpeed @ v[[ 21 ]];
fitRecordValue[ "Cadence256"                     , v_ ] := fitCadence256 @ v[[ 22 ]];
fitRecordValue[ "TotalHemoglobinConcentration"   , v_ ] := fitHemoglobin @ v[[ 23 ]];
fitRecordValue[ "TotalHemoglobinConcentrationMin", v_ ] := fitHemoglobin @ v[[ 24 ]];
fitRecordValue[ "TotalHemoglobinConcentrationMax", v_ ] := fitHemoglobin @ v[[ 25 ]];
fitRecordValue[ "SaturatedHemoglobinPercent"     , v_ ] := fitHemoglobinPercent @ v[[ 26 ]];
fitRecordValue[ "SaturatedHemoglobinPercentMin"  , v_ ] := fitHemoglobinPercent @ v[[ 27 ]];
fitRecordValue[ "SaturatedHemoglobinPercentMax"  , v_ ] := fitHemoglobinPercent @ v[[ 28 ]];
fitRecordValue[ "HeartRate"                      , v_ ] := fitHeartRate @ v[[ 29 ]];
fitRecordValue[ "Cadence"                        , v_ ] := fitCadence[ v[[ 30 ]], v[[ 46 ]] ];
fitRecordValue[ "Resistance"                     , v_ ] := fitResistance @ v[[ 31 ]];
fitRecordValue[ "CycleLength"                    , v_ ] := fitCycleLength @ v[[ 32 ]];
fitRecordValue[ "Temperature"                    , v_ ] := fitTemperature @ v[[ 33 ]];
fitRecordValue[ "Cycles"                         , v_ ] := fitCycles8 @ v[[ 34 ]];
fitRecordValue[ "LeftRightBalance"               , v_ ] := fitLeftRightBalance @ v[[ 35 ]];
fitRecordValue[ "GPSAccuracy"                    , v_ ] := fitGPSAccuracy @ v[[ 36 ]];
fitRecordValue[ "ActivityType"                   , v_ ] := fitActivityType @ v[[ 37 ]];
fitRecordValue[ "LeftTorqueEffectiveness"        , v_ ] := fitTorqueEffectiveness @ v[[ 38 ]];
fitRecordValue[ "RightTorqueEffectiveness"       , v_ ] := fitTorqueEffectiveness @ v[[ 39 ]];
fitRecordValue[ "LeftPedalSmoothness"            , v_ ] := fitPedalSmoothness @ v[[ 40 ]];
fitRecordValue[ "RightPedalSmoothness"           , v_ ] := fitPedalSmoothness @ v[[ 41 ]];
fitRecordValue[ "CombinedPedalSmoothness"        , v_ ] := fitPedalSmoothness @ v[[ 42 ]];
fitRecordValue[ "Time128"                        , v_ ] := fitTime128 @ v[[ 43 ]];
fitRecordValue[ "StrokeType"                     , v_ ] := fitStrokeType @ v[[ 44 ]];
fitRecordValue[ "Zone"                           , v_ ] := fitZone @ v[[ 45 ]];
fitRecordValue[ "DeviceIndex"                    , v_ ] := fitDeviceIndex @ v[[ 47 ]];
fitRecordValue[ "LeftPlatformCenterOffset"       , v_ ] := fitPCO @ v[[ 48 ]];
fitRecordValue[ "RightPlatformCenterOffset"      , v_ ] := fitPCO @ v[[ 49 ]];
fitRecordValue[ "LeftPowerPhaseStart"            , v_ ] := fitPowerPhase @ v[[ 50 ]];
fitRecordValue[ "LeftPowerPhaseEnd"              , v_ ] := fitPowerPhase @ v[[ 51 ]];
fitRecordValue[ "LeftPowerPhasePeakStart"        , v_ ] := fitPowerPhase @ v[[ 52 ]];
fitRecordValue[ "LeftPowerPhasePeakEnd"          , v_ ] := fitPowerPhase @ v[[ 53 ]];
fitRecordValue[ "RightPowerPhaseStart"           , v_ ] := fitPowerPhase @ v[[ 54 ]];
fitRecordValue[ "RightPowerPhaseEnd"             , v_ ] := fitPowerPhase @ v[[ 55 ]];
fitRecordValue[ "RightPowerPhasePeakStart"       , v_ ] := fitPowerPhase @ v[[ 56 ]];
fitRecordValue[ "RightPowerPhasePeakEnd"         , v_ ] := fitPowerPhase @ v[[ 57 ]];
fitRecordValue[ "BatterySOC"                     , v_ ] := fitPercent @ v[[ 58 ]];
fitRecordValue[ "MotorPower"                     , v_ ] := fitPower8 @ v[[ 59 ]];
fitRecordValue[ "VerticalRatio"                  , v_ ] := fitPercent @ v[[ 60 ]];
fitRecordValue[ "StanceTimeBalance"              , v_ ] := fitPercent @ v[[ 61 ]];
fitRecordValue[ "StepLength"                     , v_ ] := fitMM8 @ v[[ 62 ]];
fitRecordValue[ "AbsolutePressure"               , v_ ] := fitPressure @ v[[ 63 ]];
fitRecordValue[ "Unknown61"                      , v_ ] := fitUINT16 @ v[[ 64 ]];
fitRecordValue[ "PerformanceCondition"           , v_ ] := fitSINT8 @ v[[ 65 ]];
fitRecordValue[ "Unknown90"                      , v_ ] := fitSINT8 @ v[[ 66 ]];
fitRecordValue[ "RespirationRate"                , v_ ] := fitRespirationRate @ v[[ 67 ]];
fitRecordValue[ "HeartRateVariability"           , v_ ] := fitHRV @ v[[ 68 ]];
fitRecordValue[ "PowerZone"                      , v_ ] := fitPowerZone @ v[[ 13 ]];
fitRecordValue[ "HeartRateZone"                  , v_ ] := fitHeartRateZone @ v[[ 29 ]];
fitRecordValue[ _                                , _  ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Event*)
fitValue[ "Event", name_, value_ ] := fitEventValue[ name, value ];

fitEventValue[ "Timestamp"           , v_ ] := fitDateTime @ v[[ 2 ]];
fitEventValue[ "Data"                , v_ ] := fitUINT32 @ v[[ 3 ]];
fitEventValue[ "Data16"              , v_ ] := fitUINT16 @ v[[ 4 ]];
fitEventValue[ "Score"               , v_ ] := fitUINT16 @ v[[ 5 ]];
fitEventValue[ "OpponentScore"       , v_ ] := fitUINT16 @ v[[ 6 ]];
fitEventValue[ "Event"               , v_ ] := fitEvent @ v[[ 7 ]];
fitEventValue[ "EventType"           , v_ ] := fitEventType @ v[[ 8 ]];
fitEventValue[ "EventGroup"          , v_ ] := fitEventGroup @ v[[ 9 ]];
fitEventValue[ "FrontGearNum"        , v_ ] := fitFrontGearNum @ v[[ 10 ]];
fitEventValue[ "FrontGear"           , v_ ] := fitFrontGear @ v[[ 11 ]];
fitEventValue[ "RearGearNum"         , v_ ] := fitRearGearNum @ v[[ 12 ]];
fitEventValue[ "RearGear"            , v_ ] := fitRearGear @ v[[ 13 ]];
fitEventValue[ "RadarThreatLevelType", v_ ] := fitRadarThreatLevelType @ v[[ 14 ]];
fitEventValue[ "RadarThreatCount"    , v_ ] := fitRadarThreatCount @ v[[ 15 ]];
fitEventValue[ _                     , _  ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*DeviceInformation*)
fitValue[ "DeviceInformation", name_, value_ ] := fitDeviceInformationValue[ name, value ];

fitDeviceInformationValue[ "Timestamp"              , v_ ] := fitDateTime @ v[[ 2 ]];
fitDeviceInformationValue[ "SerialNumber"           , v_ ] := fitSerialNumber @ v[[ 3 ]];
fitDeviceInformationValue[ "CumulativeOperatingTime", v_ ] := fitCumulativeOperatingTime @ v[[ 4 ]];
fitDeviceInformationValue[ "Manufacturer"           , v_ ] := fitManufacturer @ v[[ 5 ]];
fitDeviceInformationValue[ "Product"                , v_ ] := fitProduct @ v[[ 6 ]];
fitDeviceInformationValue[ "SoftwareVersion"        , v_ ] := fitSoftwareVersion @ v[[ 7 ]];
fitDeviceInformationValue[ "BatteryVoltage"         , v_ ] := fitBatteryVoltage @ v[[ 8 ]];
fitDeviceInformationValue[ "ANTDeviceNumber"        , v_ ] := fitANTDeviceNumber @ v[[ 9 ]];
fitDeviceInformationValue[ "DeviceIndex"            , v_ ] := fitDeviceIndex @ v[[ 10 ]];
fitDeviceInformationValue[ "DeviceType"             , v_ ] := fitANTPlusDeviceType @ v[[ 11 ]];
fitDeviceInformationValue[ "HardwareVersion"        , v_ ] := fitHardwareVersion @ v[[ 12 ]];
fitDeviceInformationValue[ "BatteryStatus"          , v_ ] := fitBatteryStatus @ v[[ 13 ]];
fitDeviceInformationValue[ "SensorPosition"         , v_ ] := fitBodyLocation @ v[[ 14 ]];
fitDeviceInformationValue[ "ANTTransmissionType"    , v_ ] := fitANTTransmissionType @ v[[ 15 ]];
fitDeviceInformationValue[ "ANTNetwork"             , v_ ] := fitANTNetwork @ v[[ 16 ]];
fitDeviceInformationValue[ "SourceType"             , v_ ] := fitSourceType @ v[[ 17 ]];
fitDeviceInformationValue[ "ProductName"            , v_ ] := fitProductName[ v[[ 5;;6 ]], v[[ 18;;37 ]] ];
fitDeviceInformationValue[ _                        , _  ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Session*)
fitValue[ "Session", name_, value_ ] := fitSessionValue[ name, value ];

fitSessionValue[ "Timestamp"                              , v_ ] := fitDateTime @ v[[ 2 ]];
fitSessionValue[ "StartTime"                              , v_ ] := fitDateTime @ v[[ 3 ]];
fitSessionValue[ "StartPosition"                          , v_ ] := fitGeoPosition @ v[[ 4;;5 ]];
fitSessionValue[ "TotalElapsedTime"                       , v_ ] := fitTime32 @ v[[ 6 ]];
fitSessionValue[ "TotalTimerTime"                         , v_ ] := fitTime32 @ v[[ 7 ]];
fitSessionValue[ "TotalDistance"                          , v_ ] := fitDistance @ v[[ 8 ]];
fitSessionValue[ "TotalCycles"                            , v_ ] := fitCycles32[ v[[ 9 ]], v[[ 89 ]] ];
fitSessionValue[ "GeoBoundingBox"                         , v_ ] := fitGeoBoundingBox @ v[[ 10;;13 ]];
fitSessionValue[ "AverageStrokeCount"                     , v_ ] := fitAverageStrokeCount @ v[[ 14 ]];
fitSessionValue[ "TotalWork"                              , v_ ] := fitWork @ v[[ 15 ]];
fitSessionValue[ "TotalMovingTime"                        , v_ ] := fitTime32 @ v[[ 16 ]];
fitSessionValue[ "TimeInHeartRateZone"                    , v_ ] := fitTimeInZone @ v[[ 17 ]];
fitSessionValue[ "TimeInSpeedZone"                        , v_ ] := fitTimeInZone @ v[[ 18 ]];
fitSessionValue[ "TimeInCadenceZone"                      , v_ ] := fitTimeInZone @ v[[ 19 ]];
fitSessionValue[ "TimeInPowerZone"                        , v_ ] := fitTimeInZone @ v[[ 20 ]];
fitSessionValue[ "AverageLapTime"                         , v_ ] := fitTime32 @ v[[ 21 ]];
fitSessionValue[ "MessageIndex"                           , v_ ] := fitMessageIndex @ v[[ 27 ]];
fitSessionValue[ "TotalCalories"                          , v_ ] := fitCalories @ v[[ 28 ]];
fitSessionValue[ "TotalFatCalories"                       , v_ ] := fitCalories @ v[[ 29 ]];
fitSessionValue[ "AverageSpeed"                           , v_ ] := fitSpeedSelect[ v[[ 22 ]], v[[ 30 ]] ];
fitSessionValue[ "MaxSpeed"                               , v_ ] := fitSpeedSelect[ v[[ 23 ]], v[[ 31 ]] ];
fitSessionValue[ "AveragePower"                           , v_ ] := fitPower @ v[[ 32 ]];
fitSessionValue[ "MaxPower"                               , v_ ] := fitPower @ v[[ 33 ]];
fitSessionValue[ "TotalAscent"                            , v_ ] := fitAscent @ v[[ 34 ]];
fitSessionValue[ "TotalDescent"                           , v_ ] := fitAscent @ v[[ 35 ]];
fitSessionValue[ "FirstLapIndex"                          , v_ ] := fitUINT16 @ v[[ 36 ]];
fitSessionValue[ "NumberOfLaps"                           , v_ ] := fitLaps @ v[[ 37 ]];
fitSessionValue[ "NumberOfLengths"                        , v_ ] := fitLengths @ v[[ 38 ]];
fitSessionValue[ "NormalizedPower"                        , v_ ] := fitPower @ v[[ 39 ]];
fitSessionValue[ "TrainingStressScore"                    , v_ ] := fitTrainingStressScore @ v[[ 40 ]];
fitSessionValue[ "IntensityFactor"                        , v_ ] := fitIntensityFactor @ v[[ 41 ]];
fitSessionValue[ "LeftRightBalance"                       , v_ ] := fitLeftRightBalance @ v[[ 42 ]];
fitSessionValue[ "AverageStrokeDistance"                  , v_ ] := fitMeters100 @ v[[ 43 ]];
fitSessionValue[ "PoolLength"                             , v_ ] := fitMeters100 @ v[[ 44 ]];
fitSessionValue[ "ThresholdPower"                         , v_ ] := fitPower @ v[[ 45 ]];
fitSessionValue[ "NumberOfActiveLengths"                  , v_ ] := fitLengths @ v[[ 46 ]];
fitSessionValue[ "AverageAltitude"                        , v_ ] := fitAltitudeSelect[ v[[ 24 ]], v[[ 47 ]] ];
fitSessionValue[ "MaxAltitude"                            , v_ ] := fitAltitudeSelect[ v[[ 26 ]], v[[ 48 ]] ];
fitSessionValue[ "AverageGrade"                           , v_ ] := fitGrade @ v[[ 49 ]];
fitSessionValue[ "AveragePositiveGrade"                   , v_ ] := fitGrade @ v[[ 50 ]];
fitSessionValue[ "AverageNegativeGrade"                   , v_ ] := fitGrade @ v[[ 51 ]];
fitSessionValue[ "MaxPositiveGrade"                       , v_ ] := fitGrade @ v[[ 52 ]];
fitSessionValue[ "MaxNegativeGrade"                       , v_ ] := fitGrade @ v[[ 53 ]];
fitSessionValue[ "AveragePositiveVerticalSpeed"           , v_ ] := fitVerticalSpeed @ v[[ 54 ]];
fitSessionValue[ "AverageNegativeVerticalSpeed"           , v_ ] := fitVerticalSpeed @ v[[ 55 ]];
fitSessionValue[ "MaxPositiveVerticalSpeed"               , v_ ] := fitVerticalSpeed @ v[[ 56 ]];
fitSessionValue[ "MaxNegativeVerticalSpeed"               , v_ ] := fitVerticalSpeed @ v[[ 57 ]];
fitSessionValue[ "BestLapIndex"                           , v_ ] := fitUINT16 @ v[[ 58 ]];
fitSessionValue[ "MinAltitude"                            , v_ ] := fitAltitudeSelect[ v[[ 25 ]], v[[ 59 ]] ];
fitSessionValue[ "PlayerScore"                            , v_ ] := fitUINT16 @ v[[ 60 ]];
fitSessionValue[ "OpponentScore"                          , v_ ] := fitUINT16 @ v[[ 61 ]];
fitSessionValue[ "StrokeCount"                            , v_ ] := fitStrokeCount @ v[[ 62 ]];
fitSessionValue[ "ZoneCount"                              , v_ ] := fitZoneCount @ v[[ 63 ]];
fitSessionValue[ "MaxBallSpeed"                           , v_ ] := fitBallSpeed @ v[[ 64 ]];
fitSessionValue[ "AverageBallSpeed"                       , v_ ] := fitBallSpeed @ v[[ 65 ]];
fitSessionValue[ "AverageVerticalOscillation"             , v_ ] := fitVerticalOscillation @ v[[ 66 ]];
fitSessionValue[ "AverageStanceTimePercent"               , v_ ] := fitStanceTimePercent @ v[[ 67 ]];
fitSessionValue[ "AverageStanceTime"                      , v_ ] := fitStanceTime @ v[[ 68 ]];
fitSessionValue[ "AverageVAM"                             , v_ ] := fitVAM @ v[[ 69 ]];
fitSessionValue[ "Event"                                  , v_ ] := fitEvent @ v[[ 70 ]];
fitSessionValue[ "EventType"                              , v_ ] := fitEventType @ v[[ 71 ]];
fitSessionValue[ "Sport"                                  , v_ ] := fitSport @ v[[ 72 ]];
fitSessionValue[ "SubSport"                               , v_ ] := fitSubSport @ v[[ 73 ]];
fitSessionValue[ "AverageHeartRate"                       , v_ ] := fitHeartRate @ v[[ 74 ]];
fitSessionValue[ "MaxHeartRate"                           , v_ ] := fitHeartRate @ v[[ 75 ]];
fitSessionValue[ "AverageCadence"                         , v_ ] := fitCadence[ v[[ 76 ]], v[[ 87 ]] ];
fitSessionValue[ "MaxCadence"                             , v_ ] := fitCadence[ v[[ 77 ]], v[[ 88 ]] ];
fitSessionValue[ "TotalAerobicTrainingEffect"             , v_ ] := fitTrainingEffect @ v[[ 78 ]];
fitSessionValue[ "TotalAerobicTrainingEffectDescription"  , v_ ] := fitTrainingEffectDescription @ v[[ 78 ]];
fitSessionValue[ "EventGroup"                             , v_ ] := fitEventGroup @ v[[ 79 ]];
fitSessionValue[ "Trigger"                                , v_ ] := fitSessionTrigger @ v[[ 80 ]];
fitSessionValue[ "SwimStroke"                             , v_ ] := fitSwimStroke @ v[[ 81 ]];
fitSessionValue[ "PoolLengthUnit"                         , v_ ] := fitDisplayMeasure @ v[[ 82 ]];
fitSessionValue[ "GPSAccuracy"                            , v_ ] := fitGPSAccuracy @ v[[ 83 ]];
fitSessionValue[ "AverageTemperature"                     , v_ ] := fitTemperature @ v[[ 84 ]];
fitSessionValue[ "MaxTemperature"                         , v_ ] := fitTemperature @ v[[ 85 ]];
fitSessionValue[ "MinHeartRate"                           , v_ ] := fitHeartRate @ v[[ 86 ]];
fitSessionValue[ "SportIndex"                             , v_ ] := fitUINT8 @ v[[ 90 ]];
fitSessionValue[ "TotalAnaerobicTrainingEffect"           , v_ ] := fitTrainingEffect @ v[[ 91 ]];
fitSessionValue[ "TotalAnaerobicTrainingEffectDescription", v_ ] := fitTrainingEffectDescription @ v[[ 91 ]];
fitSessionValue[ "AverageLeftPlatformCenterOffset"        , v_ ] := fitPCO @ v[[ 92 ]];
fitSessionValue[ "AverageRightPlatformCenterOffset"       , v_ ] := fitPCO @ v[[ 93 ]];
fitSessionValue[ "AverageLeftPowerPhaseStart"             , v_ ] := fitPowerPhase @ v[[ 94 ]];
fitSessionValue[ "AverageLeftPowerPhaseEnd"               , v_ ] := fitPowerPhase @ v[[ 95 ]];
fitSessionValue[ "AverageLeftPowerPhasePeakStart"         , v_ ] := fitPowerPhase @ v[[ 96 ]];
fitSessionValue[ "AverageLeftPowerPhasePeakEnd"           , v_ ] := fitPowerPhase @ v[[ 97 ]];
fitSessionValue[ "AverageRightPowerPhaseStart"            , v_ ] := fitPowerPhase @ v[[ 98 ]];
fitSessionValue[ "AverageRightPowerPhaseEnd"              , v_ ] := fitPowerPhase @ v[[ 99 ]];
fitSessionValue[ "AverageRightPowerPhasePeakStart"        , v_ ] := fitPowerPhase @ v[[ 100 ]];
fitSessionValue[ "AverageRightPowerPhasePeakEnd"          , v_ ] := fitPowerPhase @ v[[ 101 ]];
fitSessionValue[ _                                        , _  ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*ZonesTarget*)
fitValue[ "ZonesTarget" , name_, value_ ] := fitZonesTargetValue[ name, value ];

fitZonesTargetValue[ "FunctionalThresholdPower", v_ ] := fitFTPSetting @ v[[ 2 ]];
fitZonesTargetValue[ "MaxHeartRate"            , v_ ] := fitMaxHRSetting @ v[[ 3 ]];
fitZonesTargetValue[ "ThresholdHeartRate"      , v_ ] := fitHeartRate @ v[[ 4 ]];
fitZonesTargetValue[ "HeartRateCalculationType", v_ ] := fitHeartRateZoneCalc @ v[[ 5 ]];
fitZonesTargetValue[ "PowerZoneCalculationType", v_ ] := fitPowerZoneCalc @ v[[ 6 ]];
fitZonesTargetValue[ _                         , _  ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*FileCreator*)
fitValue[ "FileCreator", name_, value_ ] := fitFileCreatorValue[ name, value ];

fitFileCreatorValue[ "SoftwareVersion", v_ ] := fitUINT16 @ v[[ 2 ]];
fitFileCreatorValue[ "HardwareVersion", v_ ] := fitUINT8 @ v[[ 3 ]];
fitFileCreatorValue[ _                , _  ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Sport*)
fitValue[ "Sport", name_, value_ ] := fitSportValue[ name, value ];

fitSportValue[ "Name"    , v_ ] := fitString @ v[[ 2;;17 ]];
fitSportValue[ "Sport"   , v_ ] := fitSport @ v[[ 18 ]];
fitSportValue[ "SubSport", v_ ] := fitSubSport @ v[[ 19 ]];
fitSportValue[ _         , _  ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*DeveloperDataID*)
fitValue[ "DeveloperDataID", name_, value_ ] := fitDeveloperDataIDValue[ name, value ];

fitDeveloperDataIDValue[ "DeveloperID"       , v_ ] := fitHexString @ v[[ 2;;17 ]];
fitDeveloperDataIDValue[ "ApplicationID"     , v_ ] := fitHexString @ v[[ 18;;33 ]];
fitDeveloperDataIDValue[ "ApplicationVersion", v_ ] := fitUINT32 @ v[[ 34 ]];
fitDeveloperDataIDValue[ "ManufacturerID"    , v_ ] := fitManufacturer @ v[[ 35 ]];
fitDeveloperDataIDValue[ "DeveloperDataIndex", v_ ] := fitUINT8 @ v[[ 36 ]];
fitDeveloperDataIDValue[ _                   , _  ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*MessageInformation*)
fitValue[ "MessageInformation", name_, value_ ] := fitMessageInformationValue[ name, value ];

fitMessageInformationValue[ "MessageTypeName", v_ ] := fitMessageType @ v[[ 2 ]];
fitMessageInformationValue[ "MessageIDNumber", v_ ] := v[[ 2 ]];
fitMessageInformationValue[ "MessageSize"    , v_ ] := v[[ 3 ]];
fitMessageInformationValue[ "Supported"      , v_ ] := messageTypeQ @ fitMessageType @ v[[ 2 ]];
fitMessageInformationValue[ "ByteOrdering"   , v_ ] := fitByteOrder @ v[[ 4 ]];
fitMessageInformationValue[ "FieldCount"     , v_ ] := v[[ 5 ]];
fitMessageInformationValue[ "FileOffset"     , v_ ] := fitFileOffset @ v[[ 6 ]];
fitMessageInformationValue[ "MessageIndex"   , v_ ] := v[[ 7 ]];
fitMessageInformationValue[ _                , _  ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*FieldDescription*)
fitValue[ "FieldDescription", name_, value_ ] := fitFieldDescriptionValue[ name, value ];

fitFieldDescriptionValue[ "FieldName"            , v_ ] := fitString @ v[[ 2;;65 ]];
fitFieldDescriptionValue[ "Units"                , v_ ] := fitString @ v[[ 66;;81 ]];
fitFieldDescriptionValue[ "FitBaseUnitID"        , v_ ] := fitFitBaseUnit @ v[[ 82 ]];
fitFieldDescriptionValue[ "NativeMessageNumber"  , v_ ] := fitUINT16 @ v[[ 83 ]];
fitFieldDescriptionValue[ "DeveloperDataIndex"   , v_ ] := fitUINT8 @ v[[ 84 ]];
fitFieldDescriptionValue[ "FieldDefinitionNumber", v_ ] := fitUINT8 @ v[[ 85 ]];
fitFieldDescriptionValue[ "FitBaseTypeID"        , v_ ] := fitFitBaseType @ v[[ 86 ]];
fitFieldDescriptionValue[ "Scale"                , v_ ] := fitUINT8 @ v[[ 87 ]];
fitFieldDescriptionValue[ "Offset"               , v_ ] := fitSINT8 @ v[[ 88 ]];
fitFieldDescriptionValue[ "NativeFieldNumber"    , v_ ] := fitUINT8 @ v[[ 89 ]];
fitFieldDescriptionValue[ _                      , _  ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*TrainingFile*)
fitValue[ "TrainingFile", name_, value_ ] := fitTrainingFileValue[ name, value ];

fitTrainingFileValue[ "Timestamp"   , v_ ] := fitDateTime @ v[[ 2 ]];
fitTrainingFileValue[ "SerialNumber", v_ ] := fitUINT32Z @ v[[ 3 ]];
fitTrainingFileValue[ "TimeCreated" , v_ ] := fitDateTime @ v[[ 4 ]];
fitTrainingFileValue[ "Manufacturer", v_ ] := fitManufacturer @ v[[ 5 ]];
fitTrainingFileValue[ "Product"     , v_ ] := fitProduct @ v[[ 6 ]];
fitTrainingFileValue[ "Type"        , v_ ] := fitFile @ v[[ 7 ]];
fitTrainingFileValue[ "ProductName" , v_ ] := fitProductName @ v[[ 5;;6 ]];
fitTrainingFileValue[ _             , _  ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*WorkoutStep*)
fitValue[ "WorkoutStep", name_, value_ ] := fitWorkoutStepValue[ name, value ];

fitWorkoutStepValue[ "WorkoutStepName"               , v_ ] := fitString @ v[[ 2;;17 ]];
fitWorkoutStepValue[ "Duration"                      , v_ ] := fitWktDuration[ v[[ 18 ]], v[[ 27 ]] ];
fitWOrkoutStepValue[ "DurationType"                  , v_ ] := fitWorkoutStepDuration @ v[[ 27 ]];
fitWorkoutStepValue[ "TargetValue"                   , v_ ] := fitWktTargetValue[ v[[ 19 ]], v[[ 28 ]] ];
fitWorkoutStepValue[ "TargetType"                    , v_ ] := fitWorkoutStepTarget @ v[[ 28 ]];
fitWorkoutStepValue[ "CustomTargetValueLow"          , v_ ] := fitWktTargetValue[ v[[ 20 ]], v[[ 28 ]] ];
fitWorkoutStepValue[ "CustomTargetValueHigh"         , v_ ] := fitWktTargetValue[ v[[ 21 ]], v[[ 28 ]] ];
fitWorkoutStepValue[ "SecondaryTargetValue"          , v_ ] := fitWktTargetValue[ v[[ 22 ]], v[[ 81 ]] ];
fitWorkoutStepValue[ "SecondaryCustomTargetValueLow" , v_ ] := fitWktTargetValue[ v[[ 23 ]], v[[ 81 ]] ];
fitWorkoutStepValue[ "SecondaryCustomTargetValueHigh", v_ ] := fitWktTargetValue[ v[[ 24 ]], v[[ 81 ]] ];
fitWorkoutStepValue[ "SecondaryTargetType"           , v_ ] := fitWorkoutStepTarget @ v[[ 81 ]];
fitWorkoutStepValue[ "MessageIndex"                  , v_ ] := fitMessageIndex @ v[[ 25 ]];
fitWorkoutStepValue[ "ExerciseCategory"              , v_ ] := fitExerciseCategory @ v[[ 26 ]];
fitWorkoutStepValue[ "TargetType"                    , v_ ] := fitWorkoutStepTarget @ v[[ 28 ]];
fitWorkoutStepValue[ "Intensity"                     , v_ ] := fitIntensity @ v[[ 29 ]];
fitWorkoutStepValue[ "Notes"                         , v_ ] := fitString @ v[[ 30;;79 ]];
fitWorkoutStepValue[ "Equipment"                     , v_ ] := fitWorkoutEquipment @ v[[ 80 ]];
fitWorkoutStepValue[ "SecondaryTargetType"           , v_ ] := fitWorkoutStepTarget @ v[[ 81 ]];
fitWorkoutStepValue[ _                               , _  ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Workout*)
fitValue[ "Workout", name_, value_ ] := fitWorkoutValue[ name, value ];

fitWorkoutValue[ "Capabilities"      , v_ ] := fitWorkoutCapabilities @ v[[ 2 ]];
fitWorkoutValue[ "WorkoutName"       , v_ ] := fitString @ v[[ 3;;18 ]];
fitWorkoutValue[ "NumberOfValidSteps", v_ ] := fitUINT16 @ v[[ 19 ]];
fitWorkoutValue[ "PoolLength"        , v_ ] := fitMeters100 @ v[[ 20 ]];
fitWorkoutValue[ "Sport"             , v_ ] := fitSport @ v[[ 21 ]];
fitWorkoutValue[ "SubSport"          , v_ ] := fitSubSport @ v[[ 22 ]];
fitWorkoutValue[ "PoolLengthUnit"    , v_ ] := fitDisplayMeasure @ v[[ 23 ]];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*HeartRateVariability*)
fitValue[ "HeartRateVariability", name_, value_ ] := fitHeartRateVariabilityValue[ name, value ];

fitHeartRateVariabilityValue[ "Time", v_ ] := fitHRV @ v[[ 2 ]];
fitHeartRateVariabilityValue[ _     , _  ] := Missing[ "NotAvailable" ];

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
    Block[ { PrintTemporary },
        ResourceFunction[ "SecondsToQuantity", "Function" ]
    ];

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
fitWktDuration0[ w_, "PowerLessThan"        ] := fitPower @ w;
fitWktDuration0[ w_, "PowerGreaterThan"     ] := fitPower @ w;

fitWktDuration0[ v_, t_ ] := v;
fitWktDuration0[ ___    ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitWktTargetValue*)
fitWktTargetValue // ClearAll;
fitWktTargetValue[ v_, t_ ] := fitWktTargetValue0[ fitUINT32 @ v, fitWorkoutStepTarget @ t ];
fitWktTargetValue[ ___ ] := Missing[ "NotAvailable" ];

fitWktTargetValue0 // ClearAll;
fitWktTargetValue0[ _Missing, _        ] := Missing[ "NotAvailable" ];
fitWktTargetValue0[ _       , _Missing ] := Missing[ "NotAvailable" ];

fitWktTargetValue0[ w_, "Power"      ] := fitPower @ w;
fitWktTargetValue0[ w_, "HeartRate"  ] := fitHeartRate @ w;
fitWktTargetValue0[ w_, "Cadence"    ] := fitCadence @ w;
fitWktTargetValue0[ w_, "Speed"      ] := fitSpeed @ w;
fitWktTargetValue0[ w_, "Grade"      ] := fitGrade @ w;
fitWktTargetValue0[ w_, "Resistance" ] := fitResistance @ w;

fitWktTargetValue0[ v_, t_ ] := v;
fitWktTargetValue0[ ___    ] := Missing[ "NotAvailable" ];

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
(* ::Section::Closed:: *)
(*Package Footer*)
End[ ];
EndPackage[ ];

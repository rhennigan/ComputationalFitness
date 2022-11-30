(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "RH`ComputationalFitness`" ];

Begin[ "`Private`" ];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Config*)
$timeOffset          = 0;
$ftp                 = Automatic;
$maxHR               = Automatic;
$weight              = Automatic;
$sport               = Automatic;
$fileByteCount       = 0;
$pzPlotWidth         = 650;
$invalidSINT8        = 127;
$invalidUINT8        = 255;
$invalidUINT8Z       = 0;
$invalidSINT16       = 32767;
$invalidUINT16       = 65535;
$invalidUINT16Z      = 0;
$invalidSINT32       = 2147483647;
$invalidUINT32       = 4294967295;
$invalidUINT32Z      = 0;
$invalidTimestamp    = 2840036400;
$fitTerm             = 1685024357;
$powerZoneThresholds = { 0.05, 0.55, 0.75, 0.9, 1.05, 1.2, 1.5 };

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
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
(*FIT Message Keys*)
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
(* ::Section::Closed:: *)
(*Package Footer*)
End[ ];
EndPackage[ ];

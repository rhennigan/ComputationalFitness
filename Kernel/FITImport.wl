(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "RH`FitnessData`" ];

Begin[ "`Private`" ];

$ContextAliases[ "gu`" ] = "GeneralUtilities`";

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Config*)
$invalidSINT8  = 127;
$invalidUINT8  = 255;
$invalidSINT16 = 32767;
$invalidUINT16 = 65535;
$invalidSINT32 = 2147483647;
$invalidUINT32 = 4294967295;

$unitSystem := $UnitSystem;

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*FITImport*)
FITImport[ file_ ] := FITImport[ file, "Dataset" ];

FITImport[ file_? FileExistsQ, "RawData" ] :=
    fitImport @ ExpandFileName @ file;

FITImport[ file_? FileExistsQ, "Data" ] :=
    Module[ { data, formatted, tr, filtered },
        Needs[ "GeneralUtilities`" -> None ];
        data = FITImport[ file, "RawData" ];
        formatted = formatFitData @ data;
        tr = gu`AssociationTranspose @ formatted;
        filtered = Select[ tr, Composition[ Not, AllTrue @ MissingQ ] ];
        gu`AssociationTranspose @ filtered
    ];

FITImport[ file_? FileExistsQ, "Dataset" ] :=
    Dataset @ FITImport[ file, "Data" ];

FITImport[ file_? FileExistsQ, "GeoPath" ] :=
    Module[ { data },
        data = FITImport[ file, "Data" ];
        GeoPath @ data[[ All, "GeoPosition" ]]
    ];

FITImport[ file_, prop_ ] :=
    With[ { found = FindFile @ file },
        FITImport[ found, prop ] /; FileExistsQ @ found
    ];

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*fitImport*)
fitImport := fitImport = LibraryFunctionLoad[
    $libraryFile,
    "FITImport",
    { String },
    { Integer, 2 }
];

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*$fitKeys*)
$fitKeys = {
    "Timestamp",
    "GeoPosition",
    "Distance",
    "TimeFromCourse",
    "TotalCycles",
    "AccumulatedPower",
    "EnhancedSpeed",
    "EnhancedAltitude",
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
    "FractionalCadence",
    "DeviceIndex"
};

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*formatFitData*)
formatFitData[ data_ ] :=
    Block[ { $unitSystem = $UnitSystem, $start = data[[ 1, 1 ]] },
        makeFitAssociation /@ data
    ];

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*makeFitAssociation*)
makeFitAssociation[ values_ ] :=
    AssociationMap[ fitValue[ #1, values ] &, $fitKeys ];

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*fitValue*)
fitValue[ "Timestamp"                      , v_ ] := fitTimestamp @ v[[ 1 ]];
fitValue[ "GeoPosition"                    , v_ ] := fitGeoPosition @ v[[ 2;;3 ]];
fitValue[ "Distance"                       , v_ ] := fitDistance @ v[[ 4 ]];
fitValue[ "TimeFromCourse"                 , v_ ] := fitTimeFromCourse @ v[[ 5 ]];
fitValue[ "TotalCycles"                    , v_ ] := fitTotalCycles @ v[[ 6 ]];
fitValue[ "AccumulatedPower"               , v_ ] := fitAccumulatedPower @ v[[ { 1, 7 } ]];
fitValue[ "EnhancedSpeed"                  , v_ ] := fitEnhancedSpeed @ v[[ 8 ]];
fitValue[ "EnhancedAltitude"               , v_ ] := fitEnhancedAltitude @ v[[ 9 ]];
fitValue[ "Altitude"                       , v_ ] := fitAltitude @ v[[ 10 ]];
fitValue[ "Speed"                          , v_ ] := fitSpeed @ v[[ 11 ]];
fitValue[ "Power"                          , v_ ] := fitPower @ v[[ 12 ]];
fitValue[ "Grade"                          , v_ ] := fitGrade @ v[[ 13 ]];
fitValue[ "CompressedAccumulatedPower"     , v_ ] := fitCompressedAccumulatedPower @ v[[ 14 ]];
fitValue[ "VerticalSpeed"                  , v_ ] := fitVerticalSpeed @ v[[ 15 ]];
fitValue[ "Calories"                       , v_ ] := fitCalories @ v[[ 16 ]];
fitValue[ "VerticalOscillation"            , v_ ] := fitVerticalOscillation @ v[[ 17 ]];
fitValue[ "StanceTimePercent"              , v_ ] := fitStanceTimePercent @ v[[ 18 ]];
fitValue[ "StanceTime"                     , v_ ] := fitStanceTime @ v[[ 19 ]];
fitValue[ "BallSpeed"                      , v_ ] := fitBallSpeed @ v[[ 20 ]];
fitValue[ "Cadence256"                     , v_ ] := fitCadence256 @ v[[ 21 ]];
fitValue[ "TotalHemoglobinConcentration"   , v_ ] := fitTotalHemoglobinConcentration @ v[[ 22 ]];
fitValue[ "TotalHemoglobinConcentrationMin", v_ ] := fitTotalHemoglobinConcentrationMin @ v[[ 23 ]];
fitValue[ "TotalHemoglobinConcentrationMax", v_ ] := fitTotalHemoglobinConcentrationMax @ v[[ 24 ]];
fitValue[ "SaturatedHemoglobinPercent"     , v_ ] := fitSaturatedHemoglobinPercent @ v[[ 25 ]];
fitValue[ "SaturatedHemoglobinPercentMin"  , v_ ] := fitSaturatedHemoglobinPercentMin @ v[[ 26 ]];
fitValue[ "SaturatedHemoglobinPercentMax"  , v_ ] := fitSaturatedHemoglobinPercentMax @ v[[ 27 ]];
fitValue[ "HeartRate"                      , v_ ] := fitHeartRate @ v[[ 28 ]];
fitValue[ "Cadence"                        , v_ ] := fitCadence @ v[[ 29 ]];
fitValue[ "Resistance"                     , v_ ] := fitResistance @ v[[ 30 ]];
fitValue[ "CycleLength"                    , v_ ] := fitCycleLength @ v[[ 31 ]];
fitValue[ "Temperature"                    , v_ ] := fitTemperature @ v[[ 32 ]];
fitValue[ "Cycles"                         , v_ ] := fitCycles @ v[[ 33 ]];
fitValue[ "LeftRightBalance"               , v_ ] := fitLeftRightBalance @ v[[ 34 ]];
fitValue[ "GPSAccuracy"                    , v_ ] := fitGPSAccuracy @ v[[ 35 ]];
fitValue[ "ActivityType"                   , v_ ] := fitActivityType @ v[[ 36 ]];
fitValue[ "LeftTorqueEffectiveness"        , v_ ] := fitLeftTorqueEffectiveness @ v[[ 37 ]];
fitValue[ "RightTorqueEffectiveness"       , v_ ] := fitRightTorqueEffectiveness @ v[[ 38 ]];
fitValue[ "LeftPedalSmoothness"            , v_ ] := fitLeftPedalSmoothness @ v[[ 39 ]];
fitValue[ "RightPedalSmoothness"           , v_ ] := fitRightPedalSmoothness @ v[[ 40 ]];
fitValue[ "CombinedPedalSmoothness"        , v_ ] := fitCombinedPedalSmoothness @ v[[ 41 ]];
fitValue[ "Time128"                        , v_ ] := fitTime128 @ v[[ 42 ]];
fitValue[ "StrokeType"                     , v_ ] := fitStrokeType @ v[[ 43 ]];
fitValue[ "Zone"                           , v_ ] := fitZone @ v[[ 44 ]];
fitValue[ "FractionalCadence"              , v_ ] := fitFractionalCadence @ v[[ 45 ]];
fitValue[ "DeviceIndex"                    , v_ ] := fitDeviceIndex @ v[[ 46 ]];

fitValue[ _, _ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTimestamp*)
fitTimestamp[ $invalidUINT32 ] := Missing[ "NotAvailable" ];
fitTimestamp[ n_Integer ] := TimeZoneConvert @ DateObject[ n, TimeZone -> 0 ];
fitTimestamp[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitGeoPosition*)
fitGeoPosition[ { $invalidSINT32|0, _ } ] := Missing[ "NotAvailable" ];
fitGeoPosition[ { _, $invalidSINT32|0 } ] := Missing[ "NotAvailable" ];
fitGeoPosition[ { a_, b_ } ] := GeoPosition[ 8.381903175442434*^-8*{ a, b } ];
fitGeoPosition[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitDistance*)
fitDistance[ n_Integer ] := fitDistance[ n, $unitSystem ];
fitDistance[ $invalidUINT32, "Imperial" ] := Quantity[ 0.0, "Miles" ];
fitDistance[ $invalidUINT32, _ ] := Quantity[ 0.0, "Meters" ];
fitDistance[ n_, "Imperial" ] := Quantity[ 6.213711922373339*^-6*n, "Miles" ];
fitDistance[ n_, _ ] := Quantity[ n/100.0, "Meters" ];
fitDistance[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTimeFromCourse*)
(* TODO *)
fitTimeFromCourse[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTotalCycles*)
fitTotalCycles[ $invalidUINT32 ] := Missing[ "NotAvailable" ];
fitTotalCycles[ n_Integer ] := Quantity[ n, IndependentUnit[ "Cycles" ] ];
fitTotalCycles[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitAccumulatedPower*)
fitAccumulatedPower[ { $invalidUINT32, _ } ] := Missing[ "NotAvailable" ];
fitAccumulatedPower[ { _, $invalidUINT32 } ] := Quantity[ 0.0, "Kilojoules" ];
fitAccumulatedPower[ a_ ] := fitAccumulatedPower[ $start, a ];
fitAccumulatedPower[ t0_Integer, { t_Integer, n_Integer } ] := Quantity[ 0.001 n t - 0.001 n t0, "Kilojoules" ];
fitAccumulatedPower[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitEnhancedSpeed*)
(* TODO *)
fitEnhancedSpeed[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitEnhancedAltitude*)
fitEnhancedAltitude[ $invalidUINT32 ] := Missing[ "NotAvailable" ];
fitEnhancedAltitude[ n_Integer ] := fitEnhancedAltitude[ n, $unitSystem ];
fitEnhancedAltitude[ n_, "Imperial" ] := Quantity[ 0.6561679790026247*n - 328.0839895013123, "Feet" ];
fitEnhancedAltitude[ n_, _ ] := Quantity[ 0.2 n - 100.0, "Meters" ];
fitEnhancedAltitude[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitAltitude*)
fitAltitude[ $invalidUINT16 ] := Missing[ "NotAvailable" ];
fitAltitude[ n_Integer ] := fitAltitude[ n, $unitSystem ];
fitAltitude[ n_, "Imperial" ] := Quantity[ 0.656168 n - 1640.42, "Feet" ];
fitAltitude[ n_, _ ] := Quantity[ 0.2 n - 500.0, "Meters" ];
fitAltitude[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitSpeed*)
fitSpeed[ n_Integer ] := fitSpeed[ n, $unitSystem ];
fitSpeed[ $invalidUINT16, "Imperial" ] := Quantity[ 0.0, "Miles"/"Hours" ];
fitSpeed[ $invalidUINT16, _ ] := Quantity[ 0.0, "Meters"/"Seconds" ];
fitSpeed[ n_, "Imperial" ] := Quantity[ 0.0022369362920544025*n, "Miles"/"Hours" ];
fitSpeed[ n_, _ ] := Quantity[ n/1000.0, "Meters"/"Seconds" ];
fitSpeed[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitPower*)
fitPower[ $invalidUINT16 ] := Quantity[ 0, "Watts" ];
fitPower[ n_Integer ] := Quantity[ n, "Watts" ];
fitPower[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitGrade*)
(* TODO *)
fitGrade[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitCompressedAccumulatedPower*)
(* TODO *)
fitCompressedAccumulatedPower[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitVerticalSpeed*)
(* TODO *)
fitVerticalSpeed[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitCalories*)
(* TODO *)
fitCalories[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitVerticalOscillation*)
(* TODO *)
fitVerticalOscillation[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitStanceTimePercent*)
(* TODO *)
fitStanceTimePercent[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitStanceTime*)
(* TODO *)
fitStanceTime[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitBallSpeed*)
(* TODO *)
fitBallSpeed[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitCadence256*)
(* TODO *)
fitCadence256[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTotalHemoglobinConcentration*)
(* TODO *)
fitTotalHemoglobinConcentration[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTotalHemoglobinConcentrationMin*)
(* TODO *)
fitTotalHemoglobinConcentrationMin[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTotalHemoglobinConcentrationMax*)
(* TODO *)
fitTotalHemoglobinConcentrationMax[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitSaturatedHemoglobinPercent*)
(* TODO *)
fitSaturatedHemoglobinPercent[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitSaturatedHemoglobinPercentMin*)
(* TODO *)
fitSaturatedHemoglobinPercentMin[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitSaturatedHemoglobinPercentMax*)
(* TODO *)
fitSaturatedHemoglobinPercentMax[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitHeartRate*)
fitHeartRate[ $invalidUINT8 ] := Missing[ "NotAvailable" ];
fitHeartRate[ n_Integer ] := Quantity[ n, "Beats"/"Minute" ];
fitHeartRate[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitCadence*)
fitCadence[ $invalidUINT8 ] := Missing[ "NotAvailable" ];
fitCadence[ n_Integer ] := Quantity[ n, "Revolutions"/"Minute" ];
fitCadence[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitResistance*)
(* TODO *)
fitResistance[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitCycleLength*)
(* TODO *)
fitCycleLength[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTemperature*)
fitTemperature[ $invalidSINT8 ] := Missing[ "NotAvailable" ];
fitTemperature[ n_Integer ] := fitTemperature[ n, $unitSystem ];
fitTemperature[ n_Integer, "Imperial" ] := Quantity[ 32.0 + 1.8 n, "DegreesFahrenheit" ];
fitTemperature[ n_Integer, _ ] := Quantity[ 1.0 * n, "DegreesCelsius" ];
fitTemperature[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitCycles*)
(* TODO *)
fitCycles[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitLeftRightBalance*)
(* TODO *)
fitLeftRightBalance[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitGPSAccuracy*)
(* TODO *)
fitGPSAccuracy[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitActivityType*)
(* TODO *)
fitActivityType[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitLeftTorqueEffectiveness*)
(* TODO *)
fitLeftTorqueEffectiveness[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitRightTorqueEffectiveness*)
(* TODO *)
fitRightTorqueEffectiveness[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitLeftPedalSmoothness*)
(* TODO *)
fitLeftPedalSmoothness[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitRightPedalSmoothness*)
(* TODO *)
fitRightPedalSmoothness[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitCombinedPedalSmoothness*)
(* TODO *)
fitCombinedPedalSmoothness[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTime128*)
(* TODO *)
fitTime128[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitStrokeType*)
(* TODO *)
fitStrokeType[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitZone*)
(* TODO *)
fitZone[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitFractionalCadence*)
(* TODO *)
fitFractionalCadence[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitDeviceIndex*)
(* TODO *)
fitDeviceIndex[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Footer*)
End[ ];
EndPackage[ ];

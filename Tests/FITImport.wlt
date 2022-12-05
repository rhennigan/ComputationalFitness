(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Initialization*)
VerificationTest[
    $pacletDir = DirectoryName[ $TestFileName, 2 ],
    _? DirectoryQ,
    SameTest -> MatchQ,
    TestID   -> "Initialize-PacletDirectory@@Tests/FITImport.wlt:4,1-9,2"
]

VerificationTest[
    $paclet = PacletObject @ File[ $pacletDir ],
    _? PacletObjectQ,
    SameTest -> MatchQ,
    TestID   -> "Initialize-PacletObject@@Tests/FITImport.wlt:11,1-16,2"
]

VerificationTest[
    PacletDirectoryLoad @ $pacletDir,
    { ___, $pacletDir, ___ },
    SameTest -> MatchQ,
    TestID   -> "Initialize-PacletDirectoryLoad@@Tests/FITImport.wlt:18,1-23,2"
]

VerificationTest[
    Needs[ "RH`ComputationalFitness`" ],
    Null,
    SameTest -> MatchQ,
    TestID   -> "Initialize-Needs-ComputationalFitness@@Tests/FITImport.wlt:25,1-30,2"
]

(* ::**********************************************************************:: *)
(* ::Section:: *)
(*Tests*)

(* ::**********************************************************************:: *)
(* ::Subsection:: *)
(*Basic Examples*)
VerificationTest[
    FITImport[ "ComputationalFitness/ExampleData/BikeRide.fit" ],
    _Dataset,
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-1@@Tests/FITImport.wlt:39,1-44,2"
]

VerificationTest[
    session = FITImport[ "ComputationalFitness/ExampleData/BikeRide.fit", "Session" ],
    _Dataset,
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-2@@Tests/FITImport.wlt:46,1-51,2"
]

VerificationTest[
    session1 = session[ 1 ],
    _Dataset,
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-3@@Tests/FITImport.wlt:53,1-58,2"
]

VerificationTest[
    Normal @ session1,
    KeyValuePattern @ {
        "AverageCadence"                          -> _Quantity,
        "AverageHeartRate"                        -> _Quantity,
        "AverageLeftPowerPhaseEnd"                -> _Quantity,
        "AverageLeftPowerPhasePeakEnd"            -> _Quantity,
        "AverageLeftPowerPhasePeakStart"          -> _Quantity,
        "AverageLeftPowerPhaseStart"              -> _Quantity,
        "AveragePower"                            -> _Quantity,
        "AverageRightPowerPhaseEnd"               -> _Quantity,
        "AverageRightPowerPhasePeakEnd"           -> _Quantity,
        "AverageRightPowerPhasePeakStart"         -> _Quantity,
        "AverageRightPowerPhaseStart"             -> _Quantity,
        "AverageSpeed"                            -> _Quantity,
        "AverageTemperature"                      -> _Quantity,
        "AverageVAM"                              -> _Quantity,
        "Event"                                   -> _String,
        "EventType"                               -> _String,
        "FirstLapIndex"                           -> _Integer,
        "GeoBoundingBox"                          -> { _GeoPosition, _GeoPosition },
        "IntensityFactor"                         -> _Real,
        "LeftRightBalance"                        -> { Quantity[ _, "Percent" ], Quantity[ _, "Percent" ] },
        "MaxCadence"                              -> _Quantity,
        "MaxHeartRate"                            -> _Quantity,
        "MaxPower"                                -> _Quantity,
        "MaxSpeed"                                -> _Quantity,
        "MaxTemperature"                          -> _Quantity,
        "NormalizedPower"                         -> _Quantity,
        "NumberOfLaps"                            -> _Quantity,
        "Sport"                                   -> _String,
        "StartPosition"                           -> _GeoPosition,
        "StartTime"                               -> _DateObject,
        "SubSport"                                -> _String,
        "ThresholdPower"                          -> _Quantity,
        "Timestamp"                               -> _DateObject,
        "TotalAerobicTrainingEffect"              -> _Real,
        "TotalAerobicTrainingEffectDescription"   -> _String,
        "TotalAnaerobicTrainingEffect"            -> _Real,
        "TotalAnaerobicTrainingEffectDescription" -> _String,
        "TotalAscent"                             -> _Quantity,
        "TotalCalories"                           -> _Quantity,
        "TotalCycles"                             -> _Quantity,
        "TotalDescent"                            -> _Quantity,
        "TotalDistance"                           -> _Quantity,
        "TotalElapsedTime"                        -> _Quantity,
        "TotalTimerTime"                          -> _Quantity,
        "TotalWork"                               -> _Quantity,
        "TrainingStressScore"                     -> _Real,
        "Trigger"                                 -> _String
    },
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-4@@Tests/FITImport.wlt:60,1-113,2"
]

VerificationTest[
    pos = FITImport[ "ComputationalFitness/ExampleData/BikeRide.fit", "GeoPosition" ],
    _TemporalData,
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-5@@Tests/FITImport.wlt:115,1-120,2"
]

VerificationTest[
    Values @ pos,
    { __GeoPosition },
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-6@@Tests/FITImport.wlt:122,1-127,2"
]

VerificationTest[
    DateListPlot @ FITImport[ "ComputationalFitness/ExampleData/BikeHillClimb.fit", "Altitude" ],
    _Graphics,
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-7@@Tests/FITImport.wlt:129,1-134,2"
]

VerificationTest[
    FITImport[ "ComputationalFitness/ExampleData/IndoorIntervals.fit", "PowerZonePlot" ],
    _Legended,
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-8@@Tests/FITImport.wlt:136,1-141,2"
]

VerificationTest[
    FITImport[ "ComputationalFitness/ExampleData/BikeLaps.fit", "AveragePowerPhasePlot" ],
    _Graphics,
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-9@@Tests/FITImport.wlt:143,1-148,2"
]

VerificationTest[
    FITImport[ "ComputationalFitness/ExampleData/BikeLaps.fit", "CriticalPowerCurvePlot" ],
    _Graphics,
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-10@@Tests/FITImport.wlt:150,1-155,2"
]

(* ::**********************************************************************:: *)
(* ::Subsection:: *)
(*Scope*)
VerificationTest[
    devices = FITImport[ "ComputationalFitness/ExampleData/BikeHillClimb.fit", "DeviceInformation" ],
    _Dataset,
    SameTest -> MatchQ,
    TestID   -> "Scope-1@@Tests/FITImport.wlt:160,1-165,2"
]

VerificationTest[
    FirstCase[ Normal @ devices, KeyValuePattern @ { "ProductName" -> "Edge830" } ],
    _Association,
    SameTest -> MatchQ,
    TestID   -> "Scope-2@@Tests/FITImport.wlt:167,1-172,2"
]

(* ::**********************************************************************:: *)
(* ::Subsection:: *)
(*Options*)

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*FunctionalThresholdPower*)
VerificationTest[
    oldFTP = PersistentSymbol[ "FITImport/FunctionalThresholdPower" ];
    If[ ! MissingQ @ oldFTP,
        Unset @ PersistentSymbol[ "FITImport/FunctionalThresholdPower" ]
    ],
    Null,
    SameTest -> MatchQ,
    TestID -> "Options/FunctionalThresholdPower-1@@Tests/FITImport.wlt:181,1-189,2"
]

VerificationTest[
    FITImport[ "ComputationalFitness/ExampleData/ZwiftRide.fit", "PowerZone" ],
    _Missing,
    SameTest -> MatchQ,
    TestID   -> "Options-FunctionalThresholdPower-2@@Tests/FITImport.wlt:191,1-196,2"
]

VerificationTest[
    FITImport[
        "ComputationalFitness/ExampleData/ZwiftRide.fit",
        "PowerZone",
        "FunctionalThresholdPower" -> Quantity[ 250, "Watts" ]
    ],
    _TemporalData,
    SameTest -> MatchQ,
    TestID   -> "Options-FunctionalThresholdPower-3@@Tests/FITImport.wlt:198,1-207,2"
]

VerificationTest[
    FITImport[ "ComputationalFitness/ExampleData/ZwiftRide.fit", "PowerZonePlot" ],
    _Graphics,
    { FITImport::NoFTPValue },
    SameTest -> MatchQ,
    TestID   -> "Options-FunctionalThresholdPower-4@@Tests/FITImport.wlt:209,1-215,2"
]

VerificationTest[
    PersistentSymbol[ "FITImport/FunctionalThresholdPower" ] = Quantity[ 250, "Watts" ],
    _Quantity,
    SameTest -> MatchQ,
    TestID   -> "Options-FunctionalThresholdPower-5@@Tests/FITImport.wlt:217,1-222,2"
]

VerificationTest[
    FITImport[ "ComputationalFitness/ExampleData/ZwiftRide.fit", "PowerZone" ],
    _TemporalData,
    SameTest -> MatchQ,
    TestID   -> "Options-FunctionalThresholdPower-6@@Tests/FITImport.wlt:224,1-229,2"
]

VerificationTest[
    If[ ! MissingQ @ oldFTP,
        PersistentSymbol[ "FITImport/FunctionalThresholdPower" ] = oldFTP;
    ],
    Null,
    SameTest -> MatchQ,
    TestID   -> "Options-FunctionalThresholdPower-7@@Tests/FITImport.wlt:231,1-238,2"
]

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*MaxHeartRate*)
VerificationTest[
    oldMaxHR = PersistentSymbol[ "FITImport/MaxHeartRate" ];
    If[ ! MissingQ @ oldMaxHR,
        Unset @ PersistentSymbol[ "FITImport/MaxHeartRate" ]
    ],
    Null,
    SameTest -> MatchQ,
    TestID   -> "Options-MaxHeartRate-1@@Tests/FITImport.wlt:243,1-251,2"
]

VerificationTest[
    FITImport[ "ComputationalFitness/ExampleData/ZwiftRide.fit", "HeartRateZone" ],
    _Missing,
    SameTest -> MatchQ,
    TestID   -> "Options-MaxHeartRate-2@@Tests/FITImport.wlt:253,1-258,2"
]

VerificationTest[
    FITImport[
        "ComputationalFitness/ExampleData/ZwiftRide.fit",
        "HeartRateZone",
        "MaxHeartRate" -> 190
    ],
    _TemporalData,
    SameTest -> MatchQ,
    TestID   -> "Options-MaxHeartRate-3@@Tests/FITImport.wlt:260,1-269,2"
]

VerificationTest[
    PersistentSymbol[ "FITImport/MaxHeartRate" ] = Quantity[ 190, "BPM" ],
    _Quantity,
    SameTest -> MatchQ,
    TestID   -> "Options-MaxHeartRate-4@@Tests/FITImport.wlt:271,1-276,2"
]

VerificationTest[
    FITImport[ "ComputationalFitness/ExampleData/ZwiftRide.fit", "HeartRateZone" ],
    _TemporalData,
    SameTest -> MatchQ,
    TestID   -> "Options-MaxHeartRate-5@@Tests/FITImport.wlt:278,1-283,2"
]

VerificationTest[
    If[ ! MissingQ @ oldMaxHR,
        PersistentSymbol[ "FITImport/MaxHeartRate" ] = oldMaxHR;
    ],
    Null,
    SameTest -> MatchQ,
    TestID   -> "Options-MaxHeartRate-6@@Tests/FITImport.wlt:285,1-292,2"
]

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*UnitSystem*)
VerificationTest[
    FITImport[ "ComputationalFitness/ExampleData/BikeHillClimb.fit", "Altitude", UnitSystem -> "Imperial" ][ "LastValue" ],
    Quantity[ _, "Feet" ],
    SameTest -> MatchQ,
    TestID   -> "Options-UnitSystem-1@@Tests/FITImport.wlt:297,1-302,2"
]

VerificationTest[
    FITImport[ "ComputationalFitness/ExampleData/BikeHillClimb.fit", "Altitude", UnitSystem -> "Metric" ][ "LastValue" ],
    Quantity[ _, "Meters" ],
    SameTest -> MatchQ,
    TestID   -> "Options-UnitSystem-2@@Tests/FITImport.wlt:304,1-309,2"
]

VerificationTest[
    Block[ { $UnitSystem = "Imperial" },
        FITImport[ "ComputationalFitness/ExampleData/BikeHillClimb.fit", "Altitude" ][ "LastValue" ]
    ],
    Quantity[ _, "Feet" ],
    SameTest -> MatchQ,
    TestID   -> "Options-UnitSystem-3@@Tests/FITImport.wlt:311,1-318,2"
]

VerificationTest[
    Block[ { $UnitSystem = "Metric" },
        FITImport[ "ComputationalFitness/ExampleData/BikeHillClimb.fit", "Altitude" ][ "LastValue" ]
    ],
    Quantity[ _, "Meters" ],
    SameTest -> MatchQ,
    TestID   -> "Options-UnitSystem-4@@Tests/FITImport.wlt:320,1-327,2"
]

(* ::**********************************************************************:: *)
(* ::Subsection:: *)
(*Errors*)

(* ::**********************************************************************:: *)
(* ::Subsection:: *)
(*Applications*)


(* ::**********************************************************************:: *)
(* ::Subsection:: *)
(*Properties and Relations*)
VerificationTest[
    FITImport[ "ComputationalFitness/ExampleData/BikeRide.fit", "MessageCounts" ],
    KeyValuePattern[ "Record" -> 11376 ],
    SameTest -> MatchQ,
    TestID   -> "PropertiesAndRelations-1@@Tests/FITImport.wlt:341,1-346,2"
]

VerificationTest[
    Total @ Select[
        FITImport[ "ComputationalFitness/ExampleData/BikeRide.fit", "MessageInformation" ],
        #Supported &
    ][ All, "Count" ],
    Length @ FITImport[ "ComputationalFitness/ExampleData/BikeRide.fit", "RawData" ],
    SameTest -> MatchQ,
    TestID   -> "PropertiesAndRelations-2@@Tests/FITImport.wlt:348,1-356,2"
]

VerificationTest[
    FITImport[ "ComputationalFitness/ExampleData/Walk.fit", "Session" ][ 1 ][ "AverageCadence" ],
    Quantity[ _, "Steps"/"Minutes" ],
    SameTest -> MatchQ,
    TestID   -> "PropertiesAndRelations-3@@Tests/FITImport.wlt:358,1-363,2"
]

VerificationTest[
    FITImport[ "ComputationalFitness/ExampleData/BikeRide.fit", "Session" ][ 1 ][ "AverageCadence" ],
    Quantity[ _, "Revolutions"/"Minutes" ],
    SameTest -> MatchQ,
    TestID   -> "PropertiesAndRelations-4@@Tests/FITImport.wlt:365,1-370,2"
]

(* ::**********************************************************************:: *)
(* ::Subsection:: *)
(*Possible Issues*)


(* ::**********************************************************************:: *)
(* ::Subsection:: *)
(*Neat Examples*)

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Example Data*)
VerificationTest[
    $exampleDir = DirectoryName @ FindFile[ "ComputationalFitness/ExampleData/BikeRide.fit" ],
    _? DirectoryQ,
    SameTest -> MatchQ,
    TestID   -> "ExampleData-1@@Tests/FITImport.wlt:384,1-389,2"
]

VerificationTest[
    StringStartsQ[ $exampleDir, $UserBaseDirectory ],
    True,
    SameTest -> MatchQ,
    TestID   -> "ExampleData-2@@Tests/FITImport.wlt:391,1-396,2"
]

VerificationTest[
    $exampleFiles = FileNames[ "*.fit", $exampleDir ],
    { Repeated[ _String, { 5, Infinity } ] },
    SameTest -> MatchQ,
    TestID   -> "ExampleData-3@@Tests/FITImport.wlt:398,1-403,2"
]

VerificationTest[
    MemberQ[ $Path, AbsoluteFileName @ DirectoryName @ $exampleDir ],
    True,
    SameTest -> MatchQ,
    TestID   -> "ExampleData-4@@Tests/FITImport.wlt:405,1-410,2"
]

VerificationTest[
    (FITImport @ FileNameTake[ #, -2 ] &) /@ $exampleFiles,
    { __Dataset },
    SameTest -> MatchQ,
    TestID   -> "ExampleData-5@@Tests/FITImport.wlt:412,1-417,2"
]

(* ::**********************************************************************:: *)
(* ::Subsection:: *)
(*Error Cases*)


(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Cleanup*)


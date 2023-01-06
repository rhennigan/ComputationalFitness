(* ::**************************************************************************************************************:: *)
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

VerificationTest[
    Context @ FITImport,
    "RH`ComputationalFitness`",
    SameTest -> MatchQ,
    TestID   -> "Initialize-Context@@Tests/FITImport.wlt:32,1-37,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Section:: *)
(*Tests*)

(* ::**************************************************************************************************************:: *)
(* ::Subsection:: *)
(*Basic Examples*)
VerificationTest[
    Quiet[
        FITImport[ "ComputationalFitness/ExampleData/BikeRide.fit" ],
        FITImport::CompileOnDemand
    ],
    _Dataset,
    SameTest -> MatchQ,
    TestID -> "BasicExamples-1@@Tests/FITImport.wlt:46,1-54,2"
]

VerificationTest[
    session = FITImport[ "ComputationalFitness/ExampleData/BikeRide.fit", "Session" ],
    _Dataset,
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-2@@Tests/FITImport.wlt:56,1-61,2"
]

VerificationTest[
    session1 = session[ 1 ],
    _Dataset,
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-3@@Tests/FITImport.wlt:63,1-68,2"
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
    TestID   -> "BasicExamples-4@@Tests/FITImport.wlt:70,1-123,2"
]

VerificationTest[
    pos = FITImport[ "ComputationalFitness/ExampleData/BikeRide.fit", "GeoPosition" ],
    _TemporalData,
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-5@@Tests/FITImport.wlt:125,1-130,2"
]

VerificationTest[
    Values @ pos,
    { __GeoPosition },
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-6@@Tests/FITImport.wlt:132,1-137,2"
]

VerificationTest[
    DateListPlot @ FITImport[ "ComputationalFitness/ExampleData/BikeHillClimb.fit", "Altitude" ],
    _Graphics,
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-7@@Tests/FITImport.wlt:139,1-144,2"
]

VerificationTest[
    FITImport[ "ComputationalFitness/ExampleData/IndoorIntervals.fit", "PowerZonePlot" ],
    _Legended,
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-8@@Tests/FITImport.wlt:146,1-151,2"
]

VerificationTest[
    FITImport[ "ComputationalFitness/ExampleData/BikeLaps.fit", "AveragePowerPhasePlot" ],
    _Graphics,
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-9@@Tests/FITImport.wlt:153,1-158,2"
]

VerificationTest[
    FITImport[ "ComputationalFitness/ExampleData/BikeLaps.fit", "CriticalPowerCurvePlot" ],
    _Graphics,
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-10@@Tests/FITImport.wlt:160,1-165,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Subsection:: *)
(*Scope*)
VerificationTest[
    devices = FITImport[ "ComputationalFitness/ExampleData/BikeHillClimb.fit", "DeviceInformation" ],
    _Dataset,
    SameTest -> MatchQ,
    TestID   -> "Scope-1@@Tests/FITImport.wlt:170,1-175,2"
]

VerificationTest[
    FirstCase[ Normal @ devices, KeyValuePattern @ { "ProductName" -> "Edge830" } ],
    _Association,
    SameTest -> MatchQ,
    TestID   -> "Scope-2@@Tests/FITImport.wlt:177,1-182,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Subsection:: *)
(*Options*)

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*FunctionalThresholdPower*)
VerificationTest[
    oldFTP = PersistentSymbol[ "FITImport/FunctionalThresholdPower" ];
    If[ ! MissingQ @ oldFTP,
        Unset @ PersistentSymbol[ "FITImport/FunctionalThresholdPower" ]
    ],
    Null,
    SameTest -> MatchQ,
    TestID -> "Options/FunctionalThresholdPower-1@@Tests/FITImport.wlt:191,1-199,2"
]

VerificationTest[
    FITImport[ "ComputationalFitness/ExampleData/ZwiftRide.fit", "PowerZone" ],
    _Missing,
    SameTest -> MatchQ,
    TestID   -> "Options-FunctionalThresholdPower-2@@Tests/FITImport.wlt:201,1-206,2"
]

VerificationTest[
    FITImport[
        "ComputationalFitness/ExampleData/ZwiftRide.fit",
        "PowerZone",
        "FunctionalThresholdPower" -> Quantity[ 250, "Watts" ]
    ],
    _TemporalData,
    SameTest -> MatchQ,
    TestID   -> "Options-FunctionalThresholdPower-3@@Tests/FITImport.wlt:208,1-217,2"
]

VerificationTest[
    FITImport[ "ComputationalFitness/ExampleData/ZwiftRide.fit", "PowerZonePlot" ],
    _Graphics,
    { FITImport::NoFTPValue },
    SameTest -> MatchQ,
    TestID   -> "Options-FunctionalThresholdPower-4@@Tests/FITImport.wlt:219,1-225,2"
]

VerificationTest[
    PersistentSymbol[ "FITImport/FunctionalThresholdPower" ] = Quantity[ 250, "Watts" ],
    _Quantity,
    SameTest -> MatchQ,
    TestID   -> "Options-FunctionalThresholdPower-5@@Tests/FITImport.wlt:227,1-232,2"
]

VerificationTest[
    FITImport[ "ComputationalFitness/ExampleData/ZwiftRide.fit", "PowerZone" ],
    _TemporalData,
    SameTest -> MatchQ,
    TestID   -> "Options-FunctionalThresholdPower-6@@Tests/FITImport.wlt:234,1-239,2"
]

VerificationTest[
    If[ ! MissingQ @ oldFTP,
        PersistentSymbol[ "FITImport/FunctionalThresholdPower" ] = oldFTP;
    ],
    Null,
    SameTest -> MatchQ,
    TestID   -> "Options-FunctionalThresholdPower-7@@Tests/FITImport.wlt:241,1-248,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*MaxHeartRate*)
VerificationTest[
    oldMaxHR = PersistentSymbol[ "FITImport/MaxHeartRate" ];
    If[ ! MissingQ @ oldMaxHR,
        Unset @ PersistentSymbol[ "FITImport/MaxHeartRate" ]
    ],
    Null,
    SameTest -> MatchQ,
    TestID   -> "Options-MaxHeartRate-1@@Tests/FITImport.wlt:253,1-261,2"
]

VerificationTest[
    FITImport[ "ComputationalFitness/ExampleData/ZwiftRide.fit", "HeartRateZone" ],
    _Missing,
    SameTest -> MatchQ,
    TestID   -> "Options-MaxHeartRate-2@@Tests/FITImport.wlt:263,1-268,2"
]

VerificationTest[
    FITImport[
        "ComputationalFitness/ExampleData/ZwiftRide.fit",
        "HeartRateZone",
        "MaxHeartRate" -> 190
    ],
    _TemporalData,
    SameTest -> MatchQ,
    TestID   -> "Options-MaxHeartRate-3@@Tests/FITImport.wlt:270,1-279,2"
]

VerificationTest[
    PersistentSymbol[ "FITImport/MaxHeartRate" ] = Quantity[ 190, "BPM" ],
    _Quantity,
    SameTest -> MatchQ,
    TestID   -> "Options-MaxHeartRate-4@@Tests/FITImport.wlt:281,1-286,2"
]

VerificationTest[
    FITImport[ "ComputationalFitness/ExampleData/ZwiftRide.fit", "HeartRateZone" ],
    _TemporalData,
    SameTest -> MatchQ,
    TestID   -> "Options-MaxHeartRate-5@@Tests/FITImport.wlt:288,1-293,2"
]

VerificationTest[
    If[ ! MissingQ @ oldMaxHR,
        PersistentSymbol[ "FITImport/MaxHeartRate" ] = oldMaxHR;
    ],
    Null,
    SameTest -> MatchQ,
    TestID   -> "Options-MaxHeartRate-6@@Tests/FITImport.wlt:295,1-302,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*UnitSystem*)
VerificationTest[
    FITImport[ "ComputationalFitness/ExampleData/BikeHillClimb.fit", "Altitude", UnitSystem -> "Imperial" ][ "LastValue" ],
    Quantity[ _, "Feet" ],
    SameTest -> MatchQ,
    TestID   -> "Options-UnitSystem-1@@Tests/FITImport.wlt:307,1-312,2"
]

VerificationTest[
    FITImport[ "ComputationalFitness/ExampleData/BikeHillClimb.fit", "Altitude", UnitSystem -> "Metric" ][ "LastValue" ],
    Quantity[ _, "Meters" ],
    SameTest -> MatchQ,
    TestID   -> "Options-UnitSystem-2@@Tests/FITImport.wlt:314,1-319,2"
]

VerificationTest[
    Block[ { $UnitSystem = "Imperial" },
        FITImport[ "ComputationalFitness/ExampleData/BikeHillClimb.fit", "Altitude" ][ "LastValue" ]
    ],
    Quantity[ _, "Feet" ],
    SameTest -> MatchQ,
    TestID   -> "Options-UnitSystem-3@@Tests/FITImport.wlt:321,1-328,2"
]

VerificationTest[
    Block[ { $UnitSystem = "Metric" },
        FITImport[ "ComputationalFitness/ExampleData/BikeHillClimb.fit", "Altitude" ][ "LastValue" ]
    ],
    Quantity[ _, "Meters" ],
    SameTest -> MatchQ,
    TestID   -> "Options-UnitSystem-4@@Tests/FITImport.wlt:330,1-337,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Subsection:: *)
(*Errors*)

(* ::**************************************************************************************************************:: *)
(* ::Subsection:: *)
(*Applications*)


(* ::**************************************************************************************************************:: *)
(* ::Subsection:: *)
(*Properties and Relations*)
VerificationTest[
    FITImport[ "ComputationalFitness/ExampleData/BikeRide.fit", "MessageCounts" ],
    KeyValuePattern[ "Record" -> 11376 ],
    SameTest -> MatchQ,
    TestID   -> "PropertiesAndRelations-1@@Tests/FITImport.wlt:351,1-356,2"
]

VerificationTest[
    Total @ Select[
        FITImport[ "ComputationalFitness/ExampleData/BikeRide.fit", "MessageInformation" ],
        #Supported &
    ][ All, "Count" ],
    Length @ FITImport[ "ComputationalFitness/ExampleData/BikeRide.fit", "RawData" ],
    SameTest -> MatchQ,
    TestID   -> "PropertiesAndRelations-2@@Tests/FITImport.wlt:358,1-366,2"
]

VerificationTest[
    FITImport[ "ComputationalFitness/ExampleData/Walk.fit", "Session" ][ 1 ][ "AverageCadence" ],
    Quantity[ _, "Steps"/"Minutes" ],
    SameTest -> MatchQ,
    TestID   -> "PropertiesAndRelations-3@@Tests/FITImport.wlt:368,1-373,2"
]

VerificationTest[
    FITImport[ "ComputationalFitness/ExampleData/BikeRide.fit", "Session" ][ 1 ][ "AverageCadence" ],
    Quantity[ _, "Revolutions"/"Minutes" ],
    SameTest -> MatchQ,
    TestID   -> "PropertiesAndRelations-4@@Tests/FITImport.wlt:375,1-380,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Subsection:: *)
(*Possible Issues*)


(* ::**************************************************************************************************************:: *)
(* ::Subsection:: *)
(*Neat Examples*)

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Example Data*)
VerificationTest[
    $exampleDir = DirectoryName @ FindFile[ "ComputationalFitness/ExampleData/BikeRide.fit" ],
    _? DirectoryQ,
    SameTest -> MatchQ,
    TestID   -> "ExampleData-1@@Tests/FITImport.wlt:394,1-399,2"
]

VerificationTest[
    StringStartsQ[ $exampleDir, $pacletDir ],
    True,
    SameTest -> MatchQ,
    TestID   -> "ExampleData-2@@Tests/FITImport.wlt:401,1-406,2"
]

VerificationTest[
    $exampleFiles = FileNames[ "*.fit", $exampleDir ],
    { Repeated[ _String, { 5, Infinity } ] },
    SameTest -> MatchQ,
    TestID   -> "ExampleData-3@@Tests/FITImport.wlt:408,1-413,2"
]

VerificationTest[
    FindFile[ "ComputationalFitness/ExampleData/BikeRide.fit" ],
    _? FileExistsQ,
    SameTest -> MatchQ,
    TestID   -> "ExampleData-4@@Tests/FITImport.wlt:415,1-420,2"
]

VerificationTest[
    (FITImport[ FileNameTake[ #, -3 ], "MessageCounts" ] &) /@ $exampleFiles,
    { __Association? AssociationQ },
    SameTest -> MatchQ,
    TestID   -> "ExampleData-5@@Tests/FITImport.wlt:422,1-427,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Subsection:: *)
(*Error Cases*)


(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Cleanup*)


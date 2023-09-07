(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Initialization*)
VerificationTest[
    $pacletDir =
        Module[ { root, mx },
            root = DirectoryName[ $TestFileName, 2 ];
            mx = FileNameJoin @ { root, "MXBuild", "RH__ComputationalFitness" };
            If[ DirectoryQ @ mx,
                PacletDirectoryUnload @ root; mx,
                root
            ]
        ],
    _? DirectoryQ,
    SameTest -> MatchQ,
    TestID   -> "Initialize-PacletDirectory@@Tests/FITImport.wlt:4,1-17,2"
]

Print[ "::notice::", "Paclet directory: ", $pacletDir, "\n" ];
Print[ "::notice::", "Paclet files: ", FileNames[ All, $pacletDir, Infinity ], "\n" ];

VerificationTest[
    $paclet = PacletObject @ File[ $pacletDir ],
    _? PacletObjectQ,
    SameTest -> MatchQ,
    TestID   -> "Initialize-PacletObject@@Tests/FITImport.wlt:22,1-27,2"
]

VerificationTest[
    PacletDirectoryLoad @ $pacletDir,
    { ___, $pacletDir, ___ },
    SameTest -> MatchQ,
    TestID   -> "Initialize-PacletDirectoryLoad@@Tests/FITImport.wlt:29,1-34,2"
]

Print[ "::notice::", "FindFile: ", FindFile[ "RH`ComputationalFitness`" ], "\n" ];

VerificationTest[
    Get[ "RH`ComputationalFitness`" ],
    Null,
    SameTest -> MatchQ,
    TestID   -> "Initialize-Get-ComputationalFitness@@Tests/FITImport.wlt:38,1-43,2"
]

VerificationTest[
    {
        Context @ FITImport,
        Context @ FitnessData,
        Context @ FitnessDataQ
    },
    ConstantArray[ "RH`ComputationalFitness`", 3 ],
    SameTest -> MatchQ,
    TestID   -> "Initialize-Context@@Tests/FITImport.wlt:45,1-54,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Section:: *)
(*Tests*)

(* ::**************************************************************************************************************:: *)
(* ::Subsection:: *)
(*Basic Examples*)
VerificationTest[
    Quiet[
        FITImport[ "RH/ComputationalFitness/ExampleData/BikeRide.fit" ],
        FITImport::CompileOnDemand
    ],
    _FitnessData? FitnessDataQ,
    SameTest -> MatchQ,
    TestID -> "BasicExamples-1@@Tests/FITImport.wlt:63,1-71,2"
]

VerificationTest[
    session = FITImport[ "RH/ComputationalFitness/ExampleData/BikeRide.fit", "Session" ],
    _Dataset,
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-2@@Tests/FITImport.wlt:73,1-78,2"
]

VerificationTest[
    session1 = session[ 1 ],
    _Dataset,
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-3@@Tests/FITImport.wlt:80,1-85,2"
]

VerificationTest[
    Normal @ session1,
    KeyValuePattern @ {
        "AverageAscentSpeed"                      -> _Quantity,
        "AverageCadence"                          -> _Quantity,
        "AverageCadencePosition"                  -> { _Quantity, _Quantity },
        "AverageHeartRate"                        -> _Quantity,
        "AverageLeftPowerPhaseEnd"                -> _Quantity,
        "AverageLeftPowerPhasePeakEnd"            -> _Quantity,
        "AverageLeftPowerPhasePeakStart"          -> _Quantity,
        "AverageLeftPowerPhaseStart"              -> _Quantity,
        "AveragePower"                            -> _Quantity,
        "AveragePowerPosition"                    -> { _Quantity, _Quantity },
        "AverageRightPowerPhaseEnd"               -> _Quantity,
        "AverageRightPowerPhasePeakEnd"           -> _Quantity,
        "AverageRightPowerPhasePeakStart"         -> _Quantity,
        "AverageRightPowerPhaseStart"             -> _Quantity,
        "AverageSpeed"                            -> _Quantity,
        "AverageTemperature"                      -> _Quantity,
        "Event"                                   -> _String,
        "EventType"                               -> _String,
        "FirstLapIndex"                           -> _Integer,
        "GeoBoundingBox"                          -> { _GeoPosition, _GeoPosition },
        "IntensityFactor"                         -> _Real,
        "LeftRightBalance"                        -> { _Quantity, _Quantity },
        "MaximumCadence"                          -> _Quantity,
        "MaximumCadencePosition"                  -> { _Quantity, _Quantity },
        "MaximumHeartRate"                        -> _Quantity,
        "MaximumPower"                            -> _Quantity,
        "MaximumPowerPosition"                    -> { _Quantity, _Quantity },
        "MaximumSpeed"                            -> _Quantity,
        "MaximumTemperature"                      -> _Quantity,
        "NormalizedPower"                         -> _Quantity,
        "NumberOfLaps"                            -> _Integer,
        "Sport"                                   -> _String,
        "StandCount"                              -> _Integer,
        "StartPosition"                           -> _GeoPosition,
        "StartTime"                               -> _DateObject,
        "SubSport"                                -> _String,
        "ThresholdPower"                          -> _Quantity,
        "Timestamp"                               -> _DateObject,
        "TimeStanding"                            -> _Quantity,
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
        "TrainingLoadPeak"                        -> _Integer,
        "TrainingStressScore"                     -> _Real,
        "Trigger"                                 -> _String
    },
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-4@@Tests/FITImport.wlt:87,1-147,2"
]

VerificationTest[
    pos = FITImport[ "RH/ComputationalFitness/ExampleData/BikeRide.fit", "GeoPosition" ],
    _TemporalData,
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-5@@Tests/FITImport.wlt:149,1-154,2"
]

VerificationTest[
    Values @ pos,
    { __GeoPosition },
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-6@@Tests/FITImport.wlt:156,1-161,2"
]

VerificationTest[
    DateListPlot @ FITImport[ "RH/ComputationalFitness/ExampleData/BikeHillClimb.fit", "Altitude" ],
    _Graphics,
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-7@@Tests/FITImport.wlt:163,1-168,2"
]

VerificationTest[
    FITImport[ "RH/ComputationalFitness/ExampleData/IndoorIntervals.fit", "PowerZonePlot" ],
    _Legended,
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-8@@Tests/FITImport.wlt:170,1-175,2"
]

VerificationTest[
    FITImport[ "RH/ComputationalFitness/ExampleData/BikeLaps.fit", "AveragePowerPhasePlot" ],
    _Graphics,
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-9@@Tests/FITImport.wlt:177,1-182,2"
]

VerificationTest[
    FITImport[ "RH/ComputationalFitness/ExampleData/BikeLaps.fit", "CriticalPowerCurvePlot" ],
    _Graphics,
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-10@@Tests/FITImport.wlt:184,1-189,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Subsection:: *)
(*Scope*)
VerificationTest[
    devices = FITImport[ "RH/ComputationalFitness/ExampleData/BikeHillClimb.fit", "DeviceInformation" ],
    _Dataset,
    SameTest -> MatchQ,
    TestID   -> "Scope-1@@Tests/FITImport.wlt:194,1-199,2"
]

VerificationTest[
    FirstCase[ Normal @ devices, KeyValuePattern @ { "ProductName" -> "Edge830" } ],
    _Association,
    SameTest -> MatchQ,
    TestID   -> "Scope-2@@Tests/FITImport.wlt:201,1-206,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Subsection:: *)
(*Options*)

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*FunctionalThresholdPower*)

(* FIXME: these aren't working correctly *)
(* VerificationTest[
    oldFTP = PersistentSymbol[ "FITImport/FunctionalThresholdPower" ];
    If[ ! MissingQ @ oldFTP,
        Unset @ PersistentSymbol[ "FITImport/FunctionalThresholdPower" ]
    ],
    Null,
    SameTest -> MatchQ,
    TestID -> "Options/FunctionalThresholdPower-1@@Tests/FITImport.wlt:191,1-199,2"
]

VerificationTest[
    FITImport[ "RH/ComputationalFitness/ExampleData/ZwiftRide.fit", "PowerZone" ],
    _Missing,
    SameTest -> MatchQ,
    TestID   -> "Options-FunctionalThresholdPower-2@@Tests/FITImport.wlt:201,1-206,2"
]

VerificationTest[
    FITImport[
        "RH/ComputationalFitness/ExampleData/ZwiftRide.fit",
        "PowerZone",
        "FunctionalThresholdPower" -> Quantity[ 250, "Watts" ]
    ],
    _TemporalData,
    SameTest -> MatchQ,
    TestID   -> "Options-FunctionalThresholdPower-3@@Tests/FITImport.wlt:208,1-217,2"
]

VerificationTest[
    FITImport[ "RH/ComputationalFitness/ExampleData/ZwiftRide.fit", "PowerZonePlot" ],
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
    FITImport[ "RH/ComputationalFitness/ExampleData/ZwiftRide.fit", "PowerZone" ],
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
] *)

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*MaxHeartRate*)

(* FIXME: these aren't working correctly *)
(* VerificationTest[
    oldMaxHR = PersistentSymbol[ "FITImport/MaxHeartRate" ];
    If[ ! MissingQ @ oldMaxHR,
        Unset @ PersistentSymbol[ "FITImport/MaxHeartRate" ]
    ],
    Null,
    SameTest -> MatchQ,
    TestID   -> "Options-MaxHeartRate-1@@Tests/FITImport.wlt:253,1-261,2"
]

VerificationTest[
    FITImport[ "RH/ComputationalFitness/ExampleData/ZwiftRide.fit", "HeartRateZone" ],
    _Missing,
    SameTest -> MatchQ,
    TestID   -> "Options-MaxHeartRate-2@@Tests/FITImport.wlt:263,1-268,2"
]

VerificationTest[
    FITImport[
        "RH/ComputationalFitness/ExampleData/ZwiftRide.fit",
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
    FITImport[ "RH/ComputationalFitness/ExampleData/ZwiftRide.fit", "HeartRateZone" ],
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
] *)

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*UnitSystem*)
VerificationTest[
    FITImport[ "RH/ComputationalFitness/ExampleData/BikeHillClimb.fit", "Altitude", UnitSystem -> "Imperial" ][ "LastValue" ],
    Quantity[ _, "Feet" ],
    SameTest -> MatchQ,
    TestID   -> "Options-UnitSystem-1@@Tests/FITImport.wlt:335,1-340,2"
]

VerificationTest[
    FITImport[ "RH/ComputationalFitness/ExampleData/BikeHillClimb.fit", "Altitude", UnitSystem -> "Metric" ][ "LastValue" ],
    Quantity[ _, "Meters" ],
    SameTest -> MatchQ,
    TestID   -> "Options-UnitSystem-2@@Tests/FITImport.wlt:342,1-347,2"
]

VerificationTest[
    Block[ { $UnitSystem = "Imperial" },
        FITImport[ "RH/ComputationalFitness/ExampleData/BikeHillClimb.fit", "Altitude" ][ "LastValue" ]
    ],
    Quantity[ _, "Feet" ],
    SameTest -> MatchQ,
    TestID   -> "Options-UnitSystem-3@@Tests/FITImport.wlt:349,1-356,2"
]

VerificationTest[
    Block[ { $UnitSystem = "Metric" },
        FITImport[ "RH/ComputationalFitness/ExampleData/BikeHillClimb.fit", "Altitude" ][ "LastValue" ]
    ],
    Quantity[ _, "Meters" ],
    SameTest -> MatchQ,
    TestID   -> "Options-UnitSystem-4@@Tests/FITImport.wlt:358,1-365,2"
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
    FITImport[ "RH/ComputationalFitness/ExampleData/BikeRide.fit", "MessageCounts" ],
    KeyValuePattern[ "Record" -> 11376 ],
    SameTest -> MatchQ,
    TestID   -> "PropertiesAndRelations-1@@Tests/FITImport.wlt:379,1-384,2"
]

VerificationTest[
    Total @ Select[
        FITImport[ "RH/ComputationalFitness/ExampleData/BikeRide.fit", "MessageInformation" ],
        #Supported &
    ][ All, "Count" ],
    23149,
    SameTest -> GreaterEqual,
    TestID   -> "PropertiesAndRelations-2@@Tests/FITImport.wlt:386,1-394,2"
]

VerificationTest[
    FITImport[ "RH/ComputationalFitness/ExampleData/Walk.fit", "Session" ][ 1 ][ "AverageCadence" ],
    Quantity[ _, "Steps"/"Minutes" ],
    SameTest -> MatchQ,
    TestID   -> "PropertiesAndRelations-3@@Tests/FITImport.wlt:396,1-401,2"
]

VerificationTest[
    FITImport[ "RH/ComputationalFitness/ExampleData/BikeRide.fit", "Session" ][ 1 ][ "AverageCadence" ],
    Quantity[ _, "Revolutions"/"Minutes" ],
    SameTest -> MatchQ,
    TestID   -> "PropertiesAndRelations-4@@Tests/FITImport.wlt:403,1-408,2"
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
    $exampleDir = DirectoryName @ FindFile[ "RH/ComputationalFitness/ExampleData/BikeRide.fit" ],
    _? DirectoryQ,
    SameTest -> MatchQ,
    TestID   -> "ExampleData-1@@Tests/FITImport.wlt:422,1-427,2"
]

VerificationTest[
    StringStartsQ[ $exampleDir, $pacletDir ],
    True,
    SameTest -> MatchQ,
    TestID   -> "ExampleData-2@@Tests/FITImport.wlt:429,1-434,2"
]

VerificationTest[
    $exampleFiles = FileNames[ "*.fit", $exampleDir ],
    { Repeated[ _String, { 5, Infinity } ] },
    SameTest -> MatchQ,
    TestID   -> "ExampleData-3@@Tests/FITImport.wlt:436,1-441,2"
]

VerificationTest[
    FindFile[ "RH/ComputationalFitness/ExampleData/BikeRide.fit" ],
    _? FileExistsQ,
    SameTest -> MatchQ,
    TestID   -> "ExampleData-4@@Tests/FITImport.wlt:443,1-448,2"
]

VerificationTest[
    (FITImport[ FileNameTake[ #, -3 ], "MessageCounts" ] &) /@ $exampleFiles,
    { __Association? AssociationQ },
    SameTest -> MatchQ,
    TestID   -> "ExampleData-5@@Tests/FITImport.wlt:450,1-455,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Subsection:: *)
(*Error Cases*)


(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Cleanup*)


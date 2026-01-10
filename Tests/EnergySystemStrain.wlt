(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Initialization*)
VerificationTest[
    $pacletDir =
        Module[ { root, build },
            root = DirectoryName[ $TestFileName, 2 ];
            build = FileNameJoin @ { root, "build", "RickHennigan__ComputationalFitness" };
            If[ DirectoryQ @ build,
                PacletDirectoryUnload @ root; build,
                root
            ]
        ],
    _? DirectoryQ,
    SameTest -> MatchQ,
    TestID   -> "Initialize-PacletDirectory@@Tests/EnergySystemStrain.wlt:4,1-17,2"
]

VerificationTest[
    $paclet = PacletObject @ File[ $pacletDir ],
    _? PacletObjectQ,
    SameTest -> MatchQ,
    TestID   -> "Initialize-PacletObject@@Tests/EnergySystemStrain.wlt:19,1-24,2"
]

VerificationTest[
    PacletDirectoryLoad @ $pacletDir,
    { ___, $pacletDir, ___ },
    SameTest -> MatchQ,
    TestID   -> "Initialize-PacletDirectoryLoad@@Tests/EnergySystemStrain.wlt:26,1-31,2"
]

VerificationTest[
    Get[ "RickHennigan`ComputationalFitness`" ],
    Null,
    SameTest -> MatchQ,
    TestID   -> "Initialize-Get-ComputationalFitness@@Tests/EnergySystemStrain.wlt:33,1-38,2"
]

VerificationTest[
    Context @ EnergySystemStrain,
    "RickHennigan`ComputationalFitness`",
    SameTest -> MatchQ,
    TestID   -> "Initialize-Context@@Tests/EnergySystemStrain.wlt:40,1-45,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Section:: *)
(*Tests*)

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Basic Examples*)

(* Test with file input and parameter association *)
VerificationTest[
    $params = <|
        "CriticalPower" -> 250,
        "AnaerobicWorkCapacity" -> 20,
        "MaximalInstantaneousPower" -> 1200
    |>;
    EnergySystemStrain[ File[ "ExampleData/BikeRide.fit" ], $params ],
    _Association,
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-1@@Tests/EnergySystemStrain.wlt:56,1-66,2"
]

(* Test return structure has all required keys *)
VerificationTest[
    $result = EnergySystemStrain[ File[ "ExampleData/BikeRide.fit" ], $params ];
    Sort @ Keys @ $result,
    { "Glycolytic", "Oxidative", "Phosphocreatine", "Total" },
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-2@@Tests/EnergySystemStrain.wlt:69,1-75,2"
]

(* Test with FitnessData input *)
VerificationTest[
    $fitnessData = FITImport[ "ExampleData/BikeRide.fit" ];
    EnergySystemStrain[ $fitnessData, $params ],
    _Association,
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-3@@Tests/EnergySystemStrain.wlt:78,1-84,2"
]

(* Test with TemporalData input *)
VerificationTest[
    $powerData = FITImport[ "ExampleData/BikeRide.fit", "Power" ];
    EnergySystemStrain[ $powerData, $params ],
    _Association,
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-4@@Tests/EnergySystemStrain.wlt:87,1-93,2"
]

(* Test with QuantityArray input *)
VerificationTest[
    $resampled = TimeSeriesResample[ $powerData, 1 ];
    $values = $resampled[ "Values" ];
    EnergySystemStrain[ $values, $params ],
    _Association,
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-5@@Tests/EnergySystemStrain.wlt:96,1-103,2"
]

(* Test with List input (machine reals) *)
VerificationTest[
    $power = N @ QuantityMagnitude @ UnitConvert[ $values, "Watts" ];
    EnergySystemStrain[ $power, $params ],
    _Association,
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-6@@Tests/EnergySystemStrain.wlt:106,1-112,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Properties & Relations*)

(* Total strain should equal sum of system-specific strains *)
VerificationTest[
    $strain = EnergySystemStrain[ File[ "ExampleData/BikeRide.fit" ], $params ];
    Abs[ $strain[ "Total" ] - ($strain[ "Oxidative" ] + $strain[ "Glycolytic" ] + $strain[ "Phosphocreatine" ]) ] < 0.001,
    True,
    SameTest -> MatchQ,
    TestID   -> "PropertiesRelations-1@@Tests/EnergySystemStrain.wlt:119,1-125,2"
]

(* All strain values should be non-negative *)
VerificationTest[
    $strain = EnergySystemStrain[ File[ "ExampleData/BikeRide.fit" ], $params ];
    AllTrue[ Values @ $strain, # >= 0 & ],
    True,
    SameTest -> MatchQ,
    TestID   -> "PropertiesRelations-2@@Tests/EnergySystemStrain.wlt:128,1-134,2"
]

(* Higher power should generally result in higher strain *)
VerificationTest[
    $lowPower = ConstantArray[ 100.0, 3600 ];
    $highPower = ConstantArray[ 300.0, 3600 ];
    $strainLow = EnergySystemStrain[ $lowPower, $params ];
    $strainHigh = EnergySystemStrain[ $highPower, $params ];
    $strainHigh[ "Total" ] > $strainLow[ "Total" ],
    True,
    SameTest -> MatchQ,
    TestID   -> "PropertiesRelations-3@@Tests/EnergySystemStrain.wlt:137,1-146,2"
]

(* Power below CP should have zero glycolytic and phosphocreatine strain *)
VerificationTest[
    $belowCP = ConstantArray[ 200.0, 3600 ];
    $strain = EnergySystemStrain[ $belowCP, $params ];
    $strain[ "Glycolytic" ] < 0.001 && $strain[ "Phosphocreatine" ] < 0.001,
    True,
    SameTest -> MatchQ,
    TestID   -> "PropertiesRelations-4@@Tests/EnergySystemStrain.wlt:149,1-156,2"
]

(* Power above CP should have non-zero glycolytic and/or phosphocreatine strain *)
VerificationTest[
    $aboveCP = ConstantArray[ 400.0, 600 ];
    $strain = EnergySystemStrain[ $aboveCP, $params ];
    $strain[ "Glycolytic" ] > 0 || $strain[ "Phosphocreatine" ] > 0,
    True,
    SameTest -> MatchQ,
    TestID   -> "PropertiesRelations-5@@Tests/EnergySystemStrain.wlt:159,1-166,2"
]

(* Test with parameter estimation from MMP curve *)
VerificationTest[
    $mmpCurve = MeanMaximalPowerCurve @ File[ "ExampleData/BikeRide.fit" ];
    If[ MissingQ @ $mmpCurve,
        Missing[ "NotAvailable" ],
        $estimatedParams = EstimateCriticalPowerParameters @ $mmpCurve;
        EnergySystemStrain[ File[ "ExampleData/BikeRide.fit" ], $estimatedParams ]
    ],
    _Association | _Missing,
    SameTest -> MatchQ,
    TestID   -> "PropertiesRelations-6@@Tests/EnergySystemStrain.wlt:169,1-179,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Parameter Validation*)

(* Invalid CP (negative) *)
VerificationTest[
    EnergySystemStrain[
        ConstantArray[ 200.0, 100 ],
        <| "CriticalPower" -> -250, "AnaerobicWorkCapacity" -> 20, "MaximalInstantaneousPower" -> 1200 |>
    ],
    _Failure,
    SameTest -> MatchQ,
    TestID   -> "ParameterValidation-1@@Tests/EnergySystemStrain.wlt:186,1-194,2"
]

(* Invalid W' (negative) *)
VerificationTest[
    EnergySystemStrain[
        ConstantArray[ 200.0, 100 ],
        <| "CriticalPower" -> 250, "AnaerobicWorkCapacity" -> -20, "MaximalInstantaneousPower" -> 1200 |>
    ],
    _Failure,
    SameTest -> MatchQ,
    TestID   -> "ParameterValidation-2@@Tests/EnergySystemStrain.wlt:197,1-205,2"
]

(* Invalid PMax (less than CP) *)
VerificationTest[
    EnergySystemStrain[
        ConstantArray[ 200.0, 100 ],
        <| "CriticalPower" -> 250, "AnaerobicWorkCapacity" -> 20, "MaximalInstantaneousPower" -> 200 |>
    ],
    _Failure,
    SameTest -> MatchQ,
    TestID   -> "ParameterValidation-3@@Tests/EnergySystemStrain.wlt:208,1-216,2"
]

(* Valid parameters with units *)
VerificationTest[
    EnergySystemStrain[
        ConstantArray[ 200.0, 100 ],
        <|
            "CriticalPower" -> Quantity[ 250, "Watts" ],
            "AnaerobicWorkCapacity" -> Quantity[ 20, "Kilojoules" ],
            "MaximalInstantaneousPower" -> Quantity[ 1200, "Watts" ]
        |>
    ],
    _Association,
    SameTest -> MatchQ,
    TestID   -> "ParameterValidation-4@@Tests/EnergySystemStrain.wlt:219,1-231,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Possible Issues*)

(* Missing power data in file *)
VerificationTest[
    EnergySystemStrain[ File[ "ExampleData/Walk.fit" ], $params ],
    _Failure,
    SameTest -> MatchQ,
    TestID   -> "PossibleIssues-1@@Tests/EnergySystemStrain.wlt:238,1-243,2"
]

(* Empty power array *)
VerificationTest[
    EnergySystemStrain[ {}, $params ],
    _Association,
    SameTest -> MatchQ,
    TestID   -> "PossibleIssues-2@@Tests/EnergySystemStrain.wlt:246,1-251,2"
]

(* Single power value *)
VerificationTest[
    EnergySystemStrain[ { 200.0 }, $params ],
    _Association,
    SameTest -> MatchQ,
    TestID   -> "PossibleIssues-3@@Tests/EnergySystemStrain.wlt:254,1-259,2"
]

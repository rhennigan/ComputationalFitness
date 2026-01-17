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
    TestID   -> "Initialize-PacletDirectory@@Tests/EstimateCriticalPowerParameters.wlt:4,1-17,2"
]

VerificationTest[
    $paclet = PacletObject @ File[ $pacletDir ],
    _? PacletObjectQ,
    SameTest -> MatchQ,
    TestID   -> "Initialize-PacletObject@@Tests/EstimateCriticalPowerParameters.wlt:19,1-24,2"
]

VerificationTest[
    PacletDirectoryLoad @ $pacletDir,
    { ___, $pacletDir, ___ },
    SameTest -> MatchQ,
    TestID   -> "Initialize-PacletDirectoryLoad@@Tests/EstimateCriticalPowerParameters.wlt:26,1-31,2"
]

VerificationTest[
    Get[ "RickHennigan`ComputationalFitness`" ],
    Null,
    SameTest -> MatchQ,
    TestID   -> "Initialize-Get-ComputationalFitness@@Tests/EstimateCriticalPowerParameters.wlt:33,1-38,2"
]

VerificationTest[
    Context @ EstimateCriticalPowerParameters,
    "RickHennigan`ComputationalFitness`",
    SameTest -> MatchQ,
    TestID   -> "Initialize-Context@@Tests/EstimateCriticalPowerParameters.wlt:40,1-45,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Section:: *)
(*Tests*)

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Basic Examples*)
VerificationTest[
    EstimateCriticalPowerParameters @ File[ "ExampleData/BikeRide.fit" ],
    _Association,
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-File@@Tests/EstimateCriticalPowerParameters.wlt:54,1-59,2"
]

VerificationTest[
    EstimateCriticalPowerParameters @ FITImport[ "ExampleData/BikeRide.fit" ],
    _Association,
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-FitnessData@@Tests/EstimateCriticalPowerParameters.wlt:61,1-66,2"
]

VerificationTest[
    EstimateCriticalPowerParameters @ FITImport[ "ExampleData/BikeRide.fit", "Power" ],
    _Association,
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-TemporalData@@Tests/EstimateCriticalPowerParameters.wlt:68,1-73,2"
]

VerificationTest[
    EstimateCriticalPowerParameters @ MeanMaximalPowerCurve @ File[ "ExampleData/BikeRide.fit" ],
    _Association,
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-QuantityArray@@Tests/EstimateCriticalPowerParameters.wlt:75,1-80,2"
]

VerificationTest[
    EstimateCriticalPowerParameters @ { File[ "ExampleData/BikeRide.fit" ], File[ "ExampleData/BikeLaps.fit" ] },
    _Association,
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-MultipleFiles@@Tests/EstimateCriticalPowerParameters.wlt:82,1-87,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Properties & Relations*)
VerificationTest[
    Keys @ EstimateCriticalPowerParameters @ File[ "ExampleData/BikeRide.fit" ],
    { "AnaerobicWorkCapacity", "CriticalPower", "MaximalInstantaneousPower" },
    SameTest -> MatchQ,
    TestID   -> "PropertiesRelations-Keys@@Tests/EstimateCriticalPowerParameters.wlt:92,1-97,2"
]

VerificationTest[
    params = EstimateCriticalPowerParameters @ File[ "ExampleData/BikeRide.fit" ];
    QuantityQ @ params[ "AnaerobicWorkCapacity" ],
    True,
    SameTest -> MatchQ,
    TestID   -> "PropertiesRelations-WPrimeIsQuantity@@Tests/EstimateCriticalPowerParameters.wlt:99,1-105,2"
]

VerificationTest[
    params = EstimateCriticalPowerParameters @ File[ "ExampleData/BikeRide.fit" ];
    QuantityQ @ params[ "CriticalPower" ],
    True,
    SameTest -> MatchQ,
    TestID   -> "PropertiesRelations-CPIsQuantity@@Tests/EstimateCriticalPowerParameters.wlt:107,1-113,2"
]

VerificationTest[
    params = EstimateCriticalPowerParameters @ File[ "ExampleData/BikeRide.fit" ];
    QuantityQ @ params[ "MaximalInstantaneousPower" ],
    True,
    SameTest -> MatchQ,
    TestID   -> "PropertiesRelations-PMaxIsQuantity@@Tests/EstimateCriticalPowerParameters.wlt:115,1-121,2"
]

VerificationTest[
    params = EstimateCriticalPowerParameters @ File[ "ExampleData/BikeRide.fit" ];
    CompatibleUnitQ[ params[ "AnaerobicWorkCapacity" ], "Kilojoules" ],
    True,
    SameTest -> MatchQ,
    TestID   -> "PropertiesRelations-WPrimeUnits@@Tests/EstimateCriticalPowerParameters.wlt:123,1-129,2"
]

VerificationTest[
    params = EstimateCriticalPowerParameters @ File[ "ExampleData/BikeRide.fit" ];
    CompatibleUnitQ[ params[ "CriticalPower" ], "Watts" ],
    True,
    SameTest -> MatchQ,
    TestID   -> "PropertiesRelations-CPUnits@@Tests/EstimateCriticalPowerParameters.wlt:131,1-137,2"
]

VerificationTest[
    params = EstimateCriticalPowerParameters @ File[ "ExampleData/BikeRide.fit" ];
    CompatibleUnitQ[ params[ "MaximalInstantaneousPower" ], "Watts" ],
    True,
    SameTest -> MatchQ,
    TestID   -> "PropertiesRelations-PMaxUnits@@Tests/EstimateCriticalPowerParameters.wlt:139,1-145,2"
]

VerificationTest[
    params = EstimateCriticalPowerParameters @ File[ "ExampleData/BikeRide.fit" ];
    pMax = QuantityMagnitude @ UnitConvert[ params[ "MaximalInstantaneousPower" ], "Watts" ];
    cp = QuantityMagnitude @ UnitConvert[ params[ "CriticalPower" ], "Watts" ];
    pMax > cp,
    True,
    SameTest -> MatchQ,
    TestID   -> "PropertiesRelations-PMaxGreaterThanCP@@Tests/EstimateCriticalPowerParameters.wlt:147,1-155,2"
]

VerificationTest[
    params = EstimateCriticalPowerParameters @ File[ "ExampleData/BikeRide.fit" ];
    wPrime = QuantityMagnitude @ UnitConvert[ params[ "AnaerobicWorkCapacity" ], "Kilojoules" ];
    wPrime > 0,
    True,
    SameTest -> MatchQ,
    TestID   -> "PropertiesRelations-WPrimePositive@@Tests/EstimateCriticalPowerParameters.wlt:157,1-164,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Possible Issues*)
VerificationTest[
    EstimateCriticalPowerParameters @ File[ "ExampleData/Walk.fit" ],
    _Failure,
    { ComputationalFitness::Internal },
    SameTest -> MatchQ,
    TestID   -> "PossibleIssues-NoPowerData@@Tests/EstimateCriticalPowerParameters.wlt:169,1-175,2"
]

VerificationTest[
    EstimateCriticalPowerParameters @ QuantityArray[ ConstantArray[ 100.0, 5 ], "Watts" ],
    _Failure,
    { EstimateCriticalPowerParameters::InsufficientData },
    SameTest -> MatchQ,
    TestID   -> "PossibleIssues-TooFewPoints@@Tests/EstimateCriticalPowerParameters.wlt:177,1-183,2"
]

VerificationTest[
    EstimateCriticalPowerParameters @ "NonExistentFile.fit",
    _Failure,
    { EstimateCriticalPowerParameters::InvalidArguments },
    SameTest -> MatchQ,
    TestID   -> "PossibleIssues-InvalidFile@@Tests/EstimateCriticalPowerParameters.wlt:185,1-191,2"
]

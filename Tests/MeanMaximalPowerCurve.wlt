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
    TestID   -> "Initialize-PacletDirectory@@Tests/MeanMaximalPowerCurve.wlt:4,1-17,2"
]

VerificationTest[
    $paclet = PacletObject @ File[ $pacletDir ],
    _? PacletObjectQ,
    SameTest -> MatchQ,
    TestID   -> "Initialize-PacletObject@@Tests/MeanMaximalPowerCurve.wlt:19,1-24,2"
]

VerificationTest[
    PacletDirectoryLoad @ $pacletDir,
    { ___, $pacletDir, ___ },
    SameTest -> MatchQ,
    TestID   -> "Initialize-PacletDirectoryLoad@@Tests/MeanMaximalPowerCurve.wlt:26,1-31,2"
]

VerificationTest[
    Get[ "RickHennigan`ComputationalFitness`" ],
    Null,
    SameTest -> MatchQ,
    TestID   -> "Initialize-Get-ComputationalFitness@@Tests/MeanMaximalPowerCurve.wlt:33,1-38,2"
]

VerificationTest[
    Context @ MeanMaximalPowerCurve,
    "RickHennigan`ComputationalFitness`",
    SameTest -> MatchQ,
    TestID   -> "Initialize-Context@@Tests/MeanMaximalPowerCurve.wlt:40,1-45,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Section:: *)
(*Tests*)

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Basic Examples*)
VerificationTest[
    MeanMaximalPowerCurve @ File[ "ExampleData/BikeRide.fit" ],
    _QuantityArray,
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-1@@Tests/MeanMaximalPowerCurve.wlt:54,1-59,2"
]

VerificationTest[
    MeanMaximalPowerCurve @ FITImport[ "ExampleData/BikeRide.fit" ],
    _QuantityArray,
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-2@@Tests/MeanMaximalPowerCurve.wlt:61,1-66,2"
]

VerificationTest[
    MeanMaximalPowerCurve @ FITImport[ "ExampleData/BikeRide.fit", "Power" ],
    _QuantityArray,
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-3@@Tests/MeanMaximalPowerCurve.wlt:68,1-73,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Properties & Relations*)
VerificationTest[
    MeanMaximalPowerCurve[ File[ "ExampleData/BikeLaps.fit" ] ][[ 60 ]],
    N @ Max @ MovingMap[ Mean, FITImport[ "ExampleData/BikeLaps.fit", "Power" ], Quantity[ 59, "Seconds" ] ],
    SameTest -> MatchQ,
    TestID   -> "PropertiesRelations-1@@Tests/MeanMaximalPowerCurve.wlt:78,1-83,2"
]

VerificationTest[
    FITImport[ "ExampleData/BikeLaps.fit", "MeanMaximalPowerCurvePlot" ],
    _Graphics,
    SameTest -> MatchQ,
    TestID   -> "PropertiesRelations-2@@Tests/MeanMaximalPowerCurve.wlt:85,1-90,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Possible Issues*)
VerificationTest[
    MeanMaximalPowerCurve @ File[ "ExampleData/Walk.fit" ],
    _Missing,
    SameTest -> MatchQ,
    TestID   -> "PossibleIssues-1@@Tests/MeanMaximalPowerCurve.wlt:95,1-100,2"
]
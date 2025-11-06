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
    TestID   -> "Initialize-PacletDirectory@@Tests/MeanMaximalPowerCurvePlot.wlt:4,1-17,2"
]

VerificationTest[
    $paclet = PacletObject @ File[ $pacletDir ],
    _? PacletObjectQ,
    SameTest -> MatchQ,
    TestID   -> "Initialize-PacletObject@@Tests/MeanMaximalPowerCurvePlot.wlt:19,1-24,2"
]

VerificationTest[
    PacletDirectoryLoad @ $pacletDir,
    { ___, $pacletDir, ___ },
    SameTest -> MatchQ,
    TestID   -> "Initialize-PacletDirectoryLoad@@Tests/MeanMaximalPowerCurvePlot.wlt:26,1-31,2"
]

VerificationTest[
    Get[ "RickHennigan`ComputationalFitness`" ],
    Null,
    SameTest -> MatchQ,
    TestID   -> "Initialize-Get-ComputationalFitness@@Tests/MeanMaximalPowerCurvePlot.wlt:33,1-38,2"
]

VerificationTest[
    Context @ MeanMaximalPowerCurvePlot,
    "RickHennigan`ComputationalFitness`",
    SameTest -> MatchQ,
    TestID   -> "Initialize-Context@@Tests/MeanMaximalPowerCurvePlot.wlt:40,1-45,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Section:: *)
(*Tests*)

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Basic Examples*)
VerificationTest[
    MeanMaximalPowerCurvePlot @ File[ "ExampleData/BikeRide.fit" ],
    _Graphics,
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-1@@Tests/MeanMaximalPowerCurvePlot.wlt:54,1-59,2"
]

VerificationTest[
    MeanMaximalPowerCurvePlot @ FITImport[ "ExampleData/BikeRide.fit" ],
    _Graphics,
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-2@@Tests/MeanMaximalPowerCurvePlot.wlt:61,1-66,2"
]

VerificationTest[
    MeanMaximalPowerCurvePlot @ FITImport[ "ExampleData/BikeRide.fit", "Power" ],
    _Graphics,
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-3@@Tests/MeanMaximalPowerCurvePlot.wlt:68,1-73,2"
]

VerificationTest[
    MeanMaximalPowerCurvePlot @ MeanMaximalPowerCurve @ File[ "ExampleData/BikeRide.fit" ],
    _Graphics,
    SameTest -> MatchQ,
    TestID   -> "BasicExamples-4@@Tests/MeanMaximalPowerCurvePlot.wlt:75,1-80,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Options*)
VerificationTest[
    plot = MeanMaximalPowerCurvePlot[
        File[ "ExampleData/BikeRide.fit" ],
        PlotLabel -> "Test Label"
    ];
    Options[ plot, PlotLabel ],
    { PlotLabel -> "Test Label" },
    SameTest -> MatchQ,
    TestID   -> "Options-1@@Tests/MeanMaximalPowerCurvePlot.wlt:85,1-94,2"
]

VerificationTest[
    plot = MeanMaximalPowerCurvePlot[
        File[ "ExampleData/BikeRide.fit" ],
        PlotStyle -> Red
    ];
    Head @ plot,
    Graphics,
    SameTest -> MatchQ,
    TestID   -> "Options-2@@Tests/MeanMaximalPowerCurvePlot.wlt:96,1-105,2"
]

VerificationTest[
    plot = MeanMaximalPowerCurvePlot[
        File[ "ExampleData/BikeRide.fit" ],
        ImageSize -> 500
    ];
    AbsoluteOptions[ plot, ImageSize ],
    { ImageSize -> { 500., _?NumericQ } },
    SameTest -> MatchQ,
    TestID   -> "Options-3@@Tests/MeanMaximalPowerCurvePlot.wlt:107,1-116,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Properties & Relations*)
VerificationTest[
    AbsoluteOptions[
        MeanMaximalPowerCurvePlot @ File[ "ExampleData/BikeRide.fit" ],
        AspectRatio
    ],
    { AspectRatio -> 0.2 },
    SameTest -> MatchQ,
    TestID   -> "PropertiesRelations-1@@Tests/MeanMaximalPowerCurvePlot.wlt:121,1-129,2"
]

VerificationTest[
    plot = MeanMaximalPowerCurvePlot @ File[ "ExampleData/BikeRide.fit" ];
    AbsoluteOptions[ plot, PlotRange ],
    { PlotRange -> { { _?NumericQ, _?Positive }, { _?NumericQ, _?NumericQ } } },
    SameTest -> MatchQ,
    TestID   -> "PropertiesRelations-2@@Tests/MeanMaximalPowerCurvePlot.wlt:131,1-137,2"
]

VerificationTest[
    FITImport[ "ExampleData/BikeLaps.fit", "MeanMaximalPowerCurvePlot" ],
    _Graphics,
    SameTest -> MatchQ,
    TestID   -> "PropertiesRelations-3@@Tests/MeanMaximalPowerCurvePlot.wlt:139,1-144,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Multiple Sources*)
VerificationTest[
    MeanMaximalPowerCurvePlot @ {
        File[ "ExampleData/BikeRide.fit" ],
        File[ "ExampleData/BikeLaps.fit" ]
    },
    _Graphics,
    SameTest -> MatchQ,
    TestID   -> "MultipleSources-1@@Tests/MeanMaximalPowerCurvePlot.wlt:149,1-157,2"
]

(* Multiple TemporalData sources *)
VerificationTest[
    MeanMaximalPowerCurvePlot @ {
        FITImport[ "ExampleData/BikeRide.fit" ],
        FITImport[ "ExampleData/BikeLaps.fit" ]
    },
    _Graphics,
    SameTest -> MatchQ,
    TestID   -> "MultipleSources-2@@Tests/MeanMaximalPowerCurvePlot.wlt:160,1-168,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Input Types*)
VerificationTest[
    MeanMaximalPowerCurvePlot @ QuantityArray[ { 100, 200, 150, 175 }, "Watts" ],
    _Graphics,
    SameTest -> MatchQ,
    TestID   -> "InputTypes-1@@Tests/MeanMaximalPowerCurvePlot.wlt:173,1-178,2"
]

VerificationTest[
    MeanMaximalPowerCurvePlot @ { 100.0, 200.0, 150.0, 175.0 },
    _Graphics,
    SameTest -> MatchQ,
    TestID   -> "InputTypes-2@@Tests/MeanMaximalPowerCurvePlot.wlt:180,1-185,2"
]

VerificationTest[
    powerTS = TimeSeries[
        QuantityArray[ { 100, 200, 150, 175, 190 }, "Watts" ],
        { Range[ 5 ] }
    ];
    MeanMaximalPowerCurvePlot @ powerTS,
    _Graphics,
    SameTest -> MatchQ,
    TestID   -> "InputTypes-3@@Tests/MeanMaximalPowerCurvePlot.wlt:187,1-196,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Edge Cases*)
VerificationTest[
    mmp = MeanMaximalPowerCurve @ { 100.0 };
    MeanMaximalPowerCurvePlot @ mmp,
    _Graphics,
    SameTest -> MatchQ,
    TestID   -> "EdgeCases-1@@Tests/MeanMaximalPowerCurvePlot.wlt:201,1-207,2"
]

VerificationTest[
    MeanMaximalPowerCurvePlot @ QuantityArray[ { 0 }, "Watts" ],
    _Graphics,
    SameTest -> MatchQ,
    TestID   -> "EdgeCases-2@@Tests/MeanMaximalPowerCurvePlot.wlt:209,1-214,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Possible Issues*)
VerificationTest[
    MeanMaximalPowerCurvePlot @ File[ "ExampleData/Walk.fit" ],
    _Failure,
    SameTest -> MatchQ,
    TestID   -> "PossibleIssues-1@@Tests/MeanMaximalPowerCurvePlot.wlt:219,1-224,2"
]

VerificationTest[
    MeanMaximalPowerCurvePlot[ ],
    _Failure,
    SameTest -> MatchQ,
    TestID   -> "PossibleIssues-2@@Tests/MeanMaximalPowerCurvePlot.wlt:226,1-231,2"
]

VerificationTest[
    MeanMaximalPowerCurvePlot @ "invalid",
    _Failure,
    SameTest -> MatchQ,
    TestID   -> "PossibleIssues-3@@Tests/MeanMaximalPowerCurvePlot.wlt:233,1-238,2"
]

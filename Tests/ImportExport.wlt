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
    TestID   -> "Initialize-PacletDirectory@@Tests/ImportExport.wlt:4,1-17,2"
]

VerificationTest[
    $paclet = PacletObject @ File[ $pacletDir ],
    _? PacletObjectQ,
    SameTest -> MatchQ,
    TestID   -> "Initialize-PacletObject@@Tests/ImportExport.wlt:19,1-24,2"
]

VerificationTest[
    PacletDirectoryLoad @ $pacletDir,
    { ___, $pacletDir, ___ },
    SameTest -> MatchQ,
    TestID   -> "Initialize-PacletDirectoryLoad@@Tests/ImportExport.wlt:26,1-31,2"
]

VerificationTest[
    Needs[ "RickHennigan`ComputationalFitness`" ],
    Null,
    SameTest -> MatchQ,
    TestID   -> "Initialize-Needs-ComputationalFitness@@Tests/ImportExport.wlt:33,1-38,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Section:: *)
(*Tests*)

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*FileFormat*)
VerificationTest[
    FileFormat[ "ExampleData/BikeRide.fit" ],
    "FIT",
    SameTest -> MatchQ,
    TestID   -> "FileFormat-1@@Tests/ImportExport.wlt:47,1-52,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*FileFormatProperties*)
VerificationTest[
    FileFormatProperties[ "FIT" ],
    KeyValuePattern @ {
        "DefaultImportElement" -> "FitnessData",
        "FileNamePatterns"     -> { "*.fit" },
        "ImportElements"       -> { ___, "FitnessData", ___ },
        "MIMETypes"            -> { ___, "application/vnd.ant.fit", ___ }
    },
    SameTest -> MatchQ,
    TestID   -> "FileFormatProperties-1@@Tests/ImportExport.wlt:57,1-67,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Import*)
VerificationTest[
    Import[ "ExampleData/BikeRide.fit" ],
    _FitnessData? FitnessDataQ,
    SameTest -> MatchQ,
    TestID   -> "Import-1@@Tests/ImportExport.wlt:72,1-77,2"
]

VerificationTest[
    Import[ "ExampleData/BikeRide.fit", "Elements" ],
    { __String },
    SameTest -> MatchQ,
    TestID   -> "Import-2@@Tests/ImportExport.wlt:79,1-84,2"
]

VerificationTest[
    Import[ "ExampleData/BikeRide.fit", "Dataset" ],
    _Dataset,
    SameTest -> MatchQ,
    TestID   -> "Import-2@@Tests/ImportExport.wlt:86,1-91,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Export*)
VerificationTest[
    tmp = FileNameJoin @ { CreateDirectory[ ], "test.fit" };
    data1 = Dataset @
        With[ { t = DateObject[ Now, "Second" ] },
            {
                <| "Timestamp" -> t + Quantity[ 0, "Seconds" ], "Distance" -> Quantity[ 10, "Meters" ] |>,
                <| "Timestamp" -> t + Quantity[ 1, "Seconds" ], "Distance" -> Quantity[ 20, "Meters" ] |>,
                <| "Timestamp" -> t + Quantity[ 2, "Seconds" ], "Distance" -> Quantity[ 30, "Meters" ] |>
            }
        ];
    Export[ tmp, data1, "FIT" ]
    ,
    _? FileExistsQ,
    SameTest -> MatchQ,
    TestID   -> "Export-1@@Tests/ImportExport.wlt:96,1-111,2"
]

VerificationTest[
    data2 = Import[ tmp, "Dataset", UnitSystem -> "Metric" ],
    _Dataset,
    SameTest -> MatchQ,
    TestID   -> "Export-2@@Tests/ImportExport.wlt:113,1-118,2"
]

VerificationTest[
    Max[ QuantityMagnitude /@ (Normal @ data1 - Normal @ data2) ],
    0,
    SameTest -> Equal,
    TestID   -> "Export-3@@Tests/ImportExport.wlt:120,1-125,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Cleanup*)

VerificationTest[
    DeleteDirectory @ DirectoryName @ tmp,
    Null,
    SameTest -> MatchQ,
    TestID   -> "Cleanup-1@@Tests/ImportExport.wlt:131,1-136,2"
]

VerificationTest[
    ! FileExistsQ @ tmp,
    True,
    SameTest -> MatchQ,
    TestID   -> "Cleanup-2@@Tests/ImportExport.wlt:138,1-143,2"
]
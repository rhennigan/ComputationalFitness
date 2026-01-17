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
    TestID   -> "Initialize-PacletDirectory@@Tests/FITFileType.wlt:4,1-17,2"
]

VerificationTest[
    $paclet = PacletObject @ File[ $pacletDir ],
    _? PacletObjectQ,
    SameTest -> MatchQ,
    TestID   -> "Initialize-PacletObject@@Tests/FITFileType.wlt:19,1-24,2"
]

VerificationTest[
    PacletDirectoryLoad @ $pacletDir,
    { ___, $pacletDir, ___ },
    SameTest -> MatchQ,
    TestID   -> "Initialize-PacletDirectoryLoad@@Tests/FITFileType.wlt:26,1-31,2"
]

VerificationTest[
    Get[ "RickHennigan`ComputationalFitness`" ],
    Null,
    SameTest -> MatchQ,
    TestID   -> "Initialize-Get-ComputationalFitness@@Tests/FITFileType.wlt:33,1-38,2"
]

VerificationTest[
    {
        Context @ FITFileType,
        Context @ FITImport,
        Context @ FitnessData
    },
    ConstantArray[ "RickHennigan`ComputationalFitness`", 3 ],
    SameTest -> MatchQ,
    TestID   -> "Initialize-Context@@Tests/FITFileType.wlt:40,1-49,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*FITFileType - Activity Files*)
VerificationTest[
    FITFileType @ FileNameJoin @ { $pacletDir, "ExampleData", "Activity.fit" },
    "Activity",
    TestID -> "FITFileType-Activity@@Tests/FITFileType.wlt:54,1-58,2"
]

VerificationTest[
    FITFileType @ FileNameJoin @ { $pacletDir, "ExampleData", "BikeRide.fit" },
    "Activity",
    TestID -> "FITFileType-BikeRide@@Tests/FITFileType.wlt:60,1-64,2"
]

VerificationTest[
    FITFileType @ FileNameJoin @ { $pacletDir, "ExampleData", "BikeHillClimb.fit" },
    "Activity",
    TestID -> "FITFileType-BikeHillClimb@@Tests/FITFileType.wlt:66,1-70,2"
]

VerificationTest[
    FITFileType @ FileNameJoin @ { $pacletDir, "ExampleData", "BikeLaps.fit" },
    "Activity",
    TestID -> "FITFileType-BikeLaps@@Tests/FITFileType.wlt:72,1-76,2"
]

VerificationTest[
    FITFileType @ FileNameJoin @ { $pacletDir, "ExampleData", "ZwiftRide.fit" },
    "Activity",
    TestID -> "FITFileType-ZwiftRide@@Tests/FITFileType.wlt:78,1-82,2"
]

VerificationTest[
    FITFileType @ FileNameJoin @ { $pacletDir, "ExampleData", "Walk.fit" },
    "Activity",
    TestID -> "FITFileType-Walk@@Tests/FITFileType.wlt:84,1-88,2"
]

VerificationTest[
    FITFileType @ FileNameJoin @ { $pacletDir, "ExampleData", "activity_multisport.fit" },
    "Activity",
    TestID -> "FITFileType-ActivityMultisport@@Tests/FITFileType.wlt:90,1-94,2"
]

VerificationTest[
    FITFileType @ FileNameJoin @ { $pacletDir, "ExampleData", "activity_poolswim.fit" },
    "Activity",
    TestID -> "FITFileType-ActivityPoolSwim@@Tests/FITFileType.wlt:96,1-100,2"
]

VerificationTest[
    FITFileType @ FileNameJoin @ { $pacletDir, "ExampleData", "activity_developerdata.fit" },
    "Activity",
    TestID -> "FITFileType-ActivityDeveloperData@@Tests/FITFileType.wlt:102,1-106,2"
]

VerificationTest[
    FITFileType @ FileNameJoin @ { $pacletDir, "ExampleData", "IndoorIntervals.fit" },
    "Activity",
    TestID -> "FITFileType-IndoorIntervals@@Tests/FITFileType.wlt:108,1-112,2"
]

VerificationTest[
    FITFileType @ FileNameJoin @ { $pacletDir, "ExampleData", "IndoorWorkout.fit" },
    "Activity",
    TestID -> "FITFileType-IndoorWorkout@@Tests/FITFileType.wlt:114,1-118,2"
]

VerificationTest[
    FITFileType @ FileNameJoin @ { $pacletDir, "ExampleData", "TrainerRoadActivity.fit" },
    "Activity",
    TestID -> "FITFileType-TrainerRoadActivity@@Tests/FITFileType.wlt:120,1-124,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*FITFileType - Settings Files*)
VerificationTest[
    FITFileType @ FileNameJoin @ { $pacletDir, "ExampleData", "Settings.fit" },
    "Settings",
    TestID -> "FITFileType-Settings@@Tests/FITFileType.wlt:129,1-133,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*FITFileType - Workout Files*)
VerificationTest[
    FITFileType @ FileNameJoin @ { $pacletDir, "ExampleData", "WorkoutIndividualSteps.fit" },
    "Workout",
    TestID -> "FITFileType-WorkoutIndividualSteps@@Tests/FITFileType.wlt:138,1-142,2"
]

VerificationTest[
    FITFileType @ FileNameJoin @ { $pacletDir, "ExampleData", "WorkoutRepeatSteps.fit" },
    "Workout",
    TestID -> "FITFileType-WorkoutRepeatSteps@@Tests/FITFileType.wlt:144,1-148,2"
]

VerificationTest[
    FITFileType @ FileNameJoin @ { $pacletDir, "ExampleData", "WorkoutRepeatGreaterThanStep.fit" },
    "Workout",
    TestID -> "FITFileType-WorkoutRepeatGreaterThanStep@@Tests/FITFileType.wlt:150,1-154,2"
]

VerificationTest[
    FITFileType @ FileNameJoin @ { $pacletDir, "ExampleData", "WorkoutCustomTargetValues.fit" },
    "Workout",
    TestID -> "FITFileType-WorkoutCustomTargetValues@@Tests/FITFileType.wlt:156,1-160,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*FITFileType - Weight Files*)
VerificationTest[
    FITFileType @ FileNameJoin @ { $pacletDir, "ExampleData", "WeightScaleSingleUser.fit" },
    "Weight",
    TestID -> "FITFileType-WeightScaleSingleUser@@Tests/FITFileType.wlt:165,1-169,2"
]

VerificationTest[
    FITFileType @ FileNameJoin @ { $pacletDir, "ExampleData", "WeightScaleMultiUser.fit" },
    "Weight",
    TestID -> "FITFileType-WeightScaleMultiUser@@Tests/FITFileType.wlt:171,1-175,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*FITFileType - Monitoring Files*)
VerificationTest[
    FITFileType @ FileNameJoin @ { $pacletDir, "ExampleData", "MonitoringFile.fit" },
    "MonitoringB",
    TestID -> "FITFileType-MonitoringFile@@Tests/FITFileType.wlt:180,1-184,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*FITFileType - Developer Data Files*)
VerificationTest[
    FITFileType @ FileNameJoin @ { $pacletDir, "ExampleData", "DeveloperData.fit" },
    "Activity",
    TestID -> "FITFileType-DeveloperData@@Tests/FITFileType.wlt:189,1-193,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*FITFileType - FitnessData Objects*)
VerificationTest[
    With[
        {
            data = IntermediateTest[
                FITImport @ FileNameJoin @ { $pacletDir, "ExampleData", "BikeRide.fit" },
                _FitnessData,
                SameTest -> MatchQ,
                TestID -> "FITFileType-FitnessData-Import"
            ]
        },
        FITFileType @ data
    ],
    "Activity",
    TestID -> "FITFileType-FitnessData-Activity@@Tests/FITFileType.wlt:198,1-212,2"
]

VerificationTest[
    With[
        {
            data = IntermediateTest[
                FITImport @ FileNameJoin @ { $pacletDir, "ExampleData", "Settings.fit" },
                _FitnessData,
                SameTest -> MatchQ,
                TestID -> "FITFileType-FitnessData-Settings-Import"
            ]
        },
        FITFileType @ data
    ],
    "Settings",
    TestID -> "FITFileType-FitnessData-Settings@@Tests/FITFileType.wlt:214,1-228,2"
]

VerificationTest[
    With[
        {
            data = IntermediateTest[
                FITImport @ FileNameJoin @ { $pacletDir, "ExampleData", "WorkoutIndividualSteps.fit" },
                _FitnessData,
                SameTest -> MatchQ,
                TestID -> "FITFileType-FitnessData-Workout-Import"
            ]
        },
        FITFileType @ data
    ],
    "Workout",
    TestID -> "FITFileType-FitnessData-Workout@@Tests/FITFileType.wlt:230,1-244,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*FITFileType - Error Cases*)
VerificationTest[
    FITFileType @ FileNameJoin @ { $pacletDir, "ExampleData", "nonexistent.fit" },
    _Failure,
    { FITFileType::LibraryErrorOpenFile },
    SameTest -> MatchQ,
    TestID -> "FITFileType-NonexistentFile@@Tests/FITFileType.wlt:249,1-255,2"
]

VerificationTest[
    FITFileType @ FileNameJoin @ { $pacletDir, "LICENSE" },
    _Failure,
    { FITFileType::LibraryErrorNoFileID },
    SameTest -> MatchQ,
    TestID -> "FITFileType-NonFITFile@@Tests/FITFileType.wlt:257,1-263,2"
]

VerificationTest[
    FITFileType @ FileNameJoin @ { $pacletDir, "PacletInfo.wl" },
    _Failure,
    { FITFileType::LibraryErrorNoFileID },
    SameTest -> MatchQ,
    TestID -> "FITFileType-WolframFile@@Tests/FITFileType.wlt:265,1-271,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*FITFileType - Truncated File*)
VerificationTest[
    FITFileType @ FileNameJoin @ { $pacletDir, "ExampleData", "activity_truncated.fit" },
    "Activity" | _Missing,
    SameTest -> MatchQ,
    TestID -> "FITFileType-TruncatedFile@@Tests/FITFileType.wlt:276,1-281,2"
]

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*FITFileType - Invalid File Structure*)
VerificationTest[
    With[
        {
            tempFile = IntermediateTest[
                Module[ { file },
                    file = CreateFile[ ];
                    BinaryWrite[ file, ByteArray @ { 14, 0, 32, 0, 200, 0, 0, 0, 46, 70, 73, 84, 255, 255 } ];
                    Close @ file;
                    file
                ],
                _String ? FileExistsQ,
                SameTest -> MatchQ,
                TestID -> "FITFileType-InvalidStructure-CreateFile"
            ]
        },
        FITFileType @ tempFile
    ],
    _Failure | _Missing,
    { FITFileType::LibraryErrorNoFileID },
    SameTest -> MatchQ,
    TestID -> "FITFileType-InvalidStructure@@Tests/FITFileType.wlt:286,1-307,2"
]
